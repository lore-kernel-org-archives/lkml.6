Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x22445EcnMKpRJi8+Qb8GTykEvmMzJP9x0jTciKXv/4pMpbsyNvuD/l213XjshP2QkfPn7nqf
ARC-Seal: i=1; a=rsa-sha256; t=1518323636; cv=none;
        d=google.com; s=arc-20160816;
        b=zFVfaajSyPoo9/1PgMw7Fz3tMALxxpCHPZK1511hoSD2+h4DgaQQK8KCWPf1x2SsNp
         Uvd5aowzNvJlP85P0jH7hlav9Uj/KeZC6pD+lXE6m5goGc06/YJ/ckV3LA0U0oFrWZCZ
         CmbLLcfn1hD18X/luU60ofnkK5OmCKiJCDcCHhZsyV5UU0NGQ5EjKJHsMv6SCpHA9hNF
         dH8d19Ye2JcbT6GZe2vl/s+4MaH704U1VAuKgSjJioBQ/jxXt5e+9GeBRa0lLEEwJxr1
         hk9W+vFBr/xJdS23x+FouSSf91argKaiLFWm8kD0ujY0fXKtM8u9zFZ30dkncdv3kmGa
         cBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=qNDZUnFoGfMHGx4FUvgCjDqSe8wGZMHxiPGQgZHqerg=;
        b=UvvnSZqe8dJJlbD8TCPu75jsJ8y+qxxoZ8Hmp31GzLrc3lRfSsZtk1/3nT6dmOdGWa
         RzT/436qzItTEk6t7UwAB1mOAkRBNidIn66D3UH6gOJZdZlL/X/2g5Im2+aGA8/2GrV4
         +m5cKcOjgIqIPCejDLGbZADXCvw0qRdJjnFTYDRdDvN5bMJB5L5WkJQ4fuyH+LhW420X
         TKtSBY24lHhLSOuArJvmrSCqudg2ctTW567ryOj8ngpLfUe6KMbQOZrLc7Ayyo7/MbGP
         glKc3EVrVoH+dAYa6gYlaGhvTv7lvdOEwMHfpoqRYssG96B/vRXmdlgGRt3ezgMa/pxe
         kzNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Johan Hovold" <johan@kernel.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.561634586@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 016/136] USB: serial: garmin_gps: fix I/O after
 failed probe and remove
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077709106859121?=
X-GMAIL-MSGID: =?utf-8?q?1592077725400127811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 19a565d9af6e0d828bd0d521d3bafd5017f4ce52 upstream.

Make sure to stop any submitted interrupt and bulk-out URBs before
returning after failed probe and when the port is being unbound to avoid
later NULL-pointer dereferences in the completion callbacks.

Also fix up the related and broken I/O cancellation on failed open and
on close. (Note that port->write_urb was never submitted.)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/garmin_gps.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -138,6 +138,7 @@ struct garmin_data {
 	__u8   privpkt[4*6];
 	spinlock_t lock;
 	struct list_head pktlist;
+	struct usb_anchor write_urbs;
 };
 
 
@@ -906,7 +907,7 @@ static int garmin_init_session(struct us
 					sizeof(GARMIN_START_SESSION_REQ), 0);
 
 			if (status < 0)
-				break;
+				goto err_kill_urbs;
 		}
 
 		if (status > 0)
@@ -914,6 +915,12 @@ static int garmin_init_session(struct us
 	}
 
 	return status;
+
+err_kill_urbs:
+	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
+	usb_kill_urb(port->interrupt_in_urb);
+
+	return status;
 }
 
 
@@ -931,7 +938,6 @@ static int garmin_open(struct tty_struct
 	spin_unlock_irqrestore(&garmin_data_p->lock, flags);
 
 	/* shutdown any bulk reads that might be going on */
-	usb_kill_urb(port->write_urb);
 	usb_kill_urb(port->read_urb);
 
 	if (garmin_data_p->state == STATE_RESET)
@@ -954,7 +960,7 @@ static void garmin_close(struct usb_seri
 
 	/* shutdown our urbs */
 	usb_kill_urb(port->read_urb);
-	usb_kill_urb(port->write_urb);
+	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
 
 	/* keep reset state so we know that we must start a new session */
 	if (garmin_data_p->state != STATE_RESET)
@@ -1038,12 +1044,14 @@ static int garmin_write_bulk(struct usb_
 	}
 
 	/* send it down the pipe */
+	usb_anchor_urb(urb, &garmin_data_p->write_urbs);
 	status = usb_submit_urb(urb, GFP_ATOMIC);
 	if (status) {
 		dev_err(&port->dev,
 		   "%s - usb_submit_urb(write bulk) failed with status = %d\n",
 				__func__, status);
 		count = status;
+		usb_unanchor_urb(urb);
 		kfree(buffer);
 	}
 
@@ -1402,6 +1410,7 @@ static int garmin_port_probe(struct usb_
 	garmin_data_p->state = 0;
 	garmin_data_p->flags = 0;
 	garmin_data_p->count = 0;
+	init_usb_anchor(&garmin_data_p->write_urbs);
 	usb_set_serial_port_data(port, garmin_data_p);
 
 	status = garmin_init_session(port);
@@ -1414,6 +1423,7 @@ static int garmin_port_remove(struct usb
 {
 	struct garmin_data *garmin_data_p = usb_get_serial_port_data(port);
 
+	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
 	usb_kill_urb(port->interrupt_in_urb);
 	del_timer_sync(&garmin_data_p->timer);
 	kfree(garmin_data_p);
