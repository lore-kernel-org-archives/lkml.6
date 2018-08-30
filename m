Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720802082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovh2DSFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720802082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeH3XFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35714 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH3XFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so3084850wmc.0;
        Thu, 30 Aug 2018 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t7Yy96h1CNLQsmpPB+gBtt+3MwMJX3o+4LyGaKYq94s=;
        b=Ovh2DSFQ3Cs6oLBB67ht6cSz4HYmGF8Wha89mOyuDPXkA1DktCSvtOe9hN5rJM0COS
         BqdbmOs3DP96TKpkimSVj+KN7d2D3YrtcPABUwXb7VS+YIshG7m0D0X9qlXfWUE5WPzQ
         fumVRD+JDD/7qTg9FPB+lWDdNyQSuT2/aERQEzH34edKn8K+oLj+6uX49dMym8abrtMS
         5auJyHSU4SL8rfQCcfSL/B77phx64zqXzdkX+1ZlG5PSW+jGUVvUSOAiG9/QcA2gNIlQ
         4cfntFdChWp7ZXQNx0uxZIJQoWDez6a8xLhtUG6/YweucdqC+/Gp+iLOg7i2Vr2fkqKp
         7FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t7Yy96h1CNLQsmpPB+gBtt+3MwMJX3o+4LyGaKYq94s=;
        b=rInyriQaT05Sn2a72D2vweNqrTwcTWZjIeCw63edfMYpsrkIis0/LpR+Bn1uip4cs3
         plm/67Y/AO0JWn/ffcwljWVtdcUAqrCNyxL4ao+HrhKu6KVktFzZQbDdsqyJT1Wl24hU
         8q7wCcc0e62nacfO5iF/0eTBFvHzy4pbwTb/qRyqyd3R1AKenyx3F5SeRk/Bxh7e8lk5
         6yLI4Rbsm5RouwQEaheU9Qgmg0JgN0zPhfEzRJWNUWzw+SCRLJgyAiPdUtEyiaGtqJ99
         /Zh6sWfozFMhE1KdZ9atc2eFEC5EfbcXLrHySoUWrjzgkTUEcUXTo7RW326MZk+D+gZm
         63fg==
X-Gm-Message-State: APzg51DnB4f4HyY2HBy4BpRBKtQFV5i1gNlqlfLD41ptHTL05KSdOkJF
        /J3SUtEeitEgS3SNE6TNQXs=
X-Google-Smtp-Source: ANB0Vdb6vrLVv1tUQqsKvf3EK6v9rGI3K/xY72jlBe/Kj2psPEnGdHTISywO0PI3hRnsWYx3Asqzew==
X-Received: by 2002:a1c:908b:: with SMTP id s133-v6mr2706797wmd.69.1535655691915;
        Thu, 30 Aug 2018 12:01:31 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:30 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 02/13] ata: ahci_platform: add support for AHCI controller regulator
Date:   Thu, 30 Aug 2018 21:01:09 +0200
Message-Id: <20180830190120.722-3-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
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

