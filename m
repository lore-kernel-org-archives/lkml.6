Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62331C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230BA20658
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230BA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeH1Fob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:31 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40602 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeH1Foa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:30 -0400
Received: by mail-oi0-f66.google.com with SMTP id l202-v6so8887oig.7;
        Mon, 27 Aug 2018 18:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xzl/jEllKBAoAthtNOD/Uqw64599aiwGpdVG/EB0yBc=;
        b=LJe1oASV1cas8bBZqRenJrwgfk36kSSw16EPFxHRLwRQCWNkSj+js9djF0zweGrAJQ
         z6ExwonCELtkuJ1RsYpe0G7u4ZMMiKLxqyFU8ZayiADTrORy4Iqc8zSYknF4wtpJ/H4C
         jPEgwGV8h3W5u70Gfuwu8dMz5cAMF86SCmh1EiP+AHjerrz1U9GjZdCSLUxRbA4inSMl
         XmcXlkPWNO5fOnkAURC1kK+6kZb2tCaiFKRSc5SkNM0nPMdbTFHZCC1D7My5fcBRLR47
         Wo8YsyFQsC8K5MbdGht6JK3xtBKn1vdom8YZJS6MqrXPHP07jlwJHcY3CpIwT0zHlEjz
         vHOQ==
X-Gm-Message-State: APzg51CodA1csc8JkvOnQ3uIe4XoaGG31408zXKnfBbZW+IXZ8kf1VzJ
        xHA+hyGcfz0UZgrbcivjX2Eujzg=
X-Google-Smtp-Source: ANB0VdYJ1BEpiaQNpoofwzS6frzISe9/e9J1u5+sfDB0nA7oOQ4QxUYQAoomnhepb6WuVu9Thp69xQ==
X-Received: by 2002:aca:ef87:: with SMTP id n129-v6mr1137519oih.161.1535421313947;
        Mon, 27 Aug 2018 18:55:13 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:13 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] thermal: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:46 -0500
Message-Id: <20180828015252.28511-45-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/thermal/of-thermal.c    | 10 +++++-----
 drivers/thermal/qoriq_thermal.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 977a8307fbb1..e201ae1c382f 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -483,8 +483,8 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 		if (sensor_specs.args_count >= 1) {
 			id = sensor_specs.args[0];
 			WARN(sensor_specs.args_count > 1,
-			     "%s: too many cells in sensor specifier %d\n",
-			     sensor_specs.np->name, sensor_specs.args_count);
+			     "%pOFn: too many cells in sensor specifier %d\n",
+			     sensor_specs.np, sensor_specs.args_count);
 		} else {
 			id = 0;
 		}
@@ -960,8 +960,8 @@ int __init of_parse_thermal_zones(void)
 
 		tz = thermal_of_build_thermal_zone(child);
 		if (IS_ERR(tz)) {
-			pr_err("failed to build thermal zone %s: %ld\n",
-			       child->name,
+			pr_err("failed to build thermal zone %pOFn: %ld\n",
+			       child,
 			       PTR_ERR(tz));
 			continue;
 		}
@@ -995,7 +995,7 @@ int __init of_parse_thermal_zones(void)
 						    tz->passive_delay,
 						    tz->polling_delay);
 		if (IS_ERR(zone)) {
-			pr_err("Failed to build %s zone %ld\n", child->name,
+			pr_err("Failed to build %pOFn zone %ld\n", child,
 			       PTR_ERR(zone));
 			kfree(tzp);
 			kfree(ops);
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c866cc165960..1fa132fc316b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -129,8 +129,8 @@ static int qoriq_tmu_get_sensor_id(void)
 	if (sensor_specs.args_count >= 1) {
 		id = sensor_specs.args[0];
 		WARN(sensor_specs.args_count > 1,
-				"%s: too many cells in sensor specifier %d\n",
-				sensor_specs.np->name, sensor_specs.args_count);
+				"%pOFn: too many cells in sensor specifier %d\n",
+				sensor_specs.np, sensor_specs.args_count);
 	} else {
 		id = 0;
 	}
-- 
2.17.1

