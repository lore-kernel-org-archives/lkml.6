Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF08ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B94B20647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XbdBLMA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B94B20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbeGTRee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:34:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59990 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388011AbeGTRec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hPh+dO4dhabTPj9wtfvqRRvEnVVgeQEHVRvWQaRHQRM=; b=XbdBLMA2pxBG
        uw5725+pukPbeaWjV68hGx8uMaKaBUu55pI7nP2HoIlnllZ/8//cPcBbAqPzCoXYnYoCBOz6psz3o
        W7yIzsR2P/b2R5HvNnx5Ey8ktl7U7E9i7E0fOUNQOs1vg+gq6j8gEsMNrkeRNd7i1eELDmoGdtO5G
        03/Ps=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYWz-00006V-JB; Fri, 20 Jul 2018 16:45:25 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYWz-0001AF-5V; Fri, 20 Jul 2018 17:45:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: qcom_spmi: Fix warning Bad of_node_put()" to the regulator tree
In-Reply-To:  <20180716133255.1506-2-niklas.cassel@linaro.org>
Message-Id: <E1fgYWz-0001AF-5V@debutante>
Date:   Fri, 20 Jul 2018 17:45:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: qcom_spmi: Fix warning Bad of_node_put()

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From fffe7f52eb5db41eedadba9a8038e982dcfaee0c Mon Sep 17 00:00:00 2001
From: Niklas Cassel <niklas.cassel@linaro.org>
Date: Mon, 16 Jul 2018 15:32:51 +0200
Subject: [PATCH] regulator: qcom_spmi: Fix warning Bad of_node_put()

For of_find_node_by_name(), you typically pass what the previous call
returned. Therefore, of_find_node_by_name() increases the refcount of
the returned node, and decreases the refcount of the node passed as the
first argument.

of_find_node_by_name() is incorrectly used, and produces a warning.
Fix the warning by using the more suitable function
of_get_child_by_name().

Also add a missing of_node_put() for the returned value, since this was
previously being leaked.

OF: ERROR: Bad of_node_put() on /soc/qcom,spmi@400f000/pmic@3/regulators
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         4.18.0-rc4-00223-gefd7b360b70e #12
Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
Call trace:
 dump_backtrace+0x0/0x1a8
 show_stack+0x14/0x20
 dump_stack+0x90/0xb4
 of_node_release+0x74/0x78
 kobject_put+0x90/0x1f0
 of_node_put+0x14/0x20
 of_find_node_by_name+0x80/0xd8
 qcom_spmi_regulator_probe+0x30c/0x508

Fixes: 0caecaa87202 ("regulator: qcom_spmi: Add support for SAW")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 32 +++++++++++++++----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 9817f1a75342..4cc14c65d86b 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1752,7 +1752,8 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 	const char *name;
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *syscon;
+	struct device_node *syscon, *reg_node;
+	struct property *reg_prop;
 	int ret, lenp;
 	struct list_head *vreg_list;
 
@@ -1780,10 +1781,13 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 
 	for (reg = match->data; reg->name; reg++) {
 
-		if (saw_regmap && \
-		    of_find_property(of_find_node_by_name(node, reg->name), \
-				     "qcom,saw-slave", &lenp)) {
-			continue;
+		if (saw_regmap) {
+			reg_node = of_get_child_by_name(node, reg->name);
+			reg_prop = of_find_property(reg_node, "qcom,saw-slave",
+						    &lenp);
+			of_node_put(reg_node);
+			if (reg_prop)
+				continue;
 		}
 
 		vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
@@ -1816,13 +1820,17 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 		if (ret)
 			continue;
 
-		if (saw_regmap && \
-		    of_find_property(of_find_node_by_name(node, reg->name), \
-				     "qcom,saw-leader", &lenp)) {
-			spmi_saw_ops = *(vreg->desc.ops);
-			spmi_saw_ops.set_voltage_sel = \
-				spmi_regulator_saw_set_voltage;
-			vreg->desc.ops = &spmi_saw_ops;
+		if (saw_regmap) {
+			reg_node = of_get_child_by_name(node, reg->name);
+			reg_prop = of_find_property(reg_node, "qcom,saw-leader",
+						    &lenp);
+			of_node_put(reg_node);
+			if (reg_prop) {
+				spmi_saw_ops = *(vreg->desc.ops);
+				spmi_saw_ops.set_voltage_sel =
+					spmi_regulator_saw_set_voltage;
+				vreg->desc.ops = &spmi_saw_ops;
+			}
 		}
 
 		config.dev = dev;
-- 
2.18.0

