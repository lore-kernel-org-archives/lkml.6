Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEF9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8458C2150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDQhPqAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8458C2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbeITHPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:15:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37571 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbeITHPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:15:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so3548506pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nNvAonLYhhMyL2rVaMZj5rHBUVBtZQTJDv7L7fgoZM4=;
        b=PDQhPqAsHAdjtLGgmVFX1lrnqYoP20zYSfccmOboeA/4PRJJYr4shIxQSjUffLXkyv
         mULvdbMliVOgXPyfDF1yWIk4x2NUE0kRrgza3+HkzAYfn3NT1gg8ZZpS4D10/1KhzLrk
         1ifznVcXrJ9SqzNEZEI2cOjmjo6BkbA5MdKF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nNvAonLYhhMyL2rVaMZj5rHBUVBtZQTJDv7L7fgoZM4=;
        b=Qsk76u9gWZ7lOqyOws4xrwPpC+itvNBiyC6iIrmw10TTJxe1HFfK3pIGGFk8ogwF/t
         5zbZenZ6GEtVnTK0M0QR8sOWTTn82UFvZ4x5+z1AKq781C/t6W6D7gAY0PEvHPqBISkt
         /5n9deYlvT6i9lrZpNv9twVBe694rdvFd5vjd546bFYb+60xps9YmfvHhZzfJrgt1MRW
         ZgAoFc2fWJgpBG641GAijrqGROvrRN0X1KVMWDKHM+JG7prudW44p2OikULFStAVpsIp
         E5Ui2uTLD9xaaTNTMCOZqnr+zQadcMM+7W3eEd6k8g1VDyYECy88JIz/YbLqGmzDXY/C
         nJvA==
X-Gm-Message-State: APzg51D4Mmqf1j3VMcoefMcROHx2+c8nEKRlAchYFt6YOnQGAPGjlmzi
        LPDK5E0cO1oq1v9HZr5Yu61MNw==
X-Google-Smtp-Source: ANB0Vdb94HgL7+pBJwlQoVlBPtaj/umrkAGU0srAZ4sXZnLiqu9jUODtfZG3V0VzPuTatBgTNAkQpg==
X-Received: by 2002:a63:d70e:: with SMTP id d14-v6mr35107396pgg.110.1537407298413;
        Wed, 19 Sep 2018 18:34:58 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l127-v6sm38753943pfc.55.2018.09.19.18.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 18:34:57 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] pinctrl: qcom: Support dispersed tiles
Date:   Wed, 19 Sep 2018 18:37:10 -0700
Message-Id: <20180920013712.2361-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920013712.2361-1-bjorn.andersson@linaro.org>
References: <20180920013712.2361-1-bjorn.andersson@linaro.org>
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
 drivers/pinctrl/qcom/pinctrl-msm.c | 30 +++++++++++++++++++++---------
 drivers/pinctrl/qcom/pinctrl-msm.h |  4 ++++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 86fbb5fe4d0e..0726c8a09065 100644
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
@@ -1046,7 +1047,7 @@ static int msm_ps_hold_restart(struct notifier_block *nb, unsigned long action,
 {
 	struct msm_pinctrl *pctrl = container_of(nb, struct msm_pinctrl, restart_nb);
 
-	writel(0, pctrl->regs + PS_HOLD_OFFSET);
+	writel(0, pctrl->regs[0] + PS_HOLD_OFFSET);
 	mdelay(1000);
 	return NOTIFY_DONE;
 }
@@ -1082,6 +1083,7 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	struct msm_pinctrl *pctrl;
 	struct resource *res;
 	int ret;
+	int i;
 
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
@@ -1093,10 +1095,20 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 
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

