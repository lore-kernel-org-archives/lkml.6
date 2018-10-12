Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C02C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D562087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D562087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeJLQs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:48:28 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49442 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbeJLQs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:48:26 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAtYz-0006u3-DB; Fri, 12 Oct 2018 10:16:53 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gAtYy-0005YV-Hs; Fri, 12 Oct 2018 10:16:52 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, gregkh@linuxfoundation.org,
        bjorn@mork.no, steve.glendinning@shawell.net,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 4/7] net: qmi_wwan: add usbnet -> priv function
Date:   Fri, 12 Oct 2018 10:16:39 +0100
Message-Id: <20181012091642.21294-5-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places in the qmi_wwan driver where it gets the
private-data from the usbnet passed in. It would be sensible to have
one inline function to convert it and change all points in the driver
to use that.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/qmi_wwan.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 533b6fb8d923..45930758a945 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -76,6 +76,11 @@ struct qmimux_priv {
 	u8 mux_id;
 };
 
+static inline struct qmi_wwan_state *usbnet_to_qmi(struct usbnet *usb)
+{
+	return (void *) &usb->data;
+}
+
 static int qmimux_open(struct net_device *dev)
 {
 	struct qmimux_priv *priv = netdev_priv(dev);
@@ -253,7 +258,7 @@ static void qmimux_unregister_device(struct net_device *dev)
 static void qmi_wwan_netdev_setup(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 
 	if (info->flags & QMI_WWAN_FLAG_RAWIP) {
 		net->header_ops      = NULL;  /* No header */
@@ -276,7 +281,7 @@ static void qmi_wwan_netdev_setup(struct net_device *net)
 static ssize_t raw_ip_show(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 
 	return sprintf(buf, "%c\n", info->flags & QMI_WWAN_FLAG_RAWIP ? 'Y' : 'N');
 }
@@ -284,7 +289,7 @@ static ssize_t raw_ip_show(struct device *d, struct device_attribute *attr, char
 static ssize_t raw_ip_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 	bool enable;
 	int ret;
 
@@ -346,7 +351,7 @@ static ssize_t add_mux_show(struct device *d, struct device_attribute *attr, cha
 static ssize_t add_mux_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 	u8 mux_id;
 	int ret;
 
@@ -391,7 +396,7 @@ static ssize_t del_mux_show(struct device *d, struct device_attribute *attr, cha
 static ssize_t del_mux_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 	struct net_device *del_dev;
 	u8 mux_id;
 	int ret = 0;
@@ -468,7 +473,7 @@ static const u8 buggy_fw_addr[ETH_ALEN] = {0x00, 0xa0, 0xc6, 0x00, 0x00, 0x00};
  */
 static int qmi_wwan_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 	bool rawip = info->flags & QMI_WWAN_FLAG_RAWIP;
 	__be16 proto;
 
@@ -555,7 +560,7 @@ static const struct net_device_ops qmi_wwan_netdev_ops = {
  */
 static int qmi_wwan_manage_power(struct usbnet *dev, int on)
 {
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 	int rv;
 
 	dev_dbg(&dev->intf->dev, "%s() pmcount=%d, on=%d\n", __func__,
@@ -589,7 +594,7 @@ static int qmi_wwan_register_subdriver(struct usbnet *dev)
 {
 	int rv;
 	struct usb_driver *subdriver = NULL;
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 
 	/* collect bulk endpoints */
 	rv = usbnet_get_endpoints(dev, info->data);
@@ -651,7 +656,7 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct usb_cdc_union_desc *cdc_union;
 	struct usb_cdc_ether_desc *cdc_ether;
 	struct usb_driver *driver = driver_of(intf);
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 	struct usb_cdc_parsed_header hdr;
 
 	BUILD_BUG_ON((sizeof(((struct usbnet *)0)->data) <
@@ -746,7 +751,7 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static void qmi_wwan_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 	struct usb_driver *driver = driver_of(intf);
 	struct usb_interface *other;
 
@@ -785,7 +790,7 @@ static void qmi_wwan_unbind(struct usbnet *dev, struct usb_interface *intf)
 static int qmi_wwan_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 	int ret;
 
 	/* Both usbnet_suspend() and subdriver->suspend() MUST return 0
@@ -808,7 +813,7 @@ static int qmi_wwan_suspend(struct usb_interface *intf, pm_message_t message)
 static int qmi_wwan_resume(struct usb_interface *intf)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = usbnet_to_qmi(dev);
 	int ret = 0;
 	bool callsub = (intf == info->control && info->subdriver &&
 			info->subdriver->resume);
@@ -1406,7 +1411,7 @@ static void qmi_wwan_disconnect(struct usb_interface *intf)
 	/* called twice if separate control and data intf */
 	if (!dev)
 		return;
-	info = (void *)&dev->data;
+	info = usbnet_to_qmi(dev);
 	if (info->flags & QMI_WWAN_FLAG_MUX) {
 		if (!rtnl_trylock()) {
 			restart_syscall();
-- 
2.19.1

