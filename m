Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83470ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB5920835
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB5920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeGMLWK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:22:10 -0400
Received: from hermes.aosc.io ([199.195.250.187]:55072 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbeGMLWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:22:10 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 02CBA64B5C;
        Fri, 13 Jul 2018 11:07:49 +0000 (UTC)
Date:   Fri, 13 Jul 2018 19:07:38 +0800
In-Reply-To: <1531479786-4911-7-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com> <1531479786-4911-7-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 6/9] ata: ahci_platform: add support for port regulator
To:     Corentin Labbe <clabbe@baylibre.com>, hdegoede@redhat.com,
        linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
CC:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <E8988FD2-335C-4BB9-87C3-2DE439784976@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月13日 GMT+08:00 下午7:03:03, Corentin Labbe <clabbe@baylibre.com> 写到:
>The SoC R40 AHCI controller need a port regulator to work.

In fact it should be a PHY regulator.

>We cannot use the "target-supply" since it's not a target power
>regulator.
>So this patch add a way to add an optional port regulator.
>
>Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>---
> drivers/ata/ahci.h             |  1 +
>drivers/ata/libahci_platform.c | 47
>+++++++++++++++++++++++++++++++++++++-----
> 2 files changed, 43 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>index 274c1885a5ad..716fd679dd3e 100644
>--- a/drivers/ata/ahci.h
>+++ b/drivers/ata/ahci.h
>@@ -352,6 +352,7 @@ struct ahci_host_priv {
> 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
> 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
> 	struct regulator	**target_pwrs;	/* Optional */
>+	struct regulator	**port_regulators;/* Optional */
> 	struct regulator	*ahci_regulator;/* Optional */
> 	struct reset_control	*ahci_reset;	/* Optional */
> 	/*
>diff --git a/drivers/ata/libahci_platform.c
>b/drivers/ata/libahci_platform.c
>index 1199ba411c15..d7574b3e1f6a 100644
>--- a/drivers/ata/libahci_platform.c
>+++ b/drivers/ata/libahci_platform.c
>@@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
>  */
> int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
> {
>-	int rc, i;
>+	int rc, i, j;
> 
> 	if (hpriv->ahci_regulator) {
> 		rc = regulator_enable(hpriv->ahci_regulator);
>@@ -164,9 +164,21 @@ int ahci_platform_enable_regulators(struct
>ahci_host_priv *hpriv)
> 		if (rc)
> 			goto disable_target_pwrs;
> 	}
>+	for (j = 0; j < hpriv->nports; j++) {
>+		if (!hpriv->port_regulators[j])
>+			continue;
>+
>+		rc = regulator_enable(hpriv->port_regulators[j]);
>+		if (rc)
>+			goto disable_port_regulators;
>+	}
> 
> 	return 0;
> 
>+disable_port_regulators:
>+	while (--j >= 0)
>+		if (hpriv->port_regulators[j])
>+			regulator_disable(hpriv->port_regulators[j]);
> disable_target_pwrs:
> 	while (--i >= 0)
> 		if (hpriv->target_pwrs[i])
>@@ -190,9 +202,10 @@ void ahci_platform_disable_regulators(struct
>ahci_host_priv *hpriv)
> 	int i;
> 
> 	for (i = 0; i < hpriv->nports; i++) {
>-		if (!hpriv->target_pwrs[i])
>-			continue;
>-		regulator_disable(hpriv->target_pwrs[i]);
>+		if (hpriv->target_pwrs[i])
>+			regulator_disable(hpriv->target_pwrs[i]);
>+		if (hpriv->port_regulators[i])
>+			regulator_disable(hpriv->port_regulators[i]);
> 	}
> 
> 	if (hpriv->ahci_regulator)
>@@ -291,9 +304,12 @@ static void ahci_platform_put_resources(struct
>device *dev, void *res)
> 	 * SATA device itself. So we can't use devm for automatically
> 	 * releasing them. We have to do it manually here.
> 	 */
>-	for (c = 0; c < hpriv->nports; c++)
>+	for (c = 0; c < hpriv->nports; c++) {
> 		if (hpriv->target_pwrs && hpriv->target_pwrs[c])
> 			regulator_put(hpriv->target_pwrs[c]);
>+		if (hpriv->port_regulators && hpriv->port_regulators[c])
>+			regulator_put(hpriv->port_regulators[c]);
>+	}
> }
> 
>static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32
>port,
>@@ -338,6 +354,7 @@ static int ahci_platform_get_regulator(struct
>ahci_host_priv *hpriv, u32 port,
> 				struct device *dev)
> {
> 	struct regulator *target_pwr;
>+	struct regulator *port_regulator;
> 	int rc = 0;
> 
> 	target_pwr = regulator_get_optional(dev, "target");
>@@ -346,6 +363,21 @@ static int ahci_platform_get_regulator(struct
>ahci_host_priv *hpriv, u32 port,
> 		hpriv->target_pwrs[port] = target_pwr;
> 	else
> 		rc = PTR_ERR(target_pwr);
>+	/* Only EPROBE_DEFER is important since it's an optional regulator */
>+	if (rc != -EPROBE_DEFER)
>+		rc = 0;
>+	else
>+		return rc;
>+
>+	port_regulator = regulator_get_optional(dev, "port");
>+
>+	if (!IS_ERR(port_regulator))
>+		hpriv->port_regulators[port] = port_regulator;
>+	else
>+		rc = PTR_ERR(port_regulator);
>+	/* Only EPROBE_DEFER is important since it's an optional regulator */
>+	if (rc != -EPROBE_DEFER)
>+		rc = 0;
> 
> 	return rc;
> }
>@@ -454,6 +486,11 @@ struct ahci_host_priv
>*ahci_platform_get_resources(struct platform_device *pdev)
> 		rc = -ENOMEM;
> 		goto err_out;
> 	}
>+	hpriv->port_regulators = devm_kcalloc(dev, hpriv->nports,
>sizeof(*hpriv->port_regulators), GFP_KERNEL);
>+	if (!hpriv->port_regulators) {
>+		rc = -ENOMEM;
>+		goto err_out;
>+	}
> 
> 	if (child_nodes) {
> 		for_each_child_of_node(dev->of_node, child) {
