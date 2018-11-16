Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE52C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643392145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+iqTvBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643392145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389594AbeKPUQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:16:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46752 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389436AbeKPUQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:16:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id s9-v6so11160665pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnCIsEGq5MZTTZCkNy8l3CMIA4bwOFY/LPw8vXjcyjo=;
        b=T+iqTvBvTwFjGud//iZpTeH9leHdAkXHiolZPRv3m8YPKwjf2NcPiFwBMBs7pPsl7i
         R5glNd1K+psMyhUEK1DQEqo7NLCNyyuPWywmWuqlnBOqjjuysRuc+lDVK/lwYT+9t6dK
         KFeF0TCLS7C54iI2qZj7AIdlKNDijQ52Ooaf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnCIsEGq5MZTTZCkNy8l3CMIA4bwOFY/LPw8vXjcyjo=;
        b=pAErhGJzE7hLSqFo4SFhcwyJt6vhIEmaxorgmSXmiEXDC53m/PsVS0uTbXkym6lI5K
         PRONPkCPWZ1J/yaG8WdrjyLTtlj2LJnQLnFOjLyPw5ViIO/xlYij32YrcgtC7mdANeiG
         rTlY6Y8ooH6GHWKFHuZNHv0I2Belpky1o2ykRMZCfBllbG+hXkP7yyu4BK3CDzjzm33V
         WQZvJRindDi4JE+mf46cdmsg1RWsob727lBkenXZLKLsoHlrPHUQgVpbMBWC1E/34FHt
         GXqFxx2lN/K3SGiBwoLx/OMpTO79MwOdAPhtRfoz/xSHIMpqEIlTxJrMml3vph/e4igF
         ZJtg==
X-Gm-Message-State: AGRZ1gIQ6qwqHFHvFkvPqG/5IZxDq95Rxpy7K9atPRXBuNqMrjv/2MXV
        yxmoJVB6gKSLFEoKt4vW2RBkUQ==
X-Google-Smtp-Source: AJdET5fag+/4M4Kh2zoKCTv3gSeGIG7dumpyvhJU29YRSRveHS/q5GVSeYkuhb45R2PZnJAZr4G4Yw==
X-Received: by 2002:a63:314c:: with SMTP id x73mr9435566pgx.323.1542362714354;
        Fri, 16 Nov 2018 02:05:14 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id u76-v6sm41233381pfa.176.2018.11.16.02.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:05:13 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] ARM64: dts: mediatek: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:34:29 +0530
Message-Id: <3c7c9155ac01a2d745ba5e4434c958820200d088.1542362530.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each CPU can (and does) participate in cooling down the system but the
DT only captures a handful of them, normally CPU0, in the cooling maps.
Things work by chance currently as under normal circumstances its the
first CPU of each cluster which is used by the operating systems to
probe the cooling devices. But as soon as this CPU ordering changes and
any other CPU is used to bring up the cooling device, we will start
seeing failures.

Also the DT is rather incomplete when we list only one CPU in the
cooling maps, as the hardware doesn't have any such limitations.

Update cooling maps to include all devices affected by individual trip
points.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 9 ++++++---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index fe0c875f1d95..53e707df98d9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -170,17 +170,20 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu_passive>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 
 				map1 {
 					trip = <&cpu_active>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 
 				map2 {
 					trip = <&cpu_hot>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index abd2f15a544b..e578f7d18038 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -275,12 +275,14 @@
 			cooling-maps {
 				map@0 {
 					trip = <&target>;
-					cooling-device = <&cpu0 0 0>;
+					cooling-device = <&cpu0 0 0>,
+							 <&cpu1 0 0>;
 					contribution = <3072>;
 				};
 				map@1 {
 					trip = <&target>;
-					cooling-device = <&cpu2 0 0>;
+					cooling-device = <&cpu2 0 0>,
+							 <&cpu3 0 0>;
 					contribution = <1024>;
 				};
 			};
-- 
2.19.1.568.g152ad8e3369a

