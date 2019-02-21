Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E79C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADE92084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIVimHlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfBUPqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:46:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34869 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbfBUPqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:46:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id y15so9773555wma.0;
        Thu, 21 Feb 2019 07:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVAkFHWsBw81LuVIp40tAQgEJel2bCx4+a76C+S8vdY=;
        b=VIVimHlLCiYlvoz/2h+LipK3zCcKsLIzq9raYG1EkPUteKzR4gQwiX9nKNo9tL5qXZ
         wwzuibuAP5c/io1HNbfelTtLFsr1kW5kl2kpXxdmi8XUw0ZGYd3Ts/Sz2TO2K6BJ+0mQ
         ra9S50IaeDGgUKyeQdkO+jlAX3ZYLTMXYtk13w8riRZW1uL93dGPKclo3ViUZ1f99vvu
         8je9kqX9CilHJQg4YkImQodwWOYtfrpFHNWoxpHcmKjq2E5FPh+eNwiEzvF1z7mxICSD
         jZNKyPOM9QaOhvuGmOz8I9odrqwk064CleBLqUdQMTv9ddSlBozY6qjxZ/tMq2rSCWEZ
         fb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVAkFHWsBw81LuVIp40tAQgEJel2bCx4+a76C+S8vdY=;
        b=pj3JkOgsPoQO8707eFi52ZifD4E+4/ptvO+Zn6jcOOTuvYVpzqa4o+S9xKMmgIEX9R
         ic8gEx2HUdul/gbostHeivhwMau+qdAQJT3nl1B7klleh0npzOPDs8Dkc7nsN1eWxW6+
         HTkLFdXaO4tdQ2/Htd/xsuooWre9goZG7k1XzGeLyTGaM55DJHNXeGU5vKkxkpWwPhW3
         W+UXvIUDYoIa2+WhMTumYsezRFsICOF5/BXSggS7w4u3lORunkXbQArmq60pjXr/qR6k
         PakLXNbUNHgC0yC2BurSL/aV77g1sho+xua/b6/lJgOmSG59byw82Uuh59aBAzAlF86a
         RfeQ==
X-Gm-Message-State: AHQUAuZlcSkPsdSireEtSKSfQMHkXxPcAdPYMvnFnpuyMq988X8mvbfR
        YTRwPRm+x8h3uk3Cni93Jqw=
X-Google-Smtp-Source: AHgI3IbG+E/HxuLF5uKhES+WrpinxbeK0ImwjJTi2bf78ZoEbtrpqDzKaAVZwxsSEsdJA92k7lUG7Q==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr10449845wma.32.1550764002180;
        Thu, 21 Feb 2019 07:46:42 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id o5sm10400553wmh.12.2019.02.21.07.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:46:41 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] phy: tegra: xusb: Add support for power supplies
Date:   Thu, 21 Feb 2019 16:46:33 +0100
Message-Id: <20190221154634.10684-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154634.10684-1-thierry.reding@gmail.com>
References: <20190221154634.10684-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Support enabling various supplies needed to provide power to the PLLs
and logic used to drive the USB, PCI and SATA pads.

Reviewed-by: JC Kuo <jckuo@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/phy/tegra/xusb.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/phy/tegra/xusb.h |  5 +++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 57a2d08ef6da..e510629f4f1c 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -864,6 +864,7 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 	struct tegra_xusb_padctl *padctl;
 	const struct of_device_id *match;
 	struct resource *res;
+	unsigned int i;
 	int err;
 
 	/* for backwards compatibility with old device trees */
@@ -901,14 +902,38 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 		goto remove;
 	}
 
+	padctl->supplies = devm_kcalloc(&pdev->dev, padctl->soc->num_supplies,
+					sizeof(*padctl->supplies), GFP_KERNEL);
+	if (!padctl->supplies) {
+		err = -ENOMEM;
+		goto remove;
+	}
+
+	for (i = 0; i < padctl->soc->num_supplies; i++)
+		padctl->supplies[i].supply = padctl->soc->supply_names[i];
+
+	err = devm_regulator_bulk_get(&pdev->dev, padctl->soc->num_supplies,
+				      padctl->supplies);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to get regulators: %d\n", err);
+		goto remove;
+	}
+
 	err = reset_control_deassert(padctl->rst);
 	if (err < 0)
 		goto remove;
 
+	err = regulator_bulk_enable(padctl->soc->num_supplies,
+				    padctl->supplies);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to enable supplies: %d\n", err);
+		goto reset;
+	}
+
 	err = tegra_xusb_setup_pads(padctl);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to setup pads: %d\n", err);
-		goto reset;
+		goto power_down;
 	}
 
 	err = tegra_xusb_setup_ports(padctl);
@@ -921,6 +946,8 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 
 remove_pads:
 	tegra_xusb_remove_pads(padctl);
+power_down:
+	regulator_bulk_disable(padctl->soc->num_supplies, padctl->supplies);
 reset:
 	reset_control_assert(padctl->rst);
 remove:
@@ -936,6 +963,11 @@ static int tegra_xusb_padctl_remove(struct platform_device *pdev)
 	tegra_xusb_remove_ports(padctl);
 	tegra_xusb_remove_pads(padctl);
 
+	err = regulator_bulk_disable(padctl->soc->num_supplies,
+				     padctl->supplies);
+	if (err < 0)
+		dev_err(&pdev->dev, "failed to disable supplies: %d\n", err);
+
 	err = reset_control_assert(padctl->rst);
 	if (err < 0)
 		dev_err(&pdev->dev, "failed to assert reset: %d\n", err);
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index bb60fc09c752..5d5d22f6cb41 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -370,6 +370,9 @@ struct tegra_xusb_padctl_soc {
 	} ports;
 
 	const struct tegra_xusb_padctl_ops *ops;
+
+	const char * const *supply_names;
+	unsigned int num_supplies;
 };
 
 struct tegra_xusb_padctl {
@@ -393,6 +396,8 @@ struct tegra_xusb_padctl {
 	unsigned int enable;
 
 	struct clk *clk;
+
+	struct regulator_bulk_data *supplies;
 };
 
 static inline void padctl_writel(struct tegra_xusb_padctl *padctl, u32 value,
-- 
2.20.1

