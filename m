Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 07213C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EB82087E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/19vKzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EB82087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754865AbeFNHip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:38:45 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35068 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754676AbeFNHhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:37:14 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so7846853lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0EPNV9PY6l0QgOuy7PjTTS6a92xNNMAKQ2oPnDBFpI=;
        b=C/19vKzhnBb9Yw4Uu+d4DE+bGscdQuvt4e+SwpW4tFH0T+PazQ9XSx+AROmHLP9i2z
         U9u3VnJVab2WGsxbxl3jmUNPHWmx/F9N4Q7xW3xUAjjvNrmXoSvZXCv+FrjH76ikjaTT
         qgk6a1ElXBDAisWck7XIvn9VNgvfNI5CPukOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0EPNV9PY6l0QgOuy7PjTTS6a92xNNMAKQ2oPnDBFpI=;
        b=TaUzBUAbOUL6ivpkC0ikUJ9ma29q3/K92zv8k4LX/HtTsuEMuLVHW/JSWHIWsZiscL
         kb+Bl1sLtH8obT76hHM2r9SiDB9ANGFb5pDTp0BK8X4CHLt6k1HzBbAjAtWANuLBMtYo
         4ioE9yR2v67QTXOBrxfXwFLEqCdxbVBjevihaaNKojl5SpK93JCTkVlX5NDnYXZz9WwG
         s2hTkNB7Hpzn1Xqyi72QPChlkc1xjHmXAin5LCCrcDfv16IScUYPp5GxjDa9ahsmkjHI
         mRNGFDUtHMDr1PlEnd61T5QxAHTSr6xiCb3JtSrXYfT53daPxKy+RHSif8wlRl+/ENRg
         0m2Q==
X-Gm-Message-State: APt69E0CcMBGNj+OiOgS/8j+NHOoRZDvXdVm3KCFdotV7aPhrLuPdk2H
        UDz5rTiEC9A4eLvAFK25KfkDjA==
X-Google-Smtp-Source: ADUXVKK8ZuJyxmr4CMXtKXfZHmpHE4kjfoT9yZ4Ni7hYPgq5cCPDkQLQu1U5Y2vb32F+0Et02L3w9g==
X-Received: by 2002:a2e:994f:: with SMTP id r15-v6mr900004ljj.53.1528961833199;
        Thu, 14 Jun 2018 00:37:13 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id a195-v6sm957597lfe.44.2018.06.14.00.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 00:37:12 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next 3/6] net: ethernet: ti: cpsw: add MQPRIO Qdisc offload
Date:   Thu, 14 Jun 2018 10:36:47 +0300
Message-Id: <20180614073650.29659-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614073650.29659-1-ivan.khoronzhuk@linaro.org>
References: <20180614073650.29659-1-ivan.khoronzhuk@linaro.org>
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

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 406537d74ec1..edd14def98df 100644
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
@@ -453,6 +456,7 @@ struct cpsw_priv {
 	u8				mac_addr[ETH_ALEN];
 	bool				rx_pause;
 	bool				tx_pause;
+	bool				mqprio_hw;
 	u32 emac_port;
 	struct cpsw_common *cpsw;
 };
@@ -1577,6 +1581,14 @@ static void cpsw_slave_stop(struct cpsw_slave *slave, struct cpsw_common *cpsw)
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
@@ -2190,6 +2202,75 @@ static int cpsw_ndo_set_tx_maxrate(struct net_device *ndev, int queue, u32 rate)
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
@@ -2205,6 +2286,7 @@ static const struct net_device_ops cpsw_netdev_ops = {
 #endif
 	.ndo_vlan_rx_add_vid	= cpsw_ndo_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= cpsw_ndo_vlan_rx_kill_vid,
+	.ndo_setup_tc           = cpsw_ndo_setup_tc,
 };
 
 static int cpsw_get_regs_len(struct net_device *ndev)
-- 
2.17.1

