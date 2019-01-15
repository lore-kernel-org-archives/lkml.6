Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B392C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AD2206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfAOBE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:04:59 -0500
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:54342
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbfAOBE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:04:58 -0500
X-Greylist: delayed 675 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2019 20:04:58 EST
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id jCyAgoSv1SXh6jCyAgnQMC; Mon, 14 Jan 2019 17:52:42 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1gjCyA-0001BU-DI; Mon, 14 Jan 2019 17:52:42 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     sashal@kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        netdev@vger.kernel.org, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH hyperv-fixes,3/3] Fix hash key value reset after other ops
Date:   Tue, 15 Jan 2019 00:51:44 +0000
Message-Id: <20190115005144.4494-4-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190115005144.4494-1-haiyangz@linuxonhyperv.com>
References: <20190115005144.4494-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Reply-To: haiyangz@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMlqs0RKlwdZYOpR/JOiABJKIv81zkEGanmeiiIJ7wOmmmHm7mg6zN53XdgnWM7ovcCWD4WqQQ5GuNcGo5S8iG043+zrZR3VKoLebQVFXxQwsMmlboS3
 5UNBEo/qX7wp0j8CEfoYPxhijtVF9kUpyJ/D8CNTXf5NVuN8mdiGbnjrB8rO/VTemHQlElO5RXAEBTxoWIO55xINamFTKqFTY7KHQaDKqUF9bOUXixVtPlpr
 t28NcMh7hIwPeNtgFCoVT1PZ//KEZxwJ3ixDvp9XPKdw1Bd/fT9dIGFioB7Wz+1Ajt/1jWIA9LraW8/f2diac14YtX77+W3k4kVTN7RWp9KzZiYMN2cNOid3
 VBj2TnfyxGNRwjJ6ZbaPNmLCqyyZ7/4o7X2D+KyYiBKxVIm9AtqYqnFJ2g4kK9hlvaVizZv4izXvYAxZjiZciX7/8aEA5ursIYyxEOTRCpVUl/3nuRyhna/k
 n2zhLNgE+KdlJghQ8CYEl5ttGWF/eXZxTtw3fdphOVzT8cSIdEYQMj9D1pA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Changing mtu, channels, or buffer sizes ops call to netvsc_attach(),
rndis_set_subchannel(), which always reset the hash key to default
value. That will override hash key changed previously. This patch
fixes the problem by save the hash key, then restore it when we re-
add the netvsc device.

Fixes: ff4a44199012 ("netvsc: allow get/set of RSS indirection table")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h   | 10 +++++++---
 drivers/net/hyperv/netvsc.c       |  2 +-
 drivers/net/hyperv/netvsc_drv.c   |  5 ++++-
 drivers/net/hyperv/rndis_filter.c |  9 +++++++--
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index ef6f766f6389..e598a684700b 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -144,6 +144,8 @@ struct hv_netvsc_packet {
 	u32 total_data_buflen;
 };
 
+#define NETVSC_HASH_KEYLEN 40
+
 struct netvsc_device_info {
 	unsigned char mac_adr[ETH_ALEN];
 	u32  num_chn;
@@ -151,6 +153,8 @@ struct netvsc_device_info {
 	u32  recv_sections;
 	u32  send_section_size;
 	u32  recv_section_size;
+
+	u8 rss_key[NETVSC_HASH_KEYLEN];
 };
 
 enum rndis_device_state {
@@ -160,8 +164,6 @@ enum rndis_device_state {
 	RNDIS_DEV_DATAINITIALIZED,
 };
 
-#define NETVSC_HASH_KEYLEN 40
-
 struct rndis_device {
 	struct net_device *ndev;
 
@@ -209,7 +211,9 @@ int netvsc_recv_callback(struct net_device *net,
 void netvsc_channel_cb(void *context);
 int netvsc_poll(struct napi_struct *napi, int budget);
 
-int rndis_set_subchannel(struct net_device *ndev, struct netvsc_device *nvdev);
+int rndis_set_subchannel(struct net_device *ndev,
+			 struct netvsc_device *nvdev,
+			 struct netvsc_device_info *dev_info);
 int rndis_filter_open(struct netvsc_device *nvdev);
 int rndis_filter_close(struct netvsc_device *nvdev);
 struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 922054c1d544..1910810e55bd 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -84,7 +84,7 @@ static void netvsc_subchan_work(struct work_struct *w)
 
 	rdev = nvdev->extension;
 	if (rdev) {
-		ret = rndis_set_subchannel(rdev->ndev, nvdev);
+		ret = rndis_set_subchannel(rdev->ndev, nvdev, NULL);
 		if (ret == 0) {
 			netif_device_attach(rdev->ndev);
 		} else {
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index f424327f7206..e281829a04ef 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -877,6 +877,9 @@ static struct netvsc_device_info *netvsc_devinfo_get
 		dev_info->send_section_size = nvdev->send_section_size;
 		dev_info->recv_sections = nvdev->recv_section_cnt;
 		dev_info->recv_section_size = nvdev->recv_section_size;
+
+		memcpy(dev_info->rss_key, nvdev->extension->rss_key,
+		       NETVSC_HASH_KEYLEN);
 	} else {
 		dev_info->num_chn = VRSS_CHANNEL_DEFAULT;
 		dev_info->send_sections = NETVSC_DEFAULT_TX;
@@ -939,7 +942,7 @@ static int netvsc_attach(struct net_device *ndev,
 		return PTR_ERR(nvdev);
 
 	if (nvdev->num_chn > 1) {
-		ret = rndis_set_subchannel(ndev, nvdev);
+		ret = rndis_set_subchannel(ndev, nvdev, dev_info);
 
 		/* if unavailable, just proceed with one queue */
 		if (ret) {
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index a4661d396e3c..db81378e6624 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1134,7 +1134,9 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
  * This breaks overlap of processing the host message for the
  * new primary channel with the initialization of sub-channels.
  */
-int rndis_set_subchannel(struct net_device *ndev, struct netvsc_device *nvdev)
+int rndis_set_subchannel(struct net_device *ndev,
+			 struct netvsc_device *nvdev,
+			 struct netvsc_device_info *dev_info)
 {
 	struct nvsp_message *init_packet = &nvdev->channel_init_pkt;
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
@@ -1175,7 +1177,10 @@ int rndis_set_subchannel(struct net_device *ndev, struct netvsc_device *nvdev)
 		   atomic_read(&nvdev->open_chn) == nvdev->num_chn);
 
 	/* ignore failues from setting rss parameters, still have channels */
-	rndis_filter_set_rss_param(rdev, netvsc_hash_key);
+	if (dev_info)
+		rndis_filter_set_rss_param(rdev, dev_info->rss_key);
+	else
+		rndis_filter_set_rss_param(rdev, netvsc_hash_key);
 
 	netif_set_real_num_tx_queues(ndev, nvdev->num_chn);
 	netif_set_real_num_rx_queues(ndev, nvdev->num_chn);
-- 
2.19.1

