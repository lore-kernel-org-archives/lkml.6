Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A76C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C1920843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m070xjmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C1920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeICOVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40694 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeICOVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so515520wme.5;
        Mon, 03 Sep 2018 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t7Yy96h1CNLQsmpPB+gBtt+3MwMJX3o+4LyGaKYq94s=;
        b=m070xjmTV8oB18DF8XHLMSb11OXMKQs4HbkTJBzGsA/kkCepsrdAH/620RDjGWUxkr
         fVxM32Xk6O2ToADYUpC/Bq1fbBsqzz92WEv6rSx+LGrz9kYfmE73CQe85+DXUqdmUBaE
         uWoKO6TxQ4k8oheINrk/Jq9Ac6XrtY5d2/O2jLgsq96FdD8xXuF2Nl9aLvUQghs7ofoe
         nUoBZa99VKNQ+jcvmjSFELfUQbPnZ9lmh/l7UQq3nnfTTZ7kPUdp65SqiBqvf8gtq69B
         YqDJdpoLk/EmwXZcd40Kii785c1BHBSZ6eKnbDhQ+TROcSG2r8uN4HXB0TjMrtLBAFWt
         4xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t7Yy96h1CNLQsmpPB+gBtt+3MwMJX3o+4LyGaKYq94s=;
        b=nCiuma0+0eRTyFISjGCPXZBS/57wRf+bsCquqBvD+Ne2Nh9F0m0WQcT4ayoc4kfWOX
         OBtuvaKH7QveiZ5Q4NzIkp+b4+GB1Crhly3p3qlE4q7oWv21gHXXrS1+zfTz7BTmTpH5
         R4wG8zvA3UKdPwtpiQRN4fPjd6tv1J7qcczhpd1yVB0vKQp+OsSRHDUphNgLLGxnmovL
         JuuQnhsOs4EC71oBjOY6G7w5IRC37k18LeyHN5BXfJiy8MZrhhS/kPmP6lK5K0lL8D32
         sSCpeHFqU/MgfHMpEZGh1Fw7SOt9sPxPZ0Nch397EDMgJQSdgPzd0Y5IxgyuWyDVwsPX
         P/gg==
X-Gm-Message-State: APzg51BukSDwVKW+gz12jpNjWXXLFTSTih7FHtQlxYqScmIddP2aULCa
        uWq+Ykt6j7CtVaCGTfKYHOA=
X-Google-Smtp-Source: ANB0VdaOCrX22FEezBJWtRmBN94RtIe219A0b5ROX8xCmEYZdUsBkS2c17wZUAYKwtPmJevJ1M10EQ==
X-Received: by 2002:a1c:1d87:: with SMTP id d129-v6mr4492426wmd.34.1535968928948;
        Mon, 03 Sep 2018 03:02:08 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm31773936wre.18.2018.09.03.03.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 03:02:08 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v5 2/9] ata: ahci_platform: add support for AHCI controller regulator
Date:   Mon,  3 Sep 2018 12:01:54 +0200
Message-Id: <20180903100201.23131-3-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC R40 AHCI controller need a regulator to work.
So this patch add a way to add an optional regulator on AHCI controller.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/ata/ahci.h             |  1 +
 drivers/ata/libahci_platform.c | 26 ++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 6a1515f0da40..1415f1012de5 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -352,6 +352,7 @@ struct ahci_host_priv {
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct reset_control	*rsts;		/* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
+	struct regulator	*ahci_regulator;/* Optional */
 	/*
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
 	 * the PHY position in this array.
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index c92c10d55374..a886b61476a3 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -139,7 +139,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
  * ahci_platform_enable_regulators - Enable regulators
  * @hpriv: host private area to store config values
  *
- * This function enables all the regulators found in
+ * This function enables all the regulators found in controller and
  * hpriv->target_pwrs, if any.  If a regulator fails to be enabled, it
  * disables all the regulators already enabled in reverse order and
  * returns an error.
@@ -151,6 +151,12 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 {
 	int rc, i;
 
+	if (hpriv->ahci_regulator) {
+		rc = regulator_enable(hpriv->ahci_regulator);
+		if (rc)
+			return rc;
+	}
+
 	for (i = 0; i < hpriv->nports; i++) {
 		if (!hpriv->target_pwrs[i])
 			continue;
@@ -167,6 +173,8 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 		if (hpriv->target_pwrs[i])
 			regulator_disable(hpriv->target_pwrs[i]);
 
+	if (hpriv->ahci_regulator)
+		regulator_disable(hpriv->ahci_regulator);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_platform_enable_regulators);
@@ -175,7 +183,8 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_regulators);
  * ahci_platform_disable_regulators - Disable regulators
  * @hpriv: host private area to store config values
  *
- * This function disables all regulators found in hpriv->target_pwrs.
+ * This function disables all regulators found in hpriv->target_pwrs and
+ * AHCI controller.
  */
 void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 {
@@ -186,6 +195,9 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 			continue;
 		regulator_disable(hpriv->target_pwrs[i]);
 	}
+
+	if (hpriv->ahci_regulator)
+		regulator_disable(hpriv->ahci_regulator);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
 /**
@@ -351,6 +363,7 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
  *
  * 1) mmio registers (IORESOURCE_MEM 0, mandatory)
  * 2) regulator for controlling the targets power (optional)
+ *    regulator for controlling the AHCI controller (optional)
  * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
  *    or for non devicetree enabled platforms a single clock
  * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
@@ -408,6 +421,15 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		hpriv->clks[i] = clk;
 	}
 
+	hpriv->ahci_regulator = devm_regulator_get_optional(dev, "ahci");
+	if (IS_ERR(hpriv->ahci_regulator)) {
+		rc = PTR_ERR(hpriv->ahci_regulator);
+		if (rc == -EPROBE_DEFER)
+			goto err_out;
+		rc = 0;
+		hpriv->ahci_regulator = NULL;
+	}
+
 	if (flags & AHCI_PLATFORM_GET_RESETS) {
 		hpriv->rsts = devm_reset_control_array_get_optional_shared(dev);
 		if (IS_ERR(hpriv->rsts)) {
-- 
2.16.4

