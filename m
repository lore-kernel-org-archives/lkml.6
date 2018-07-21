Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB38ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764BA206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQQ+xuPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764BA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeGUMwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:52:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44469 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbeGUMwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:52:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so13184294ljq.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1YA/ffmI4lvPW6BD2uhQsoeiW5XV+DX4SZhSwKauGOw=;
        b=TQQ+xuPyV0qwrF/V1dFImuWPHaG+oPPFqLH9G6xdeRnk6knbT+TGup/Q07LJ2AYdS+
         4T9goXTzmz60Jtv97jEx7/937mxahREDDToQR7GDsu1dnjlZNPm4SJbCF7RXk1HQGM3j
         a0htMvw4NikRfNwgZkXp4jZG0Nos6CSfPsKy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1YA/ffmI4lvPW6BD2uhQsoeiW5XV+DX4SZhSwKauGOw=;
        b=gQpgeGBgAE0fPRdKjgK3GyxR5nibCk5yL+C33bjyHmiEaG3gc8rBnhkSKDG3PJGF7F
         o1kHtNwQ9OZ0Pxp331LlY0KeD6lX89PNgTmyY1R012k2BiPK70klDfIk4b+wt9TELfSC
         SbpMfIBUob8N68WahgMmHW8i+PZW2Z2rTI2WGPXjT9rpCBHCFT19gHEwh3D/VbO8txcr
         QetLUoLeHrM+cRAZ8fr+0KBVvYtJ9XcW3AsrvlhqoKWlmSHkC3buDoTdvKR9+uRJx0XJ
         kZf55TVolWvzdYA0VzKpfScXMwo70ZEmuNr0xlIKu8JGJz+oALE0MJH2771MtasaWwJG
         Z29Q==
X-Gm-Message-State: AOUpUlGEKJiyXkgPDdRQWjuHRiDkGCvvU5NItusTpEBMVe8ER81+98QW
        VMEaQ+ljgsD25v0aZuv+1BAVoA==
X-Google-Smtp-Source: AAOMgpevXdI5q1Dkt9JxrcExZFIHBYPkYFPEFa9tQkRokPPiLgbCppNEvvmLmWJCg/2hY1sB2BRYqg==
X-Received: by 2002:a2e:800e:: with SMTP id j14-v6mr4134395ljg.114.1532174380338;
        Sat, 21 Jul 2018 04:59:40 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 73-v6sm664260lfs.44.2018.07.21.04.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 04:59:39 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 net-next 5/6] net: ethernet: ti: cpsw: restore shaper configuration while down/up
Date:   Sat, 21 Jul 2018 14:59:22 +0300
Message-Id: <20180721115923.1389-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721115923.1389-1-ivan.khoronzhuk@linaro.org>
References: <20180721115923.1389-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to restore shapers configuration after interface was down/up.
This is needed as appropriate configuration is still replicated in
kernel settings. This only shapers context restore, so vlan
configuration should be restored by user if needed, especially for
devices with one port where vlan frames are sent via ALE.

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

