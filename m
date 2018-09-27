Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC54C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111E720838
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBXWaozF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111E720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeI0Nol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:44:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45004 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeI0Nok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:44:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so1246827pgu.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 00:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4VmbNGK4/Krdl0b5VErXgThoZu7vAXm7F8ofWNw+h+Y=;
        b=GBXWaozFl12GA1q1cUTlGwVVR+P0Bb8rD8e8VxrtYN36gA3qiFLOgYiO/JVNs2yMPI
         riJ4mt5JHP2UxRFqFGo2rJSzUkvbsTO3aL0VTLwbm1NPFGoWANNv6aVH+bvGFtwhtcDp
         nUVEh8RdqvoBYUYA/KEC7suEcSxCJdyevAYnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4VmbNGK4/Krdl0b5VErXgThoZu7vAXm7F8ofWNw+h+Y=;
        b=KrD1x8JIvv70SR5X7GZsiJENV33Z0M0X6D9HbHL8TA0WBzZxyArehlZxTOHuHozTZO
         yhzoceBkHIISBKxM3/01eRSPm2CNa0PHoaKKnX8x2esQcRp6aMm5/Mo1Fw9wTqFu9wKw
         YLDbVV0aaVZecCeUI/OUhvfGahutAdBdV0f5yurE3vCQ238vZmuWTwbqtVzupmgJ2GlU
         XsY3jz9qyV+T6dgwig6xDFiI2fmmxfGpfFCif4PmybpImpVomVdh/yxhze8xv0y/8zNn
         JoCkpnz5ofLGkJLYIK+KH6umBvxyQbIj9JiPiE48PgccigKPmpaWDvj1xZZDG0Wn0JA9
         A99w==
X-Gm-Message-State: ABuFfoir6p1qXnpVJuoXXyCstvuBEhSj6Tnpaj3X5D1RjPgnCPx2MdS+
        GxRaAeeP3RGI11dF7/5h7KCwYg==
X-Google-Smtp-Source: ACcGV61KPgGBcSimqyzqYx3UME18t3abL3+TYfTnpzG4XbIvrBikZN5jy+XuanYgEs2RRDWc4WrLaw==
X-Received: by 2002:a62:7788:: with SMTP id s130-v6mr9859304pfc.189.1538033269467;
        Thu, 27 Sep 2018 00:27:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h12-v6sm1835018pfo.135.2018.09.27.00.27.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 00:27:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v3 1/4] power: supply: core: Introduce one property to present the battery internal resistance
Date:   Thu, 27 Sep 2018 15:26:54 +0800
Message-Id: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal resistance of a battery is not a constant in its life cycle,
this varies over the age of the battery or temperature and so on. But we
just want use one constant battery internal resistance to estimate the
battery capacity. Thus this patch introduces one property to present
the battery factory internal resistance for battery information.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v2:
 - Rename the property.
 - Improve the commit message.

Changes from v1:
 - New patch in v2.
---
 .../devicetree/bindings/power/supply/battery.txt   |    2 ++
 drivers/power/supply/power_supply_core.c           |    3 +++
 include/linux/power_supply.h                       |    1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index f4d3b4a..938d027 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -22,6 +22,7 @@ Optional Properties:
  - charge-term-current-microamp: current for charge termination phase
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
+ - factory-internal-resistance-micro-ohms: battery factory internal resistance
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -42,6 +43,7 @@ Example:
 		charge-term-current-microamp = <128000>;
 		constant-charge-current-max-microamp = <900000>;
 		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <250000>;
 	};
 
 	charger: charger@11 {
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

