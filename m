Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226AaY7G40jSa38jLvd/bgIhhZk5xtRWYjEf2sCezsK9KU+zn5ktW30ROpsMjsoulHGnopEm
ARC-Seal: i=1; a=rsa-sha256; t=1518708034; cv=none;
        d=google.com; s=arc-20160816;
        b=lgOqB5cQjAw3a/maWZxtUApalKNwzBbSEgtklxUN3dZeVxwqMjvjJlXDDKiH1BpChI
         +2DLWSrQsBRZ1I7kMdPuc/N9Py/zRUdSvrQlaAv4Iu8YT87X3UT31RcrippAJGTjZDBx
         wOSpOrYxSJQks8WCfeK8UA/QRDhFRP3haHn8z+A6okzH1PCjD6db3Xasni2srdnB6t4f
         79bOBKeNyG/Xo3ipeaSiuYb2HrNEMvPuhqMndD3B1cuQQKYqFftAN+j6ZBs+VGu3Bkw5
         EFF3XPQWS+NF+oPKWgJb1ieGAD1o7anShxi5tt/G042l9uO9aPuR83EmeMc3IjsRkCe5
         7IMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KXU24SWJP9hzXpD5SHDvIK8+ZRF7C1SGWEYNEo/gMV4=;
        b=wVD6tawN/WfV6CDpmiBxLV9b5czuapmwe6P4MssGnFGhPDsuPu3vDRymayRr00vNFf
         sst8YSs0lioOFp5nkE2miA/VKGIM5zPbTW6NXCneukHOOUCzvIaKtn/HWzqRol0dq6iU
         OYXQbcDgI0bREZl3dmX5g9Qim7Rpz5aE8fcVzCvY5GT2f0GhTC6tm140wVELTUMwovip
         zdK5w6ukSNfr+KxETjRQU9TTmiDr+my+4CSESI5c70tdxJn57hwb86hf4IXyTMe1NF3j
         CQhrGnDCS2sizLpSR14tRXAWwEiGnCjpDa3tG5Uit0nT9OFClYNpSe80JsdgjfqOV4ip
         /22A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrew Goodbody <andrew.goodbody@cambrionix.com>,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 19/45] usb: usbip: Fix possible deadlocks reported by lockdep
Date: Thu, 15 Feb 2018 16:17:10 +0100
Message-Id: <20180215144120.038606867@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480795539268142?=
X-GMAIL-MSGID: =?utf-8?q?1592480795539268142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Goodbody <andrew.goodbody@cambrionix.com>

commit 21619792d1eca7e772ca190ba68588e57f29595b upstream.

Change spin_lock calls to spin_lock_irqsave to prevent
attmpted recursive lock taking in interrupt context.

This patch fixes Bug 109351
  https://bugzilla.kernel.org/show_bug.cgi?id=109351

Signed-off-by: Andrew Goodbody <andrew.goodbody@cambrionix.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/usbip_event.c |    5 +-
 drivers/usb/usbip/vhci_hcd.c    |   88 +++++++++++++++++++++++-----------------
 drivers/usb/usbip/vhci_rx.c     |   30 +++++++------
 drivers/usb/usbip/vhci_sysfs.c  |   19 +++++---
 drivers/usb/usbip/vhci_tx.c     |   14 +++---
 5 files changed, 91 insertions(+), 65 deletions(-)

--- a/drivers/usb/usbip/usbip_event.c
+++ b/drivers/usb/usbip/usbip_event.c
@@ -117,11 +117,12 @@ EXPORT_SYMBOL_GPL(usbip_event_add);
 int usbip_event_happened(struct usbip_device *ud)
 {
 	int happened = 0;
+	unsigned long flags;
 
-	spin_lock(&ud->lock);
+	spin_lock_irqsave(&ud->lock, flags);
 	if (ud->event != 0)
 		happened = 1;
-	spin_unlock(&ud->lock);
+	spin_unlock_irqrestore(&ud->lock, flags);
 
 	return happened;
 }
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -121,9 +121,11 @@ static void dump_port_status_diff(u32 pr
 
 void rh_port_connect(int rhport, enum usb_device_speed speed)
 {
+	unsigned long	flags;
+
 	usbip_dbg_vhci_rh("rh_port_connect %d\n", rhport);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	the_controller->port_status[rhport] |= USB_PORT_STAT_CONNECTION
 		| (1 << USB_PORT_FEAT_C_CONNECTION);
@@ -139,22 +141,24 @@ void rh_port_connect(int rhport, enum us
 		break;
 	}
 
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	usb_hcd_poll_rh_status(vhci_to_hcd(the_controller));
 }
 
 static void rh_port_disconnect(int rhport)
 {
+	unsigned long	flags;
+
 	usbip_dbg_vhci_rh("rh_port_disconnect %d\n", rhport);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	the_controller->port_status[rhport] &= ~USB_PORT_STAT_CONNECTION;
 	the_controller->port_status[rhport] |=
 					(1 << USB_PORT_FEAT_C_CONNECTION);
 
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 	usb_hcd_poll_rh_status(vhci_to_hcd(the_controller));
 }
 
@@ -182,13 +186,14 @@ static int vhci_hub_status(struct usb_hc
 	int		retval;
 	int		rhport;
 	int		changed = 0;
+	unsigned long	flags;
 
 	retval = DIV_ROUND_UP(VHCI_NPORTS + 1, 8);
 	memset(buf, 0, retval);
 
 	vhci = hcd_to_vhci(hcd);
 
-	spin_lock(&vhci->lock);
+	spin_lock_irqsave(&vhci->lock, flags);
 	if (!HCD_HW_ACCESSIBLE(hcd)) {
 		usbip_dbg_vhci_rh("hw accessible flag not on?\n");
 		goto done;
@@ -209,7 +214,7 @@ static int vhci_hub_status(struct usb_hc
 		usb_hcd_resume_root_hub(hcd);
 
 done:
-	spin_unlock(&vhci->lock);
+	spin_unlock_irqrestore(&vhci->lock, flags);
 	return changed ? retval : 0;
 }
 
@@ -230,6 +235,7 @@ static int vhci_hub_control(struct usb_h
 	struct vhci_hcd	*dum;
 	int             retval = 0;
 	int		rhport;
+	unsigned long	flags;
 
 	u32 prev_port_status[VHCI_NPORTS];
 
@@ -248,7 +254,7 @@ static int vhci_hub_control(struct usb_h
 
 	dum = hcd_to_vhci(hcd);
 
-	spin_lock(&dum->lock);
+	spin_lock_irqsave(&dum->lock, flags);
 
 	/* store old status and compare now and old later */
 	if (usbip_dbg_flag_vhci_rh) {
@@ -402,7 +408,7 @@ static int vhci_hub_control(struct usb_h
 	}
 	usbip_dbg_vhci_rh(" bye\n");
 
-	spin_unlock(&dum->lock);
+	spin_unlock_irqrestore(&dum->lock, flags);
 
 	return retval;
 }
@@ -425,6 +431,7 @@ static void vhci_tx_urb(struct urb *urb)
 {
 	struct vhci_device *vdev = get_vdev(urb->dev);
 	struct vhci_priv *priv;
+	unsigned long flags;
 
 	if (!vdev) {
 		pr_err("could not get virtual device");
@@ -437,7 +444,7 @@ static void vhci_tx_urb(struct urb *urb)
 		return;
 	}
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 
 	priv->seqnum = atomic_inc_return(&the_controller->seqnum);
 	if (priv->seqnum == 0xffff)
@@ -451,7 +458,7 @@ static void vhci_tx_urb(struct urb *urb)
 	list_add_tail(&priv->list, &vdev->priv_tx);
 
 	wake_up(&vdev->waitq_tx);
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 }
 
 static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
@@ -460,6 +467,7 @@ static int vhci_urb_enqueue(struct usb_h
 	struct device *dev = &urb->dev->dev;
 	int ret = 0;
 	struct vhci_device *vdev;
+	unsigned long flags;
 
 	usbip_dbg_vhci_hc("enter, usb_hcd %p urb %p mem_flags %d\n",
 			  hcd, urb, mem_flags);
@@ -467,11 +475,11 @@ static int vhci_urb_enqueue(struct usb_h
 	/* patch to usb_sg_init() is in 2.5.60 */
 	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	if (urb->status != -EINPROGRESS) {
 		dev_err(dev, "URB already unlinked!, status %d\n", urb->status);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 		return urb->status;
 	}
 
@@ -483,7 +491,7 @@ static int vhci_urb_enqueue(struct usb_h
 	    vdev->ud.status == VDEV_ST_ERROR) {
 		dev_err(dev, "enqueue for inactive port %d\n", vdev->rhport);
 		spin_unlock(&vdev->ud.lock);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 		return -ENODEV;
 	}
 	spin_unlock(&vdev->ud.lock);
@@ -558,14 +566,14 @@ static int vhci_urb_enqueue(struct usb_h
 
 out:
 	vhci_tx_urb(urb);
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	return 0;
 
 no_need_xmit:
 	usb_hcd_unlink_urb_from_ep(hcd, urb);
 no_need_unlink:
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 	usb_hcd_giveback_urb(vhci_to_hcd(the_controller), urb, urb->status);
 	return ret;
 }
@@ -620,16 +628,17 @@ static int vhci_urb_dequeue(struct usb_h
 {
 	struct vhci_priv *priv;
 	struct vhci_device *vdev;
+	unsigned long flags;
 
 	pr_info("dequeue a urb %p\n", urb);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	priv = urb->hcpriv;
 	if (!priv) {
 		/* URB was never linked! or will be soon given back by
 		 * vhci_rx. */
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 		return 0;
 	}
 
@@ -638,7 +647,7 @@ static int vhci_urb_dequeue(struct usb_h
 
 		ret = usb_hcd_check_unlink_urb(hcd, urb, status);
 		if (ret) {
-			spin_unlock(&the_controller->lock);
+			spin_unlock_irqrestore(&the_controller->lock, flags);
 			return ret;
 		}
 	}
@@ -666,10 +675,10 @@ static int vhci_urb_dequeue(struct usb_h
 
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
 
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 		usb_hcd_giveback_urb(vhci_to_hcd(the_controller), urb,
 				     urb->status);
-		spin_lock(&the_controller->lock);
+		spin_lock_irqsave(&the_controller->lock, flags);
 
 	} else {
 		/* tcp connection is alive */
@@ -681,7 +690,7 @@ static int vhci_urb_dequeue(struct usb_h
 		unlink = kzalloc(sizeof(struct vhci_unlink), GFP_ATOMIC);
 		if (!unlink) {
 			spin_unlock(&vdev->priv_lock);
-			spin_unlock(&the_controller->lock);
+			spin_unlock_irqrestore(&the_controller->lock, flags);
 			usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_MALLOC);
 			return -ENOMEM;
 		}
@@ -702,7 +711,7 @@ static int vhci_urb_dequeue(struct usb_h
 		spin_unlock(&vdev->priv_lock);
 	}
 
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	usbip_dbg_vhci_hc("leave\n");
 	return 0;
@@ -711,8 +720,9 @@ static int vhci_urb_dequeue(struct usb_h
 static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 {
 	struct vhci_unlink *unlink, *tmp;
+	unsigned long flags;
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 	spin_lock(&vdev->priv_lock);
 
 	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
@@ -746,19 +756,19 @@ static void vhci_device_unlink_cleanup(s
 		list_del(&unlink->list);
 
 		spin_unlock(&vdev->priv_lock);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 
 		usb_hcd_giveback_urb(vhci_to_hcd(the_controller), urb,
 				     urb->status);
 
-		spin_lock(&the_controller->lock);
+		spin_lock_irqsave(&the_controller->lock, flags);
 		spin_lock(&vdev->priv_lock);
 
 		kfree(unlink);
 	}
 
 	spin_unlock(&vdev->priv_lock);
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 }
 
 /*
@@ -825,8 +835,9 @@ static void vhci_shutdown_connection(str
 static void vhci_device_reset(struct usbip_device *ud)
 {
 	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
+	unsigned long flags;
 
-	spin_lock(&ud->lock);
+	spin_lock_irqsave(&ud->lock, flags);
 
 	vdev->speed  = 0;
 	vdev->devid  = 0;
@@ -841,14 +852,16 @@ static void vhci_device_reset(struct usb
 	}
 	ud->status = VDEV_ST_NULL;
 
-	spin_unlock(&ud->lock);
+	spin_unlock_irqrestore(&ud->lock, flags);
 }
 
 static void vhci_device_unusable(struct usbip_device *ud)
 {
-	spin_lock(&ud->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ud->lock, flags);
 	ud->status = VDEV_ST_ERROR;
-	spin_unlock(&ud->lock);
+	spin_unlock_irqrestore(&ud->lock, flags);
 }
 
 static void vhci_device_init(struct vhci_device *vdev)
@@ -938,12 +951,13 @@ static int vhci_get_frame_number(struct
 static int vhci_bus_suspend(struct usb_hcd *hcd)
 {
 	struct vhci_hcd *vhci = hcd_to_vhci(hcd);
+	unsigned long flags;
 
 	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
 
-	spin_lock(&vhci->lock);
+	spin_lock_irqsave(&vhci->lock, flags);
 	hcd->state = HC_STATE_SUSPENDED;
-	spin_unlock(&vhci->lock);
+	spin_unlock_irqrestore(&vhci->lock, flags);
 
 	return 0;
 }
@@ -952,15 +966,16 @@ static int vhci_bus_resume(struct usb_hc
 {
 	struct vhci_hcd *vhci = hcd_to_vhci(hcd);
 	int rc = 0;
+	unsigned long flags;
 
 	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
 
-	spin_lock(&vhci->lock);
+	spin_lock_irqsave(&vhci->lock, flags);
 	if (!HCD_HW_ACCESSIBLE(hcd))
 		rc = -ESHUTDOWN;
 	else
 		hcd->state = HC_STATE_RUNNING;
-	spin_unlock(&vhci->lock);
+	spin_unlock_irqrestore(&vhci->lock, flags);
 
 	return rc;
 }
@@ -1058,17 +1073,18 @@ static int vhci_hcd_suspend(struct platf
 	int rhport = 0;
 	int connected = 0;
 	int ret = 0;
+	unsigned long flags;
 
 	hcd = platform_get_drvdata(pdev);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	for (rhport = 0; rhport < VHCI_NPORTS; rhport++)
 		if (the_controller->port_status[rhport] &
 		    USB_PORT_STAT_CONNECTION)
 			connected += 1;
 
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	if (connected > 0) {
 		dev_info(&pdev->dev,
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -72,10 +72,11 @@ static void vhci_recv_ret_submit(struct
 {
 	struct usbip_device *ud = &vdev->ud;
 	struct urb *urb;
+	unsigned long flags;
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 	urb = pickup_urb_and_free_priv(vdev, pdu->base.seqnum);
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	if (!urb) {
 		pr_err("cannot find a urb of seqnum %u\n", pdu->base.seqnum);
@@ -104,9 +105,9 @@ static void vhci_recv_ret_submit(struct
 
 	usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 	usb_hcd_unlink_urb_from_ep(vhci_to_hcd(the_controller), urb);
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	usb_hcd_giveback_urb(vhci_to_hcd(the_controller), urb, urb->status);
 
@@ -117,8 +118,9 @@ static struct vhci_unlink *dequeue_pendi
 						  struct usbip_header *pdu)
 {
 	struct vhci_unlink *unlink, *tmp;
+	unsigned long flags;
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 
 	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_rx, list) {
 		pr_info("unlink->seqnum %lu\n", unlink->seqnum);
@@ -127,12 +129,12 @@ static struct vhci_unlink *dequeue_pendi
 					  unlink->seqnum);
 			list_del(&unlink->list);
 
-			spin_unlock(&vdev->priv_lock);
+			spin_unlock_irqrestore(&vdev->priv_lock, flags);
 			return unlink;
 		}
 	}
 
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	return NULL;
 }
@@ -142,6 +144,7 @@ static void vhci_recv_ret_unlink(struct
 {
 	struct vhci_unlink *unlink;
 	struct urb *urb;
+	unsigned long flags;
 
 	usbip_dump_header(pdu);
 
@@ -152,9 +155,9 @@ static void vhci_recv_ret_unlink(struct
 		return;
 	}
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 	urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	if (!urb) {
 		/*
@@ -171,9 +174,9 @@ static void vhci_recv_ret_unlink(struct
 		urb->status = pdu->u.ret_unlink.status;
 		pr_info("urb->status %d\n", urb->status);
 
-		spin_lock(&the_controller->lock);
+		spin_lock_irqsave(&the_controller->lock, flags);
 		usb_hcd_unlink_urb_from_ep(vhci_to_hcd(the_controller), urb);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 
 		usb_hcd_giveback_urb(vhci_to_hcd(the_controller), urb,
 				     urb->status);
@@ -185,10 +188,11 @@ static void vhci_recv_ret_unlink(struct
 static int vhci_priv_tx_empty(struct vhci_device *vdev)
 {
 	int empty = 0;
+	unsigned long flags;
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 	empty = list_empty(&vdev->priv_rx);
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	return empty;
 }
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -32,10 +32,11 @@ static ssize_t status_show(struct device
 {
 	char *s = out;
 	int i = 0;
+	unsigned long flags;
 
 	BUG_ON(!the_controller || !out);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	/*
 	 * output example:
@@ -73,7 +74,7 @@ static ssize_t status_show(struct device
 		spin_unlock(&vdev->ud.lock);
 	}
 
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	return out - s;
 }
@@ -83,11 +84,12 @@ static DEVICE_ATTR_RO(status);
 static int vhci_port_disconnect(__u32 rhport)
 {
 	struct vhci_device *vdev;
+	unsigned long flags;
 
 	usbip_dbg_vhci_sysfs("enter\n");
 
 	/* lock */
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	vdev = port_to_vdev(rhport);
 
@@ -97,14 +99,14 @@ static int vhci_port_disconnect(__u32 rh
 
 		/* unlock */
 		spin_unlock(&vdev->ud.lock);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 
 		return -EINVAL;
 	}
 
 	/* unlock */
 	spin_unlock(&vdev->ud.lock);
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	usbip_event_add(&vdev->ud, VDEV_EVENT_DOWN);
 
@@ -180,6 +182,7 @@ static ssize_t store_attach(struct devic
 	int sockfd = 0;
 	__u32 rhport = 0, devid = 0, speed = 0;
 	int err;
+	unsigned long flags;
 
 	/*
 	 * @rhport: port number of vhci_hcd
@@ -205,14 +208,14 @@ static ssize_t store_attach(struct devic
 	/* now need lock until setting vdev status as used */
 
 	/* begin a lock */
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 	vdev = port_to_vdev(rhport);
 	spin_lock(&vdev->ud.lock);
 
 	if (vdev->ud.status != VDEV_ST_NULL) {
 		/* end of the lock */
 		spin_unlock(&vdev->ud.lock);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 
 		sockfd_put(socket);
 
@@ -231,7 +234,7 @@ static ssize_t store_attach(struct devic
 	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
 
 	spin_unlock(&vdev->ud.lock);
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 	/* end the lock */
 
 	vdev->ud.tcp_rx = kthread_get_run(vhci_rx_loop, &vdev->ud, "vhci_rx");
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -47,16 +47,17 @@ static void setup_cmd_submit_pdu(struct
 static struct vhci_priv *dequeue_from_priv_tx(struct vhci_device *vdev)
 {
 	struct vhci_priv *priv, *tmp;
+	unsigned long flags;
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 
 	list_for_each_entry_safe(priv, tmp, &vdev->priv_tx, list) {
 		list_move_tail(&priv->list, &vdev->priv_rx);
-		spin_unlock(&vdev->priv_lock);
+		spin_unlock_irqrestore(&vdev->priv_lock, flags);
 		return priv;
 	}
 
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	return NULL;
 }
@@ -136,16 +137,17 @@ static int vhci_send_cmd_submit(struct v
 static struct vhci_unlink *dequeue_from_unlink_tx(struct vhci_device *vdev)
 {
 	struct vhci_unlink *unlink, *tmp;
+	unsigned long flags;
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 
 	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
 		list_move_tail(&unlink->list, &vdev->unlink_rx);
-		spin_unlock(&vdev->priv_lock);
+		spin_unlock_irqrestore(&vdev->priv_lock, flags);
 		return unlink;
 	}
 
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	return NULL;
 }
