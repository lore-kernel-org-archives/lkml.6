Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A420C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6D420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPUSK8as"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6D420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeLIUc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:32:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33044 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeLIUbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:10 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so7816841ljd.0;
        Sun, 09 Dec 2018 12:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6JVMbk4XZ3boK+Wu7ilSs//m2kUIEmMXZzqXljfLTDo=;
        b=bPUSK8asqZo8DNk15nbYRXACtCYUG9EeYfZ9Q0el1pP7jfQ8yY+ShtQExyskJdh9dk
         seN1xFY7uQ4pJIYVW9KCIuWEDrqekSiko5PJczyyjOSLHtgQrwXuz8ycD11b+nJ6IOSv
         H76oJNTI18j3Ci2LR8UL1lCwNNN36+2g5x0s/DrA+KSsPRQ2FYvrEoQih8fDyY8EMz1l
         pNkm886o70V0J0JkcBlf/trOTFC7QXZ8n60s9xDqp+Su8nY4kj8XSCqr5Ra4w8jBN/JQ
         uWzFd94ElfBeIouQbP9qEG46If/0E2Vx3zIY3Z6SQabrzn2Cl9uyYoMRKODVJ6Us1jIE
         kMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6JVMbk4XZ3boK+Wu7ilSs//m2kUIEmMXZzqXljfLTDo=;
        b=JNXdl+WUQ+pB6tzKtt78oebx90eRCAiOkPg31eArVqyqYp5N5JscEoh279bRb6BINV
         2JSibKGvpuNmbPLoOMUlj8HZQYBzqEqoYqMIQyyO6uXiKEe76SxABPIB5EyH9zu6V80/
         0d2Fqnt5wcxZGEJPVGgujzymYxVg4aVZqBx6raB+dEmEM7LzSCwYVQmYsea+/1+RCb7p
         naUErdOX9tpbvCmn3ZmjC2ZvPofY853CZhSmC70vaEEnxJCL2wPdeK2ETCV7xSC+LIxx
         TaRYhgzE1C23EvOT9QTXW8wxdYJqL79I5+stIb6B6smPK9JSZ/9cDW5+if0RWsKqvda+
         6s6A==
X-Gm-Message-State: AA+aEWZCTs37R03+jAroaVrn2YQs+NqCDPwF6RHOz77Zq7Z92TqxsVzD
        h6fG5w3xK6a9BXSX4mgaPx8=
X-Google-Smtp-Source: AFSGD/WDNLETbB2TblZ5bsSM4vLzgC6JeIL5JVhGcqMpVQ/i0H6AdmbiQ8TVsgoEdNpvsHSG+7YWIA==
X-Received: by 2002:a2e:914b:: with SMTP id q11-v6mr5374535ljg.164.1544387467659;
        Sun, 09 Dec 2018 12:31:07 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/21] memory: tegra: Adapt to Tegra20 device-tree binding changes
Date:   Sun,  9 Dec 2018 23:29:38 +0300
Message-Id: <20181209202950.31486-10-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra20-mc device-tree binding has been changed, GART has been
squashed into Memory Controller and now the clock property is mandatory
for Tegra20, the DT compatible has been changed as well. Adapt driver to
the DT changes.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 21 ++++++++-------------
 drivers/memory/tegra/mc.h |  6 ------
 include/soc/tegra/mc.h    |  2 +-
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index b99f3c620f6c..59db13287b47 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -51,7 +51,7 @@
 
 static const struct of_device_id tegra_mc_of_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
-	{ .compatible = "nvidia,tegra20-mc", .data = &tegra20_mc_soc },
+	{ .compatible = "nvidia,tegra20-mc-gart", .data = &tegra20_mc_soc },
 #endif
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 	{ .compatible = "nvidia,tegra30-mc", .data = &tegra30_mc_soc },
@@ -638,24 +638,19 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
+	mc->clk = devm_clk_get(&pdev->dev, "mc");
+	if (IS_ERR(mc->clk)) {
+		dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
+			PTR_ERR(mc->clk));
+		return PTR_ERR(mc->clk);
+	}
+
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 	if (mc->soc == &tegra20_mc_soc) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		mc->regs2 = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(mc->regs2))
-			return PTR_ERR(mc->regs2);
-
 		isr = tegra20_mc_irq;
 	} else
 #endif
 	{
-		mc->clk = devm_clk_get(&pdev->dev, "mc");
-		if (IS_ERR(mc->clk)) {
-			dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
-				PTR_ERR(mc->clk));
-			return PTR_ERR(mc->clk);
-		}
-
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
 			dev_err(&pdev->dev, "failed to setup latency allowance: %d\n",
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 01065f12ebeb..9856f085e487 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -26,18 +26,12 @@
 
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
 {
-	if (mc->regs2 && offset >= 0x24)
-		return readl(mc->regs2 + offset - 0x3c);
-
 	return readl(mc->regs + offset);
 }
 
 static inline void mc_writel(struct tegra_mc *mc, u32 value,
 			     unsigned long offset)
 {
-	if (mc->regs2 && offset >= 0x24)
-		return writel(value, mc->regs2 + offset - 0x3c);
-
 	writel(value, mc->regs + offset);
 }
 
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index b43f37fea096..db5bfdf589b4 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -144,7 +144,7 @@ struct tegra_mc_soc {
 struct tegra_mc {
 	struct device *dev;
 	struct tegra_smmu *smmu;
-	void __iomem *regs, *regs2;
+	void __iomem *regs;
 	struct clk *clk;
 	int irq;
 
-- 
2.19.1

