Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x2244GNt0p45h/jFw41ntdo1m8jTuOgcQMdaSi5cZ4+WRxNUE74vW0jx/Hi2z5jBe851poEu8
ARC-Seal: i=1; a=rsa-sha256; t=1518323637; cv=none;
        d=google.com; s=arc-20160816;
        b=cDJGrm5BBPq0fxeriOV36Jnv7FdLi1Og9LOll+EaUqfgdVNrwuxX3UPbRGTyFa7nsa
         r5MQUyjcZASYfrziDofLNNJxCyyCa16PAE0yG9F8F11CF21Je6omWrrDMUdI2eY3MWhr
         cXb8flrQZse8d9d8pFVXlxnJu8cp/mzD8BDtfH1fGVO78lRGxQ3n4mPlvCRtxdQTiLoI
         /91bmYJfPW1gq0EMIM4SCGz1NWUE2PwSil8DpFWVpu8Ckx+iTwAYHIoxANr8JRj65/WG
         rVoxLchgY1sIjL666LB7Z7jCXtdUYFFk3qNfvzv8wgBOOX+20hPg+ELO8p5Tkf0lYOZf
         Mz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=4XOgvesn6hVnwJFYkufS/oXke/P4RPYKfE8ltxV7w/I=;
        b=eUa/DjAENRVituj9QM/VNZVs6nvIkZw+hBO8anDGtuDT20Dbw9x6IFkSFPHxrKO2SM
         j7UyIAKkkwpi9Xz8L/BXeT2c7d+5iiRc6hQKLOvbl7sZIlTkF8g5bLykPBYSEbFwUCF6
         j2vAbv7txJquyLPINY3Kxsyc99o972zszGrbPOKDiEpiA3vcFsBbVf2kGtzW76mdnwnX
         YeLmL6sgZ51uOpVMGYKRHOE06HAzs5kmaEQKmM+iqsRKoONqT249ZWiH6mI94HlF/xXX
         45k5xEALCBMznUIFixHK8CP2v+PYZ60eiReNubQMtP5eMNvGPA1IwmGcmTmC/h8L5X4r
         B2gA==
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
 "Alexander Popov" <alpopov@ptsecurity.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.201596848@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 122/136] usbip: fix NULL pointer dereference on errors
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077726776112075?=
X-GMAIL-MSGID: =?utf-8?q?1592077726776112075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Popov <alpopov@ptsecurity.com>

commit 8c7003a3b4b4afd3734cdcc39217ef22d78a4a16 upstream.

Fix NULL pointer dereference and obsolete comments forgotten when
usbip server was converted from an interface driver to a device driver.

Signed-off-by: Alexander Popov <alpopov@ptsecurity.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub.h     |  1 -
 drivers/staging/usbip/stub_dev.c |  4 ++--
 drivers/staging/usbip/stub_rx.c  | 19 +++++++------------
 drivers/staging/usbip/stub_tx.c  |  6 +++---
 4 files changed, 12 insertions(+), 18 deletions(-)

--- a/drivers/staging/usbip/stub.h
+++ b/drivers/staging/usbip/stub.h
@@ -33,7 +33,6 @@
 #define STUB_BUSID_ALLOC 3
 
 struct stub_device {
-	struct usb_interface *interface;
 	struct usb_device *udev;
 
 	struct usbip_device ud;
--- a/drivers/staging/usbip/stub_dev.c
+++ b/drivers/staging/usbip/stub_dev.c
@@ -246,7 +246,7 @@ static void stub_device_reset(struct usb
 
 	dev_dbg(&udev->dev, "device reset");
 
-	ret = usb_lock_device_for_reset(udev, sdev->interface);
+	ret = usb_lock_device_for_reset(udev, NULL);
 	if (ret < 0) {
 		dev_err(&udev->dev, "lock for reset\n");
 		spin_lock_irq(&ud->lock);
@@ -279,7 +279,7 @@ static void stub_device_unusable(struct
 
 /**
  * stub_device_alloc - allocate a new stub_device struct
- * @interface: usb_interface of a new device
+ * @udev: usb_device of a new device
  *
  * Allocates and initializes a new stub_device struct.
  */
--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -165,12 +165,7 @@ static int tweak_reset_device_cmd(struct
 
 	dev_info(&urb->dev->dev, "usb_queue_reset_device\n");
 
-	/*
-	 * With the implementation of pre_reset and post_reset the driver no
-	 * longer unbinds. This allows the use of synchronous reset.
-	 */
-
-	if (usb_lock_device_for_reset(sdev->udev, sdev->interface) < 0) {
+	if (usb_lock_device_for_reset(sdev->udev, NULL) < 0) {
 		dev_err(&urb->dev->dev, "could not obtain lock to reset device\n");
 		return 0;
 	}
@@ -321,7 +316,7 @@ static struct stub_priv *stub_priv_alloc
 
 	priv = kmem_cache_zalloc(stub_priv_cache, GFP_ATOMIC);
 	if (!priv) {
-		dev_err(&sdev->interface->dev, "alloc stub_priv\n");
+		dev_err(&sdev->udev->dev, "alloc stub_priv\n");
 		spin_unlock_irqrestore(&sdev->priv_lock, flags);
 		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
 		return NULL;
@@ -352,7 +347,7 @@ static int get_pipe(struct stub_device *
 	else
 		ep = udev->ep_out[epnum & 0x7f];
 	if (!ep) {
-		dev_err(&sdev->interface->dev, "no such endpoint?, %d\n",
+		dev_err(&sdev->udev->dev, "no such endpoint?, %d\n",
 			epnum);
 		BUG();
 	}
@@ -387,7 +382,7 @@ static int get_pipe(struct stub_device *
 	}
 
 	/* NOT REACHED */
-	dev_err(&sdev->interface->dev, "get pipe, epnum %d\n", epnum);
+	dev_err(&sdev->udev->dev, "get pipe, epnum %d\n", epnum);
 	return 0;
 }
 
@@ -466,7 +461,7 @@ static void stub_recv_cmd_submit(struct
 		priv->urb = usb_alloc_urb(0, GFP_KERNEL);
 
 	if (!priv->urb) {
-		dev_err(&sdev->interface->dev, "malloc urb\n");
+		dev_err(&udev->dev, "malloc urb\n");
 		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
 		return;
 	}
@@ -486,7 +481,7 @@ static void stub_recv_cmd_submit(struct
 	priv->urb->setup_packet = kmemdup(&pdu->u.cmd_submit.setup, 8,
 					  GFP_KERNEL);
 	if (!priv->urb->setup_packet) {
-		dev_err(&sdev->interface->dev, "allocate setup_packet\n");
+		dev_err(&udev->dev, "allocate setup_packet\n");
 		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
 		return;
 	}
@@ -517,7 +512,7 @@ static void stub_recv_cmd_submit(struct
 		usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
 				  pdu->base.seqnum);
 	else {
-		dev_err(&sdev->interface->dev, "submit_urb error, %d\n", ret);
+		dev_err(&udev->dev, "submit_urb error, %d\n", ret);
 		usbip_dump_header(pdu);
 		usbip_dump_urb(priv->urb);
 
--- a/drivers/staging/usbip/stub_tx.c
+++ b/drivers/staging/usbip/stub_tx.c
@@ -233,7 +233,7 @@ static int stub_send_ret_submit(struct s
 			}
 
 			if (txsize != sizeof(pdu_header) + urb->actual_length) {
-				dev_err(&sdev->interface->dev,
+				dev_err(&sdev->udev->dev,
 					"actual length of urb %d does not match iso packet sizes %zu\n",
 					urb->actual_length,
 					txsize-sizeof(pdu_header));
@@ -265,7 +265,7 @@ static int stub_send_ret_submit(struct s
 		ret = kernel_sendmsg(sdev->ud.tcp_socket, &msg,
 						iov,  iovnum, txsize);
 		if (ret != txsize) {
-			dev_err(&sdev->interface->dev,
+			dev_err(&sdev->udev->dev,
 				"sendmsg failed!, retval %d for %zd\n",
 				ret, txsize);
 			kfree(iov);
@@ -340,7 +340,7 @@ static int stub_send_ret_unlink(struct s
 		ret = kernel_sendmsg(sdev->ud.tcp_socket, &msg, iov,
 				     1, txsize);
 		if (ret != txsize) {
-			dev_err(&sdev->interface->dev,
+			dev_err(&sdev->udev->dev,
 				"sendmsg failed!, retval %d for %zd\n",
 				ret, txsize);
 			usbip_event_add(&sdev->ud, SDEV_EVENT_ERROR_TCP);
