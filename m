Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D852C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42532148C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42532148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeJLQs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:48:27 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49446 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbeJLQs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:48:26 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAtYz-0006u4-Dy; Fri, 12 Oct 2018 10:16:53 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gAtYy-0005YY-Iz; Fri, 12 Oct 2018 10:16:52 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, gregkh@linuxfoundation.org,
        bjorn@mork.no, steve.glendinning@shawell.net,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 5/7] net: cdc_ether: add usbnet -> priv function
Date:   Fri, 12 Oct 2018 10:16:40 +0100
Message-Id: <20181012091642.21294-6-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places in the cdc drivers where it gets the
private-data from the usbnet passed in. It would be sensible to have
one inline function to convert it and change all points in the driver
to use that.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/cdc_ether.c  |  8 ++---
 drivers/net/usb/cdc_mbim.c   | 23 ++++++++------
 drivers/net/usb/cdc_ncm.c    | 61 +++++++++++++++++++-----------------
 drivers/net/usb/rndis_host.c |  6 ++--
 include/linux/usb/usbnet.h   |  5 +++
 5 files changed, 59 insertions(+), 44 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 5c42cf81a08b..7fee0ebc1943 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -77,7 +77,7 @@ static const u8 mbm_guid[16] = {
 
 static void usbnet_cdc_update_filter(struct usbnet *dev)
 {
-	struct cdc_state	*info = (void *) &dev->data;
+	struct cdc_state	*info = usbnet_to_cdc(dev);
 	struct usb_interface	*intf = info->control;
 	struct net_device	*net = dev->net;
 
@@ -115,7 +115,7 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8				*buf = intf->cur_altsetting->extra;
 	int				len = intf->cur_altsetting->extralen;
 	struct usb_interface_descriptor	*d;
-	struct cdc_state		*info = (void *) &dev->data;
+	struct cdc_state		*info = usbnet_to_cdc(dev);
 	int				status;
 	int				rndis;
 	bool				android_rndis_quirk = false;
@@ -353,7 +353,7 @@ EXPORT_SYMBOL_GPL(usbnet_ether_cdc_bind);
 
 void usbnet_cdc_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_state		*info = (void *) &dev->data;
+	struct cdc_state		*info = usbnet_to_cdc(dev);
 	struct usb_driver		*driver = driver_of(intf);
 
 	/* combined interface - nothing  to do */
@@ -438,7 +438,7 @@ EXPORT_SYMBOL_GPL(usbnet_cdc_status);
 int usbnet_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int				status;
-	struct cdc_state		*info = (void *) &dev->data;
+	struct cdc_state		*info = usbnet_to_cdc(dev);
 
 	BUILD_BUG_ON((sizeof(((struct usbnet *)0)->data)
 			< sizeof(struct cdc_state)));
diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index 0362acd5cdca..aec8f8eb21a7 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -36,6 +36,11 @@ struct cdc_mbim_state {
 	unsigned long flags;
 };
 
+static inline struct cdc_mbim_state *usbnet_to_mbim(struct usbnet *usb)
+{
+	return (void *)&usb->data;
+}
+
 /* flags for the cdc_mbim_state.flags field */
 enum cdc_mbim_flags {
 	FLAG_IPS0_VLAN = 1 << 0,	/* IP session 0 is tagged  */
@@ -44,7 +49,7 @@ enum cdc_mbim_flags {
 /* using a counter to merge subdriver requests with our own into a combined state */
 static int cdc_mbim_manage_power(struct usbnet *dev, int on)
 {
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_to_mbim(dev);
 	int rv = 0;
 
 	dev_dbg(&dev->intf->dev, "%s() pmcount=%d, on=%d\n", __func__, atomic_read(&info->pmcount), on);
@@ -73,7 +78,7 @@ static int cdc_mbim_wdm_manage_power(struct usb_interface *intf, int status)
 static int cdc_mbim_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_to_mbim(dev);
 
 	/* creation of this VLAN is a request to tag IP session 0 */
 	if (vid == MBIM_IPS0_VID)
@@ -87,7 +92,7 @@ static int cdc_mbim_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 static int cdc_mbim_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_to_mbim(dev);
 
 	/* this is a request for an untagged IP session 0 */
 	if (vid == MBIM_IPS0_VID)
@@ -144,7 +149,7 @@ static int cdc_mbim_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct usb_driver *subdriver = ERR_PTR(-ENODEV);
 	int ret = -ENODEV;
 	u8 data_altsetting = 1;
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_to_mbim(dev);
 
 	/* should we change control altsetting on a NCM/MBIM function? */
 	if (cdc_ncm_select_altsetting(intf) == CDC_NCM_COMM_ALTSETTING_MBIM) {
@@ -195,7 +200,7 @@ static int cdc_mbim_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static void cdc_mbim_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_to_mbim(dev);
 	struct cdc_ncm_ctx *ctx = info->ctx;
 
 	/* disconnect subdriver from control interface */
@@ -221,7 +226,7 @@ static bool is_ip_proto(__be16 proto)
 static struct sk_buff *cdc_mbim_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 {
 	struct sk_buff *skb_out;
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_to_mbim(dev);
 	struct cdc_ncm_ctx *ctx = info->ctx;
 	__le32 sign = cpu_to_le32(USB_CDC_MBIM_NDP16_IPS_SIGN);
 	u16 tci = 0;
@@ -411,7 +416,7 @@ static struct sk_buff *cdc_mbim_process_dgram(struct usbnet *dev, u8 *buf, size_
 static int cdc_mbim_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 {
 	struct sk_buff *skb;
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_to_mbim(dev);
 	struct cdc_ncm_ctx *ctx = info->ctx;
 	int len;
 	int nframes;
@@ -506,7 +511,7 @@ static int cdc_mbim_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	int ret = -ENODEV;
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_to_mbim(dev);
 	struct cdc_ncm_ctx *ctx = info->ctx;
 
 	if (!ctx)
@@ -534,7 +539,7 @@ static int cdc_mbim_resume(struct usb_interface *intf)
 {
 	int  ret = 0;
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_to_mbim(dev);
 	struct cdc_ncm_ctx *ctx = info->ctx;
 	bool callsub = (intf == ctx->control && info->subdriver && info->subdriver->resume);
 
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 1eaec648bd1f..0d722b326e1b 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -91,6 +91,11 @@ static const struct cdc_ncm_stats cdc_ncm_gstrings_stats[] = {
 
 #define CDC_NCM_LOW_MEM_MAX_CNT 10
 
+static inline struct cdc_ncm_ctx *usbnet_to_ncm(struct usbnet *net)
+{
+	return (struct cdc_ncm_ctx *)net->data[0];
+}
+
 static int cdc_ncm_get_sset_count(struct net_device __always_unused *netdev, int sset)
 {
 	switch (sset) {
@@ -106,7 +111,7 @@ static void cdc_ncm_get_ethtool_stats(struct net_device *netdev,
 				    u64 *data)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	int i;
 	char *p = NULL;
 
@@ -148,7 +153,7 @@ static const struct ethtool_ops cdc_ncm_ethtool_ops = {
 
 static u32 cdc_ncm_check_rx_max(struct usbnet *dev, u32 new_rx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	u32 val, max, min;
 
 	/* clamp new_rx to sane values */
@@ -171,7 +176,7 @@ static u32 cdc_ncm_check_rx_max(struct usbnet *dev, u32 new_rx)
 
 static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	u32 val, max, min;
 
 	/* clamp new_tx to sane values */
@@ -191,7 +196,7 @@ static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
 static ssize_t cdc_ncm_show_min_tx_pkt(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 
 	return sprintf(buf, "%u\n", ctx->min_tx_pkt);
 }
@@ -199,7 +204,7 @@ static ssize_t cdc_ncm_show_min_tx_pkt(struct device *d, struct device_attribute
 static ssize_t cdc_ncm_show_rx_max(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 
 	return sprintf(buf, "%u\n", ctx->rx_max);
 }
@@ -207,7 +212,7 @@ static ssize_t cdc_ncm_show_rx_max(struct device *d, struct device_attribute *at
 static ssize_t cdc_ncm_show_tx_max(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 
 	return sprintf(buf, "%u\n", ctx->tx_max);
 }
@@ -215,7 +220,7 @@ static ssize_t cdc_ncm_show_tx_max(struct device *d, struct device_attribute *at
 static ssize_t cdc_ncm_show_tx_timer_usecs(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 
 	return sprintf(buf, "%u\n", ctx->timer_interval / (u32)NSEC_PER_USEC);
 }
@@ -223,7 +228,7 @@ static ssize_t cdc_ncm_show_tx_timer_usecs(struct device *d, struct device_attri
 static ssize_t cdc_ncm_store_min_tx_pkt(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	unsigned long val;
 
 	/* no need to restrict values - anything from 0 to infinity is OK */
@@ -237,7 +242,7 @@ static ssize_t cdc_ncm_store_min_tx_pkt(struct device *d,  struct device_attribu
 static ssize_t cdc_ncm_store_rx_max(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	unsigned long val;
 
 	if (kstrtoul(buf, 0, &val) || cdc_ncm_check_rx_max(dev, val) != val)
@@ -250,7 +255,7 @@ static ssize_t cdc_ncm_store_rx_max(struct device *d,  struct device_attribute *
 static ssize_t cdc_ncm_store_tx_max(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	unsigned long val;
 
 	if (kstrtoul(buf, 0, &val) || cdc_ncm_check_tx_max(dev, val) != val)
@@ -263,7 +268,7 @@ static ssize_t cdc_ncm_store_tx_max(struct device *d,  struct device_attribute *
 static ssize_t cdc_ncm_store_tx_timer_usecs(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	ssize_t ret;
 	unsigned long val;
 
@@ -289,7 +294,7 @@ static DEVICE_ATTR(tx_timer_usecs, 0644, cdc_ncm_show_tx_timer_usecs, cdc_ncm_st
 static ssize_t ndp_to_end_show(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 
 	return sprintf(buf, "%c\n", ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END ? 'Y' : 'N');
 }
@@ -297,7 +302,7 @@ static ssize_t ndp_to_end_show(struct device *d, struct device_attribute *attr,
 static ssize_t ndp_to_end_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	bool enable;
 
 	if (strtobool(buf, &enable))
@@ -332,7 +337,7 @@ static DEVICE_ATTR_RW(ndp_to_end);
 static ssize_t cdc_ncm_show_##name(struct device *d, struct device_attribute *attr, char *buf) \
 { \
 	struct usbnet *dev = netdev_priv(to_net_dev(d)); \
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0]; \
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev); \
 	return sprintf(buf, format "\n", tocpu(ctx->ncm_parm.name));	\
 } \
 static DEVICE_ATTR(name, 0444, cdc_ncm_show_##name, NULL)
@@ -375,7 +380,7 @@ static const struct attribute_group cdc_ncm_sysfs_attr_group = {
 /* handle rx_max and tx_max changes */
 static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	u32 val;
 
@@ -447,7 +452,7 @@ static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
 /* helpers for NCM and MBIM differences */
 static u8 cdc_ncm_flags(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 
 	if (cdc_ncm_comm_intf_is_mbim(dev->intf->cur_altsetting) && ctx->mbim_desc)
 		return ctx->mbim_desc->bmNetworkCapabilities;
@@ -472,7 +477,7 @@ static u32 cdc_ncm_min_dgram_size(struct usbnet *dev)
 
 static u32 cdc_ncm_max_dgram_size(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 
 	if (cdc_ncm_comm_intf_is_mbim(dev->intf->cur_altsetting) && ctx->mbim_desc)
 		return le16_to_cpu(ctx->mbim_desc->wMaxSegmentSize);
@@ -486,7 +491,7 @@ static u32 cdc_ncm_max_dgram_size(struct usbnet *dev)
  */
 static int cdc_ncm_init(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	int err;
 
@@ -560,7 +565,7 @@ static int cdc_ncm_init(struct usbnet *dev)
 /* set a new max datagram size */
 static void cdc_ncm_set_dgram_size(struct usbnet *dev, int new_size)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	__le16 max_datagram_size;
 	u16 mbim_mtu;
@@ -608,7 +613,7 @@ static void cdc_ncm_set_dgram_size(struct usbnet *dev, int new_size)
 
 static void cdc_ncm_fix_modulus(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	u32 val;
 
 	/*
@@ -652,7 +657,7 @@ static void cdc_ncm_fix_modulus(struct usbnet *dev)
 
 static int cdc_ncm_setup(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	u32 def_rx, def_tx;
 
 	/* be conservative when selecting intial buffer size to
@@ -950,7 +955,7 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	if (ctx->data != ctx->control)
 		usb_driver_release_interface(driver, ctx->data);
 error:
-	cdc_ncm_free((struct cdc_ncm_ctx *)dev->data[0]);
+	cdc_ncm_free(usbnet_to_ncm(dev));
 	dev->data[0] = 0;
 	dev_info(&intf->dev, "bind() failure\n");
 	return -ENODEV;
@@ -959,7 +964,7 @@ EXPORT_SYMBOL_GPL(cdc_ncm_bind_common);
 
 void cdc_ncm_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	struct usb_driver *driver = driver_of(intf);
 
 	if (ctx == NULL)
@@ -1110,7 +1115,7 @@ static struct usb_cdc_ncm_ndp16 *cdc_ncm_ndp(struct cdc_ncm_ctx *ctx, struct sk_
 struct sk_buff *
 cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	struct usb_cdc_ncm_nth16 *nth16;
 	struct usb_cdc_ncm_ndp16 *ndp16;
 	struct sk_buff *skb_out;
@@ -1360,7 +1365,7 @@ static enum hrtimer_restart cdc_ncm_tx_timer_cb(struct hrtimer *timer)
 static void cdc_ncm_txpath_bh(unsigned long param)
 {
 	struct usbnet *dev = (struct usbnet *)param;
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 
 	spin_lock_bh(&ctx->mtx);
 	if (ctx->tx_timer_pending != 0) {
@@ -1382,7 +1387,7 @@ struct sk_buff *
 cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 {
 	struct sk_buff *skb_out;
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 
 	/*
 	 * The Ethernet API we are using does not support transmitting
@@ -1495,7 +1500,7 @@ EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_ndp16);
 int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 {
 	struct sk_buff *skb;
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_to_ncm(dev);
 	int len;
 	int nframes;
 	int x;
@@ -1604,7 +1609,7 @@ static void cdc_ncm_status(struct usbnet *dev, struct urb *urb)
 	struct cdc_ncm_ctx *ctx;
 	struct usb_cdc_notification *event;
 
-	ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	ctx = usbnet_to_ncm(dev);
 
 	if (urb->actual_length < sizeof(*event))
 		return;
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index b807c91abe1d..a24af05a74fb 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -69,7 +69,7 @@ EXPORT_SYMBOL_GPL(rndis_status);
 static void rndis_msg_indicate(struct usbnet *dev, struct rndis_indicate *msg,
 				int buflen)
 {
-	struct cdc_state *info = (void *)&dev->data;
+	struct cdc_state *info = usbnet_to_cdc(dev);
 	struct device *udev = &info->control->dev;
 
 	if (dev->driver_info->indication) {
@@ -102,7 +102,7 @@ static void rndis_msg_indicate(struct usbnet *dev, struct rndis_indicate *msg,
  */
 int rndis_command(struct usbnet *dev, struct rndis_msg_hdr *buf, int buflen)
 {
-	struct cdc_state	*info = (void *) &dev->data;
+	struct cdc_state	*info = usbnet_to_cdc(dev);
 	struct usb_cdc_notification notification;
 	int			master_ifnum;
 	int			retval;
@@ -301,7 +301,7 @@ generic_rndis_bind(struct usbnet *dev, struct usb_interface *intf, int flags)
 {
 	int			retval;
 	struct net_device	*net = dev->net;
-	struct cdc_state	*info = (void *) &dev->data;
+	struct cdc_state	*info = usbnet_to_cdc(dev);
 	union {
 		void			*buf;
 		struct rndis_msg_hdr	*header;
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index e2ec3582e549..cdb54dd3a4b4 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -207,6 +207,11 @@ struct cdc_state {
 	struct usb_interface		*data;
 };
 
+static inline struct cdc_state *usbnet_to_cdc(struct usbnet *net)
+{
+	return (void *) &net->data;
+}
+
 extern int usbnet_generic_cdc_bind(struct usbnet *, struct usb_interface *);
 extern int usbnet_ether_cdc_bind(struct usbnet *dev, struct usb_interface *intf);
 extern int usbnet_cdc_bind(struct usbnet *, struct usb_interface *);
-- 
2.19.1

