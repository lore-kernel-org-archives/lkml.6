Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0FEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BE521522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okGL05ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BE521522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389933AbeIURWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:22:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34120 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389708AbeIURV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:21:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id j25-v6so3962402wmc.1;
        Fri, 21 Sep 2018 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Rwfhn7cN/qx//wJgbq96vWyhsg0cmvYywmwUb3M8DOI=;
        b=okGL05gekctPsZoofUFLp7/LKbjAZuNxhPLt/+ciZl7zVrnXv2ixQfeDFK5Om0s/WO
         7fRHcvB/DpwvsV82agIUuIErAR0u4EqFMThKIffAp/wNV+wrVlKUvTmZaflmRVNyv/qR
         pJsV1tykkbOm0ryMRDvQyYqmDjU9kSirrgMOO20X9NlyIPE81lJwUrGtbfYkOsIb3aF8
         /77ujeLiD/cQqKsH9UMb72vMs/9wpCUjnaie3fDRBm+acF6UWRr59fVr9uLCABc8G6Vs
         TQNKQEYKXzNhPYLXyJ+uAKuuMNo1wtubQMmQ9O7XE7w9ZvsvvcWI0ZU6lT5kEr/Cpf8K
         cQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Rwfhn7cN/qx//wJgbq96vWyhsg0cmvYywmwUb3M8DOI=;
        b=s8N5I9J+I9qEde8WRERpoGlVX12d2+QSL9FWrG0GkPVHj/zRle5J08SiuZe4sUfmaB
         FWiLBWtEcklgbhM4qMGk9KYY3Whyz5N0VB/Y+IoeT6UkX0xgUpxBgLRQxAgA1cH8ouqL
         0ufsmHMZebH/uQJAIiGhXlBInVM/MDDhp3Qm8lG8lXz7ZQ7m2UCrpEnpQ+O8CcmKrKub
         GwstE8DsqExQoLjtUdF+Zc9g6szbLK/FSJq5BwKHqm34zDc0+0OS0JSrgOavWClnXllb
         Rwp7FOBJOV8H201XnLWDfjpepozBxTHSYH8Hg08YmaFVFYYk3kacjHcl8HoEqLUDv/u9
         F/jA==
X-Gm-Message-State: APzg51CsPANlOa3Dhv7ky5wqlPC/HLT/aEVemGUpACwR6hfM4Hi31T3g
        ZeC5ntZeCYY6G8vFsAgou/0=
X-Google-Smtp-Source: ANB0Vda4XCjShMTg/d25lxWydirM8bWXQRveC9M+Yt0zkgoH3iwW/PfX3NxyxCm8k83abdTt66b9ZA==
X-Received: by 2002:a1c:dd05:: with SMTP id u5-v6mr3012704wmg.107.1537529610735;
        Fri, 21 Sep 2018 04:33:30 -0700 (PDT)
Received: from inc028000032.lancs.ac.uk (inc028000032.lancs.ac.uk. [148.88.228.92])
        by smtp.gmail.com with ESMTPSA id e7-v6sm6052593wrs.25.2018.09.21.04.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 04:33:30 -0700 (PDT)
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
X-Google-Original-From: Willy Wolff <willy.mh.wolff@gmail.com>
Date:   Fri, 21 Sep 2018 12:33:29 +0100
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: ordering wrong order tmu_cpu on
 Odroid-XU3/4 thermal-zones definition
Message-ID: <20180921113329.tha5tfrsvdf7dtws@inc028000032.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to open a discussion about wrong order of tmu_cpu.

It seems that tmu_cpu1 correspond to cpu3, and tmu_cpu3 match cpu1.
Note, cpu{0|3} in dtsi correspond to cpu{3|7} in linux and are the big
cores.

By dependencis from exynos5422-odroidxu3-common.dtsi to
exynos5800.dtsi -> exynos5420.dtsi, I guess definitions of tmu_cpuX are
incorrect. However, changing the address, reg interrupts or clocks
would breack other boards depending on it. As I can't test other boards,
I've just overload the reference in the thermal-zones node.

To reproduce the problem, I provide two scripts:
== script_stress:

for i in 0 10 20 40 80; do
    echo $i
    taskset $i stress -t 10 -c 1
done;

== script_read_temp:

while true; do
    for i in 0 1 2 3 4; do
	echo $i
	cat /sys/devices/virtual/thermal/thermal_zone$i/temp
    done;
    sleep 1
    clear
done;

Signed-off-by: Willy Wolff <willy.mh.wolff@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 96e281c0a118..4512ffad2785 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -135,7 +135,8 @@
 			};
 		};
 		cpu1_thermal: cpu1-thermal {
-			thermal-sensors = <&tmu_cpu1 0>;
+			// thermal-sensors = <&tmu_cpu1 0>;
+			thermal-sensors = <&tmu_cpu3 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -269,7 +270,8 @@
 			};
 		};
 		cpu3_thermal: cpu3-thermal {
-			thermal-sensors = <&tmu_cpu3 0>;
+			// thermal-sensors = <&tmu_cpu3 0>;
+			thermal-sensors = <&tmu_cpu1 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
-- 
2.11.0

