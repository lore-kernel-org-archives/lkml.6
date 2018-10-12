Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505FAC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B9B2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B9B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeJLQs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:48:27 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49443 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbeJLQs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:48:26 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAtYz-0006u0-0F; Fri, 12 Oct 2018 10:16:53 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gAtYy-0005YM-Ep; Fri, 12 Oct 2018 10:16:52 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, gregkh@linuxfoundation.org,
        bjorn@mork.no, steve.glendinning@shawell.net,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/7] net: smsc75xx: add usbnet -> priv function
Date:   Fri, 12 Oct 2018 10:16:36 +0100
Message-Id: <20181012091642.21294-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places in the smsc75xx driver where it gets the
private-data from the usbnet passed in. It would be sensible to have
one inline function to convert it and change all points in the driver
to use that.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/smsc75xx.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 05553d252446..6d12fcd9b4b0 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -73,6 +73,11 @@ struct smsc75xx_priv {
 	u8 suspend_flags;
 };
 
+static inline struct smsc75xx_priv *usbnet_to_smsc(struct usbnet *dev)
+{
+	return (struct smsc75xx_priv *)dev->data[0];
+}
+
 struct usb_context {
 	struct usb_ctrlrequest req;
 	struct usbnet *dev;
@@ -469,7 +474,7 @@ static int smsc75xx_dataport_wait_not_busy(struct usbnet *dev)
 static int smsc75xx_dataport_write(struct usbnet *dev, u32 ram_select, u32 addr,
 				   u32 length, u32 *buf)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 dp_sel;
 	int i, ret;
 
@@ -553,7 +558,7 @@ static void smsc75xx_deferred_multicast_write(struct work_struct *param)
 static void smsc75xx_set_multicast(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	unsigned long flags;
 	int i;
 
@@ -718,7 +723,7 @@ static void smsc75xx_ethtool_get_wol(struct net_device *net,
 				     struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 
 	wolinfo->supported = SUPPORTED_WAKE;
 	wolinfo->wolopts = pdata->wolopts;
@@ -728,7 +733,7 @@ static int smsc75xx_ethtool_set_wol(struct net_device *net,
 				    struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	int ret;
 
 	pdata->wolopts = wolinfo->wolopts & SUPPORTED_WAKE;
@@ -945,7 +950,7 @@ static int smsc75xx_set_features(struct net_device *netdev,
 	netdev_features_t features)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	unsigned long flags;
 	int ret;
 
@@ -1051,7 +1056,7 @@ static int smsc75xx_phy_gig_workaround(struct usbnet *dev)
 
 static int smsc75xx_reset(struct usbnet *dev)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 buf;
 	int ret = 0, timeout;
 
@@ -1515,7 +1520,7 @@ static int smsc75xx_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static void smsc75xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	if (pdata) {
 		netif_dbg(dev, ifdown, dev->net, "free pdata\n");
 		kfree(pdata);
@@ -1571,7 +1576,7 @@ static int smsc75xx_write_wuff(struct usbnet *dev, int filter, u32 wuf_cfg,
 
 static int smsc75xx_enter_suspend0(struct usbnet *dev)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 val;
 	int ret;
 
@@ -1597,7 +1602,7 @@ static int smsc75xx_enter_suspend0(struct usbnet *dev)
 
 static int smsc75xx_enter_suspend1(struct usbnet *dev)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 val;
 	int ret;
 
@@ -1633,7 +1638,7 @@ static int smsc75xx_enter_suspend1(struct usbnet *dev)
 
 static int smsc75xx_enter_suspend2(struct usbnet *dev)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 val;
 	int ret;
 
@@ -1659,7 +1664,7 @@ static int smsc75xx_enter_suspend2(struct usbnet *dev)
 
 static int smsc75xx_enter_suspend3(struct usbnet *dev)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 val;
 	int ret;
 
@@ -1794,7 +1799,7 @@ static int smsc75xx_autosuspend(struct usbnet *dev, u32 link_up)
 static int smsc75xx_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	u32 val, link_up;
 	int ret;
 
@@ -2095,7 +2100,7 @@ static int smsc75xx_suspend(struct usb_interface *intf, pm_message_t message)
 static int smsc75xx_resume(struct usb_interface *intf)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = usbnet_to_smsc(dev);
 	u8 suspend_flags = pdata->suspend_flags;
 	int ret;
 	u32 val;
-- 
2.19.1

