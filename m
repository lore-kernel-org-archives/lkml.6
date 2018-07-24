Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D46FECDFBB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75F420875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75F420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbeGXCmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:42:38 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:33318
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388253AbeGXCmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:42:37 -0400
X-Greylist: delayed 677 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2018 22:42:37 EDT
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id hm5pfyVFxdH2Ehm5pfjxuN; Mon, 23 Jul 2018 18:26:25 -0700
x-originating-ip: 107.180.71.197
Received: from yidren by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <yidren@linuxonhyperv2.linuxonhyperv.com>)
        id 1fhm5p-00070D-Dz; Mon, 23 Jul 2018 18:26:25 -0700
From:   Yidong Ren <yidren@linuxonhyperv.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     madhans@microsoft.com, Yidong Ren <yidren@microsoft.com>
Subject: [PATCH v3] hv_netvsc: Add per-cpu ethtool stats for netvsc
Date:   Tue, 24 Jul 2018 01:26:22 +0000
Message-Id: <20180724012622.26873-1-yidren@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180613193608.444-1-yidren@linuxonhyperv.com>
References: <20180613193608.444-1-yidren@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfBbz9BwPUtu5Rrpg/8WQtAyCAiriY8mEZ8N3lxp0C/vjf5eUOG7Xnlog6UjBDM4QR6RAsAJv9ugoW0eaeDAqrEmIJoKIMjR+ZAyJjH9f/eK2mIBMYDK2
 KRY5U/vEV6/5qyFTyccBGHDMhM6KSGn5JySdNoJTLCb/dAFQ0N1cvmtcvbEV6htO0zHQGX1p/IXI9UUthlph4h1lWEhrosLBKICsL2HyTHJ1wA7zjbAl/RRH
 32nfkvXWJklCGPxOwk0Bb5eUVCgfPW2G9NX+dmN3TvpYgC/1I+nPpGPlO0NEYoODzg8cmKqTj5uMfwYq5QnzOtmWO/VEBL6mOmbCFutxlG/DhFosNoQCYjbW
 HK/qnbHoy8Va0/g8l8B3slnxWOGyNaK6bhj9shc6h7k26j5wAgMkuj6waTqvGiaW//sLx8Q/31kS4ZpXpqNuq+FlZGbtdRUOUJye75K7pqD533RDbPbf2qAk
 ZBckIhFp0siOOwLvsWgVNIFn9NPIEzV8+WTq9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yidong Ren <yidren@microsoft.com>

This patch implements following ethtool stats fields for netvsc:
cpu<n>_tx/rx_packets/bytes
cpu<n>_vf_tx/rx_packets/bytes

Corresponding per-cpu counters already exist in current code. Exposing
these counters will help troubleshooting performance issues.

Signed-off-by: Yidong Ren <yidren@microsoft.com>
---
Changes since v2:
 * Reimplemented with kvmalloc instead of alloc_percpu
 drivers/net/hyperv/hyperv_net.h |  11 ++++
 drivers/net/hyperv/netvsc_drv.c | 103 +++++++++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 4b6e308199d2..a32ded5b4f41 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -873,6 +873,17 @@ struct netvsc_ethtool_stats {
 	unsigned long wake_queue;
 };
 
+struct netvsc_ethtool_pcpu_stats {
+	u64     rx_packets;
+	u64     rx_bytes;
+	u64     tx_packets;
+	u64     tx_bytes;
+	u64     vf_rx_packets;
+	u64     vf_rx_bytes;
+	u64     vf_tx_packets;
+	u64     vf_tx_bytes;
+};
+
 struct netvsc_vf_pcpu_stats {
 	u64     rx_packets;
 	u64     rx_bytes;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index dd1d6e115145..51f9cab2da5b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1118,6 +1118,64 @@ static void netvsc_get_vf_stats(struct net_device *net,
 	}
 }
 
+static void netvsc_get_pcpu_stats(struct net_device *net,
+				  struct netvsc_ethtool_pcpu_stats *pcpu_tot)
+{
+	struct net_device_context *ndev_ctx = netdev_priv(net);
+	struct netvsc_device *nvdev = rcu_dereference_rtnl(ndev_ctx->nvdev);
+	int i;
+
+	/* fetch percpu stats of vf */
+	for_each_possible_cpu(i) {
+		const struct netvsc_vf_pcpu_stats *stats =
+			per_cpu_ptr(ndev_ctx->vf_stats, i);
+		struct netvsc_ethtool_pcpu_stats *this_tot = &pcpu_tot[i];
+		unsigned int start;
+
+		do {
+			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			this_tot->vf_rx_packets = stats->rx_packets;
+			this_tot->vf_tx_packets = stats->tx_packets;
+			this_tot->vf_rx_bytes = stats->rx_bytes;
+			this_tot->vf_tx_bytes = stats->tx_bytes;
+		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+		this_tot->rx_packets = this_tot->vf_rx_packets;
+		this_tot->tx_packets = this_tot->vf_tx_packets;
+		this_tot->rx_bytes   = this_tot->vf_rx_bytes;
+		this_tot->tx_bytes   = this_tot->vf_tx_bytes;
+	}
+
+	/* fetch percpu stats of netvsc */
+	for (i = 0; i < nvdev->num_chn; i++) {
+		const struct netvsc_channel *nvchan = &nvdev->chan_table[i];
+		const struct netvsc_stats *stats;
+		struct netvsc_ethtool_pcpu_stats *this_tot =
+			&pcpu_tot[nvchan->channel->target_cpu];
+		u64 packets, bytes;
+		unsigned int start;
+
+		stats = &nvchan->tx_stats;
+		do {
+			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			packets = stats->packets;
+			bytes = stats->bytes;
+		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+
+		this_tot->tx_bytes	+= bytes;
+		this_tot->tx_packets	+= packets;
+
+		stats = &nvchan->rx_stats;
+		do {
+			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			packets = stats->packets;
+			bytes = stats->bytes;
+		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+
+		this_tot->rx_bytes	+= bytes;
+		this_tot->rx_packets	+= packets;
+	}
+}
+
 static void netvsc_get_stats64(struct net_device *net,
 			       struct rtnl_link_stats64 *t)
 {
@@ -1215,6 +1273,23 @@ static const struct {
 	{ "rx_no_memory", offsetof(struct netvsc_ethtool_stats, rx_no_memory) },
 	{ "stop_queue", offsetof(struct netvsc_ethtool_stats, stop_queue) },
 	{ "wake_queue", offsetof(struct netvsc_ethtool_stats, wake_queue) },
+}, pcpu_stats[] = {
+	{ "cpu%u_rx_packets",
+		offsetof(struct netvsc_ethtool_pcpu_stats, rx_packets) },
+	{ "cpu%u_rx_bytes",
+		offsetof(struct netvsc_ethtool_pcpu_stats, rx_bytes) },
+	{ "cpu%u_tx_packets",
+		offsetof(struct netvsc_ethtool_pcpu_stats, tx_packets) },
+	{ "cpu%u_tx_bytes",
+		offsetof(struct netvsc_ethtool_pcpu_stats, tx_bytes) },
+	{ "cpu%u_vf_rx_packets",
+		offsetof(struct netvsc_ethtool_pcpu_stats, vf_rx_packets) },
+	{ "cpu%u_vf_rx_bytes",
+		offsetof(struct netvsc_ethtool_pcpu_stats, vf_rx_bytes) },
+	{ "cpu%u_vf_tx_packets",
+		offsetof(struct netvsc_ethtool_pcpu_stats, vf_tx_packets) },
+	{ "cpu%u_vf_tx_bytes",
+		offsetof(struct netvsc_ethtool_pcpu_stats, vf_tx_bytes) },
 }, vf_stats[] = {
 	{ "vf_rx_packets", offsetof(struct netvsc_vf_pcpu_stats, rx_packets) },
 	{ "vf_rx_bytes",   offsetof(struct netvsc_vf_pcpu_stats, rx_bytes) },
@@ -1226,6 +1301,9 @@ static const struct {
 #define NETVSC_GLOBAL_STATS_LEN	ARRAY_SIZE(netvsc_stats)
 #define NETVSC_VF_STATS_LEN	ARRAY_SIZE(vf_stats)
 
+/* statistics per queue (rx/tx packets/bytes) */
+#define NETVSC_PCPU_STATS_LEN (num_present_cpus() * ARRAY_SIZE(pcpu_stats))
+
 /* 4 statistics per queue (rx/tx packets/bytes) */
 #define NETVSC_QUEUE_STATS_LEN(dev) ((dev)->num_chn * 4)
 
@@ -1241,6 +1319,7 @@ static int netvsc_get_sset_count(struct net_device *dev, int string_set)
 	case ETH_SS_STATS:
 		return NETVSC_GLOBAL_STATS_LEN
 			+ NETVSC_VF_STATS_LEN
+			+ NETVSC_PCPU_STATS_LEN
 			+ NETVSC_QUEUE_STATS_LEN(nvdev);
 	default:
 		return -EINVAL;
@@ -1255,9 +1334,10 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
 	const void *nds = &ndc->eth_stats;
 	const struct netvsc_stats *qstats;
 	struct netvsc_vf_pcpu_stats sum;
+	struct netvsc_ethtool_pcpu_stats *pcpu_sum;
 	unsigned int start;
 	u64 packets, bytes;
-	int i, j;
+	int i, j, cpu;
 
 	if (!nvdev)
 		return;
@@ -1269,6 +1349,18 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
 	for (j = 0; j < NETVSC_VF_STATS_LEN; j++)
 		data[i++] = *(u64 *)((void *)&sum + vf_stats[j].offset);
 
+	pcpu_sum = kvmalloc(sizeof(struct netvsc_ethtool_pcpu_stats) *
+			num_present_cpus(), GFP_KERNEL);
+	netvsc_get_pcpu_stats(dev, pcpu_sum);
+	for_each_present_cpu(cpu) {
+		struct netvsc_ethtool_pcpu_stats *this_sum = &pcpu_sum[cpu];
+
+		for (j = 0; j < ARRAY_SIZE(pcpu_stats); j++)
+			data[i++] = *(u64 *)((void *)this_sum
+					     + pcpu_stats[j].offset);
+	}
+	kvfree(pcpu_sum);
+
 	for (j = 0; j < nvdev->num_chn; j++) {
 		qstats = &nvdev->chan_table[j].tx_stats;
 
@@ -1296,7 +1388,7 @@ static void netvsc_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 	struct net_device_context *ndc = netdev_priv(dev);
 	struct netvsc_device *nvdev = rtnl_dereference(ndc->nvdev);
 	u8 *p = data;
-	int i;
+	int i, cpu;
 
 	if (!nvdev)
 		return;
@@ -1313,6 +1405,13 @@ static void netvsc_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 			p += ETH_GSTRING_LEN;
 		}
 
+		for_each_present_cpu(cpu) {
+			for (i = 0; i < ARRAY_SIZE(pcpu_stats); i++) {
+				sprintf(p, pcpu_stats[i].name, cpu);
+				p += ETH_GSTRING_LEN;
+			}
+		}
+
 		for (i = 0; i < nvdev->num_chn; i++) {
 			sprintf(p, "tx_queue_%u_packets", i);
 			p += ETH_GSTRING_LEN;
-- 
2.17.1

