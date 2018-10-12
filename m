Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0613C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4A52086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4A52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeJLQGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:06:00 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48209 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeJLQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:05:33 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAstc-0005Te-Up; Fri, 12 Oct 2018 09:34:09 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gAstc-00052q-BR; Fri, 12 Oct 2018 09:34:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 8/8] usbnet: smsc95xx: add rx_turbo attribute
Date:   Fri, 12 Oct 2018 09:34:05 +0100
Message-Id: <20181012083405.19246-9-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012083405.19246-1-ben.dooks@codethink.co.uk>
References: <20181012083405.19246-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add attribute for the rx_turbo mode to allow run-time configuration of
this feature.

Note, this requires a restart of the device to take effect.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/smsc95xx.c | 41 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 1eb0795ec90f..330c3cf5d6f6 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -73,6 +73,7 @@ struct smsc95xx_priv {
 	u8 features;
 	u8 suspend_flags;
 	u8 mdix_ctrl;
+	bool rx_turbo;
 	bool link_ok;
 	struct delayed_work carrier_check;
 	struct usbnet *dev;
@@ -1103,7 +1104,7 @@ static int smsc95xx_reset(struct usbnet *dev)
 		  "Read Value from HW_CFG after writing HW_CFG_BIR_: 0x%08x\n",
 		  read_buf);
 
-	if (!turbo_mode) {
+	if (!pdata->rx_turbo) {
 		burst_cap = 0;
 		dev->rx_urb_size = MAX_SINGLE_PACKET_SIZE;
 	} else if (dev->udev->speed == USB_SPEED_HIGH) {
@@ -1259,6 +1260,37 @@ static const struct net_device_ops smsc95xx_netdev_ops = {
 	.ndo_set_features	= smsc95xx_set_features,
 };
 
+static inline struct smsc95xx_priv *dev_to_priv(struct device *dev)
+{
+	struct usb_interface *ui = container_of(dev, struct usb_interface, dev);
+	return usbnet_to_smsc(usb_get_intfdata(ui));
+}
+
+/* Currently rx_turbo will not take effect until next close/open */
+static ssize_t rx_turbo_show(struct device *adev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct smsc95xx_priv *priv = dev_to_priv(adev);
+	return snprintf(buf, PAGE_SIZE, "%d", priv->rx_turbo);
+}
+
+static ssize_t rx_turbo_store(struct device *adev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct smsc95xx_priv *priv = dev_to_priv(adev);
+	bool res;
+
+	if (kstrtobool(buf, &res))
+		return -EINVAL;
+
+	priv->rx_turbo = res;
+	return count;
+}
+
+static DEVICE_ATTR_RW(rx_turbo);
+
 static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	struct smsc95xx_priv *pdata = NULL;
@@ -1280,6 +1312,7 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	if (!pdata)
 		return -ENOMEM;
 
+	pdata->rx_turbo = turbo_mode;
 	spin_lock_init(&pdata->mac_cr_lock);
 
 	/* LAN95xx devices do not alter the computed checksum of 0 to 0xffff.
@@ -1328,6 +1361,11 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	INIT_DELAYED_WORK(&pdata->carrier_check, check_carrier);
 	schedule_delayed_work(&pdata->carrier_check, CARRIER_CHECK_DELAY);
 
+	ret = device_create_file(&dev->udev->dev, &dev_attr_rx_turbo);
+	if (ret)
+		netdev_warn(dev->net,
+			    "failed to create rx_turbo attribute: %d\n", ret);
+
 	return 0;
 }
 
@@ -1336,6 +1374,7 @@ static void smsc95xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 
 	if (pdata) {
+		device_remove_file(&dev->udev->dev, &dev_attr_rx_turbo);
 		cancel_delayed_work(&pdata->carrier_check);
 		netif_dbg(dev, ifdown, dev->net, "free pdata\n");
 		kfree(pdata);
-- 
2.19.1

