Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8E3C64EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 03:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E8520841
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 03:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E8520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJGKoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 06:44:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52689 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbeJGKoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 06:44:32 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w973btxq047551
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Oct 2018 20:37:56 -0700
Received: from carbon-x1.hos.anvin.org (localhost [127.0.0.1])
        by carbon-x1.hos.anvin.org (8.15.2/8.15.2) with ESMTP id w973bouu224518;
        Sat, 6 Oct 2018 20:37:50 -0700
Received: (from hpa@localhost)
        by carbon-x1.hos.anvin.org (8.15.2/8.15.2/Submit) id w973boje224517;
        Sat, 6 Oct 2018 20:37:50 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
Subject: [PATCH stable 2/2] termios, tty/tty_baudrate.c: simplify, auto-generate baud table
Date:   Sat,  6 Oct 2018 20:37:48 -0700
Message-Id: <20181007033748.224461-3-hpa@zytor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181007033748.224461-1-hpa@zytor.com>
References: <20181007033748.224461-1-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Now when all architectures define BOTHER and IBSHIFT, we can
unconditionally rely on these constants. Furthermore, the code can be
significantly simplified in a number of places.

Finally, rather than having two tables and needing to be able to keep
them in sync at all times, have one auto-generated table. This also
lets us avoid the fact that architectures that have CBAUDEX == 0 have
BOTHER in a different location that those that don't.

Finally, this patch avoids overrunning the baud_table[] for
architectures with CBAUDEX == 0 (Alpha and PowerPC).

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: <linux-alpha@vger.kernel.org>
Cc: <linux-serial@vger.kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: <stable@vger.kernel.org>
---
 drivers/tty/.gitignore     |   1 +
 drivers/tty/Makefile       |  16 ++++
 drivers/tty/bmacros.c      |   2 +
 drivers/tty/tty_baudrate.c | 190 +++++++++++++++----------------------
 4 files changed, 93 insertions(+), 116 deletions(-)
 create mode 100644 drivers/tty/.gitignore
 create mode 100644 drivers/tty/bmacros.c

diff --git a/drivers/tty/.gitignore b/drivers/tty/.gitignore
new file mode 100644
index 000000000000..d436c18a912c
--- /dev/null
+++ b/drivers/tty/.gitignore
@@ -0,0 +1 @@
+bmacros.h
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index c72cafdf32b4..489b222ab1ce 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -35,3 +35,19 @@ obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
 
 obj-y += ipwireless/
+
+#
+# Rules for generating the baud rate table
+#
+CFLAGS_bmacros.o += -Wp,-dM
+
+$(obj)/tty_baudrate.o: $(obj)/bmacros.h
+
+quiet_cmd_bmacros = BMACROS $@
+      cmd_bmacros =  ( \
+	sed -nr -e 's/^.define B([0-9]+) .*$$/BTBL(B\1,\1)/p' $< \
+		| sort -n -k1.7 > $@ ) || (rm -f $@ ; echo false)
+
+targets += bmacros.h
+$(obj)/bmacros.h: $(obj)/bmacros.i FORCE
+	$(call if_changed,bmacros)
diff --git a/drivers/tty/bmacros.c b/drivers/tty/bmacros.c
new file mode 100644
index 000000000000..0af865ff00de
--- /dev/null
+++ b/drivers/tty/bmacros.c
@@ -0,0 +1,2 @@
+/* This file is used to extract the B... macros from header files */
+#include <linux/termios.h>
diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 7576ceace571..5a41eda7912a 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -9,43 +9,56 @@
 #include <linux/tty.h>
 #include <linux/export.h>
 
-
 /*
- * Routine which returns the baud rate of the tty
- *
- * Note that the baud_table needs to be kept in sync with the
- * include/asm/termbits.h file.
+ * Routine which returns the baud rate of the tty.  The B... constants
+ * are extracted from the appropriate header files via
+ * bmacros.c -> bmacros.h.
  */
-static const speed_t baud_table[] = {
-	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
-	9600, 19200, 38400, 57600, 115200, 230400, 460800,
-#ifdef __sparc__
-	76800, 153600, 307200, 614400, 921600
-#else
-	500000, 576000, 921600, 1000000, 1152000, 1500000, 2000000,
-	2500000, 3000000, 3500000, 4000000
+
+/* CBAUD mask with CBAUDEX removed */
+#define CBAUDNX (CBAUD & ~CBAUDEX)
+
+/* Lowest bit in CBAUDEX, if any.  CBAUDEX is assumed contiguous. */
+#define CBAUDEL (CBAUDEX & ~(CBAUDEX << 1))
+#if CBAUDEL & (CBAUDEL-1)
+# error "CBAUDEX is not contiguous"
 #endif
-};
 
-#ifndef __sparc__
-static const tcflag_t baud_bits[] = {
-	B0, B50, B75, B110, B134, B150, B200, B300, B600,
-	B1200, B1800, B2400, B4800, B9600, B19200, B38400,
-	B57600, B115200, B230400, B460800, B500000, B576000,
-	B921600, B1000000, B1152000, B1500000, B2000000, B2500000,
-	B3000000, B3500000, B4000000
-};
-#else
-static const tcflag_t baud_bits[] = {
-	B0, B50, B75, B110, B134, B150, B200, B300, B600,
-	B1200, B1800, B2400, B4800, B9600, B19200, B38400,
-	B57600, B115200, B230400, B460800, B76800, B153600,
-	B307200, B614400, B921600
+/* Convert from B... constant to table position */
+#define BPOS(x) (((x) & CBAUDNX) + \
+		 (CBAUDEX ? ((x) & CBAUDEX)/CBAUDEL*(CBAUDNX+1) : 0))
+
+/* Convert from table position to B... constant */
+#define BVAL(x) (((x) & CBAUDNX) + (((x)/(CBAUDNX+1)*CBAUDEX) & CBAUDEX))
+
+/* Entry into the baud_table */
+#define BTBL(b,v) [BPOS(b)] = (v),
+
+static const speed_t baud_table[] = {
+#include "bmacros.h"
 };
-#endif
 
 static int n_baud_table = ARRAY_SIZE(baud_table);
 
+/* Helper function; will be called with cbaud already masked */
+static speed_t _tty_termios_baud_rate(unsigned int cbaud, speed_t bother_speed)
+{
+	/* Magic token for arbitrary speed via c_ispeed/c_ospeed */
+	if (cbaud == BOTHER)
+		return bother_speed;
+
+	cbaud = BPOS(cbaud);
+
+	/* If CBAUDEX != 0, and we overrun the table, try dropping CBAUDEX */
+	if (cbaud & ~CBAUDNX) {
+		if (BPOS(cbaud) >= n_baud_table) {
+			/* Try without CBAUDEX */
+			cbaud &= ~CBAUDNX;
+		}
+	}
+	return (cbaud >= n_baud_table) ? 0 : baud_table[cbaud];
+}
+
 /**
  *	tty_termios_baud_rate
  *	@termios: termios structure
@@ -60,24 +73,8 @@ static int n_baud_table = ARRAY_SIZE(baud_table);
 
 speed_t tty_termios_baud_rate(struct ktermios *termios)
 {
-	unsigned int cbaud;
-
-	cbaud = termios->c_cflag & CBAUD;
-
-#ifdef BOTHER
-	/* Magic token for arbitrary speed via c_ispeed/c_ospeed */
-	if (cbaud == BOTHER)
-		return termios->c_ospeed;
-#endif
-	if (cbaud & CBAUDEX) {
-		cbaud &= ~CBAUDEX;
-
-		if (cbaud < 1 || cbaud + 15 > n_baud_table)
-			termios->c_cflag &= ~CBAUDEX;
-		else
-			cbaud += 15;
-	}
-	return baud_table[cbaud];
+	return _tty_termios_baud_rate(termios->c_cflag & CBAUD,
+				      termios->c_ospeed);
 }
 EXPORT_SYMBOL(tty_termios_baud_rate);
 
@@ -95,28 +92,15 @@ EXPORT_SYMBOL(tty_termios_baud_rate);
 
 speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 {
-#ifdef IBSHIFT
-	unsigned int cbaud = (termios->c_cflag >> IBSHIFT) & CBAUD;
-
-	if (cbaud == B0)
-		return tty_termios_baud_rate(termios);
-#ifdef BOTHER
-	/* Magic token for arbitrary speed via c_ispeed*/
-	if (cbaud == BOTHER)
-		return termios->c_ispeed;
-#endif
-	if (cbaud & CBAUDEX) {
-		cbaud &= ~CBAUDEX;
+	unsigned int cbaud;
+	speed_t bother_speed = termios->c_ispeed;
 
-		if (cbaud < 1 || cbaud + 15 > n_baud_table)
-			termios->c_cflag &= ~(CBAUDEX << IBSHIFT);
-		else
-			cbaud += 15;
+	cbaud = (termios->c_cflag >> IBSHIFT) & CBAUD;
+	if (cbaud == B0) {
+		cbaud = termios->c_cflag & CBAUD;
+		bother_speed = termios->c_ospeed;
 	}
-	return baud_table[cbaud];
-#else	/* IBSHIFT */
-	return tty_termios_baud_rate(termios);
-#endif	/* IBSHIFT */
+	return _tty_termios_baud_rate(cbaud, bother_speed);
 }
 EXPORT_SYMBOL(tty_termios_input_baud_rate);
 
@@ -145,38 +129,27 @@ EXPORT_SYMBOL(tty_termios_input_baud_rate);
 void tty_termios_encode_baud_rate(struct ktermios *termios,
 				  speed_t ibaud, speed_t obaud)
 {
-	int i = 0;
-	int ifound = -1, ofound = -1;
+	int i;
+	unsigned int ifound, ofound;
 	int iclose = ibaud/50, oclose = obaud/50;
-	int ibinput = 0;
+	bool ibinput = false;
 
-	if (obaud == 0)			/* CD dropped 		  */
+	if (obaud == 0)			/* CD dropped		  */
 		ibaud = 0;		/* Clear ibaud to be sure */
 
 	termios->c_ispeed = ibaud;
 	termios->c_ospeed = obaud;
 
-#ifdef IBSHIFT
-	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
-		ibinput = 1;	/* An input speed was specified */
-#endif
-#ifdef BOTHER
+	ibinput = ((termios->c_cflag >> IBSHIFT) & CBAUD) != B0;
+
 	/* If the user asked for a precise weird speed give a precise weird
 	   answer. If they asked for a Bfoo speed they may have problems
 	   digesting non-exact replies so fuzz a bit */
 
-	if ((termios->c_cflag & CBAUD) == BOTHER) {
+	if ((termios->c_cflag & CBAUD) == BOTHER)
 		oclose = 0;
-		if (!ibinput)
-			iclose = 0;
-	}
 	if (((termios->c_cflag >> IBSHIFT) & CBAUD) == BOTHER)
 		iclose = 0;
-#endif
-	termios->c_cflag &= ~CBAUD;
-#ifdef IBSHIFT
-	termios->c_cflag &= ~(CBAUD << IBSHIFT);
-#endif
 
 	/*
 	 *	Our goal is to find a close match to the standard baud rate
@@ -184,43 +157,28 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 	 *	match then report back the speed as a POSIX Bxxxx value by
 	 *	preference
 	 */
-
-	do {
+	ofound = ifound = BOTHER;
+	for (i = 0; i < n_baud_table; i++) {
 		if (obaud - oclose <= baud_table[i] &&
 		    obaud + oclose >= baud_table[i]) {
-			termios->c_cflag |= baud_bits[i];
-			ofound = i;
+			ofound = BVAL(i);
+			break;
 		}
-		if (ibaud - iclose <= baud_table[i] &&
-		    ibaud + iclose >= baud_table[i]) {
-			/* For the case input == output don't set IBAUD bits
-			   if the user didn't do so */
-			if (ofound == i && !ibinput)
-				ifound  = i;
-#ifdef IBSHIFT
-			else {
-				ifound = i;
-				termios->c_cflag |= (baud_bits[i] << IBSHIFT);
+	}
+	if (!ibinput) {
+		ifound = 0;
+	} else {
+		for (i = 0; i < n_baud_table; i++) {
+			if (ibaud - iclose <= baud_table[i] &&
+			    ibaud + iclose >= baud_table[i]) {
+				ifound  = BVAL(i);
+				break;
 			}
-#endif
 		}
-	} while (++i < n_baud_table);
+	}
 
-	/*
-	 *	If we found no match then use BOTHER if provided or warn
-	 *	the user their platform maintainer needs to wake up if not.
-	 */
-#ifdef BOTHER
-	if (ofound == -1)
-		termios->c_cflag |= BOTHER;
-	/* Set exact input bits only if the input and output differ or the
-	   user already did */
-	if (ifound == -1 && (ibaud != obaud || ibinput))
-		termios->c_cflag |= (BOTHER << IBSHIFT);
-#else
-	if (ifound == -1 || ofound == -1)
-		pr_warn_once("tty: Unable to return correct speed data as your architecture needs updating.\n");
-#endif
+	termios->c_cflag &= ~(CBAUD | (CBAUD << IBSHIFT));
+	termios->c_cflag |= ofound | (ifound << IBSHIFT);
 }
 EXPORT_SYMBOL_GPL(tty_termios_encode_baud_rate);
 
-- 
2.17.1

