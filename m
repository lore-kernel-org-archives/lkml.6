Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D51DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85B6204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85B6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeJAWlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:41:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:40068 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeJAWlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:41:25 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g70ek-0001EW-B3; Mon, 01 Oct 2018 17:02:46 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1g70ek-0002iv-0l; Mon, 01 Oct 2018 17:02:46 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@lists.codethink.co.uk, oneukum@suse.com,
        davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] net: usbnet: make driver_info const
Date:   Mon,  1 Oct 2018 17:02:43 +0100
Message-Id: <20181001160243.10428-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben-linux@fluff.org>

The driver_info field that is used for describing each of the usb-net
drivers using the usbnet.c core all declare their information as const
and the usbnet.c itself does not try and modify the struct.

It is therefore a good idea to make this const in the usbnet.c structure
in case anyone tries to modify it.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/usbnet.c   | 12 ++++++------
 include/linux/usb/usbnet.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 770aa624147f..d6b3833c292d 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -802,7 +802,7 @@ static void usbnet_terminate_urbs(struct usbnet *dev)
 int usbnet_stop (struct net_device *net)
 {
 	struct usbnet		*dev = netdev_priv(net);
-	struct driver_info	*info = dev->driver_info;
+	const struct driver_info *info = dev->driver_info;
 	int			retval, pm, mpn;
 
 	clear_bit(EVENT_DEV_OPEN, &dev->flags);
@@ -865,7 +865,7 @@ int usbnet_open (struct net_device *net)
 {
 	struct usbnet		*dev = netdev_priv(net);
 	int			retval;
-	struct driver_info	*info = dev->driver_info;
+	const struct driver_info *info = dev->driver_info;
 
 	if ((retval = usb_autopm_get_interface(dev->intf)) < 0) {
 		netif_info(dev, ifup, dev->net,
@@ -1205,7 +1205,7 @@ usbnet_deferred_kevent (struct work_struct *work)
 	}
 
 	if (test_bit (EVENT_LINK_RESET, &dev->flags)) {
-		struct driver_info	*info = dev->driver_info;
+		const struct driver_info *info = dev->driver_info;
 		int			retval = 0;
 
 		clear_bit (EVENT_LINK_RESET, &dev->flags);
@@ -1353,7 +1353,7 @@ netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
 	unsigned int			length;
 	struct urb		*urb = NULL;
 	struct skb_data		*entry;
-	struct driver_info	*info = dev->driver_info;
+	const struct driver_info *info = dev->driver_info;
 	unsigned long		flags;
 	int retval;
 
@@ -1646,7 +1646,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	struct usbnet			*dev;
 	struct net_device		*net;
 	struct usb_host_interface	*interface;
-	struct driver_info		*info;
+	const struct driver_info	*info;
 	struct usb_device		*xdev;
 	int				status;
 	const char			*name;
@@ -1662,7 +1662,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	}
 
 	name = udev->dev.driver->name;
-	info = (struct driver_info *) prod->driver_info;
+	info = (const struct driver_info *) prod->driver_info;
 	if (!info) {
 		dev_dbg (&udev->dev, "blacklisted by %s\n", name);
 		return -ENODEV;
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index e2ec3582e549..d8860f2d0976 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -28,7 +28,7 @@ struct usbnet {
 	/* housekeeping */
 	struct usb_device	*udev;
 	struct usb_interface	*intf;
-	struct driver_info	*driver_info;
+	const struct driver_info *driver_info;
 	const char		*driver_name;
 	void			*driver_priv;
 	wait_queue_head_t	wait;
-- 
2.19.0

