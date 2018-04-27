Return-Path: <sdias@qualcomm.com>
X-Google-Smtp-Source: AB8JxZrppSnC9xD8JxtHDkyHXQx0a/I9RqQjUS7L8OAFbwpyify1k7QlOo+2CMVcNsRxD4G1ly1k
ARC-Seal: i=1; a=rsa-sha256; t=1524795826; cv=none;
        d=google.com; s=arc-20160816;
        b=e0Us/TZ9fwk69B7ArFyoJGncHJVjRPlJrbLZm2VaPc96NJnu9qrIXZWPQU0L7Hm/WM
         lSdpmARP/CGIwOtJgKDVLdenPxxHhvNp5Mj3RkfaSTjbHleODl/vHSUfFbeLZ5lFWoUU
         p1c2hq7dhKsGdGjEDEPIorfwSkuni6p1eqYcsG7QsprtGOjEbC0Mh9ynounjAEvWGlxS
         ZLU+P9fpZbxZeuM0vn5X83UJ+konNarp58jkDt7e/5az5owNNo1SXtzp6tjkN6Ka8ZFH
         lLAmwT7Alvwo30BCvWv6rz/Kpu8hxe3WoXPclHo54EGfx5luTRdk4L/PnqboXY0Q0NfM
         3Amw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8QK2lwZ5Fgc8o3oWqH5RiqfErS4j9AGM/PM+K4d1Y3w=;
        b=gifDp2Bt04pJdgx7HVW7Ls5NsGySdyO3xRumZ8LVka+jFmozsJEOAt43sIlM2qbxYb
         604E1lO3LqqH1lJ7cMvc7dYiz4wMe85DoTI9oNt5aI4ogsUpscbvfsxF/htURxhrKvUu
         Fb8oTUfy7BsI2b5BYIWO8kFm7BCsJCMdnNXd/vzbUk1RAy3n8nXsZ46IhD21LGGPVwvq
         Vxw9YfD+bzDHlpjGcaZiXPpHuzlO70+d+nqILDr8aV9rLBtwAoAiFmpp9YTKmU7gSQCx
         w3LUY7jBQdj+k7KwHg/AJGfbU+hrpqomfKi5sYudZPAVfGqhHqhbjLb9iJW0tCJTAwRF
         KV8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sdias@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=sdias@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sdias@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=sdias@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,333,1520924400";
   d="scan'208";a="17167530"
From: Sujeev Dias <sdias@codeaurora.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Sujeev Dias <sdias@codeaurora.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Tony Truong <truong@codeaurora.org>
Subject: [PATCH v1 3/4] mhi_bus: dev: netdev: add network interface driver
Date: Thu, 26 Apr 2018 19:23:30 -0700
Message-Id: <1524795811-21399-4-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864308521389559?=
X-GMAIL-MSGID: =?utf-8?q?1598864308521389559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

MHI based net device driver is used for transferring IP
traffic between host and modem. Driver allows clients to
transfer data using standard network interface.

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
---
 Documentation/devicetree/bindings/bus/mhi.txt |  36 ++
 drivers/bus/Kconfig                           |   1 +
 drivers/bus/mhi/Makefile                      |   2 +-
 drivers/bus/mhi/devices/Kconfig               |  10 +
 drivers/bus/mhi/devices/Makefile              |   1 +
 drivers/bus/mhi/devices/mhi_netdev.c          | 893 ++++++++++++++++++++++++++
 6 files changed, 942 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bus/mhi/devices/Kconfig
 create mode 100644 drivers/bus/mhi/devices/Makefile
 create mode 100644 drivers/bus/mhi/devices/mhi_netdev.c

diff --git a/Documentation/devicetree/bindings/bus/mhi.txt b/Documentation/devicetree/bindings/bus/mhi.txt
index ea1b620..172ae7b 100644
--- a/Documentation/devicetree/bindings/bus/mhi.txt
+++ b/Documentation/devicetree/bindings/bus/mhi.txt
@@ -139,3 +139,39 @@ mhi_controller {
 		<driver specific properties>
 	};
 };
+
+================
+Children Devices
+================
+
+MHI netdev properties
+
+- mhi,chan
+  Usage: required
+  Value type: <string>
+  Definition: Channel name MHI netdev support
+
+- mhi,mru
+  Usage: required
+  Value type: <u32>
+  Definition: Largest packet size interface can receive in bytes.
+
+- mhi,interface-name
+  Usage: optional
+  Value type: <string>
+  Definition: Interface name to be given so clients can identify it
+
+- mhi,recycle-buf
+  Usage: optional
+  Value type: <bool>
+  Definition: Set true if interface support recycling buffers.
+
+========
+Example:
+========
+
+mhi_rmnet@0 {
+	mhi,chan = "IP_HW0";
+	mhi,interface-name = "rmnet_mhi";
+	mhi,mru = <0x4000>;
+};
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index fb28002..cc03762 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -190,5 +190,6 @@ config MHI_DEBUG
 
 source "drivers/bus/fsl-mc/Kconfig"
 source drivers/bus/mhi/controllers/Kconfig
+source drivers/bus/mhi/devices/Kconfig
 
 endmenu
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
index c6a2a91..2382e04 100644
--- a/drivers/bus/mhi/Makefile
+++ b/drivers/bus/mhi/Makefile
@@ -5,4 +5,4 @@
 # core layer
 obj-y += core/
 obj-y += controllers/
-#obj-y += devices/
+obj-y += devices/
diff --git a/drivers/bus/mhi/devices/Kconfig b/drivers/bus/mhi/devices/Kconfig
new file mode 100644
index 0000000..40f964d
--- /dev/null
+++ b/drivers/bus/mhi/devices/Kconfig
@@ -0,0 +1,10 @@
+menu "MHI device support"
+
+config MHI_NETDEV
+       tristate "MHI NETDEV"
+       depends on MHI_BUS
+       help
+	  MHI based net device driver for transferring IP traffic
+	  between host and modem. By enabling this driver, clients
+	  can transfer data using standard network interface.
+endmenu
diff --git a/drivers/bus/mhi/devices/Makefile b/drivers/bus/mhi/devices/Makefile
new file mode 100644
index 0000000..ee12a64
--- /dev/null
+++ b/drivers/bus/mhi/devices/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MHI_NETDEV) +=mhi_netdev.o
diff --git a/drivers/bus/mhi/devices/mhi_netdev.c b/drivers/bus/mhi/devices/mhi_netdev.c
new file mode 100644
index 0000000..23881a9
--- /dev/null
+++ b/drivers/bus/mhi/devices/mhi_netdev.c
@@ -0,0 +1,893 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/if_arp.h>
+#include <linux/dma-mapping.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/of_device.h>
+#include <linux/rtnetlink.h>
+#include <linux/mhi.h>
+
+#define MHI_NETDEV_DRIVER_NAME "mhi_netdev"
+#define WATCHDOG_TIMEOUT (30 * HZ)
+
+#ifdef CONFIG_MHI_DEBUG
+
+#define MHI_ASSERT(cond, msg) do { \
+	if (cond) \
+		panic(msg); \
+} while (0)
+
+#define MSG_VERB(fmt, ...) do { \
+	if (mhi_netdev->msg_lvl <= MHI_MSG_LVL_VERBOSE) \
+		pr_err("[D][%s] " fmt, __func__, ##__VA_ARGS__);\
+} while (0)
+
+#else
+
+#define MHI_ASSERT(cond, msg) do { \
+	if (cond) { \
+		MSG_ERR(msg); \
+		WARN_ON(cond); \
+	} \
+} while (0)
+
+#define MSG_VERB(fmt, ...)
+
+#endif
+
+#define MSG_LOG(fmt, ...) do { \
+	if (mhi_netdev->msg_lvl <= MHI_MSG_LVL_INFO) \
+		pr_err("[I][%s] " fmt, __func__, ##__VA_ARGS__);\
+} while (0)
+
+#define MSG_ERR(fmt, ...) do { \
+	if (mhi_netdev->msg_lvl <= MHI_MSG_LVL_ERROR) \
+		pr_err("[E][%s] " fmt, __func__, ##__VA_ARGS__); \
+} while (0)
+
+struct mhi_stats {
+	u32 rx_int;
+	u32 tx_full;
+	u32 tx_pkts;
+	u32 rx_budget_overflow;
+	u32 rx_frag;
+	u32 alloc_failed;
+};
+
+/* important: do not exceed sk_buf->cb (48 bytes) */
+struct mhi_skb_priv {
+	void *buf;
+	size_t size;
+	struct mhi_netdev *mhi_netdev;
+};
+
+struct mhi_netdev {
+	int alias;
+	struct mhi_device *mhi_dev;
+	spinlock_t rx_lock;
+	bool enabled;
+	rwlock_t pm_lock; /* state change lock */
+	int (*rx_queue)(struct mhi_netdev *mhi_netdev, gfp_t gfp_t);
+	struct work_struct alloc_work;
+	int wake;
+
+	struct sk_buff_head rx_allocated;
+
+	u32 mru;
+	const char *interface_name;
+	struct napi_struct napi;
+	struct net_device *ndev;
+	struct sk_buff *frag_skb;
+	bool recycle_buf;
+
+	struct mhi_stats stats;
+	struct dentry *dentry;
+	enum MHI_DEBUG_LEVEL msg_lvl;
+};
+
+struct mhi_netdev_priv {
+	struct mhi_netdev *mhi_netdev;
+};
+
+static struct mhi_driver mhi_netdev_driver;
+static void mhi_netdev_create_debugfs(struct mhi_netdev *mhi_netdev);
+
+static __be16 mhi_netdev_ip_type_trans(struct sk_buff *skb)
+{
+	__be16 protocol = 0;
+
+	/* determine L3 protocol */
+	switch (skb->data[0] & 0xf0) {
+	case 0x40:
+		protocol = htons(ETH_P_IP);
+		break;
+	case 0x60:
+		protocol = htons(ETH_P_IPV6);
+		break;
+	default:
+		/* default is QMAP */
+		protocol = htons(ETH_P_MAP);
+		break;
+	}
+	return protocol;
+}
+
+static void mhi_netdev_skb_destructor(struct sk_buff *skb)
+{
+	struct mhi_skb_priv *skb_priv = (struct mhi_skb_priv *)(skb->cb);
+	struct mhi_netdev *mhi_netdev = skb_priv->mhi_netdev;
+
+	skb->data = skb->head;
+	skb_reset_tail_pointer(skb);
+	skb->len = 0;
+	MHI_ASSERT(skb->data != skb_priv->buf, "incorrect buf");
+	skb_queue_tail(&mhi_netdev->rx_allocated, skb);
+}
+
+static int mhi_netdev_alloc_skb(struct mhi_netdev *mhi_netdev, gfp_t gfp_t)
+{
+	u32 cur_mru = mhi_netdev->mru;
+	struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
+	struct mhi_skb_priv *skb_priv;
+	int ret;
+	struct sk_buff *skb;
+	int no_tre = mhi_get_no_free_descriptors(mhi_dev, DMA_FROM_DEVICE);
+	int i;
+
+	for (i = 0; i < no_tre; i++) {
+		skb = alloc_skb(cur_mru, gfp_t);
+		if (!skb)
+			return -ENOMEM;
+
+		read_lock_bh(&mhi_netdev->pm_lock);
+		if (unlikely(!mhi_netdev->enabled)) {
+			MSG_ERR("Interface not enabled\n");
+			ret = -EIO;
+			goto error_queue;
+		}
+
+		skb_priv = (struct mhi_skb_priv *)skb->cb;
+		skb_priv->buf = skb->data;
+		skb_priv->size = cur_mru;
+		skb_priv->mhi_netdev = mhi_netdev;
+		skb->dev = mhi_netdev->ndev;
+
+		if (mhi_netdev->recycle_buf)
+			skb->destructor = mhi_netdev_skb_destructor;
+
+		spin_lock_bh(&mhi_netdev->rx_lock);
+		ret = mhi_queue_transfer(mhi_dev, DMA_FROM_DEVICE, skb,
+					 skb_priv->size, MHI_EOT);
+		spin_unlock_bh(&mhi_netdev->rx_lock);
+
+		if (ret) {
+			MSG_ERR("Failed to queue skb, ret:%d\n", ret);
+			ret = -EIO;
+			goto error_queue;
+		}
+
+		read_unlock_bh(&mhi_netdev->pm_lock);
+	}
+
+	return 0;
+
+error_queue:
+	skb->destructor = NULL;
+	read_unlock_bh(&mhi_netdev->pm_lock);
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+static void mhi_netdev_alloc_work(struct work_struct *work)
+{
+	struct mhi_netdev *mhi_netdev = container_of(work, struct mhi_netdev,
+						   alloc_work);
+	/* sleep about 1 sec and retry, that should be enough time
+	 * for system to reclaim freed memory back.
+	 */
+	const int sleep_ms =  1000;
+	int retry = 60;
+	int ret;
+
+	MSG_LOG("Entered\n");
+	do {
+		ret = mhi_netdev_alloc_skb(mhi_netdev, GFP_KERNEL);
+		/* sleep and try again */
+		if (ret == -ENOMEM) {
+			msleep(sleep_ms);
+			retry--;
+		}
+	} while (ret == -ENOMEM && retry);
+
+	MSG_LOG("Exit with status:%d retry:%d\n", ret, retry);
+}
+
+/* we will recycle buffers */
+static int mhi_netdev_skb_recycle(struct mhi_netdev *mhi_netdev, gfp_t gfp_t)
+{
+	struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
+	int no_tre;
+	int ret = 0;
+	struct sk_buff *skb;
+	struct mhi_skb_priv *skb_priv;
+
+	read_lock_bh(&mhi_netdev->pm_lock);
+	if (!mhi_netdev->enabled) {
+		read_unlock_bh(&mhi_netdev->pm_lock);
+		return -EIO;
+	}
+
+	no_tre = mhi_get_no_free_descriptors(mhi_dev, DMA_FROM_DEVICE);
+
+	spin_lock_bh(&mhi_netdev->rx_lock);
+	while (no_tre) {
+		skb = skb_dequeue(&mhi_netdev->rx_allocated);
+
+		/* no free buffers to recycle, reschedule work */
+		if (!skb) {
+			ret = -ENOMEM;
+			goto error_queue;
+		}
+
+		skb_priv = (struct mhi_skb_priv *)(skb->cb);
+		ret = mhi_queue_transfer(mhi_dev, DMA_FROM_DEVICE, skb,
+					 skb_priv->size, MHI_EOT);
+
+		/* failed to queue buffer */
+		if (ret) {
+			MSG_ERR("Failed to queue skb, ret:%d\n", ret);
+			skb_queue_tail(&mhi_netdev->rx_allocated, skb);
+			goto error_queue;
+		}
+
+		no_tre--;
+	}
+
+error_queue:
+	spin_unlock_bh(&mhi_netdev->rx_lock);
+	read_unlock_bh(&mhi_netdev->pm_lock);
+
+	return ret;
+}
+
+static void mhi_netdev_dealloc(struct mhi_netdev *mhi_netdev)
+{
+	struct sk_buff *skb;
+
+	skb = skb_dequeue(&mhi_netdev->rx_allocated);
+	while (skb) {
+		skb->destructor = NULL;
+		kfree_skb(skb);
+		skb = skb_dequeue(&mhi_netdev->rx_allocated);
+	}
+}
+
+static int mhi_netdev_poll(struct napi_struct *napi, int budget)
+{
+	struct net_device *dev = napi->dev;
+	struct mhi_netdev_priv *mhi_netdev_priv = netdev_priv(dev);
+	struct mhi_netdev *mhi_netdev = mhi_netdev_priv->mhi_netdev;
+	struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
+	int rx_work = 0;
+	int ret;
+
+	MSG_VERB("Entered\n");
+
+	read_lock_bh(&mhi_netdev->pm_lock);
+
+	if (!mhi_netdev->enabled) {
+		MSG_LOG("interface is disabled!\n");
+		napi_complete(napi);
+		read_unlock_bh(&mhi_netdev->pm_lock);
+		return 0;
+	}
+
+	mhi_device_get(mhi_dev);
+
+	rx_work = mhi_poll(mhi_dev, budget);
+	if (rx_work < 0) {
+		MSG_ERR("Error polling ret:%d\n", rx_work);
+		rx_work = 0;
+		napi_complete(napi);
+		goto exit_poll;
+	}
+
+	/* queue new buffers */
+	ret = mhi_netdev->rx_queue(mhi_netdev, GFP_ATOMIC);
+	if (ret == -ENOMEM) {
+		MSG_LOG("out of tre, queuing bg worker\n");
+		mhi_netdev->stats.alloc_failed++;
+		schedule_work(&mhi_netdev->alloc_work);
+
+	}
+
+	/* complete work if # of packet processed less than allocated budget */
+	if (rx_work < budget)
+		napi_complete(napi);
+	else
+		mhi_netdev->stats.rx_budget_overflow++;
+
+exit_poll:
+	mhi_device_put(mhi_dev);
+	read_unlock_bh(&mhi_netdev->pm_lock);
+
+	MSG_VERB("polled %d pkts\n", rx_work);
+
+	return rx_work;
+}
+
+static int mhi_netdev_open(struct net_device *dev)
+{
+	struct mhi_netdev_priv *mhi_netdev_priv = netdev_priv(dev);
+	struct mhi_netdev *mhi_netdev = mhi_netdev_priv->mhi_netdev;
+	struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
+
+	MSG_LOG("Opened net dev interface\n");
+
+	/* tx queue may not necessarily be stopped already
+	 * so stop the queue if tx path is not enabled
+	 */
+	if (!mhi_dev->ul_chan)
+		netif_stop_queue(dev);
+	else
+		netif_start_queue(dev);
+
+	return 0;
+
+}
+
+static int mhi_netdev_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct mhi_netdev_priv *mhi_netdev_priv = netdev_priv(dev);
+	struct mhi_netdev *mhi_netdev = mhi_netdev_priv->mhi_netdev;
+	struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
+
+	if (new_mtu < 0 || mhi_dev->mtu < new_mtu)
+		return -EINVAL;
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+
+static int mhi_netdev_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct mhi_netdev_priv *mhi_netdev_priv = netdev_priv(dev);
+	struct mhi_netdev *mhi_netdev = mhi_netdev_priv->mhi_netdev;
+	struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
+	int res = 0;
+	struct mhi_skb_priv *tx_priv;
+
+	MSG_VERB("Entered\n");
+
+	tx_priv = (struct mhi_skb_priv *)(skb->cb);
+	tx_priv->mhi_netdev = mhi_netdev;
+	read_lock_bh(&mhi_netdev->pm_lock);
+
+	if (unlikely(!mhi_netdev->enabled)) {
+		/* Only reason interface could be disabled and we get data
+		 * is due to an SSR. We do not want to stop the queue and
+		 * return error. Instead we will flush all the uplink packets
+		 * and return successful
+		 */
+		res = NETDEV_TX_OK;
+		dev_kfree_skb_any(skb);
+		goto mhi_xmit_exit;
+	}
+
+	res = mhi_queue_transfer(mhi_dev, DMA_TO_DEVICE, skb, skb->len,
+				 MHI_EOT);
+	if (res) {
+		MSG_VERB("Failed to queue with reason:%d\n", res);
+		netif_stop_queue(dev);
+		mhi_netdev->stats.tx_full++;
+		res = NETDEV_TX_BUSY;
+		goto mhi_xmit_exit;
+	}
+
+	mhi_netdev->stats.tx_pkts++;
+
+mhi_xmit_exit:
+	read_unlock_bh(&mhi_netdev->pm_lock);
+	MSG_VERB("Exited\n");
+
+	return res;
+}
+
+static int mhi_netdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	int rc = 0;
+
+	switch (cmd) {
+	default:
+		/* don't fail any IOCTL right now */
+		rc = 0;
+		break;
+	}
+
+	return rc;
+}
+
+static const struct net_device_ops mhi_netdev_ops_ip = {
+	.ndo_open = mhi_netdev_open,
+	.ndo_start_xmit = mhi_netdev_xmit,
+	.ndo_do_ioctl = mhi_netdev_ioctl,
+	.ndo_change_mtu = mhi_netdev_change_mtu,
+	.ndo_set_mac_address = 0,
+	.ndo_validate_addr = 0,
+};
+
+static void mhi_netdev_setup(struct net_device *dev)
+{
+	dev->netdev_ops = &mhi_netdev_ops_ip;
+	ether_setup(dev);
+
+	/* set this after calling ether_setup */
+	dev->header_ops = 0;  /* No header */
+	dev->type = ARPHRD_RAWIP;
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+	dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+	dev->watchdog_timeo = WATCHDOG_TIMEOUT;
+}
+
+/* enable mhi_netdev netdev, call only after grabbing mhi_netdev.mutex */
+static int mhi_netdev_enable_iface(struct mhi_netdev *mhi_netdev)
+{
+	int ret = 0;
+	char ifalias[IFALIASZ];
+	char ifname[IFNAMSIZ];
+	struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
+	int no_tre;
+
+	MSG_LOG("Prepare the channels for transfer\n");
+
+	ret = mhi_prepare_for_transfer(mhi_dev);
+	if (ret) {
+		MSG_ERR("Failed to start TX chan ret %d\n", ret);
+		goto mhi_failed_to_start;
+	}
+
+	/* first time enabling the node */
+	if (!mhi_netdev->ndev) {
+		struct mhi_netdev_priv *mhi_netdev_priv;
+
+		snprintf(ifalias, sizeof(ifalias), "%s_%04x_%02u.%02u.%02u_%u",
+			 mhi_netdev->interface_name, mhi_dev->dev_id,
+			 mhi_dev->domain, mhi_dev->bus, mhi_dev->slot,
+			 mhi_netdev->alias);
+
+		snprintf(ifname, sizeof(ifname), "%s%%d",
+			 mhi_netdev->interface_name);
+
+		rtnl_lock();
+		mhi_netdev->ndev = alloc_netdev(sizeof(*mhi_netdev_priv),
+					ifname, NET_NAME_PREDICTABLE,
+					mhi_netdev_setup);
+
+		if (!mhi_netdev->ndev) {
+			ret = -ENOMEM;
+			rtnl_unlock();
+			goto net_dev_alloc_fail;
+		}
+
+		mhi_netdev->ndev->mtu = mhi_dev->mtu;
+		SET_NETDEV_DEV(mhi_netdev->ndev, &mhi_dev->dev);
+		dev_set_alias(mhi_netdev->ndev, ifalias, strlen(ifalias));
+		mhi_netdev_priv = netdev_priv(mhi_netdev->ndev);
+		mhi_netdev_priv->mhi_netdev = mhi_netdev;
+		rtnl_unlock();
+
+		netif_napi_add(mhi_netdev->ndev, &mhi_netdev->napi,
+			       mhi_netdev_poll, NAPI_POLL_WEIGHT);
+		ret = register_netdev(mhi_netdev->ndev);
+		if (ret) {
+			MSG_ERR("Network device registration failed\n");
+			goto net_dev_reg_fail;
+		}
+
+		skb_queue_head_init(&mhi_netdev->rx_allocated);
+	}
+
+	write_lock_irq(&mhi_netdev->pm_lock);
+	mhi_netdev->enabled =  true;
+	write_unlock_irq(&mhi_netdev->pm_lock);
+
+	/* queue buffer for rx path */
+	no_tre = mhi_get_no_free_descriptors(mhi_dev, DMA_FROM_DEVICE);
+	ret = mhi_netdev_alloc_skb(mhi_netdev, GFP_KERNEL);
+	if (ret)
+		schedule_work(&mhi_netdev->alloc_work);
+
+	/* if we recycle prepare one more set */
+	if (mhi_netdev->recycle_buf)
+		for (; no_tre >= 0; no_tre--) {
+			struct sk_buff *skb = alloc_skb(mhi_netdev->mru,
+							GFP_KERNEL);
+			struct mhi_skb_priv *skb_priv;
+
+			if (!skb)
+				break;
+
+			skb_priv = (struct mhi_skb_priv *)skb->cb;
+			skb_priv->buf = skb->data;
+			skb_priv->size = mhi_netdev->mru;
+			skb_priv->mhi_netdev = mhi_netdev;
+			skb->dev = mhi_netdev->ndev;
+			skb->destructor = mhi_netdev_skb_destructor;
+			skb_queue_tail(&mhi_netdev->rx_allocated, skb);
+		}
+
+	napi_enable(&mhi_netdev->napi);
+
+	MSG_LOG("Exited.\n");
+
+	return 0;
+
+net_dev_reg_fail:
+	netif_napi_del(&mhi_netdev->napi);
+	free_netdev(mhi_netdev->ndev);
+	mhi_netdev->ndev = NULL;
+
+net_dev_alloc_fail:
+	mhi_unprepare_from_transfer(mhi_dev);
+
+mhi_failed_to_start:
+	MSG_ERR("Exited ret %d.\n", ret);
+
+	return ret;
+}
+
+static void mhi_netdev_xfer_ul_cb(struct mhi_device *mhi_dev,
+				  struct mhi_result *mhi_result)
+{
+	struct mhi_netdev *mhi_netdev = mhi_device_get_devdata(mhi_dev);
+	struct sk_buff *skb = mhi_result->buf_addr;
+	struct net_device *ndev = mhi_netdev->ndev;
+
+	ndev->stats.tx_packets++;
+	ndev->stats.tx_bytes += skb->len;
+	dev_kfree_skb(skb);
+
+	if (netif_queue_stopped(ndev))
+		netif_wake_queue(ndev);
+}
+
+static int mhi_netdev_process_fragment(struct mhi_netdev *mhi_netdev,
+				      struct sk_buff *skb)
+{
+	struct sk_buff *temp_skb;
+
+	if (mhi_netdev->frag_skb) {
+		/* merge the new skb into the old fragment */
+		temp_skb = skb_copy_expand(mhi_netdev->frag_skb, 0, skb->len,
+					   GFP_ATOMIC);
+		if (!temp_skb) {
+			dev_kfree_skb(mhi_netdev->frag_skb);
+			mhi_netdev->frag_skb = NULL;
+			return -ENOMEM;
+		}
+
+		dev_kfree_skb_any(mhi_netdev->frag_skb);
+		mhi_netdev->frag_skb = temp_skb;
+		memcpy(skb_put(mhi_netdev->frag_skb, skb->len), skb->data,
+		       skb->len);
+	} else {
+		mhi_netdev->frag_skb = skb_copy(skb, GFP_ATOMIC);
+		if (!mhi_netdev->frag_skb)
+			return -ENOMEM;
+	}
+
+	mhi_netdev->stats.rx_frag++;
+
+	return 0;
+}
+
+static void mhi_netdev_xfer_dl_cb(struct mhi_device *mhi_dev,
+				  struct mhi_result *mhi_result)
+{
+	struct mhi_netdev *mhi_netdev = mhi_device_get_devdata(mhi_dev);
+	struct sk_buff *skb = mhi_result->buf_addr;
+	struct net_device *dev = mhi_netdev->ndev;
+	int ret = 0;
+
+	if (mhi_result->transaction_status == -ENOTCONN) {
+		dev_kfree_skb(skb);
+		return;
+	}
+
+	skb_put(skb, mhi_result->bytes_xferd);
+	dev->stats.rx_packets++;
+	dev->stats.rx_bytes += mhi_result->bytes_xferd;
+
+	/* merge skb's together, it's a chain transfer */
+	if (mhi_result->transaction_status == -EOVERFLOW ||
+	    mhi_netdev->frag_skb) {
+		ret = mhi_netdev_process_fragment(mhi_netdev, skb);
+
+		/* recycle the skb */
+		if (mhi_netdev->recycle_buf)
+			mhi_netdev_skb_destructor(skb);
+		else
+			dev_kfree_skb(skb);
+
+		if (ret)
+			return;
+	}
+
+	/* more data will come, don't submit the buffer */
+	if (mhi_result->transaction_status == -EOVERFLOW)
+		return;
+
+	if (mhi_netdev->frag_skb) {
+		skb = mhi_netdev->frag_skb;
+		skb->dev = dev;
+		mhi_netdev->frag_skb = NULL;
+	}
+
+	skb->protocol = mhi_netdev_ip_type_trans(skb);
+	netif_receive_skb(skb);
+}
+
+static void mhi_netdev_status_cb(struct mhi_device *mhi_dev, enum MHI_CB mhi_cb)
+{
+	struct mhi_netdev *mhi_netdev = mhi_device_get_devdata(mhi_dev);
+
+	if (mhi_cb != MHI_CB_PENDING_DATA)
+		return;
+
+	if (napi_schedule_prep(&mhi_netdev->napi)) {
+		__napi_schedule(&mhi_netdev->napi);
+		mhi_netdev->stats.rx_int++;
+		return;
+	}
+
+}
+
+#ifdef CONFIG_DEBUG_FS
+
+struct dentry *dentry;
+
+static int mhi_netdev_debugfs_trigger_reset(void *data, u64 val)
+{
+	struct mhi_netdev *mhi_netdev = data;
+	struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
+	int ret;
+
+	MSG_LOG("Triggering channel reset\n");
+
+	/* disable the interface so no data processing */
+	write_lock_irq(&mhi_netdev->pm_lock);
+	mhi_netdev->enabled = false;
+	write_unlock_irq(&mhi_netdev->pm_lock);
+	napi_disable(&mhi_netdev->napi);
+
+	/* disable all hardware channels */
+	mhi_unprepare_from_transfer(mhi_dev);
+
+	/* clean up all alocated buffers */
+	mhi_netdev_dealloc(mhi_netdev);
+
+	MSG_LOG("Restarting iface\n");
+
+	ret = mhi_netdev_enable_iface(mhi_netdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(mhi_netdev_debugfs_trigger_reset_fops, NULL,
+			mhi_netdev_debugfs_trigger_reset, "%llu\n");
+
+static void mhi_netdev_create_debugfs(struct mhi_netdev *mhi_netdev)
+{
+	char node_name[32];
+	int i;
+	const umode_t mode = 0600;
+	struct dentry *file;
+	struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
+
+	const struct {
+		char *name;
+		u32 *ptr;
+	} debugfs_table[] = {
+		{
+			"rx_int",
+			&mhi_netdev->stats.rx_int
+		},
+		{
+			"tx_full",
+			&mhi_netdev->stats.tx_full
+		},
+		{
+			"tx_pkts",
+			&mhi_netdev->stats.tx_pkts
+		},
+		{
+			"rx_budget_overflow",
+			&mhi_netdev->stats.rx_budget_overflow
+		},
+		{
+			"rx_fragmentation",
+			&mhi_netdev->stats.rx_frag
+		},
+		{
+			"alloc_failed",
+			&mhi_netdev->stats.alloc_failed
+		},
+		{
+			NULL, NULL
+		},
+	};
+
+	/* Both tx & rx client handle contain same device info */
+	snprintf(node_name, sizeof(node_name), "%s_%04x_%02u.%02u.%02u_%u",
+		 mhi_netdev->interface_name, mhi_dev->dev_id, mhi_dev->domain,
+		 mhi_dev->bus, mhi_dev->slot, mhi_netdev->alias);
+
+	if (IS_ERR_OR_NULL(dentry))
+		return;
+
+	mhi_netdev->dentry = debugfs_create_dir(node_name, dentry);
+	if (IS_ERR_OR_NULL(mhi_netdev->dentry))
+		return;
+
+	file = debugfs_create_u32("msg_lvl", mode, mhi_netdev->dentry,
+				  (u32 *)&mhi_netdev->msg_lvl);
+	if (IS_ERR_OR_NULL(file))
+		return;
+
+	/* Add debug stats table */
+	for (i = 0; debugfs_table[i].name; i++) {
+		file = debugfs_create_u32(debugfs_table[i].name, mode,
+					  mhi_netdev->dentry,
+					  debugfs_table[i].ptr);
+		if (IS_ERR_OR_NULL(file))
+			return;
+	}
+
+	debugfs_create_file("reset", mode, mhi_netdev->dentry, mhi_netdev,
+			    &mhi_netdev_debugfs_trigger_reset_fops);
+}
+
+static void mhi_netdev_create_debugfs_dir(void)
+{
+	dentry = debugfs_create_dir(MHI_NETDEV_DRIVER_NAME, 0);
+}
+
+#else
+
+static void mhi_netdev_create_debugfs(struct mhi_netdev_private *mhi_netdev)
+{
+}
+
+static void mhi_netdev_create_debugfs_dir(void)
+{
+}
+
+#endif
+
+static void mhi_netdev_remove(struct mhi_device *mhi_dev)
+{
+	struct mhi_netdev *mhi_netdev = mhi_device_get_devdata(mhi_dev);
+
+	MSG_LOG("Remove notification received\n");
+
+	write_lock_irq(&mhi_netdev->pm_lock);
+	mhi_netdev->enabled = false;
+	write_unlock_irq(&mhi_netdev->pm_lock);
+
+	napi_disable(&mhi_netdev->napi);
+	netif_napi_del(&mhi_netdev->napi);
+	mhi_netdev_dealloc(mhi_netdev);
+	unregister_netdev(mhi_netdev->ndev);
+	free_netdev(mhi_netdev->ndev);
+	flush_work(&mhi_netdev->alloc_work);
+
+	if (!IS_ERR_OR_NULL(mhi_netdev->dentry))
+		debugfs_remove_recursive(mhi_netdev->dentry);
+}
+
+static int mhi_netdev_probe(struct mhi_device *mhi_dev,
+			    const struct mhi_device_id *id)
+{
+	int ret;
+	struct mhi_netdev *mhi_netdev;
+	struct device_node *of_node = mhi_dev->dev.of_node;
+	char node_name[32];
+
+	if (!of_node)
+		return -ENODEV;
+
+	mhi_netdev = devm_kzalloc(&mhi_dev->dev, sizeof(*mhi_netdev),
+				  GFP_KERNEL);
+	if (!mhi_netdev)
+		return -ENOMEM;
+
+	mhi_netdev->alias = of_alias_get_id(of_node, "mhi_netdev");
+	if (mhi_netdev->alias < 0)
+		return -ENODEV;
+
+	mhi_netdev->mhi_dev = mhi_dev;
+	mhi_device_set_devdata(mhi_dev, mhi_netdev);
+
+	ret = of_property_read_u32(of_node, "mhi,mru", &mhi_netdev->mru);
+	if (ret)
+		return -ENODEV;
+
+	ret = of_property_read_string(of_node, "mhi,interface-name",
+				      &mhi_netdev->interface_name);
+	if (ret)
+		mhi_netdev->interface_name = mhi_netdev_driver.driver.name;
+
+	mhi_netdev->recycle_buf = of_property_read_bool(of_node,
+							"mhi,recycle-buf");
+	mhi_netdev->rx_queue = mhi_netdev->recycle_buf ?
+		mhi_netdev_skb_recycle : mhi_netdev_alloc_skb;
+
+	spin_lock_init(&mhi_netdev->rx_lock);
+	rwlock_init(&mhi_netdev->pm_lock);
+	INIT_WORK(&mhi_netdev->alloc_work, mhi_netdev_alloc_work);
+
+	/* create ipc log buffer */
+	snprintf(node_name, sizeof(node_name), "%s_%04x_%02u.%02u.%02u_%u",
+		 mhi_netdev->interface_name, mhi_dev->dev_id, mhi_dev->domain,
+		 mhi_dev->bus, mhi_dev->slot, mhi_netdev->alias);
+
+	mhi_netdev->msg_lvl = MHI_MSG_LVL_ERROR;
+
+	/* setup network interface */
+	ret = mhi_netdev_enable_iface(mhi_netdev);
+	if (ret)
+		return ret;
+
+	mhi_netdev_create_debugfs(mhi_netdev);
+
+	return 0;
+}
+
+static const struct mhi_device_id mhi_netdev_match_table[] = {
+	{ .chan = "IP_HW0" },
+	{ .chan = "IP_HW_ADPL" },
+	{ NULL },
+};
+
+static struct mhi_driver mhi_netdev_driver = {
+	.id_table = mhi_netdev_match_table,
+	.probe = mhi_netdev_probe,
+	.remove = mhi_netdev_remove,
+	.ul_xfer_cb = mhi_netdev_xfer_ul_cb,
+	.dl_xfer_cb = mhi_netdev_xfer_dl_cb,
+	.status_cb = mhi_netdev_status_cb,
+	.driver = {
+		.name = "mhi_netdev",
+		.owner = THIS_MODULE,
+	}
+};
+
+static int __init mhi_netdev_init(void)
+{
+	mhi_netdev_create_debugfs_dir();
+
+	return mhi_driver_register(&mhi_netdev_driver);
+}
+module_init(mhi_netdev_init);
+
+MODULE_DESCRIPTION("MHI NETDEV Network Interface");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
