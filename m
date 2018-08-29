Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BD1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE4320658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="lExqb6hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE4320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeH2TcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:32:20 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:33333 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2TcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:32:20 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Aug 2018 15:32:19 EDT
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4FDA322888;
        Wed, 29 Aug 2018 17:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1535556319;
        bh=g22JwZYvt+C1JjDYPNe5DE0HD/UbEHhKAVujcjwDME4=;
        h=From:To:Cc:Subject:Date:From;
        b=lExqb6hqpWsDyJZpX41ewUM9vRk0R95r1Sm0SiTdpr7bmtpTzkqlS1khTtURTWkuG
         Tei2+Bzh8j9Zksb5nEedqZRbtLrT/XrhdrOoSitp6aEY94s+P9Zm00c6s3onRigsty
         W+U5oRsxtUEdvHK5vA85rNzhy0dSbDdSk7wkBnhw=
From:   Michael Walle <michael@walle.cc>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] veth: add software timestamping
Date:   Wed, 29 Aug 2018 17:24:11 +0200
Message-Id: <20180829152411.19341-1-michael@walle.cc>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: clamav-milter 0.100.0 at web
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a software TX timestamp as well as the ethtool query interface
and report the software timestamp capabilities.

Tested with "ethtool -T" and two linuxptp instances each bound to a
tunnel endpoint.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/veth.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 8d679c8b7f25..bc8faf13a731 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -24,6 +24,7 @@
 #include <linux/filter.h>
 #include <linux/ptr_ring.h>
 #include <linux/bpf_trace.h>
+#include <linux/net_tstamp.h>
 
 #define DRV_NAME	"veth"
 #define DRV_VERSION	"1.0"
@@ -114,6 +115,18 @@ static void veth_get_ethtool_stats(struct net_device *dev,
 	data[0] = peer ? peer->ifindex : 0;
 }
 
+static int veth_get_ts_info(struct net_device *dev,
+			    struct ethtool_ts_info *info)
+{
+	info->so_timestamping =
+		SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_RX_SOFTWARE |
+		SOF_TIMESTAMPING_SOFTWARE;
+	info->phc_index = -1;
+
+	return 0;
+}
+
 static const struct ethtool_ops veth_ethtool_ops = {
 	.get_drvinfo		= veth_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -121,6 +134,7 @@ static const struct ethtool_ops veth_ethtool_ops = {
 	.get_sset_count		= veth_get_sset_count,
 	.get_ethtool_stats	= veth_get_ethtool_stats,
 	.get_link_ksettings	= veth_get_link_ksettings,
+	.get_ts_info		= veth_get_ts_info,
 };
 
 /* general routines */
@@ -201,6 +215,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 			skb_record_rx_queue(skb, rxq);
 	}
 
+	skb_tx_timestamp(skb);
 	if (likely(veth_forward_skb(rcv, skb, rq, rcv_xdp) == NET_RX_SUCCESS)) {
 		struct pcpu_vstats *stats = this_cpu_ptr(dev->vstats);
 
-- 
2.11.0

