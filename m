Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82207ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A0C20779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ER3ytPTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A0C20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeJVQBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:01:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45347 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeJVQBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:01:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id o19-v6so2891959pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=guur6UyotJRvkPcD8qm7dKJt581cqentxqfsCagosRE=;
        b=ER3ytPTWaZVWB6HqyvTwfVfqbgoKAzRbeWzpCxKitcikd8Cdvar6URv9XWUmN5zExI
         B7jTB6oTwFC76x6teGcjynI5RnntVwpGqOUP58SNiISEk6KbJwduBSoUznAGC8lnv4SC
         SKjvsQMKxELkX543I1hDl3bJI8eFzqPsd6+kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=guur6UyotJRvkPcD8qm7dKJt581cqentxqfsCagosRE=;
        b=bg414t2AKKsHTD4I5lFpTxk2t1VIRVeyZHWBSU5yIC0q9J/Zyms239LWi0n1BkUuFi
         2t86uq0+yj8m9FCh3tNsv4C8yPfDuO4M/nKCOK9ueBwo6VzphVNxrr6yCuQiUX+bkN9x
         GLdon/JIFaGce7yJkByzAeTEiYD1pnJOC+kFwJARJNKvWtWlJpjeLgrFGWKPwQZLSmlv
         ZslcU39e9f5ZkgeyK87S9XDMyAMKRi7k+tJPkCqFIw58NjOBwnSxLD91/k8Comdsu1No
         X+WDi6dlhQpGNJJqXb+OHX4fL2Mws+9WQHfzWCFj6LFTzqh3WAPKnsWvwKAcx9mvTCt1
         XrmA==
X-Gm-Message-State: ABuFfogFhKWf5iLavhgKHkMFvrITeaWs3km8QAeAWA0qul+2+DaNo+Ds
        1RD1d17WANyShxeKDzprft2UqA==
X-Google-Smtp-Source: ACcGV627Y6MGGRsCccR+rETD9O6x//KbjL1FXORsQS6zS1+pQ08uhK08mSu/rrwui1QDTScGxkl41w==
X-Received: by 2002:a17:902:d01:: with SMTP id 1-v6mr44237644plu.88.1540194272040;
        Mon, 22 Oct 2018 00:44:32 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d186-v6sm43704253pfg.173.2018.10.22.00.44.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 00:44:31 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v6 2/6] power: supply: core: Add one field to present the battery internal resistance
Date:   Mon, 22 Oct 2018 15:43:58 +0800
Message-Id: <b70d55f008cfbbb79abf27018261d8a6f16e9673.1540189330.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one field for 'struct power_supply_battery_info' to present the battery
factory internal resistance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
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

