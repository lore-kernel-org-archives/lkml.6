Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224PyqHTlxpQI6PqKw0ZyVdwM5J5vhR/ANcLlNZ4QO35Q4DwUQdgZC4dD6EtdiL6+k+4+F/X
ARC-Seal: i=1; a=rsa-sha256; t=1518707955; cv=none;
        d=google.com; s=arc-20160816;
        b=T25EGJ2RWQNTA1d9Zh64hSX9BvtHUJkYDQCOPonDFOMcAmYs1d/g8E77G6+vFK7Uh7
         EjHKpW81sUhLCR+dbK9e6Z+OC9ohYX/s1v8/UGxstqD7/7kuEKM9zpmdBVXJ2m3rVbkb
         JZ5UJw1+SO+0YTZyFKerobUsqjw1ioFWBXJahS85oJ7/vAT3jXuJkqi8yRuzea0OdaEs
         I1LbmcUv6s+l/PJBBUbKEnwdeS0gGF/5xrA0lb1gnlRmidcTWzeSf265SQSQqSerb1G4
         dTjs27HZTP2VkWP95dhB21M04gL3Ly0663C7lpoRB5nKu9w1rL5sDLJXtI3lo5wiiMqw
         gygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MrOs9+TGQ7doaJLHMWoV58P9kYxQ8CuILs029QBGeHU=;
        b=EaTcR6Vai0b7v2/oGsMi+GMjbinUJgTHF+DDiRCm0CGHJxkJbwV2jcu5M1aWM3Rasg
         ORqdjPydYUknFifdu5KMjT0fdfhgS2l/3DiOj5KC4SG6pm0UqslD9J60mjCwfIAm0fxI
         T+6NTPbX/q8exTCccbl53V4sbQRE37pK1wWcCWVKtTnO6hQoEe+dBA5yqj+I+nILyEEg
         9LYaPdpFQ1sMsDLeeFTHmEjzUJBz2LCfsA3xNw/cN9KVKb429zyckX7DpEOYcm4Z2EGN
         hYk1T6uzWHc3IwVOZYoD92ZaJ6xkA03bZksbwj+s4vWC4rsLQX9N51lb+Na+scRiVERt
         yJDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 23/45] usbip: vhci: stop printing kernel pointer addresses in messages
Date: Thu, 15 Feb 2018 16:17:14 +0100
Message-Id: <20180215144120.819711329@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480712972533302?=
X-GMAIL-MSGID: =?utf-8?q?1592480712972533302?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 8272d099d05f7ab2776cf56a2ab9f9443be18907 upstream.

Remove and/or change debug, info. and error messages to not print
kernel pointer addresses.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/usb/usbip/vhci_hcd.c |   10 ----------
 drivers/usb/usbip/vhci_rx.c  |   23 +++++++++++------------
 drivers/usb/usbip/vhci_tx.c  |    3 ++-
 3 files changed, 13 insertions(+), 23 deletions(-)

--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -469,9 +469,6 @@ static int vhci_urb_enqueue(struct usb_h
 	struct vhci_device *vdev;
 	unsigned long flags;
 
-	usbip_dbg_vhci_hc("enter, usb_hcd %p urb %p mem_flags %d\n",
-			  hcd, urb, mem_flags);
-
 	/* patch to usb_sg_init() is in 2.5.60 */
 	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
 
@@ -630,8 +627,6 @@ static int vhci_urb_dequeue(struct usb_h
 	struct vhci_device *vdev;
 	unsigned long flags;
 
-	pr_info("dequeue a urb %p\n", urb);
-
 	spin_lock_irqsave(&the_controller->lock, flags);
 
 	priv = urb->hcpriv;
@@ -659,7 +654,6 @@ static int vhci_urb_dequeue(struct usb_h
 		/* tcp connection is closed */
 		spin_lock(&vdev->priv_lock);
 
-		pr_info("device %p seems to be disconnected\n", vdev);
 		list_del(&priv->list);
 		kfree(priv);
 		urb->hcpriv = NULL;
@@ -671,8 +665,6 @@ static int vhci_urb_dequeue(struct usb_h
 		 * vhci_rx will receive RET_UNLINK and give back the URB.
 		 * Otherwise, we give back it here.
 		 */
-		pr_info("gives back urb %p\n", urb);
-
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
 
 		spin_unlock_irqrestore(&the_controller->lock, flags);
@@ -701,8 +693,6 @@ static int vhci_urb_dequeue(struct usb_h
 
 		unlink->unlink_seqnum = priv->seqnum;
 
-		pr_info("device %p seems to be still connected\n", vdev);
-
 		/* send cmd_unlink and try to cancel the pending URB in the
 		 * peer */
 		list_add_tail(&unlink->list, &vdev->unlink_tx);
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -37,24 +37,23 @@ struct urb *pickup_urb_and_free_priv(str
 		urb = priv->urb;
 		status = urb->status;
 
-		usbip_dbg_vhci_rx("find urb %p vurb %p seqnum %u\n",
-				urb, priv, seqnum);
+		usbip_dbg_vhci_rx("find urb seqnum %u\n", seqnum);
 
 		switch (status) {
 		case -ENOENT:
 			/* fall through */
 		case -ECONNRESET:
-			dev_info(&urb->dev->dev,
-				 "urb %p was unlinked %ssynchronuously.\n", urb,
-				 status == -ENOENT ? "" : "a");
+			dev_dbg(&urb->dev->dev,
+				 "urb seq# %u was unlinked %ssynchronuously\n",
+				 seqnum, status == -ENOENT ? "" : "a");
 			break;
 		case -EINPROGRESS:
 			/* no info output */
 			break;
 		default:
-			dev_info(&urb->dev->dev,
-				 "urb %p may be in a error, status %d\n", urb,
-				 status);
+			dev_dbg(&urb->dev->dev,
+				 "urb seq# %u may be in a error, status %d\n",
+				 seqnum, status);
 		}
 
 		list_del(&priv->list);
@@ -79,8 +78,8 @@ static void vhci_recv_ret_submit(struct
 	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	if (!urb) {
-		pr_err("cannot find a urb of seqnum %u\n", pdu->base.seqnum);
-		pr_info("max seqnum %d\n",
+		pr_err("cannot find a urb of seqnum %u max seqnum %d\n",
+			pdu->base.seqnum,
 			atomic_read(&the_controller->seqnum));
 		usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
 		return;
@@ -103,7 +102,7 @@ static void vhci_recv_ret_submit(struct
 	if (usbip_dbg_flag_vhci_rx)
 		usbip_dump_urb(urb);
 
-	usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
+	usbip_dbg_vhci_rx("now giveback urb %u\n", pdu->base.seqnum);
 
 	spin_lock_irqsave(&the_controller->lock, flags);
 	usb_hcd_unlink_urb_from_ep(vhci_to_hcd(the_controller), urb);
@@ -168,7 +167,7 @@ static void vhci_recv_ret_unlink(struct
 		pr_info("the urb (seqnum %d) was already given back\n",
 			pdu->base.seqnum);
 	} else {
-		usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
+		usbip_dbg_vhci_rx("now giveback urb %d\n", pdu->base.seqnum);
 
 		/* If unlink is successful, status is -ECONNRESET */
 		urb->status = pdu->u.ret_unlink.status;
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -83,7 +83,8 @@ static int vhci_send_cmd_submit(struct v
 		memset(&msg, 0, sizeof(msg));
 		memset(&iov, 0, sizeof(iov));
 
-		usbip_dbg_vhci_tx("setup txdata urb %p\n", urb);
+		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
+				  priv->seqnum);
 
 		/* 1. setup usbip_header */
 		setup_cmd_submit_pdu(&pdu_header, urb);
