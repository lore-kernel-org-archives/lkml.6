Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4CFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF6D2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF6D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeJLQtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:49:02 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49444 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeJLQsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:48:25 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAtYz-0006u6-FU; Fri, 12 Oct 2018 10:16:53 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gAtYy-0005Ye-Kt; Fri, 12 Oct 2018 10:16:52 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, gregkh@linuxfoundation.org,
        bjorn@mork.no, steve.glendinning@shawell.net,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 7/7] net: usb: sr9800: add usbnet -> priv function
Date:   Fri, 12 Oct 2018 10:16:42 +0100
Message-Id: <20181012091642.21294-8-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places in the sr8900 driver where it gets the
private-data from the usbnet passed in. It would be sensible to have
one inline function to convert it and change all points in the driver
to use that.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/sr9800.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 9277a0f228df..2093ecfff5a5 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -25,6 +25,11 @@
 
 #include "sr9800.h"
 
+static inline struct sr_data *usbnet_to_sr(struct usbnet *usb)
+{
+	return (struct sr_data *)&usb->data;
+}
+
 static int sr_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 			    u16 size, void *data)
 {
@@ -296,7 +301,7 @@ static int sr_write_gpio(struct usbnet *dev, u16 value, int sleep)
 static void sr_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct sr_data *data = (struct sr_data *)&dev->data;
+	struct sr_data *data = usbnet_to_sr(dev);
 	u16 rx_ctl = SR_DEFAULT_RX_CTL;
 
 	if (net->flags & IFF_PROMISC) {
@@ -436,7 +441,7 @@ sr_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 static int sr_get_eeprom_len(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct sr_data *data = (struct sr_data *)&dev->data;
+	struct sr_data *data = usbnet_to_sr(dev);
 
 	return data->eeprom_len;
 }
@@ -493,7 +498,7 @@ static int sr_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
 static int sr_set_mac_address(struct net_device *net, void *p)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct sr_data *data = (struct sr_data *)&dev->data;
+	struct sr_data *data = usbnet_to_sr(dev);
 	struct sockaddr *addr = p;
 
 	if (netif_running(net))
@@ -595,7 +600,7 @@ static int sr9800_set_default_mode(struct usbnet *dev)
 
 static int sr9800_reset(struct usbnet *dev)
 {
-	struct sr_data *data = (struct sr_data *)&dev->data;
+	struct sr_data *data = usbnet_to_sr(dev);
 	int ret, embd_phy;
 	u16 rx_ctl;
 
@@ -726,7 +731,7 @@ static int sr9800_phy_powerup(struct usbnet *dev)
 
 static int sr9800_bind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct sr_data *data = (struct sr_data *)&dev->data;
+	struct sr_data *data = usbnet_to_sr(dev);
 	u16 led01_mux, led23_mux;
 	int ret, embd_phy;
 	u32 phyid;
-- 
2.19.1

