Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18562C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C959820892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fq+At354"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C959820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbeKPUNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:13:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44488 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389485AbeKPUNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:13:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id s5-v6so10923992plq.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LK6GiW769WFFMCSrW8bZq8d0PusJgT2ioSzhc2edhMA=;
        b=fq+At354HoAdN09twMtyS3uMc8QXc2XxXLgHQY9WkbhKgkRKwNemxOdQH3+SceMY+m
         SKk6RGwNyqjv49thLZgJfxIzTLX44RhhOfJ+SJqDtuiDCjrESb1MkUqMz+5EDSEwLDzM
         InKRhBL9rj1SrpStpMIXCel8q5B66PSAT13EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LK6GiW769WFFMCSrW8bZq8d0PusJgT2ioSzhc2edhMA=;
        b=EQ0mrfmud+IUcfbtb0s79BeCBj0zZiyoYzemo6yIKDqP5BqbqjheYggnGdwkdjBiVp
         BUBirabJM5FeQveE55jTaQGQoZBspcJn0CcFUkkZtSCxABhfPfqLBIiXtPtrZL8lj8f8
         3mDytwrzf0XA6Rq9RTbhbMHgSIO3wKkP57+NLfWEAaD3YEakclhHlFpvKo8f3t+otCE7
         D7bGQGtmd6GipRI9uWeJ6j63/VggJIXzHSg2QBIn3oz9MfTJPpsnCAKrdSj/ekzG1UFD
         GjdwU3jJyIOFHv/D0OnDCK1ypCRSIYUp67ogZVIDdAxcjaVcDh8lUB+ljh1aqU+pGPQZ
         b5Ag==
X-Gm-Message-State: AGRZ1gJqXUp+ItdF2dWidLkqk0lZEhNwmq5/HT5KtG6B+lNtGI2Ojx80
        NhjK3nRwLhRKAte96v89P5UXwQ==
X-Google-Smtp-Source: AJdET5cP3OiPVJ0GUIcBL5FuxbLvoThio2c0iqx0gdi1CHjEsGsz/vnFwS7sJ94vVR+Jg81RGev/lw==
X-Received: by 2002:a17:902:162:: with SMTP id 89-v6mr10100540plb.293.1542362499626;
        Fri, 16 Nov 2018 02:01:39 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id o84sm18959674pfi.172.2018.11.16.02.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:01:39 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ARM: dts: mt7623: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:31:12 +0530
Message-Id: <3c44454d70c9c9bafcf86f2c020d17d048f33360.1542362000.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1542362000.git.viresh.kumar@linaro.org>
References: <cover.1542362000.git.viresh.kumar@linaro.org>
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
 arch/arm/boot/dts/mt7623.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index d01bdee6f2f3..7cae886f79c9 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -187,17 +187,26 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu_passive>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 
 				map1 {
 					trip = <&cpu_active>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 
 				map2 {
 					trip = <&cpu_hot>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a

