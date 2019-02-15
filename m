Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76730C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389D32229F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197861;
	bh=GEFrVDUc43N/pV9cMh1z1H3zOA7tolEXnRmWWjUUTHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YBY4yB7DN0hwbDckPmXPjfXK5heqiqOXW+FSw6Kof82OAni7MdUUkVSzDxFqggdNu
	 krDKqpkBfFDvqRGa3OCTdsJ4TDwS1xRM+RH242MFtiZLgTNn9QKukahRz1T8O2qzWO
	 CSWzX8DyVVHDKdsy6iPGio9BViJcEpjFC5GFt/QE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbfBOCbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:31:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404351AbfBOCMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E01621B68;
        Fri, 15 Feb 2019 02:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196760;
        bh=GEFrVDUc43N/pV9cMh1z1H3zOA7tolEXnRmWWjUUTHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D803/qLugvmQsnIpE02xyMnrl7bQ5naz45dbv1HzqPfEmbmwFmfhwaa3Y50M/pV9Y
         WD7IJIgSkHgh2fNfOOlAxFXfJy1hlP20UdnXnUGJAvJzTNYbHQRfTABka9QGfoY385
         8YmAM/299lE9dappfLLkChGAXF0DJT/vZWLECoK8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, devel@linuxdriverproject.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 49/65] hv_netvsc: Fix hash key value reset after other ops
Date:   Thu, 14 Feb 2019 21:11:05 -0500
Message-Id: <20190215021121.177674-49-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
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
index a32ded5b4f41..42d284669b03 100644
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
 
@@ -210,7 +212,9 @@ int netvsc_recv_callback(struct net_device *net,
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
index fe01e141c8f8..1a942feab954 100644
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
index bece935567c1..c9e2a986ccb7 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -875,6 +875,9 @@ static struct netvsc_device_info *netvsc_devinfo_get
 		dev_info->send_section_size = nvdev->send_section_size;
 		dev_info->recv_sections = nvdev->recv_section_cnt;
 		dev_info->recv_section_size = nvdev->recv_section_size;
+
+		memcpy(dev_info->rss_key, nvdev->extension->rss_key,
+		       NETVSC_HASH_KEYLEN);
 	} else {
 		dev_info->num_chn = VRSS_CHANNEL_DEFAULT;
 		dev_info->send_sections = NETVSC_DEFAULT_TX;
@@ -937,7 +940,7 @@ static int netvsc_attach(struct net_device *ndev,
 		return PTR_ERR(nvdev);
 
 	if (nvdev->num_chn > 1) {
-		ret = rndis_set_subchannel(ndev, nvdev);
+		ret = rndis_set_subchannel(ndev, nvdev, dev_info);
 
 		/* if unavailable, just proceed with one queue */
 		if (ret) {
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 0b05f7ebeb01..53c6039bffb6 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1075,7 +1075,9 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
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
@@ -1116,7 +1118,10 @@ int rndis_set_subchannel(struct net_device *ndev, struct netvsc_device *nvdev)
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

