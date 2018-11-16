Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DD3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18CA208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1U75Cq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18CA208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389500AbeKPUQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:16:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36682 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeKPUQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:16:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so3226632pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jGnK7p9DNH1VSecCKTpjJESfpN6DrO/lgZIFx1WzcQ=;
        b=b1U75Cq6PiWwsh0z0qHVgT8KLwnvoLvx19itx4tR0J7yUo4r7wTyFJrjq1gAnh3+a/
         DflgwvN3jgsXHSjLZDgoryYD+QBV8BMllSbKnzhPJK5kO2SY3Qta71boyGvWMduiBi+S
         W0xdwbuvTG67CAHgbzPvoKWe3XXQUnYY4xs8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jGnK7p9DNH1VSecCKTpjJESfpN6DrO/lgZIFx1WzcQ=;
        b=VLmwVZjQVJJiLeyX7gp3csT0JlLFdbQzQ0J21fCP8YZCuFuuyBRWm1VcVrHm4oKoQG
         z2wg+qUlSLg6DHN+r8G9Qg3w8UVEk4yKrTl3aKZ5HdLSqWiKbEPOaR8zSNw5lJlRSb2L
         Hmjd059dhMG2BHhjQnBmffc75olD9wQgVHUHliiT1oKkCifeohSsDSmgeJ9OnQ7cT2r3
         q9+xoXuOoA1JqiD6SA4qBbTlHBhTUWFLmtDAOzGmFJex2mBGEnJC5eWf5H0pOK8a9sag
         UnFYRcs5QWmOhVIym4bnDQNAX/IagHtNOGkl/H0r0JFUpl0tvFfWhG+FYcznwc8DQk8S
         t9IA==
X-Gm-Message-State: AGRZ1gLGCnW9mLOM8NlnXgDSr3/MLOg75RWsMR2+T5NI5Aq30q9wwtXC
        TSQduk5LvBaUAvMG8GYgSgK2zQ==
X-Google-Smtp-Source: AJdET5eiv3nkhyQJtwSUP/6O1OgfLcn/0KROeaB2kUteVHDIeEdepgLTnigyMH524uMy4UFdhn/3yA==
X-Received: by 2002:a62:c501:: with SMTP id j1-v6mr5208284pfg.205.1542362691168;
        Fri, 16 Nov 2018 02:04:51 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id h7-v6sm51224721pfd.35.2018.11.16.02.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:04:50 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] ARM64: dts: amlogic: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:34:24 +0530
Message-Id: <2778d0d4813cc56be851719846afecbab5f2e657.1542362530.git.viresh.kumar@linaro.org>
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
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 22 ++++++++-----------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 313f88f8759e..cfc92d06a28f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -132,19 +132,15 @@
 
 				map1 {
 					trip = <&cpu_alert1>;
-					cooling-device = <&gpio_fan 2 THERMAL_NO_LIMIT>;
-				};
-
-				map2 {
-					trip = <&cpu_alert1>;
-					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-
-				map3 {
-					trip = <&cpu_alert1>;
-					cooling-device =
-						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&gpio_fan 2 THERMAL_NO_LIMIT>,
+							 <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a

