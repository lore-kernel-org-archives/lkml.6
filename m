Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34FDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1D72098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1D72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeJLQsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:48:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49433 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeJLQsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:48:25 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAtYz-0006u1-A6; Fri, 12 Oct 2018 10:16:53 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gAtYy-0005YP-G9; Fri, 12 Oct 2018 10:16:52 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, gregkh@linuxfoundation.org,
        bjorn@mork.no, steve.glendinning@shawell.net,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/7] net: asix: add usbnet -> priv function
Date:   Fri, 12 Oct 2018 10:16:37 +0100
Message-Id: <20181012091642.21294-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places in the asix driver where it gets the
private-data from the usbnet passed in. It would be sensible to have
one inline function to convert it and change all points in the driver
to use that.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/asix.h         |  5 +++++
 drivers/net/usb/asix_common.c  |  4 ++--
 drivers/net/usb/asix_devices.c | 16 ++++++++--------
 drivers/net/usb/ax88172a.c     |  2 +-
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/asix.h b/drivers/net/usb/asix.h
index 9a4171b90947..4bbb52669ac4 100644
--- a/drivers/net/usb/asix.h
+++ b/drivers/net/usb/asix.h
@@ -197,6 +197,11 @@ extern const struct driver_info ax88172a_info;
 /* ASIX specific flags */
 #define FLAG_EEPROM_MAC		(1UL << 0)  /* init device MAC from eeprom */
 
+static inline struct asix_data *usbnet_to_asix(struct usbnet *usb)
+{
+	return (struct asix_data *)&usb->data;
+}
+
 int asix_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 		  u16 size, void *data, int in_pm);
 
diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index e95dd12edec4..1fd650faca5b 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -418,7 +418,7 @@ int asix_write_gpio(struct usbnet *dev, u16 value, int sleep, int in_pm)
 void asix_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_to_asix(dev);
 	u16 rx_ctl = AX_DEFAULT_RX_CTL;
 
 	if (net->flags & IFF_PROMISC) {
@@ -751,7 +751,7 @@ void asix_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
 int asix_set_mac_address(struct net_device *net, void *p)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_to_asix(dev);
 	struct sockaddr *addr = p;
 
 	if (netif_running(net))
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index b654f05b2ccd..8e387f06dccf 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -144,7 +144,7 @@ static const struct ethtool_ops ax88172_ethtool_ops = {
 static void ax88172_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_to_asix(dev);
 	u8 rx_ctl = 0x8c;
 
 	if (net->flags & IFF_PROMISC) {
@@ -332,7 +332,7 @@ static int ax88772_link_reset(struct usbnet *dev)
 
 static int ax88772_reset(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_to_asix(dev);
 	int ret;
 
 	/* Rewrite MAC address */
@@ -359,7 +359,7 @@ static int ax88772_reset(struct usbnet *dev)
 
 static int ax88772_hw_reset(struct usbnet *dev, int in_pm)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_to_asix(dev);
 	int ret, embd_phy;
 	u16 rx_ctl;
 
@@ -454,7 +454,7 @@ static int ax88772_hw_reset(struct usbnet *dev, int in_pm)
 
 static int ax88772a_hw_reset(struct usbnet *dev, int in_pm)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_to_asix(dev);
 	int ret, embd_phy;
 	u16 rx_ctl, phy14h, phy15h, phy16h;
 	u8 chipcode = 0;
@@ -795,7 +795,7 @@ static const struct ethtool_ops ax88178_ethtool_ops = {
 
 static int marvell_phy_init(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_to_asix(dev);
 	u16 reg;
 
 	netdev_dbg(dev->net, "marvell_phy_init()\n");
@@ -827,7 +827,7 @@ static int marvell_phy_init(struct usbnet *dev)
 
 static int rtl8211cl_phy_init(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_to_asix(dev);
 
 	netdev_dbg(dev->net, "rtl8211cl_phy_init()\n");
 
@@ -874,7 +874,7 @@ static int marvell_led_status(struct usbnet *dev, u16 speed)
 
 static int ax88178_reset(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_to_asix(dev);
 	int ret;
 	__le16 eeprom;
 	u8 status;
@@ -962,7 +962,7 @@ static int ax88178_link_reset(struct usbnet *dev)
 {
 	u16 mode;
 	struct ethtool_cmd ecmd = { .cmd = ETHTOOL_GSET };
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_to_asix(dev);
 	u32 speed;
 
 	netdev_dbg(dev->net, "ax88178_link_reset()\n");
diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index 501576f53854..08f33c89f002 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -289,7 +289,7 @@ static void ax88172a_unbind(struct usbnet *dev, struct usb_interface *intf)
 
 static int ax88172a_reset(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_to_asix(dev);
 	struct ax88172a_private *priv = dev->driver_priv;
 	int ret;
 	u16 rx_ctl;
-- 
2.19.1

