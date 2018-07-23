Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE121ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990C8204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxLGjWVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990C8204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbeGWWaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:30:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32811 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388282AbeGWWaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:30:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so1779303ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d1Za27wcuN7sHeOL/0KokiwCWrvu5jc334Ssx7ln6cQ=;
        b=VxLGjWVmg52DX/Z2bx/9MzKKF/eQFkgY/odRP6QZDV0aE0SyupBBBa34pdIf71ozlq
         XLgWvoh5sAd+QjroInR5X0xexI1lCZtoXeTASrdFOXtRVg0VR8Z2on0rrscn0ADmDfeH
         i5kB8ztBxosNweVWp/XJBpQMQXMw+6c85t6b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d1Za27wcuN7sHeOL/0KokiwCWrvu5jc334Ssx7ln6cQ=;
        b=oPcjoz96bobGk/N7sZaeDtVKtxjCQiMYeDZq+PE0W2HFVQNFZKidd3raM9UqE314Gs
         VhK+RfNMxAJnH0jpvEJ9cVmfY3eELF0Wk9z3npovKv5zBaBFNB8V3QrMOGQnqYKtkjBC
         MNtQnDwYFg0RoOWkOcGxu5886Np0TefRHQuLx0Uy5sOX9R7qRQKMsEJswpLs8Su2kgfL
         4FKel/N9G64JXmEiY0ac+U8ERsA+lxfZ+qZShl+m7UbZm7JzJkKy8veQV4a0VIXfycHK
         SBZpLdF7M51RcpWubxju8ciokSY1ICvmuMLy8HsRfCjQffP1gSO0/heEHpAwZNWBJ6VA
         0lDw==
X-Gm-Message-State: AOUpUlG48DQ8C/8MDQhc3Vyj/OrZba+KVCEaxDv/Qs0IvSLRzczzK/hS
        37BJpVyC3gt6wi8uIpe/blpaXA==
X-Google-Smtp-Source: AAOMgpffoQ/Vjzh/l7nIWypo2LRWegoYlJ9e2gf/12ML6qOZGguEGS1MZeHYjzNsE8s4ZieB4fkyTg==
X-Received: by 2002:a2e:1004:: with SMTP id j4-v6mr10458738lje.2.1532381215695;
        Mon, 23 Jul 2018 14:26:55 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id q4-v6sm1990435ljh.36.2018.07.23.14.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:26:54 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 net-next 5/6] net: ethernet: ti: cpsw: restore shaper configuration while down/up
Date:   Tue, 24 Jul 2018 00:26:33 +0300
Message-Id: <20180723212634.3219-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723212634.3219-1-ivan.khoronzhuk@linaro.org>
References: <20180723212634.3219-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to restore shapers configuration after interface was down/up.
This is needed as appropriate configuration is still replicated in
kernel settings. This only shapers context restore, so vlan
configuration should be restored by user if needed, especially for
devices with one port where vlan frames are sent via ALE.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 449dc7f1e5f8..171abcfb6184 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1808,6 +1808,51 @@ static int cpsw_set_cbs(struct net_device *ndev,
 	return ret;
 }
 
+static void cpsw_cbs_resume(struct cpsw_slave *slave, struct cpsw_priv *priv)
+{
+	int fifo, bw;
+
+	for (fifo = CPSW_FIFO_SHAPERS_NUM; fifo > 0; fifo--) {
+		bw = priv->fifo_bw[fifo];
+		if (!bw)
+			continue;
+
+		cpsw_set_fifo_rlimit(priv, fifo, bw);
+	}
+}
+
+static void cpsw_mqprio_resume(struct cpsw_slave *slave, struct cpsw_priv *priv)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	u32 tx_prio_map = 0;
+	int i, tc, fifo;
+	u32 tx_prio_rg;
+
+	if (!priv->mqprio_hw)
+		return;
+
+	for (i = 0; i < 8; i++) {
+		tc = netdev_get_prio_tc_map(priv->ndev, i);
+		fifo = CPSW_FIFO_SHAPERS_NUM - tc;
+		tx_prio_map |= fifo << (4 * i);
+	}
+
+	tx_prio_rg = cpsw->version == CPSW_VERSION_1 ?
+		     CPSW1_TX_PRI_MAP : CPSW2_TX_PRI_MAP;
+
+	slave_write(slave, tx_prio_map, tx_prio_rg);
+}
+
+/* restore resources after port reset */
+static void cpsw_restore(struct cpsw_priv *priv)
+{
+	/* restore MQPRIO offload */
+	for_each_slave(priv, cpsw_mqprio_resume, priv);
+
+	/* restore CBS offload */
+	for_each_slave(priv, cpsw_cbs_resume, priv);
+}
+
 static int cpsw_ndo_open(struct net_device *ndev)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
@@ -1887,6 +1932,8 @@ static int cpsw_ndo_open(struct net_device *ndev)
 
 	}
 
+	cpsw_restore(priv);
+
 	/* Enable Interrupt pacing if configured */
 	if (cpsw->coal_intvl != 0) {
 		struct ethtool_coalesce coal;
-- 
2.17.1

