Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172BAECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC02E21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fx3pQzb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC02E21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeJQRNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:13:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34578 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJQRNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:13:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id z25-v6so1019477wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gtO5omnR5DvfsMQEV+qrCgDc9JtgzpU/WP6fSSftpWs=;
        b=fx3pQzb7C/Y3ml/4o3vKT2ohmdcsHQTEsOzZkA3pKIiJdSaLHWe135bt45leh8Dll1
         rwM4JNDQpKwKABPGwWu0IcAE9E8k7/4V5pD0AnoohfZnbjnLvJoNwmLx62HXqezDIK8C
         U5ZlmPlPc8cj3e7LR9P2nA8mNwyiORXdIx8oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gtO5omnR5DvfsMQEV+qrCgDc9JtgzpU/WP6fSSftpWs=;
        b=No4Bjs3YVL2LVjdXjmewIW/sqSW5sqfZTmciwQQ3aa//wSoZr8TjEvcftSLcNmXNgH
         cSl/mmwE4DVaMxmA73aGsNBvmQLCrrjHFwRMqqo2Z0xqubm8gHZKrNPnxuKDiIGV+PzC
         O8kJlBHBzlQOf4+MsyemNvZXrqZc851iUgLeADp+1FrhFaDRHLQaBBMMtMXbNDa6/8tL
         w/0Ig/cudFlAW2GrSpzUfgQRh5U4dS97nZFzr19f6Wq5jGdxxlzEFiEdB3JDjwXR0fW7
         sa54biSt9yfd+iYxE0O+jLriZ4HJ+rJc1ePxspAnwSjFIWXNPF+HgYPEjUerIorFW4xa
         yXPg==
X-Gm-Message-State: ABuFfogTv8rmgF9/Z+OvrKw/C3uVG/t7ERYSfk5XIR7WbeAD1ABmjMia
        rkWf7BacSMrEN2lusz0xtieqoA==
X-Google-Smtp-Source: ACcGV60XgibpgquriQ8CcrhbTlIZZwciaziCcARXhPtWSPJGHNa0oFSUMiksyN9b1N2VOUNstKuvTQ==
X-Received: by 2002:a1c:34d2:: with SMTP id b201-v6mr1903808wma.115.1539767934167;
        Wed, 17 Oct 2018 02:18:54 -0700 (PDT)
Received: from localhost.localdomain (212.156.88.92.rev.sfr.net. [92.88.156.212])
        by smtp.gmail.com with ESMTPSA id 18-v6sm1094723wmw.26.2018.10.17.02.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 02:18:53 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     heiko@sntech.de
Cc:     linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH V2] DT: rockchip: Fix stability issues with the 'performance' governor on rock960
Date:   Wed, 17 Oct 2018 11:18:30 +0200
Message-Id: <1539767918-26587-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the performance governor is set as default, the rock960 hangs
around one minute after booting, whatever the activity is (idle, key
pressed, loaded, ...).

Based on the commit log found at https://patchwork.kernel.org/patch/10092377/

"vdd_log has no consumer and therefore will not be set to a specific
voltage. Still the PWM output pin gets configured and thence the vdd_log
output voltage will changed from it's default. Depending on the idle
state of the PWM this will slightly over or undervoltage the logic supply
of the RK3399 and cause instability with GbE (undervoltage) and PCIe
(overvoltage). Since the default value set by a voltage divider is the
correct supply voltage and we don't need to change it during runtime we
remove the rail from the devicetree completely so the PWM pin will not
be configured."

After removing the vdd-log from the rock960's specific DT, the board
does no longer hang and shows a stable behavior.

Apply the same change for the rock960 by removing the vdd-log from the
DT.

Fixes: 874846f1fccd ("arm64: dts: rockchip: add 96boards RK3399 Ficus board")
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changelog
  - V2
     * Added Tested and Fixes tags
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 6c8c4ab..56abbb0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -57,18 +57,6 @@
 		regulator-always-on;
 		vin-supply = <&vcc_sys>;
 	};
-
-	vdd_log: vdd-log {
-		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 0>;
-		regulator-name = "vdd_log";
-		regulator-min-microvolt = <800000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
 };
 
 &cpu_l0 {
-- 
2.7.4

