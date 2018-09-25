Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AECC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A4420877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZX5Iqq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A4420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeIYPLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:11:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40020 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIYPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:11:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8-v6so18834716wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FjybuiDBSw9NEcO9lVDeNrywfT+itTu22LbecoDEATI=;
        b=bZX5Iqq+b+ebjBjrTvEni6eoWVpbN44VEylr0iEpPtrISQsPBJ+t86e/AERKMVtKr6
         yNfuI/lHspqvFYZmN7WAOvBdg53P8O63wJXVxSGHKCBMArTB/hDeflvQ7F6tmQiIzQMu
         8qMgf3qWrKBcZoGHdlM48fT9x61DQ8wq9Xqq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FjybuiDBSw9NEcO9lVDeNrywfT+itTu22LbecoDEATI=;
        b=kTt701m0lOvhimGtl+o6GV1bQoDZBkgzK1tFLIqGLNqkovrMwLYzf9ABY7l1lEGTju
         mjo6fZtCQ/NlE6bsgTBHe/S8tpvDTvzmd2hT2GFfaa3YSD136IXndzn25XsyopcryxDO
         wyR+WSTzXxs7GhB5iHk0a+QDT6xpBtOyFMTMzsK22C8El5INeE0IFoa9qQY9fNNkXI+5
         AX7KZsl9Lw05SHvnWphJJPmvXmrfietLT/LTqMIJ+F6KINJRVKVo9gV4o+BSNgASdnbE
         00gljOoJLT4kmzaR2hZ5YzhQGYzKz/SOv3Z3BOxSHMWURQMBG6vsxuRfZkfmEfU1CiMf
         Z9aw==
X-Gm-Message-State: ABuFfoh/42IDzsoRk1wibjhBSTLzkAc7d7KpW987DT3405T9/qEkrteD
        xRDNxTkza7L0rZFsZL+G/w+WvA==
X-Google-Smtp-Source: ACcGV60c+zvgyXqfFi9kBVufYxmfYw6GVgvZbVU6AhOdKAbmf4fY/l0kJbHz3HlEDhZTke6Ba5mUtw==
X-Received: by 2002:adf:fdca:: with SMTP id i10-v6mr37238wrs.276.1537866284739;
        Tue, 25 Sep 2018 02:04:44 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:04:36 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/HISILICON SOC
        SUPPORT)
Subject: [PATCH 10/14] ARM64: dts: hisilicon: Add interrupt names for the tsensors
Date:   Tue, 25 Sep 2018 11:03:08 +0200
Message-Id: <1537866192-12320-11-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing interrupts for the temperature sensors as well as
their names.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt | 8 ++++++--
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi                       | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
index 3edfae3..4cb8add 100644
--- a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
@@ -29,7 +29,11 @@ for Hi3660:
 	tsensor: tsensor@fff30000 {
 		compatible = "hisilicon,hi3660-tsensor";
 		reg = <0x0 0xfff30000 0x0 0x1000>;
-		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tsensor_a73";
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tsensor_a73", "tsensor_a53",
+				  "tsensor_g3d", "tsensor_modem";
 		#thermal-sensor-cells = <1>;
 	};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index bf8a479..dd398cb 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1080,8 +1080,12 @@
 		tsensor: tsensor@fff30000 {
 			compatible = "hisilicon,hi3660-tsensor";
 			reg = <0x0 0xfff30000 0x0 0x1000>;
-			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "tsensor_a73";
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tsensor_a73", "tsensor_a53",
+			                  "tsensor_g3d", "tsensor_modem";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.7.4

