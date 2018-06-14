Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8EEC7C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4604A208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7711F+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4604A208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754808AbeFNHh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:37:26 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38162 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754748AbeFNHhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:37:18 -0400
Received: by mail-lf0-f68.google.com with SMTP id i83-v6so7850012lfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fdzBwfiddhsxHhTDFLri8ZLLuudlxJt46EpHoD2hZtA=;
        b=V7711F+KQV3zJofRXuox9Z/KBRiI37VZvifxCQkqrWzU3bpXL8MsnCgaCMn86bUGHw
         EgERB7992eqNTThnHuJsqNoQdTnIYBERyGuG0b//aWliHRsca6MvVsZJju3+9pLniIZG
         RQC1vix44bd3G/bcyzlZhdlqbHoNYxQ9wZZ00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fdzBwfiddhsxHhTDFLri8ZLLuudlxJt46EpHoD2hZtA=;
        b=G7Hvy3CGzUueyKmBdZPV2fFkCX3A1jJcoaJrpWonLcA0A49vu3eMvt5OYUqSGwn272
         84iGSob2S4mtJssenjAUTIwdCTNRPh2losnBnUEwhEJJzPadj8Tu9W6cAio9+NfLDzt4
         wvzEp1REaSyWzaMdbBEeIpaaYkWpdILC/h9zZOCcoPfpCrYQx20+iipeBI6QY7uXjLyh
         ZQ2GbU8FKwF4a11i7J6jYR9vjqW4ReHsHPhfJZgJ+tfMCzi2/SDIJCeaStOHGDzrhn3J
         sOWsoXCwie6VNH5WpP63tdeKMU8EGgGw6Ielxeqy5EnsxIGE0rewYcEepVVewAuThAeS
         UgOA==
X-Gm-Message-State: APt69E0gohj3j1SfKLFfiDV6vosqVDjlImQa08e9psL4rCPIHwtJ1fzG
        /fIicn3OrF0UQl3BmKWcA8vUpQ==
X-Google-Smtp-Source: ADUXVKK1m1xJJsbbnnZ2L750Ackbruqwuq+uomihLMQKhtoNUm2JaVD6fEDkuu4djIsEvIpJzNfKvQ==
X-Received: by 2002:a2e:99c7:: with SMTP id l7-v6mr957123ljj.148.1528961836448;
        Thu, 14 Jun 2018 00:37:16 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id a195-v6sm957597lfe.44.2018.06.14.00.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 00:37:15 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next 5/6] net: ethernet: ti: cpsw: restore shaper configuration while down/up
Date:   Thu, 14 Jun 2018 10:36:49 +0300
Message-Id: <20180614073650.29659-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614073650.29659-1-ivan.khoronzhuk@linaro.org>
References: <20180614073650.29659-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to restore shapers configuration after interface was down/up.
This is needed as appropriate configuration is still replicated in
kernel settings. This only shapers context restore, so vlan
configuration should be restored by user if needed, especially for
devices with one port where vlan frames are sent via ALE.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 3623c2994ddf..b2dfa7053b40 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1807,6 +1807,51 @@ static int cpsw_set_cbs(struct net_device *ndev,
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
@@ -1886,6 +1931,8 @@ static int cpsw_ndo_open(struct net_device *ndev)
 
 	}
 
+	cpsw_restore(priv);
+
 	/* Enable Interrupt pacing if configured */
 	if (cpsw->coal_intvl != 0) {
 		struct ethtool_coalesce coal;
-- 
2.17.1

