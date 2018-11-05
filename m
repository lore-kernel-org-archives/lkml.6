Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77933C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7D020854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhZiNlry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7D020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeKEQ5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:57:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35703 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbeKEQ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:57:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id n4-v6so4035452plp.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 23:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=j2tmUgh6tRu6QqzVSQLrFCxkt/YAU9SuinNlw7cTUGE=;
        b=UhZiNlry/KXodTpr9qhU/8IkmbDzfvjCqlQWKTrGVJvs7F5XvczSTRFtdQ/ujwo8LS
         VaBB7GJ1eRxdJ57vsgCM7FXu/O3AgyvspchwxTXvBdDEZvq9oTIBfV7BHoYaRBkxX02a
         TEVC5b7IHUf52qwp96YzKDKpukJdQLWBUS3hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=j2tmUgh6tRu6QqzVSQLrFCxkt/YAU9SuinNlw7cTUGE=;
        b=K8dRW43cE7mprA6S6IWMKJchp+EnYX7FrY59GU4n5p2hH0Syd3GPSPIgVAT45XJOko
         SJYfnv+LDRETHM18IcvX8o14Zh2YlQnp+TR60xVmF8ELwY19JV7bK8YT8flHMFWMZERr
         kySAA1wP+2+AG4+QxAC9gnbG72eFcuOWbwDUIWN8J2/H3oxsGYZzGcGEyWhY5u7Nix2Y
         QvcbVD81j/Csb/623r39VSJ/yMQEdggtLW9k8Y9S1EDGnaQOJDFGP5dLECV/DxEn6yCr
         8TFxyQGY8zy1QFUMj+6nmn04GW5r4ynPvBaNTXx+gO0Rc3y5MMqXipGayt0/M9BWcvAW
         ouIA==
X-Gm-Message-State: AGRZ1gIlYuNFPEtGLWC7pDJl4rrdl4zoURRDeg43A1Jmf+Tg2xkAw4YJ
        U0cNcN6QnIk2yeuC9fvS6fkA1w==
X-Google-Smtp-Source: AJdET5fRuLIjHGiKwaiAWhaOw3teQLIuemIi8ZX4evJ31W8xc5KIhGsHoRfuutnM15IPMh9CatzBjg==
X-Received: by 2002:a17:902:32a4:: with SMTP id z33-v6mr21057060plb.85.1541403574125;
        Sun, 04 Nov 2018 23:39:34 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d5-v6sm27632040pfo.131.2018.11.04.23.39.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Nov 2018 23:39:33 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org, quentin.schulz@bootlin.com
Subject: [PATCH v7 2/6] power: supply: core: Add one field to present the battery internal resistance
Date:   Mon,  5 Nov 2018 15:39:07 +0800
Message-Id: <5253c12da08295914dda82d47a130916d0ed0407.1541393063.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
References: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
In-Reply-To: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
References: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one field for 'struct power_supply_battery_info' to present the battery
factory internal resistance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes from v6:
 - None.

Changes from v5:
 - None.

Changes from v4:
 - None.

Changes from v3:
 - New patch in v3, which splits code into one separate patch.
 - Add Linusw reviewed tag.
---
 drivers/power/supply/power_supply_core.c |    3 +++
 include/linux/power_supply.h             |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index e853618..307e0995 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -579,6 +579,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->charge_term_current_ua         = -EINVAL;
 	info->constant_charge_current_max_ua = -EINVAL;
 	info->constant_charge_voltage_max_uv = -EINVAL;
+	info->factory_internal_resistance_uohm  = -EINVAL;
 
 	if (!psy->of_node) {
 		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
@@ -616,6 +617,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->constant_charge_current_max_ua);
 	of_property_read_u32(battery_np, "constant_charge_voltage_max_microvolt",
 			     &info->constant_charge_voltage_max_uv);
+	of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohms",
+			     &info->factory_internal_resistance_uohm);
 
 	return 0;
 }
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index f807691..d089566 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -326,6 +326,7 @@ struct power_supply_battery_info {
 	int charge_term_current_ua;	    /* microAmps */
 	int constant_charge_current_max_ua; /* microAmps */
 	int constant_charge_voltage_max_uv; /* microVolts */
+	int factory_internal_resistance_uohm;   /* microOhms */
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
-- 
1.7.9.5

