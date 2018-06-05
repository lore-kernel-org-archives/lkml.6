Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeFERD5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752687AbeFERDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Johan Hovold <johan@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 03/37] USB: serial: cp210x: use tcflag_t to fix incompatible pointer type
Date: Tue,  5 Jun 2018 19:01:08 +0200
Message-Id: <20180605170109.105675089@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit 009615ab7fd4e43b82a38e4e6adc5e23c1ee567f upstream.

On sparc32, tcflag_t is unsigned long, unlike all other architectures:

    drivers/usb/serial/cp210x.c: In function 'cp210x_get_termios':
    drivers/usb/serial/cp210x.c:717:3: warning: passing argument 2 of 'cp210x_get_termios_port' from incompatible pointer type
       cp210x_get_termios_port(tty->driver_data,
       ^
    drivers/usb/serial/cp210x.c:35:13: note: expected 'unsigned int *' but argument is of type 'tcflag_t *'
     static void cp210x_get_termios_port(struct usb_serial_port *port,
		 ^

Consistently use tcflag_t to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -33,7 +33,7 @@ static int cp210x_open(struct tty_struct
 static void cp210x_close(struct usb_serial_port *);
 static void cp210x_get_termios(struct tty_struct *, struct usb_serial_port *);
 static void cp210x_get_termios_port(struct usb_serial_port *port,
-	unsigned int *cflagp, unsigned int *baudp);
+	tcflag_t *cflagp, unsigned int *baudp);
 static void cp210x_change_speed(struct tty_struct *, struct usb_serial_port *,
 							struct ktermios *);
 static void cp210x_set_termios(struct tty_struct *, struct usb_serial_port *,
@@ -515,7 +515,7 @@ static void cp210x_get_termios(struct tt
 			&tty->termios.c_cflag, &baud);
 		tty_encode_baud_rate(tty, baud, baud);
 	} else {
-		unsigned int cflag;
+		tcflag_t cflag;
 		cflag = 0;
 		cp210x_get_termios_port(port, &cflag, &baud);
 	}
@@ -526,10 +526,11 @@ static void cp210x_get_termios(struct tt
  * This is the heart of cp210x_get_termios which always uses a &usb_serial_port.
  */
 static void cp210x_get_termios_port(struct usb_serial_port *port,
-	unsigned int *cflagp, unsigned int *baudp)
+	tcflag_t *cflagp, unsigned int *baudp)
 {
 	struct device *dev = &port->dev;
-	unsigned int cflag, modem_ctl[4];
+	tcflag_t cflag;
+	unsigned int modem_ctl[4];
 	unsigned int baud;
 	unsigned int bits;
 
