Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23BBECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5881F206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLJLYVHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5881F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeGUMwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:52:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42836 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeGUMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:52:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so11545425ljc.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLLkeAlvs5IJFjAvRmQwjVrF2hJnKPQimLE3o5tPDis=;
        b=bLJLYVHcFoEHs2OmAqkj2vBgmAhvNLK6yw720JlCB5jlR0ZZFaXUvCGLhL8OlDOWQa
         LSFH6HR8J4EUZGQ/Jq/A397CjzHAkLwSpQQ2vNoLUavLcVGZKN/UA0tYn94vxNWA2S/1
         cr9NqzC/qlW6dXRLCNjvEF9F9jN0klEgmoqDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLLkeAlvs5IJFjAvRmQwjVrF2hJnKPQimLE3o5tPDis=;
        b=IzP6uoeTU2ZsXKvDqmeU2UaQGgK430Ky0ztd6wDQQJoiAiBFE+FZWQgxWdWxZX86k6
         NETDVvywAz+0yMpf4iProCE/Wto0O6ErHT3arSRni2nOo/qTsH9odC5xUfPxREfEMD4e
         mZWBsFvTqINAL78ZaNuqRBfjmomSoxy0woNlJeGpnn10+UI/q2//92b/fnEI7//gIFer
         U4t75yr7e+9mNecT6GG8t0WjGcoFrGLnMaPKqNV2bwBBsO+jeQVzRwlm+eOuukApt2AQ
         06mcpKavmXpprvqLA3abaXWJPhqQcJsBNlweQaAFK72XeEb4doXos4a1V4mC6jWshpx3
         CQSw==
X-Gm-Message-State: AOUpUlHlZVzVBIAtzbsrpvCAIfAfk6GY2pliZiKaG9P/c1R5gixkJ9X8
        zm3jkZtxkoXeRo4rpuGZw9dL7g==
X-Google-Smtp-Source: AAOMgpf8Rcv7bLOAXWyL85ga9CFEg772GzNaq0S0hNkwUfoSGD9KSbr6A+UN2ayH5k8iFcdBT8h/bQ==
X-Received: by 2002:a2e:9e17:: with SMTP id e23-v6mr4067940ljk.14.1532174378846;
        Sat, 21 Jul 2018 04:59:38 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 73-v6sm664260lfs.44.2018.07.21.04.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 04:59:38 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 net-next 4/6] net: ethernet: ti: cpsw: add CBS Qdisc offload
Date:   Sat, 21 Jul 2018 14:59:21 +0300
Message-Id: <20180721115923.1389-5-ivan.khoronzhuk@linaro.org>
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

The cpsw has up to 4 FIFOs per port and upper 3 FIFOs can feed rate
limited queue with shaping. In order to set and enable shaping for
those 3 FIFOs queues the network device with CBS qdisc attached is
needed. The CBS configuration is added for dual-emac/single port mode
only, but potentially can be used in switch mode also, based on
switchdev for instance.

Despite the FIFO shapers can work w/o cpdma level shapers the base
usage must be in combine with cpdma level shapers as described in TRM,
that are set as maximum rates for interface queues with sysfs.

One of the possible configuration with txq shapers and CBS shapers:

                      Configured with echo RATE >
                  /sys/class/net/eth0/queues/tx-0/tx_maxrate
             /---------------------------------------------------
            /
           /            cpdma level shapers
        +----+ +----+ +----+ +----+ +----+ +----+ +----+ +----+
        | c7 | | c6 | | c5 | | c4 | | c3 | | c2 | | c1 | | c0 |
        \    / \    / \    / \    / \    / \    / \    / \    /
         \  /   \  /   \  /   \  /   \  /   \  /   \  /   \  /
          \/     \/     \/     \/     \/     \/     \/     \/
+---------|------|------|------|-------------------------------------+
|    +----+      |      |  +---+                                     |
|    |      +----+      |  |                                         |
|    v      v           v  v                                         |
| +----+ +----+ +----+ +----+ p        p+----+ +----+ +----+ +----+  |
| |    | |    | |    | |    | o        o|    | |    | |    | |    |  |
| | f3 | | f2 | | f1 | | f0 | r  CPSW  r| f3 | | f2 | | f1 | | f0 |  |
| |    | |    | |    | |    | t        t|    | |    | |    | |    |  |
| \    / \    / \    / \    / 0        1\    / \    / \    / \    /  |
|  \  X   \  /   \  /   \  /             \  /   \  /   \  /   \  /   |
|   \/ \   \/     \/     \/               \/     \/     \/     \/    |
+-------\------------------------------------------------------------+
         \
          \ FIFO shaper, set with CBS offload added in this patch,
           \ FIFO0 cannot be rate limited
            ------------------------------------------------------

CBS shaper configuration is supposed to be used with root MQPRIO Qdisc
offload allowing to add sk_prio->tc->txq maps that direct traffic to
appropriate tx queue and maps L2 priority to FIFO shaper.

The CBS shaper is intended to be used for AVB where L2 priority
(pcp field) is used to differentiate class of traffic. So additionally
vlan needs to be created with appropriate egress sk_prio->l2 prio map.

If CBS has several tx queues assigned to it, the sum of their
bandwidth has not overlap bandwidth set for CBS. It's recomended the
CBS bandwidth to be a little bit more.

The CBS shaper is configured with CBS qdisc offload interface using tc
tool from iproute2 packet.

For instance:

$ tc qdisc replace dev eth0 handle 100: parent root mqprio num_tc 3 \
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

$ tc qdisc add dev eth0 parent 100:1 cbs locredit -1440 \
hicredit 60 sendslope -960000 idleslope 40000 offload 1

$ tc qdisc add dev eth0 parent 100:2 cbs locredit -1470 \
hicredit 62 sendslope -980000 idleslope 20000 offload 1

The above code set CBS shapers for tc0 and tc1, for that txq0 and
txq1 is used. Pay attention, the real set bandwidth can differ a bit
due to discreteness of configuration parameters.

Here parameters like locredit, hicredit and sendslope are ignored
internally and are supposed to be set with assumption that maximum
frame size for frame - 1500.

It's supposed that interface speed is not changed while reconnection,
not always is true, so inform user in case speed of interface was
changed, as it can impact on dependent shapers configuration.

For more examples see Documentation.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 221 +++++++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index f099e0ed138d..449dc7f1e5f8 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -46,6 +46,8 @@
 #include "cpts.h"
 #include "davinci_cpdma.h"
 
+#include <net/pkt_sched.h>
+
 #define CPSW_DEBUG	(NETIF_MSG_HW		| NETIF_MSG_WOL		| \
 			 NETIF_MSG_DRV		| NETIF_MSG_LINK	| \
 			 NETIF_MSG_IFUP		| NETIF_MSG_INTR	| \
@@ -154,8 +156,12 @@ do {								\
 #define IRQ_NUM			2
 #define CPSW_MAX_QUEUES		8
 #define CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT 256
+#define CPSW_FIFO_QUEUE_TYPE_SHIFT	16
+#define CPSW_FIFO_SHAPE_EN_SHIFT	16
+#define CPSW_FIFO_RATE_EN_SHIFT		20
 #define CPSW_TC_NUM			4
 #define CPSW_FIFO_SHAPERS_NUM		(CPSW_TC_NUM - 1)
+#define CPSW_PCT_MASK			0x7f
 
 #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT	29
 #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK		GENMASK(2, 0)
@@ -458,6 +464,8 @@ struct cpsw_priv {
 	bool				rx_pause;
 	bool				tx_pause;
 	bool				mqprio_hw;
+	int				fifo_bw[CPSW_TC_NUM];
+	int				shp_cfg_speed;
 	u32 emac_port;
 	struct cpsw_common *cpsw;
 };
@@ -1082,6 +1090,38 @@ static void cpsw_set_slave_mac(struct cpsw_slave *slave,
 	slave_write(slave, mac_lo(priv->mac_addr), SA_LO);
 }
 
+static bool cpsw_shp_is_off(struct cpsw_priv *priv)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct cpsw_slave *slave;
+	u32 shift, mask, val;
+
+	val = readl_relaxed(&cpsw->regs->ptype);
+
+	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
+	shift = CPSW_FIFO_SHAPE_EN_SHIFT + 3 * slave->slave_num;
+	mask = 7 << shift;
+	val = val & mask;
+
+	return !val;
+}
+
+static void cpsw_fifo_shp_on(struct cpsw_priv *priv, int fifo, int on)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct cpsw_slave *slave;
+	u32 shift, mask, val;
+
+	val = readl_relaxed(&cpsw->regs->ptype);
+
+	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
+	shift = CPSW_FIFO_SHAPE_EN_SHIFT + 3 * slave->slave_num;
+	mask = (1 << --fifo) << shift;
+	val = on ? val | mask : val & ~mask;
+
+	writel_relaxed(val, &cpsw->regs->ptype);
+}
+
 static void _cpsw_adjust_link(struct cpsw_slave *slave,
 			      struct cpsw_priv *priv, bool *link)
 {
@@ -1121,6 +1161,12 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
 			mac_control |= BIT(4);
 
 		*link = true;
+
+		if (priv->shp_cfg_speed &&
+		    priv->shp_cfg_speed != slave->phy->speed &&
+		    !cpsw_shp_is_off(priv))
+			dev_warn(priv->dev,
+				 "Speed was changed, CBS shaper speeds are changed!");
 	} else {
 		mac_control = 0;
 		/* disable forwarding */
@@ -1590,6 +1636,178 @@ static int cpsw_tc_to_fifo(int tc, int num_tc)
 	return CPSW_FIFO_SHAPERS_NUM - tc;
 }
 
+static int cpsw_set_fifo_bw(struct cpsw_priv *priv, int fifo, int bw)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	u32 val = 0, send_pct, shift;
+	struct cpsw_slave *slave;
+	int pct = 0, i;
+
+	if (bw > priv->shp_cfg_speed * 1000)
+		goto err;
+
+	/* shaping has to stay enabled for highest fifos linearly
+	 * and fifo bw no more then interface can allow
+	 */
+	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
+	send_pct = slave_read(slave, SEND_PERCENT);
+	for (i = CPSW_FIFO_SHAPERS_NUM; i > 0; i--) {
+		if (!bw) {
+			if (i >= fifo || !priv->fifo_bw[i])
+				continue;
+
+			dev_warn(priv->dev, "Prev FIFO%d is shaped", i);
+			continue;
+		}
+
+		if (!priv->fifo_bw[i] && i > fifo) {
+			dev_err(priv->dev, "Upper FIFO%d is not shaped", i);
+			return -EINVAL;
+		}
+
+		shift = (i - 1) * 8;
+		if (i == fifo) {
+			send_pct &= ~(CPSW_PCT_MASK << shift);
+			val = DIV_ROUND_UP(bw, priv->shp_cfg_speed * 10);
+			if (!val)
+				val = 1;
+
+			send_pct |= val << shift;
+			pct += val;
+			continue;
+		}
+
+		if (priv->fifo_bw[i])
+			pct += (send_pct >> shift) & CPSW_PCT_MASK;
+	}
+
+	if (pct >= 100)
+		goto err;
+
+	slave_write(slave, send_pct, SEND_PERCENT);
+	priv->fifo_bw[fifo] = bw;
+
+	dev_warn(priv->dev, "set FIFO%d bw = %d\n", fifo,
+		 DIV_ROUND_CLOSEST(val * priv->shp_cfg_speed, 100));
+
+	return 0;
+err:
+	dev_err(priv->dev, "Bandwidth doesn't fit in tc configuration");
+	return -EINVAL;
+}
+
+static int cpsw_set_fifo_rlimit(struct cpsw_priv *priv, int fifo, int bw)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct cpsw_slave *slave;
+	u32 tx_in_ctl_rg, val;
+	int ret;
+
+	ret = cpsw_set_fifo_bw(priv, fifo, bw);
+	if (ret)
+		return ret;
+
+	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
+	tx_in_ctl_rg = cpsw->version == CPSW_VERSION_1 ?
+		       CPSW1_TX_IN_CTL : CPSW2_TX_IN_CTL;
+
+	if (!bw)
+		cpsw_fifo_shp_on(priv, fifo, bw);
+
+	val = slave_read(slave, tx_in_ctl_rg);
+	if (cpsw_shp_is_off(priv)) {
+		/* disable FIFOs rate limited queues */
+		val &= ~(0xf << CPSW_FIFO_RATE_EN_SHIFT);
+
+		/* set type of FIFO queues to normal priority mode */
+		val &= ~(3 << CPSW_FIFO_QUEUE_TYPE_SHIFT);
+
+		/* set type of FIFO queues to be rate limited */
+		if (bw)
+			val |= 2 << CPSW_FIFO_QUEUE_TYPE_SHIFT;
+		else
+			priv->shp_cfg_speed = 0;
+	}
+
+	/* toggle a FIFO rate limited queue */
+	if (bw)
+		val |= BIT(fifo + CPSW_FIFO_RATE_EN_SHIFT);
+	else
+		val &= ~BIT(fifo + CPSW_FIFO_RATE_EN_SHIFT);
+	slave_write(slave, val, tx_in_ctl_rg);
+
+	/* FIFO transmit shape enable */
+	cpsw_fifo_shp_on(priv, fifo, bw);
+	return 0;
+}
+
+/* Defaults:
+ * class A - prio 3
+ * class B - prio 2
+ * shaping for class A should be set first
+ */
+static int cpsw_set_cbs(struct net_device *ndev,
+			struct tc_cbs_qopt_offload *qopt)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct cpsw_slave *slave;
+	int prev_speed = 0;
+	int tc, ret, fifo;
+	u32 bw = 0;
+
+	tc = netdev_txq_to_tc(priv->ndev, qopt->queue);
+
+	/* enable channels in backward order, as highest FIFOs must be rate
+	 * limited first and for compliance with CPDMA rate limited channels
+	 * that also used in bacward order. FIFO0 cannot be rate limited.
+	 */
+	fifo = cpsw_tc_to_fifo(tc, ndev->num_tc);
+	if (!fifo) {
+		dev_err(priv->dev, "Last tc%d can't be rate limited", tc);
+		return -EINVAL;
+	}
+
+	/* do nothing, it's disabled anyway */
+	if (!qopt->enable && !priv->fifo_bw[fifo])
+		return 0;
+
+	/* shapers can be set if link speed is known */
+	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
+	if (slave->phy && slave->phy->link) {
+		if (priv->shp_cfg_speed &&
+		    priv->shp_cfg_speed != slave->phy->speed)
+			prev_speed = priv->shp_cfg_speed;
+
+		priv->shp_cfg_speed = slave->phy->speed;
+	}
+
+	if (!priv->shp_cfg_speed) {
+		dev_err(priv->dev, "Link speed is not known");
+		return -1;
+	}
+
+	ret = pm_runtime_get_sync(cpsw->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(cpsw->dev);
+		return ret;
+	}
+
+	bw = qopt->enable ? qopt->idleslope : 0;
+	ret = cpsw_set_fifo_rlimit(priv, fifo, bw);
+	if (ret) {
+		priv->shp_cfg_speed = prev_speed;
+		prev_speed = 0;
+	}
+
+	if (bw && prev_speed)
+		dev_warn(priv->dev,
+			 "Speed was changed, CBS shaper speeds are changed!");
+
+	pm_runtime_put_sync(cpsw->dev);
+	return ret;
+}
+
 static int cpsw_ndo_open(struct net_device *ndev)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
@@ -2264,6 +2482,9 @@ static int cpsw_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			     void *type_data)
 {
 	switch (type) {
+	case TC_SETUP_QDISC_CBS:
+		return cpsw_set_cbs(ndev, type_data);
+
 	case TC_SETUP_QDISC_MQPRIO:
 		return cpsw_set_mqprio(ndev, type_data);
 
-- 
2.17.1

