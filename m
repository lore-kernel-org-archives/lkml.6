Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEC1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EF620895
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxVIQnhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EF620895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeIZJKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:10:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39754 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZJKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:10:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85-v6so9939365pge.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C683NJzRjGNOhU3KRWttGdic5R9Ub04NEzSVb+GXFUY=;
        b=gxVIQnhTc1JhfGjxOi0iWJwXD69vXw9++B7ukjRwTl49cPqYE+31s2C9ATysXbcq7I
         ODOa9yj3nldLkLlOI1JAsqDZm+YinL5cKV6DWu5pDF6w3bidQmL9c/xuEdu1cK99IVY/
         zdozqmIgEp+8ASqN7VP4uDm5dMUJFTbSNtcJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C683NJzRjGNOhU3KRWttGdic5R9Ub04NEzSVb+GXFUY=;
        b=H7Astf7NH18zjP/q+7J6Xvl4A9wLXG1jy+tG4+2ls7RT8M/Swwjtt3sNrZZWsTcLke
         X3a5jUo2eCQ46/F3K4c2o/Zh5cqHAvrA89lF1JY8lC7ZcfMPU4uKPh/bsyOFS7dcyRHL
         NfXWCzJ2MTV9ximhwccDeh4WQH0+l3UnWOeyIF2HqAlFygglk1GZBPAI2iofXu8f5Gkx
         vmzkA6XbOCw13Vf8AyAnI7+Jg7ilWQ4skaHCxKOTRUWidBMqSJyrTcPKMFeqDd33cyV4
         6nBbwg9zCraAoArrhqvbE7yqrldyew9J0+DioKFJD8vBzpMN6O93Bg9wvJi4B4OhHNQd
         dhmQ==
X-Gm-Message-State: ABuFfohbVKu8VBO7hwDUmN+pKZOXNgDO0EK6p/oq1J9OY0HNR4Dp7l83
        WACoRpM3+VuS6quhw/8vc3Un1Q==
X-Google-Smtp-Source: ACcGV60qHI5orHu2lAWMnHCKedcKt0q5Uo2M/vQT9aHOz5x54y9R2zWc/8hpTUxJdT1+uzqcuo06LA==
X-Received: by 2002:a63:7c1d:: with SMTP id x29-v6mr3590885pgc.273.1537930796746;
        Tue, 25 Sep 2018 19:59:56 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s13-v6sm5471703pfj.105.2018.09.25.19.59.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 19:59:55 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v2 1/4] power: supply: core: Introduce one property to present the battery internal resistance
Date:   Wed, 26 Sep 2018 10:59:11 +0800
Message-Id: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce one property to present the battery internal resistance for battery
information.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - New patch in v2.
---
 .../devicetree/bindings/power/supply/battery.txt   |    2 ++
 drivers/power/supply/power_supply_core.c           |    3 +++
 include/linux/power_supply.h                       |    1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index f4d3b4a..25b9d2e 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -22,6 +22,7 @@ Optional Properties:
  - charge-term-current-microamp: current for charge termination phase
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
+ - internal-resistance-micro-ohms: battery internal resistance
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -42,6 +43,7 @@ Example:
 		charge-term-current-microamp = <128000>;
 		constant-charge-current-max-microamp = <900000>;
 		constant-charge-voltage-max-microvolt = <4200000>;
+		internal-resistance-micro-ohms = <250000>;
 	};
 
 	charger: charger@11 {
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index e853618..9f3452f 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -579,6 +579,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->charge_term_current_ua         = -EINVAL;
 	info->constant_charge_current_max_ua = -EINVAL;
 	info->constant_charge_voltage_max_uv = -EINVAL;
+	info->internal_resistance_uohm       = -EINVAL;
 
 	if (!psy->of_node) {
 		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
@@ -616,6 +617,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->constant_charge_current_max_ua);
 	of_property_read_u32(battery_np, "constant_charge_voltage_max_microvolt",
 			     &info->constant_charge_voltage_max_uv);
+	of_property_read_u32(battery_np, "internal-resistance-micro-ohms",
+			     &info->internal_resistance_uohm);
 
 	return 0;
 }
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index f807691..019452d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -326,6 +326,7 @@ struct power_supply_battery_info {
 	int charge_term_current_ua;	    /* microAmps */
 	int constant_charge_current_max_ua; /* microAmps */
 	int constant_charge_voltage_max_uv; /* microVolts */
+	int internal_resistance_uohm;       /* microOhms */
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
-- 
1.7.9.5

