Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D22C67869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F222087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F222087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeJLQsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:48:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49437 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbeJLQsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:48:25 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAtYz-0006u2-CR; Fri, 12 Oct 2018 10:16:53 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gAtYy-0005YS-HA; Fri, 12 Oct 2018 10:16:52 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, gregkh@linuxfoundation.org,
        bjorn@mork.no, steve.glendinning@shawell.net,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/7] net: usb: asix88179_178a:  add usbnet -> priv function
Date:   Fri, 12 Oct 2018 10:16:38 +0100
Message-Id: <20181012091642.21294-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places in the asix88179_178a driver where it gets the
private-data from the usbnet passed in. It would be sensible to have
one inline function to convert it and change all points in the driver
to use that.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/ax88179_178a.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 9e8ad372f419..f4b64e7e7706 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -196,6 +196,11 @@ static const struct {
 	{7, 0xcc, 0x4c, 0x18, 8},
 };
 
+static inline struct ax88179_data *usbnet_to_ax(struct usbnet *usb)
+{
+	return (struct ax88179_data *)usb->data;
+}
+
 static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 			      u16 size, void *data, int in_pm)
 {
@@ -678,7 +683,7 @@ ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_eee *data)
 static int ax88179_chk_eee(struct usbnet *dev)
 {
 	struct ethtool_cmd ecmd = { .cmd = ETHTOOL_GSET };
-	struct ax88179_data *priv = (struct ax88179_data *)dev->data;
+	struct ax88179_data *priv = usbnet_to_ax(dev);
 
 	mii_ethtool_gset(&dev->mii, &ecmd);
 
@@ -781,7 +786,7 @@ static void ax88179_enable_eee(struct usbnet *dev)
 static int ax88179_get_eee(struct net_device *net, struct ethtool_eee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = (struct ax88179_data *)dev->data;
+	struct ax88179_data *priv = usbnet_to_ax(dev);
 
 	edata->eee_enabled = priv->eee_enabled;
 	edata->eee_active = priv->eee_active;
@@ -792,7 +797,7 @@ static int ax88179_get_eee(struct net_device *net, struct ethtool_eee *edata)
 static int ax88179_set_eee(struct net_device *net, struct ethtool_eee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = (struct ax88179_data *)dev->data;
+	struct ax88179_data *priv = usbnet_to_ax(dev);
 	int ret = -EOPNOTSUPP;
 
 	priv->eee_enabled = edata->eee_enabled;
@@ -841,7 +846,7 @@ static const struct ethtool_ops ax88179_ethtool_ops = {
 static void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *data = usbnet_to_ax(dev);
 	u8 *m_filter = ((u8 *)dev->data) + 12;
 
 	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
@@ -1228,7 +1233,7 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8 buf[5];
 	u16 *tmp16;
 	u8 *tmp;
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data = usbnet_to_ax(dev);
 	struct ethtool_eee eee_data;
 
 	usbnet_get_endpoints(dev, intf);
@@ -1458,7 +1463,7 @@ ax88179_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 
 static int ax88179_link_reset(struct usbnet *dev)
 {
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data = usbnet_to_ax(dev);
 	u8 tmp[5], link_sts;
 	u16 mode, tmp16, delay = HZ / 10;
 	u32 tmp32 = 0x40000000;
@@ -1533,7 +1538,7 @@ static int ax88179_reset(struct usbnet *dev)
 	u8 buf[5];
 	u16 *tmp16;
 	u8 *tmp;
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data = usbnet_to_ax(dev);
 	struct ethtool_eee eee_data;
 
 	tmp16 = (u16 *)buf;
-- 
2.19.1

