Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1916ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7990F21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnHMeEeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7990F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeJSS7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:59:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40731 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJSS7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:59:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id n31-v6so15621956pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iqKD9byHso6OMx8L+zAYM7NHKckUL6NGilBoDBaqk1Y=;
        b=UnHMeEeq5DgBn1FBAnCUVHjVAQ3cCPpbV2op4fk/HIXIw0+1RzpNUfolS7d8PK5jN5
         IGH6HUMRsn34E4vn/bAfWLblkzE0bZ+9QJ4G36bIUpM6YFxNV65fAunw3AEIOCi7etb6
         1PEnP3GkQTvWwkc/inwzmM2p9P3M6LRCW7DtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iqKD9byHso6OMx8L+zAYM7NHKckUL6NGilBoDBaqk1Y=;
        b=LHphmTcIBBlpFHhQP3/Z8oEgneZ4lpuGYpkqTxvKXizcOvTGRaZRi0mhNJNUwuCW/L
         MF0KA/vVRyWAhDYe3+6M52OWCz/s8ZVk65Jjo0uFxELwOjCSsA8510y2n+EkUPn+FbFu
         qc2wslQ6ix4JNmFxcykSduA0UWLzmZBb04pD09pa7voULn9ITCk9mG5gsblIMWOndjr4
         BbJ9dNoF/P8HbSJDr4rzBqb2yTJ4z8XfM9F3ZTlzGPYwh/hB8/d/sUqWiYT2u0u97mKL
         90dbaBg/ERXqUJQj1ypw2UvEDFO60SzL+F+npj2IOR89eJK7HmBZEeZCQtjMHwbzf3aO
         du9g==
X-Gm-Message-State: ABuFfojC92Kp3Civfnx6FxmXO6lfJag5F4egYzXQBAgkLN6xPr43v62Z
        V6ZiYj9PccOxDfdlNAdH9iom/g==
X-Google-Smtp-Source: ACcGV62Am2lsPpsnG0Iu0GwhNgThjpQG3bRhAvEahZTp1lygHgBnIqGTWL0NbHmkHJ5NcJdLXBKTjw==
X-Received: by 2002:a63:1f05:: with SMTP id f5-v6mr1341281pgf.313.1539946416809;
        Fri, 19 Oct 2018 03:53:36 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m67-v6sm54918pfm.13.2018.10.19.03.53.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 03:53:35 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v5 2/6] power: supply: core: Add one field to present the battery internal resistance
Date:   Fri, 19 Oct 2018 18:53:11 +0800
Message-Id: <b70d55f008cfbbb79abf27018261d8a6f16e9673.1539915051.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one field for 'struct power_supply_battery_info' to present the battery
factory internal resistance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
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

