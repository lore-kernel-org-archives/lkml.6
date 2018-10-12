Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6958AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA162086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA162086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeJLQFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:05:35 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48208 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbeJLQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:05:34 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAstc-0005Td-U9; Fri, 12 Oct 2018 09:34:09 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gAstc-00052n-AO; Fri, 12 Oct 2018 09:34:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 7/8] usbnet: smsc95xx: add usbnet -> priv function
Date:   Fri, 12 Oct 2018 09:34:04 +0100
Message-Id: <20181012083405.19246-8-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012083405.19246-1-ben.dooks@codethink.co.uk>
References: <20181012083405.19246-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places in the smsc95xx driver where it gets the
private-data from the usbnet passed in. It would be sensible to have
one inline function to convert it and change all points in the driver
to use that.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/smsc95xx.c | 47 +++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 03c3c02b569c..1eb0795ec90f 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -78,6 +78,11 @@ struct smsc95xx_priv {
 	struct usbnet *dev;
 };
 
+static inline struct smsc95xx_priv *usbnet_to_smsc(struct usbnet *dev)
+{
+	return (struct smsc95xx_priv *)dev->data[0];
+}
+
 static bool turbo_mode = IS_ENABLED(CONFIG_USB_NET_SMSC95XX_TURBO);
 module_param(turbo_mode, bool, 0644);
 MODULE_PARM_DESC(turbo_mode, "Enable multiple frames per Rx transaction");
@@ -467,7 +472,7 @@ static unsigned int smsc95xx_hash(char addr[ETH_ALEN])
 static void smsc95xx_set_multicast(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	unsigned long flags;
 	int ret;
 
@@ -562,7 +567,7 @@ static int smsc95xx_phy_update_flowcontrol(struct usbnet *dev, u8 duplex,
 
 static int smsc95xx_link_reset(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	struct mii_if_info *mii = &dev->mii;
 	struct ethtool_cmd ecmd = { .cmd = ETHTOOL_GSET };
 	unsigned long flags;
@@ -630,7 +635,7 @@ static void smsc95xx_status(struct usbnet *dev, struct urb *urb)
 
 static void set_carrier(struct usbnet *dev, bool link)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 
 	if (pdata->link_ok == link)
 		return;
@@ -759,7 +764,7 @@ static void smsc95xx_ethtool_get_wol(struct net_device *net,
 				     struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 
 	wolinfo->supported = SUPPORTED_WAKE;
 	wolinfo->wolopts = pdata->wolopts;
@@ -769,7 +774,7 @@ static int smsc95xx_ethtool_set_wol(struct net_device *net,
 				    struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	int ret;
 
 	pdata->wolopts = wolinfo->wolopts & SUPPORTED_WAKE;
@@ -805,7 +810,7 @@ static int get_mdix_status(struct net_device *net)
 static void set_mdix_status(struct net_device *net, __u8 mdix_ctrl)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	int buf;
 
 	if ((pdata->chip_id == ID_REV_CHIP_ID_9500A_) ||
@@ -854,7 +859,7 @@ static int smsc95xx_get_link_ksettings(struct net_device *net,
 				       struct ethtool_link_ksettings *cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	int retval;
 
 	retval = usbnet_get_link_ksettings(net, cmd);
@@ -869,7 +874,7 @@ static int smsc95xx_set_link_ksettings(struct net_device *net,
 				       const struct ethtool_link_ksettings *cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	int retval;
 
 	if (pdata->mdix_ctrl != cmd->base.eth_tp_mdix_ctrl)
@@ -951,7 +956,7 @@ static int smsc95xx_set_mac_address(struct usbnet *dev)
 /* starts the TX path */
 static int smsc95xx_start_tx_path(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	unsigned long flags;
 	int ret;
 
@@ -971,7 +976,7 @@ static int smsc95xx_start_tx_path(struct usbnet *dev)
 /* Starts the Receive path */
 static int smsc95xx_start_rx_path(struct usbnet *dev, int in_pm)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&pdata->mac_cr_lock, flags);
@@ -1028,7 +1033,7 @@ static int smsc95xx_phy_initialize(struct usbnet *dev)
 
 static int smsc95xx_reset(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 read_buf, write_buf, burst_cap;
 	int ret = 0, timeout;
 
@@ -1271,7 +1276,7 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	dev->data[0] = (unsigned long)kzalloc(sizeof(struct smsc95xx_priv),
 					      GFP_KERNEL);
 
-	pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	pdata = usbnet_to_smsc(dev);
 	if (!pdata)
 		return -ENOMEM;
 
@@ -1328,7 +1333,7 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static void smsc95xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 
 	if (pdata) {
 		cancel_delayed_work(&pdata->carrier_check);
@@ -1388,7 +1393,7 @@ static int smsc95xx_link_ok_nopm(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend0(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 val;
 	int ret;
 
@@ -1427,7 +1432,7 @@ static int smsc95xx_enter_suspend0(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend1(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	struct mii_if_info *mii = &dev->mii;
 	u32 val;
 	int ret;
@@ -1475,7 +1480,7 @@ static int smsc95xx_enter_suspend1(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend2(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 val;
 	int ret;
 
@@ -1497,7 +1502,7 @@ static int smsc95xx_enter_suspend2(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend3(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 val;
 	int ret;
 
@@ -1536,7 +1541,7 @@ static int smsc95xx_enter_suspend3(struct usbnet *dev)
 
 static int smsc95xx_autosuspend(struct usbnet *dev, u32 link_up)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	int ret;
 
 	if (!netif_running(dev->net)) {
@@ -1584,7 +1589,7 @@ static int smsc95xx_autosuspend(struct usbnet *dev, u32 link_up)
 static int smsc95xx_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 val, link_up;
 	int ret;
 
@@ -1848,7 +1853,7 @@ static int smsc95xx_resume(struct usb_interface *intf)
 	u32 val;
 
 	BUG_ON(!dev);
-	pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	pdata = usbnet_to_smsc(dev);
 	suspend_flags = pdata->suspend_flags;
 
 	netdev_dbg(dev->net, "resume suspend_flags=0x%02x\n", suspend_flags);
@@ -2084,7 +2089,7 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 
 static int smsc95xx_manage_power(struct usbnet *dev, int on)
 {
-	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
+	struct smsc95xx_priv *pdata = usbnet_to_smsc(dev);
 
 	dev->intf->needs_remote_wakeup = on;
 
-- 
2.19.1

