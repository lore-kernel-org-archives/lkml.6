Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032ADC43444
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37F1218DE
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="auAGKjun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfAFIKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:10:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42131 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfAFIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:10:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so19381707plp.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 00:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eykwn78UBt1QHUenCjEDKqDsuRhugMZbWizZ48+FyMg=;
        b=auAGKjun5gdTF6rkH5KplLjZ4gxXOfdr+8dFHbA+ENRXJgU/jDZQ0vFciuMaJoAijs
         Z2aW4MHZyFjkpt4NDM5cux8Ckjn3vME/0dLTZaAcgKComYyuxOLN9V4tByI1eN3KZX6f
         up+vc2EPqBzRrEBhZzh/i9fUYvJp0QESbc2Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eykwn78UBt1QHUenCjEDKqDsuRhugMZbWizZ48+FyMg=;
        b=sZisdbA8BOhvdHBadsgci8+DjX+F80xvm9S/nLmhUNEQSr0O3fZ1zvW4fusEtV7cVq
         BtmcaqwFb31OtSvvBz83rsvAPXiyfBRnqKMKUeKjUSJT2CgLmmt2eHLBKSZjzsDXn+Vh
         K6f2Vkm1OTFLkgV5hdXQM/mjuxvgpldB/SNO66HTBMLG/50qNjY94QaQjgCOdFtzNkIO
         xsuC9bL30dEkEz4SHJM6tzR2c6Lqpp2n9+Ba+pTJW7k29PpeDcY7qxg6ycmui8NHEsU3
         Ib/fnjRSEDZESn/9L736zlhcCWHZ8cufUG5zTbnAnO/ddwHV5zKUE5d8H3oWRlhnd/7l
         dKyg==
X-Gm-Message-State: AJcUukdMLfyuyHDj8oUo07oCX8vMmkW6FLNERfGCoI4BIuXeGy7dmO0e
        x2XBK+7ZJoyJiIlqZqyftWOElA==
X-Google-Smtp-Source: ALg8bN4nbB29ZKTwJRhVeccnnculUMkx9EBiAGttjj2MIcoyhA32qxDX5YOm1toe7Rf6xc82JQVunA==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7mr55746557plp.247.1546762222820;
        Sun, 06 Jan 2019 00:10:22 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v190sm90763364pfv.26.2019.01.06.00.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 00:10:22 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] remoteproc: q6v5-mss: Active powerdomain for SDM845
Date:   Sun,  6 Jan 2019 00:09:13 -0800
Message-Id: <20190106080915.4493-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190106080915.4493-1-bjorn.andersson@linaro.org>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDM845 MSS needs the load_state powerdomain voted for during the
duration of the MSS being powered on, to let the AOSS know that it may
not perform certain power save measures. So vote for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- New patch

 drivers/remoteproc/qcom_q6v5_mss.c | 31 ++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 62cf16ddb7af..7f86d9c551c4 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -133,6 +133,7 @@ struct rproc_hexagon_res {
 	char **proxy_clk_names;
 	char **reset_clk_names;
 	char **active_clk_names;
+	char **active_pd_names;
 	char **proxy_pd_names;
 	int version;
 	bool need_mem_protection;
@@ -159,10 +160,12 @@ struct q6v5 {
 	struct clk *active_clks[8];
 	struct clk *reset_clks[4];
 	struct clk *proxy_clks[4];
+	struct device *active_pds[1];
 	struct device *proxy_pds[3];
 	int active_clk_count;
 	int reset_clk_count;
 	int proxy_clk_count;
+	int active_pd_count;
 	int proxy_pd_count;
 
 	struct reg_info active_regs[1];
@@ -730,10 +733,16 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 
 	qcom_q6v5_prepare(&qproc->q6v5);
 
+	ret = q6v5_pds_enable(qproc, qproc->active_pds, qproc->active_pd_count);
+	if (ret < 0) {
+		dev_err(qproc->dev, "failed to enable active power domains\n");
+		goto disable_irqs;
+	}
+
 	ret = q6v5_pds_enable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
 	if (ret < 0) {
 		dev_err(qproc->dev, "failed to enable proxy power domains\n");
-		goto disable_irqs;
+		goto disable_active_pds;
 	}
 
 	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
@@ -839,6 +848,8 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 			       qproc->proxy_reg_count);
 disable_proxy_pds:
 	q6v5_pds_disable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
+disable_active_pds:
+	q6v5_pds_disable(qproc, qproc->active_pds, qproc->active_pd_count);
 disable_irqs:
 	qcom_q6v5_unprepare(&qproc->q6v5);
 
@@ -878,6 +889,7 @@ static void q6v5_mba_reclaim(struct q6v5 *qproc)
 			 qproc->active_clk_count);
 	q6v5_regulator_disable(qproc, qproc->active_regs,
 			       qproc->active_reg_count);
+	q6v5_pds_disable(qproc, qproc->active_pds, qproc->active_pd_count);
 
 	/* In case of failure or coredump scenario where reclaiming MBA memory
 	 * could not happen reclaim it here.
@@ -1410,11 +1422,19 @@ static int q6v5_probe(struct platform_device *pdev)
 	}
 	qproc->active_reg_count = ret;
 
+	ret = q6v5_pds_attach(&pdev->dev, qproc->active_pds,
+			      desc->active_pd_names);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to attach active power domains\n");
+		goto free_rproc;
+	}
+	qproc->active_pd_count = ret;
+
 	ret = q6v5_pds_attach(&pdev->dev, qproc->proxy_pds,
 			      desc->proxy_pd_names);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to init power domains\n");
-		goto free_rproc;
+		goto detach_active_pds;
 	}
 	qproc->proxy_pd_count = ret;
 
@@ -1446,6 +1466,8 @@ static int q6v5_probe(struct platform_device *pdev)
 
 detach_proxy_pds:
 	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
+detach_active_pds:
+	q6v5_pds_detach(qproc, qproc->active_pds, qproc->active_pd_count);
 free_rproc:
 	rproc_free(rproc);
 
@@ -1463,6 +1485,7 @@ static int q6v5_remove(struct platform_device *pdev)
 	qcom_remove_smd_subdev(qproc->rproc, &qproc->smd_subdev);
 	qcom_remove_ssr_subdev(qproc->rproc, &qproc->ssr_subdev);
 
+	q6v5_pds_detach(qproc, qproc->active_pds, qproc->active_pd_count);
 	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
 
 	rproc_free(qproc->rproc);
@@ -1489,6 +1512,10 @@ static const struct rproc_hexagon_res sdm845_mss = {
 			"mnoc_axi",
 			NULL
 	},
+	.active_pd_names = (char*[]){
+			"load_state",
+			NULL
+	},
 	.proxy_pd_names = (char*[]){
 			"cx",
 			"mx",
-- 
2.18.0

