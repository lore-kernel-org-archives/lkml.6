Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70831C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A66E204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Otz16K3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A66E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeIYEUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:20:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43995 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeIYETt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:19:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id q19-v6so9064648pgn.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SO/3cf37R4ebJVtFjkJ+OYsW0d2PxXmlpjfBXEFAL6E=;
        b=Otz16K3WmK0f2me16BU3f6oTm3+JyJMrXYNTA7CZyOsM7Gpr2GaHHgrtKL/d/OlMHS
         c+S6eea51novvS7rZdkRVncWDtGxCmoVdKeaVeb4rGqWV14C88YKsWoqM2QgSzfKKSbn
         EJMHwiUY2jYnpqeUAqtvKZHIJJcVhlF86wjkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SO/3cf37R4ebJVtFjkJ+OYsW0d2PxXmlpjfBXEFAL6E=;
        b=ek84fr5/Uq6lL/P/XZIJ5Orjq/2LB6wbJWwkc+MK1ImYEnycWOGcoOiiFBScOAruvk
         Z5u4d+1iawaCxt9HvNEpjGIRNrW/nLFolFHv3rNYtB5Z68NG9JfET3g6DabbQL5yKZ/S
         gF2s9NbehegceI6yQjj5M74oNaT3UKpsd1G1M9Ols+IRWs4FV0ygWJhc8YJ1RniWtnwa
         z9mMMU1FIVHbnrpV3JS/uPT9Dg2leWhBoOMdKyRoe8aD7udKqfma+E3mrUXKy54RrdU2
         ZOEBUxRM5ok2JnldBXb+5e0+A398veC/jdoAf89CusL7oRzyTfZJTKAkNQ3U5DYC4rSq
         iCkg==
X-Gm-Message-State: ABuFfoi/k9wUokpQ+jBOatzaJqKFj6FRHuKSlCBzdWTn5gbrQcDvvsVr
        /61RvhVabdLerC0DL9TjlfSCPw==
X-Google-Smtp-Source: ACcGV6270+JH0z3e+TVS33cnlMnVRasnX95SdkK44axYuu13S44oqw0L4fM8iYW5MYoF3NNorXpGiQ==
X-Received: by 2002:a17:902:76c8:: with SMTP id j8-v6mr478226plt.161.1537827325958;
        Mon, 24 Sep 2018 15:15:25 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w23-v6sm386260pgi.18.2018.09.24.15.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 15:15:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] pinctrl: qcom: Support dispersed tiles
Date:   Mon, 24 Sep 2018 15:17:46 -0700
Message-Id: <20180924221748.21584-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180924221748.21584-1-bjorn.andersson@linaro.org>
References: <20180924221748.21584-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some new platforms the tiles have been placed too far apart to be
covered in a single ioremap. Turn "regs" into an array of base addresses
and make the pingroup carry the information about which tile the pin
resides in.

For existing platforms we map the first entry regs and the existing
pingroups will all use tile 0, meaning that there's no functional
change.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/pinctrl/qcom/pinctrl-msm.c | 30 +++++++++++++++++++++---------
 drivers/pinctrl/qcom/pinctrl-msm.h |  4 ++++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index ac724a357bd6..6f02bbdb0865 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -37,6 +37,7 @@
 #include "../pinctrl-utils.h"
 
 #define MAX_NR_GPIO 300
+#define MAX_NR_TILES 4
 #define PS_HOLD_OFFSET 0x820
 
 /**
@@ -52,7 +53,7 @@
  * @dual_edge_irqs: Bitmap of irqs that need sw emulated dual edge
  *                  detection.
  * @soc;            Reference to soc_data of platform specific data.
- * @regs:           Base address for the TLMM register map.
+ * @regs:           Base addresses for the TLMM tiles.
  */
 struct msm_pinctrl {
 	struct device *dev;
@@ -70,19 +71,19 @@ struct msm_pinctrl {
 	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
 
 	const struct msm_pinctrl_soc_data *soc;
-	void __iomem *regs;
+	void __iomem *regs[MAX_NR_TILES];
 };
 
 #define MSM_ACCESSOR(name) \
 static u32 msm_readl_##name(struct msm_pinctrl *pctrl, \
 			    const struct msm_pingroup *g) \
 { \
-	return readl(pctrl->regs + g->name##_reg); \
+	return readl(pctrl->regs[g->tile] + g->name##_reg); \
 } \
 static void msm_writel_##name(u32 val, struct msm_pinctrl *pctrl, \
 			      const struct msm_pingroup *g) \
 { \
-	writel(val, pctrl->regs + g->name##_reg); \
+	writel(val, pctrl->regs[g->tile] + g->name##_reg); \
 }
 
 MSM_ACCESSOR(ctl)
@@ -1022,7 +1023,7 @@ static int msm_ps_hold_restart(struct notifier_block *nb, unsigned long action,
 {
 	struct msm_pinctrl *pctrl = container_of(nb, struct msm_pinctrl, restart_nb);
 
-	writel(0, pctrl->regs + PS_HOLD_OFFSET);
+	writel(0, pctrl->regs[0] + PS_HOLD_OFFSET);
 	mdelay(1000);
 	return NOTIFY_DONE;
 }
@@ -1058,6 +1059,7 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	struct msm_pinctrl *pctrl;
 	struct resource *res;
 	int ret;
+	int i;
 
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
@@ -1069,10 +1071,20 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 
 	raw_spin_lock_init(&pctrl->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pctrl->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pctrl->regs))
-		return PTR_ERR(pctrl->regs);
+	if (soc_data->tiles) {
+		for (i = 0; i < soc_data->ntiles; i++) {
+			res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+							   soc_data->tiles[i]);
+			pctrl->regs[i] = devm_ioremap_resource(&pdev->dev, res);
+			if (IS_ERR(pctrl->regs[i]))
+				return PTR_ERR(pctrl->regs[i]);
+		}
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		pctrl->regs[0] = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(pctrl->regs[0]))
+			return PTR_ERR(pctrl->regs[0]);
+	}
 
 	msm_pinctrl_setup_pm_reset(pctrl);
 
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 9b9feea540ff..0ad4bc55e2e1 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -76,6 +76,8 @@ struct msm_pingroup {
 	u32 intr_status_reg;
 	u32 intr_target_reg;
 
+	unsigned int tile:2;
+
 	unsigned mux_bit:5;
 
 	unsigned pull_bit:5;
@@ -117,6 +119,8 @@ struct msm_pinctrl_soc_data {
 	unsigned ngroups;
 	unsigned ngpios;
 	bool pull_no_keeper;
+	const char **tiles;
+	unsigned int ntiles;
 };
 
 int msm_pinctrl_probe(struct platform_device *pdev,
-- 
2.18.0

