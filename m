Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02037ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4A5206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1UtCUGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4A5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeGUMwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:52:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45555 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeGUMwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:52:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id q5-v6so13181238ljh.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95EtP6zyKXSlPMkmbpywBc8oLM61zDOoygw4GvJUQCc=;
        b=K1UtCUGXtWv0A3op8kRX6qqCsyZZsJ5qGKGwl5nBuKpyUt52VL/lH2eOztMiR6Wif6
         jqlomxagmQlWz9QjU3vvYKOyyLS2+GEaNbt95szzvxVOqKRS6DiU1/RXFdK0JQRpNUQd
         HJnmnU8vxaF9O16R8JzY+uj6e3/GCNbbsMZR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95EtP6zyKXSlPMkmbpywBc8oLM61zDOoygw4GvJUQCc=;
        b=AEWl1KTyKt1eFr3foC9xzhaAcXExQyk+49iexjZqZVu2vXhHpGYzPri0RL/q1NncH0
         MyLv3LkmvnV3D7pMupkpujs4+odxC+V726nENlle5HWValQ7/44aeIH6OJrpKESt194i
         Fkvhox+MeucCjYkoVD4TpHcjtIqknq8k0Vi5VpGxHOEQnWirSJTZ/yBXCRa6l6lZ/AYy
         LFPIQ8o1ucW/WaogyOL1ozk4B2A+e/s+0+yXqKp3OHKnMrmqlNc/dI41vraN07CVOorn
         YgWzV0Jh1+fKNOmjFTSFeqnJuwBNm0Pdmc3ISHpx0dm/rysnMyJT06PsDb6S9pd01Kbp
         WG7w==
X-Gm-Message-State: AOUpUlGoIN8cjGg1A9FRCoc6C1mAzFpzqvSqQJbXrhPC2WZnbYq0g+b9
        HNUwXBGLPBzwgjBhtx95jBtHYw==
X-Google-Smtp-Source: AAOMgpel86b/u16yyV+w1JM/EFM14BU7Q61rlqPrQAVow+0sIkeuupxv/wCCwW1p91i/mfx8IFb7fA==
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr2716696ljt.8.1532174377296;
        Sat, 21 Jul 2018 04:59:37 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 73-v6sm664260lfs.44.2018.07.21.04.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 04:59:36 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 net-next 3/6] net: ethernet: ti: cpsw: add MQPRIO Qdisc offload
Date:   Sat, 21 Jul 2018 14:59:20 +0300
Message-Id: <20180721115923.1389-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721115923.1389-1-ivan.khoronzhuk@linaro.org>
References: <20180721115923.1389-1-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's possible to offload vlan to tc priority mapping with
assumption sk_prio == L2 prio.

Example:
$ ethtool -L eth0 rx 1 tx 4

$ qdisc replace dev eth0 handle 100: parent root mqprio num_tc 3 \
map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1@0 1@1 2@2 hw 1

$ tc -g class show dev eth0
+---(100:ffe2) mqprio
|    +---(100:3) mqprio
|    +---(100:4) mqprio
|    
+---(100:ffe1) mqprio
|    +---(100:2) mqprio
|    
+---(100:ffe0) mqprio
     +---(100:1) mqprio

Here, 100:1 is txq0, 100:2 is txq1, 100:3 is txq2, 100:4 is txq3
txq0 belongs to tc0, txq1 to tc1, txq2 and txq3 to tc2
The offload part only maps L2 prio to classes of traffic, but not
to transmit queues, so to direct traffic to traffic class vlan has
to be created with appropriate egress map.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 4425b537b9dd..f099e0ed138d 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -39,6 +39,7 @@
 #include <linux/sys_soc.h>
 
 #include <linux/pinctrl/consumer.h>
+#include <net/pkt_cls.h>
 
 #include "cpsw.h"
 #include "cpsw_ale.h"
@@ -153,6 +154,8 @@ do {								\
 #define IRQ_NUM			2
 #define CPSW_MAX_QUEUES		8
 #define CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT 256
+#define CPSW_TC_NUM			4
+#define CPSW_FIFO_SHAPERS_NUM		(CPSW_TC_NUM - 1)
 
 #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT	29
 #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK		GENMASK(2, 0)
@@ -454,6 +457,7 @@ struct cpsw_priv {
 	u8				mac_addr[ETH_ALEN];
 	bool				rx_pause;
 	bool				tx_pause;
+	bool				mqprio_hw;
 	u32 emac_port;
 	struct cpsw_common *cpsw;
 };
@@ -1578,6 +1582,14 @@ static void cpsw_slave_stop(struct cpsw_slave *slave, struct cpsw_common *cpsw)
 	soft_reset_slave(slave);
 }
 
+static int cpsw_tc_to_fifo(int tc, int num_tc)
+{
+	if (tc == num_tc - 1)
+		return 0;
+
+	return CPSW_FIFO_SHAPERS_NUM - tc;
+}
+
 static int cpsw_ndo_open(struct net_device *ndev)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
@@ -2191,6 +2203,75 @@ static int cpsw_ndo_set_tx_maxrate(struct net_device *ndev, int queue, u32 rate)
 	return ret;
 }
 
+static int cpsw_set_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int fifo, num_tc, count, offset;
+	struct cpsw_slave *slave;
+	u32 tx_prio_map = 0;
+	int i, tc, ret;
+
+	num_tc = mqprio->qopt.num_tc;
+	if (num_tc > CPSW_TC_NUM)
+		return -EINVAL;
+
+	if (mqprio->mode != TC_MQPRIO_MODE_DCB)
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(cpsw->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(cpsw->dev);
+		return ret;
+	}
+
+	if (num_tc) {
+		for (i = 0; i < 8; i++) {
+			tc = mqprio->qopt.prio_tc_map[i];
+			fifo = cpsw_tc_to_fifo(tc, num_tc);
+			tx_prio_map |= fifo << (4 * i);
+		}
+
+		netdev_set_num_tc(ndev, num_tc);
+		for (i = 0; i < num_tc; i++) {
+			count = mqprio->qopt.count[i];
+			offset = mqprio->qopt.offset[i];
+			netdev_set_tc_queue(ndev, i, count, offset);
+		}
+	}
+
+	if (!mqprio->qopt.hw) {
+		/* restore default configuration */
+		netdev_reset_tc(ndev);
+		tx_prio_map = TX_PRIORITY_MAPPING;
+	}
+
+	priv->mqprio_hw = mqprio->qopt.hw;
+
+	offset = cpsw->version == CPSW_VERSION_1 ?
+		 CPSW1_TX_PRI_MAP : CPSW2_TX_PRI_MAP;
+
+	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
+	slave_write(slave, tx_prio_map, offset);
+
+	pm_runtime_put_sync(cpsw->dev);
+
+	return 0;
+}
+
+static int cpsw_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			     void *type_data)
+{
+	switch (type) {
+	case TC_SETUP_QDISC_MQPRIO:
+		return cpsw_set_mqprio(ndev, type_data);
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops cpsw_netdev_ops = {
 	.ndo_open		= cpsw_ndo_open,
 	.ndo_stop		= cpsw_ndo_stop,
@@ -2206,6 +2287,7 @@ static const struct net_device_ops cpsw_netdev_ops = {
 #endif
 	.ndo_vlan_rx_add_vid	= cpsw_ndo_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= cpsw_ndo_vlan_rx_kill_vid,
+	.ndo_setup_tc           = cpsw_ndo_setup_tc,
 };
 
 static int cpsw_get_regs_len(struct net_device *ndev)
-- 
2.17.1

