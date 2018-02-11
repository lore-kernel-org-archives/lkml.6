Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227MFUvQfxF1UOfNk4fIsyTx0uMufc+3XJzWH5ByHXKs0npqjbOrfovM80DbHBKyrTiBvebr
ARC-Seal: i=1; a=rsa-sha256; t=1518323621; cv=none;
        d=google.com; s=arc-20160816;
        b=Oan9aiBxn0ntBY24FP/5exDpupp30oIQ8l+gVhQdki/nleqbjzOFLU/QEgcclF4EQ6
         RgD3As6fYy2HoKPxl7Yvk1vaJNk7rTrLowwuSRWcJ9nHmMdnCrAmtyBgYoiTtmjvV5X2
         JWhgK/79b8aZ8xulfKPBMMozN6Nw06WMaCpgV+hug4gODNXJufx1g2iI88hQoZu/9E/m
         r01CD6DoYrcJdNFsGZC8RZxMzpbSVD9f36pUGfkHirtgmovvCJ6B4k0JC8+aKhpWsqSc
         XOIubvIwjK3fTIph1m/tnCNI8DWf9LzsbcyMqetYcL6y0brrr0c34ucxADhr15/iGqAl
         a26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=ESc50BGBtr1c/t0z4vRGV0Q3OppW1+TQiU8GaotPTMI=;
        b=iCCTnYuBDcVmHnFvLro+xO0Lmo/8QJBxvMOaQNogPljjoFICOwySX3KJgrn1k2bood
         HwBWIYgnN/VUwN4IVcJeEt/1nTUbePr7fjOSbjbls4bWZU6r1HBmA2r3hEEQ69ij5qF7
         2bgUkSk5K+cSV42ITKNgC6wafaW+7vkqbG/EsvTh2Z3Chx2CrA7x5VZRKxg9lu2lmmOk
         WCB4vLjI8DDyKxQj6c8ncN5eLrcnIyHDadhm7biw5InuSaFU4Gm3PdMPUIKo3NiBr/Wa
         Y0fWC/kjw38cMOb046g6eQzR9xMVNWgtJAsQC2MPl088NRnHEjsGWEXgk8/XcxpqNdkt
         oumw==
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
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.398736932@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 05/79] USB: serial: garmin_gps: fix I/O after failed
 probe and remove
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077709106859121?=
X-GMAIL-MSGID: =?utf-8?q?1592077709106859121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -142,6 +142,7 @@ struct garmin_data {
 	__u8   privpkt[4*6];
 	spinlock_t lock;
 	struct list_head pktlist;
+	struct usb_anchor write_urbs;
 };
 
 
@@ -923,7 +924,7 @@ static int garmin_init_session(struct us
 					sizeof(GARMIN_START_SESSION_REQ), 0);
 
 			if (status < 0)
-				break;
+				goto err_kill_urbs;
 		}
 
 		if (status > 0)
@@ -931,6 +932,12 @@ static int garmin_init_session(struct us
 	}
 
 	return status;
+
+err_kill_urbs:
+	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
+	usb_kill_urb(port->interrupt_in_urb);
+
+	return status;
 }
 
 
@@ -950,7 +957,6 @@ static int garmin_open(struct tty_struct
 	spin_unlock_irqrestore(&garmin_data_p->lock, flags);
 
 	/* shutdown any bulk reads that might be going on */
-	usb_kill_urb(port->write_urb);
 	usb_kill_urb(port->read_urb);
 
 	if (garmin_data_p->state == STATE_RESET)
@@ -977,7 +983,7 @@ static void garmin_close(struct usb_seri
 
 	/* shutdown our urbs */
 	usb_kill_urb(port->read_urb);
-	usb_kill_urb(port->write_urb);
+	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
 
 	/* keep reset state so we know that we must start a new session */
 	if (garmin_data_p->state != STATE_RESET)
@@ -1069,12 +1075,14 @@ static int garmin_write_bulk(struct usb_
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
 
@@ -1464,6 +1472,7 @@ static int garmin_attach(struct usb_seri
 	garmin_data_p->state = 0;
 	garmin_data_p->flags = 0;
 	garmin_data_p->count = 0;
+	init_usb_anchor(&garmin_data_p->write_urbs);
 	usb_set_serial_port_data(port, garmin_data_p);
 
 	status = garmin_init_session(port);
@@ -1479,6 +1488,7 @@ static void garmin_disconnect(struct usb
 
 	dbg("%s", __func__);
 
+	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
 	usb_kill_urb(port->interrupt_in_urb);
 	del_timer_sync(&garmin_data_p->timer);
 }
