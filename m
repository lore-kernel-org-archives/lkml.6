Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F186BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E670208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E670208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935543AbeFMTsd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:48:33 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:47964
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935006AbeFMTsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:48:31 -0400
X-Greylist: delayed 675 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2018 15:48:31 EDT
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id TBZ1fxh0OPEk0TBZ1fQ76r; Wed, 13 Jun 2018 12:36:15 -0700
x-originating-ip: 107.180.71.197
Received: from yidren by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <yidren@linuxonhyperv2.linuxonhyperv.com>)
        id 1fTBZ0-00007z-Oa; Wed, 13 Jun 2018 12:36:14 -0700
From:   Yidong Ren <yidren@linuxonhyperv.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yidong Ren <yidren@microsoft.com>
Subject: [PATCH v2] hv_netvsc: Add per-cpu ethtool stats for netvsc
Date:   Wed, 13 Jun 2018 12:36:08 -0700
Message-Id: <20180613193608.444-1-yidren@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4wfNqLQbMO36WF8FwQaBvh6SqIkN9Ch4/biEOgw1RpzPznL0GhoR8p9Jvm/AxiFvjXnkcW4iFaFJbJ2x6DV+dOwTfquvu5Zdcit/xE7R+sPdUtb85Uv+QF
 WWy4limGnHwXsB8ZlPXWZ5PDQuIk71hOAGeCq5oBgwwvlAro9UoIGnekDXhf1UUWo3sGaEPK3WnHMt07o9kMrRu4U1bkzvHY8fhCZOEQES8sJzeZeJxjL4yt
 xIA4apF8RgoWJSZ9BS927Lhq6MtIdwY42f2Wge0jjnGPiFrrobZra7fvkweDwSp43Tq3aErkK+ICaG//mCXg9HMWCunoebAe8N4patdpp1T0mFS369iYiIb2
 xqzEJunIB6NRI8dR1x7byiKOfu72P6/CPz8LS6eHqKufJyHs1UJ290Bwg2m7gKkhYe/14pQonTbF+FtRZH48FpRE1xLEdlQOoX9HJFAnf4g0f/s2RTcr/lsK
 2erSazoqsD7Rp+Ob
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yidong Ren <yidren@microsoft.com>

This patch implements following ethtool stats fields for netvsc:
cpu<n>_tx/rx_packets/bytes
cpu<n>_vf_tx/rx_packets/bytes

Corresponding per-cpu counters exist in current code. Exposing these
counters will help troubleshooting performance issues.

Signed-off-by: Yidong Ren <yidren@microsoft.com>
---
Changes in v2:
  - Remove cpp style comment
  - Resubmit after freeze

 drivers/net/hyperv/hyperv_net.h |  11 +++++
 drivers/net/hyperv/netvsc_drv.c | 104 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 23304ac..c825353 100644
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
index 7b18a8c..6803aae 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1105,6 +1105,66 @@ static void netvsc_get_vf_stats(struct net_device *net,
 	}
 }
 
+static void netvsc_get_pcpu_stats(struct net_device *net,
+				  struct netvsc_ethtool_pcpu_stats
+					__percpu *pcpu_tot)
+{
+	struct net_device_context *ndev_ctx = netdev_priv(net);
+	struct netvsc_device *nvdev = rcu_dereference_rtnl(ndev_ctx->nvdev);
+	int i;
+
+	/* fetch percpu stats of vf */
+	for_each_possible_cpu(i) {
+		const struct netvsc_vf_pcpu_stats *stats =
+			per_cpu_ptr(ndev_ctx->vf_stats, i);
+		struct netvsc_ethtool_pcpu_stats *this_tot =
+			per_cpu_ptr(pcpu_tot, i);
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
+			per_cpu_ptr(pcpu_tot, nvchan->channel->target_cpu);
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
@@ -1202,6 +1262,23 @@ static const struct {
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
@@ -1213,6 +1290,9 @@ static const struct {
 #define NETVSC_GLOBAL_STATS_LEN	ARRAY_SIZE(netvsc_stats)
 #define NETVSC_VF_STATS_LEN	ARRAY_SIZE(vf_stats)
 
+/* statistics per queue (rx/tx packets/bytes) */
+#define NETVSC_PCPU_STATS_LEN (num_present_cpus() * ARRAY_SIZE(pcpu_stats))
+
 /* 4 statistics per queue (rx/tx packets/bytes) */
 #define NETVSC_QUEUE_STATS_LEN(dev) ((dev)->num_chn * 4)
 
@@ -1228,6 +1308,7 @@ static int netvsc_get_sset_count(struct net_device *dev, int string_set)
 	case ETH_SS_STATS:
 		return NETVSC_GLOBAL_STATS_LEN
 			+ NETVSC_VF_STATS_LEN
+			+ NETVSC_PCPU_STATS_LEN
 			+ NETVSC_QUEUE_STATS_LEN(nvdev);
 	default:
 		return -EINVAL;
@@ -1242,9 +1323,10 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
 	const void *nds = &ndc->eth_stats;
 	const struct netvsc_stats *qstats;
 	struct netvsc_vf_pcpu_stats sum;
+	struct netvsc_ethtool_pcpu_stats __percpu *pcpu_sum;
 	unsigned int start;
 	u64 packets, bytes;
-	int i, j;
+	int i, j, cpu;
 
 	if (!nvdev)
 		return;
@@ -1256,6 +1338,17 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
 	for (j = 0; j < NETVSC_VF_STATS_LEN; j++)
 		data[i++] = *(u64 *)((void *)&sum + vf_stats[j].offset);
 
+	pcpu_sum = alloc_percpu(struct netvsc_ethtool_pcpu_stats);
+	netvsc_get_pcpu_stats(dev, pcpu_sum);
+	for_each_present_cpu(cpu) {
+		struct netvsc_ethtool_pcpu_stats *this_sum =
+			per_cpu_ptr(pcpu_sum, cpu);
+		for (j = 0; j < ARRAY_SIZE(pcpu_stats); j++)
+			data[i++] = *(u64 *)((void *)this_sum
+					     + pcpu_stats[j].offset);
+	}
+	free_percpu(pcpu_sum);
+
 	for (j = 0; j < nvdev->num_chn; j++) {
 		qstats = &nvdev->chan_table[j].tx_stats;
 
@@ -1283,7 +1376,7 @@ static void netvsc_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 	struct net_device_context *ndc = netdev_priv(dev);
 	struct netvsc_device *nvdev = rtnl_dereference(ndc->nvdev);
 	u8 *p = data;
-	int i;
+	int i, cpu;
 
 	if (!nvdev)
 		return;
@@ -1300,6 +1393,13 @@ static void netvsc_get_strings(struct net_device *dev, u32 stringset, u8 *data)
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
2.7.4

