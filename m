Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8A0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461C520857
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8XiPsi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461C520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeGSQp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbeGSQp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:45:27 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB2122084C;
        Thu, 19 Jul 2018 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532016097;
        bh=DeQcgj6tQKiRLII0PJEulPlaskqMIJmCj6JlOgXr9xc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=e8XiPsi71w83RdB4Re22/MBNdAjZwmqKTb6YIbZToBnvK6K4RY+GQCHyiOgT/qHNw
         qDhKNeogkiyVNPOSpG0yfeUE+IkfwSOPj7gj9q5JPwwDymc3Ncfd7lSTccH5jgrNW1
         aCGdSpmOP+RR9m2oBoqJlFVHq57sT926OZGg+DYE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 04/10] pinctrl: samsung: Add dedicated compatible for S5Pv210 wakeup interrupts
Date:   Thu, 19 Jul 2018 18:00:44 +0200
Message-Id: <20180719160050.22566-5-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S5Pv210 external wakeup interrupts differ from Exynos therefore
separate compatible is needed.  Duplicate existing flavor specific data
from exynos4210_wkup_irq_chip and add new compatible for S5Pv210.
At this point this new compatible does not bring anything new and works
exactly as "samsung,exynos4210-wakeup-eint".

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/pinctrl/samsung-pinctrl.txt    |  2 ++
 drivers/pinctrl/samsung/pinctrl-exynos.c               | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index f7700c9e0d0b..843a6cbf4774 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -161,6 +161,8 @@ B. External Wakeup Interrupts: For supporting external wakeup interrupts, a
        found on Samsung S3C2412 and S3C2413 SoCs,
      - samsung,s3c64xx-wakeup-eint: represents wakeup interrupt controller
        found on Samsung S3C64xx SoCs,
+     - samsung,s5pv210-wakeup-eint: represents wakeup interrupt controller
+       found on Samsung S5Pv210 SoCs,
      - samsung,exynos4210-wakeup-eint: represents wakeup interrupt controller
        found on Samsung Exynos4210 and S5PC110/S5PV210 SoCs.
      - samsung,exynos7-wakeup-eint: represents wakeup interrupt controller
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index a263ddd94945..29d86d704b0c 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -346,6 +346,22 @@ static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 /*
  * irq_chip for wakeup interrupts
  */
+static const struct exynos_irq_chip s5pv210_wkup_irq_chip __initconst = {
+	.chip = {
+		.name = "s5pv210_wkup_irq_chip",
+		.irq_unmask = exynos_irq_unmask,
+		.irq_mask = exynos_irq_mask,
+		.irq_ack = exynos_irq_ack,
+		.irq_set_type = exynos_irq_set_type,
+		.irq_set_wake = exynos_wkup_irq_set_wake,
+		.irq_request_resources = exynos_irq_request_resources,
+		.irq_release_resources = exynos_irq_release_resources,
+	},
+	.eint_con = EXYNOS_WKUP_ECON_OFFSET,
+	.eint_mask = EXYNOS_WKUP_EMASK_OFFSET,
+	.eint_pend = EXYNOS_WKUP_EPEND_OFFSET,
+};
+
 static const struct exynos_irq_chip exynos4210_wkup_irq_chip __initconst = {
 	.chip = {
 		.name = "exynos4210_wkup_irq_chip",
@@ -380,6 +396,8 @@ static const struct exynos_irq_chip exynos7_wkup_irq_chip __initconst = {
 
 /* list of external wakeup controllers supported */
 static const struct of_device_id exynos_wkup_irq_ids[] = {
+	{ .compatible = "samsung,s5pv210-wakeup-eint",
+			.data = &s5pv210_wkup_irq_chip },
 	{ .compatible = "samsung,exynos4210-wakeup-eint",
 			.data = &exynos4210_wkup_irq_chip },
 	{ .compatible = "samsung,exynos7-wakeup-eint",
-- 
2.14.1

