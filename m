Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3CFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13F920892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgww5nzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13F920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389526AbeKPUQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:16:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41392 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeKPUQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:16:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so57998plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJ2Y9BTKWZeThRTPqw9iFrF+TUyLNKnmOqI9tUW0Q7o=;
        b=hgww5nzdpOv5drIV5f/VTRQQbmLzNZ42o9EZrxtK2aBGiTp7aDszcflfrQ2NbuA8HG
         qFZydP1nEg7ZXwPLSLpCsBt0e+pT8A36sKcHw/+PghrrI85hpzt4DZ+sI6lOWREXpMii
         o6ZnWGXimOUqXJf2kmQdgW0rgh5KcTXiMRpl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJ2Y9BTKWZeThRTPqw9iFrF+TUyLNKnmOqI9tUW0Q7o=;
        b=OeHJJXglqql24fdQTjd0uMJ3y0YGlcQlSA1HiIRnvacvpkUpTHQoQv5CnFTzwGivrc
         QJ8a34TSamMxTRmEvD1hC9DCkD9loBBMgPaBwjjb/31cQB7XRdW8qEVQu7BbF+pvSGmX
         9x30QZ4sRJLiOXirpM2ZhCPTIQw8nHMgsDq0LHU1lPNlJi43GgT9Gz8id+4G2j2lr2vK
         ElkCn/To9s840YP2V+5JkUPMWZVXrLYDjRQVcQOcu2s+FM8p0rjoLVy8CaWPVGFmB2ss
         SMv0vEHU2AzXIMdyi7id0TnTWQM4J4vSyDLLdl9KbDaROss2lxJyPy6VBPRiwA9D/PUf
         IL8g==
X-Gm-Message-State: AGRZ1gJ9FICIcbhPFd599NhXO+gvTcxo28NbAkDyUJgIjOjR7JiPVODN
        zjFwJZx8PKPAsDtOfBGjnpBRbPdtuuQ=
X-Google-Smtp-Source: AJdET5fL6OQJKJK0wmhEbl7lT9wsvedSDRZEI4E9Rl5pNHw4TWVRcqikk1hmYVqe0yu59lGvxg23vQ==
X-Received: by 2002:a17:902:6a3:: with SMTP id 32-v6mr10371947plh.337.1542362695231;
        Fri, 16 Nov 2018 02:04:55 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id h7sm25746283pfa.105.2018.11.16.02.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:04:54 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] ARM64: dts: exynos: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:34:25 +0530
Message-Id: <74e23257aece9ceef48b1c1cf6c9bafcce3c6fbd.1542362530.git.viresh.kumar@linaro.org>
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
 .../arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
index fe3a0b14bee6..81b72393dd0d 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
@@ -55,37 +55,44 @@ thermal-zones {
 			map0 {
 				/* Set maximum frequency as 1800MHz  */
 				trip = <&atlas0_alert_0>;
-				cooling-device = <&cpu4 1 2>;
+				cooling-device = <&cpu4 1 2>, <&cpu5 1 2>,
+						 <&cpu6 1 2>, <&cpu7 1 2>;
 			};
 			map1 {
 				/* Set maximum frequency as 1700MHz  */
 				trip = <&atlas0_alert_1>;
-				cooling-device = <&cpu4 2 3>;
+				cooling-device = <&cpu4 2 3>, <&cpu5 2 3>,
+						 <&cpu6 2 3>, <&cpu7 2 3>;
 			};
 			map2 {
 				/* Set maximum frequency as 1600MHz  */
 				trip = <&atlas0_alert_2>;
-				cooling-device = <&cpu4 3 4>;
+				cooling-device = <&cpu4 3 4>, <&cpu5 3 4>,
+						 <&cpu6 3 4>, <&cpu7 3 4>;
 			};
 			map3 {
 				/* Set maximum frequency as 1500MHz  */
 				trip = <&atlas0_alert_3>;
-				cooling-device = <&cpu4 4 5>;
+				cooling-device = <&cpu4 4 5>, <&cpu5 4 5>,
+						 <&cpu6 4 5>, <&cpu7 4 5>;
 			};
 			map4 {
 				/* Set maximum frequency as 1400MHz  */
 				trip = <&atlas0_alert_4>;
-				cooling-device = <&cpu4 5 7>;
+				cooling-device = <&cpu4 5 7>, <&cpu5 5 7>,
+						 <&cpu6 5 7>, <&cpu7 5 7>;
 			};
 			map5 {
 				/* Set maximum frequencyas 1200MHz  */
 				trip = <&atlas0_alert_5>;
-				cooling-device = <&cpu4 7 9>;
+				cooling-device = <&cpu4 7 9>, <&cpu5 7 9>,
+						 <&cpu6 7 9>, <&cpu7 7 9>;
 			};
 			map6 {
 				/* Set maximum frequency as 1000MHz  */
 				trip = <&atlas0_alert_6>;
-				cooling-device = <&cpu4 9 14>;
+				cooling-device = <&cpu4 9 14>, <&cpu5 9 14>,
+						 <&cpu6 9 14>, <&cpu7 9 14>;
 			};
 		};
 	};
@@ -222,27 +229,32 @@ thermal-zones {
 			map0 {
 				/* Set maximum frequency as 1200MHz  */
 				trip = <&apollo_alert_2>;
-				cooling-device = <&cpu0 1 2>;
+				cooling-device = <&cpu0 1 2>, <&cpu1 1 2>,
+						 <&cpu2 1 2>, <&cpu3 1 2>;
 			};
 			map1 {
 				/* Set maximum frequency as 1100MHz  */
 				trip = <&apollo_alert_3>;
-				cooling-device = <&cpu0 2 3>;
+				cooling-device = <&cpu0 2 3>, <&cpu1 2 3>,
+						 <&cpu2 2 3>, <&cpu3 2 3>;
 			};
 			map2 {
 				/* Set maximum frequency as 1000MHz  */
 				trip = <&apollo_alert_4>;
-				cooling-device = <&cpu0 3 4>;
+				cooling-device = <&cpu0 3 4>, <&cpu1 3 4>,
+						 <&cpu2 3 4>, <&cpu3 3 4>;
 			};
 			map3 {
 				/* Set maximum frequency as 900MHz  */
 				trip = <&apollo_alert_5>;
-				cooling-device = <&cpu0 4 5>;
+				cooling-device = <&cpu0 4 5>, <&cpu1 4 5>,
+						 <&cpu2 4 5>, <&cpu3 4 5>;
 			};
 			map4 {
 				/* Set maximum frequency as 800MHz  */
 				trip = <&apollo_alert_6>;
-				cooling-device = <&cpu0 5 9>;
+				cooling-device = <&cpu0 5 9>, <&cpu1 5 9>,
+						 <&cpu2 5 9>, <&cpu3 5 9>;
 			};
 		};
 	};
-- 
2.19.1.568.g152ad8e3369a

