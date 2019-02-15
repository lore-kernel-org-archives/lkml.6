Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8187BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517C8222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196636;
	bh=F4VOmoeNFXrbBf5IezEifaYel9c39VWu/aM8WW3MT7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LPiqTgvPcBlXFEJwmhEF0voSUk18vhinm1vocPBf+I7XhA8nfUnjfXb2uBhKOdRpg
	 lmOtTtmC0/LnxtVqkMzVSvL8yffuAtpc4mGS6xnvXyyMf5PrKoIARHtmZaXRLh4KMt
	 L40O3Ic39s9P1b8Vlahlg+fcgGbsnYhg3sOZ1UEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390601AbfBOCKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:10:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390489AbfBOCKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D133D222C9;
        Fri, 15 Feb 2019 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196631;
        bh=F4VOmoeNFXrbBf5IezEifaYel9c39VWu/aM8WW3MT7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xEMSdq2ZsrHltgBL3DU1onTsH+B5bsTqXvm9IXprWF2YuRSiEur3EfOEagIKrgnQG
         tbcvCYQxYEZWHxsAUOsXcubs+eg7m8r523q9iQPW1557uVTGyKSdIgp2ewqszT0QNs
         M2ufXHExr6ak/Lm4tUvlQkMgXtm8GXGkU/1DkB+0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, devel@linuxdriverproject.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 57/77] hv_netvsc: Fix hash key value reset after other ops
Date:   Thu, 14 Feb 2019 21:08:35 -0500
Message-Id: <20190215020855.176727-57-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit 17d91256898402daf4425cc541ac9cbf64574d9a ]

Changing mtu, channels, or buffer sizes ops call to netvsc_attach(),
rndis_set_subchannel(), which always reset the hash key to default
value. That will override hash key changed previously. This patch
fixes the problem by save the hash key, then restore it when we re-
add the netvsc device.

Fixes: ff4a44199012 ("netvsc: allow get/set of RSS indirection table")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
[sl: fix up subject line]
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 4055e12fce9a..80d9297ad9d9 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -876,6 +876,9 @@ static struct netvsc_device_info *netvsc_devinfo_get
 		dev_info->send_section_size = nvdev->send_section_size;
 		dev_info->recv_sections = nvdev->recv_section_cnt;
 		dev_info->recv_section_size = nvdev->recv_section_size;
+
+		memcpy(dev_info->rss_key, nvdev->extension->rss_key,
+		       NETVSC_HASH_KEYLEN);
 	} else {
 		dev_info->num_chn = VRSS_CHANNEL_DEFAULT;
 		dev_info->send_sections = NETVSC_DEFAULT_TX;
@@ -938,7 +941,7 @@ static int netvsc_attach(struct net_device *ndev,
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

