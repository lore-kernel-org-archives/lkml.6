Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3E2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DC520C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3cGzg/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DC520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeIYPLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:11:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43703 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbeIYPLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:11:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id z14-v6so4966791wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UxB+GfDnTMjmOE1hd6mzvwMVcjkzKsZWm7O8IKgj40I=;
        b=e3cGzg/5ZKmcHoe7SSPCL70kclr+7cbEHw/gHo/lBo4C03IhBJkg5X2aC0Mdt0+6LL
         fH20z4P33tGqwCx6Wi9oEnfmaBZyFlFxToUm1b/kL4DtGH9Y0/+fDAKuwymHCt77vfkh
         +M5YnvdqKhs58yE5vtzmv3U/2bqAHBgZTUQUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UxB+GfDnTMjmOE1hd6mzvwMVcjkzKsZWm7O8IKgj40I=;
        b=nLb4xVeE8xYytRI0QP7ZvHmtCqc1yFb2vOPd3uaTcE3NBOC2MU2AS0sLadorWNLSIi
         +5m1QSXOQBzx6MWREiAlkvOzfFytqun7N49tCeIq5I8HmfFMqBWSBzMuBwVecMfxO1Yq
         Hjsr72AEFnFEKypfqUD+/4kC8p5SAV68cjeuaMVHYpZsamANEkcUoTds5I3xZOg3hCo1
         xlW7IdY/63xuhVs+4ZKZlFUsBWmeMIl9T9VlEY5peB6WPnITfMGjgPOtAMV72vH49Uy2
         flQ8i6ydfh6XGODUlOBX89chb1y0wtDkeenk5nAHaS6zFCiLZXltsPRmbZyuZCzqqW/4
         dXmA==
X-Gm-Message-State: ABuFfohx6vXNDMRbdSlSg9J+g21fB32ONH2YOEPCSzEjqL3Bk3+sQKls
        5eQVcff8pK62oXT8o7MyLBEdJQ==
X-Google-Smtp-Source: ACcGV62FS5T/3AUdXnrZKKhjtO9deCg0kBIywTFXZk8+z9UA6Oa3JWEvifWf3kQAtO/3YbZIBaKZ9Q==
X-Received: by 2002:adf:a925:: with SMTP id u34-v6mr16176wrc.175.1537866298105;
        Tue, 25 Sep 2018 02:04:58 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:04:57 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/HISILICON SOC
        SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 13/14] ARM64: dts: hisilicon: Add dual clusters thermal zones for hi3660
Date:   Tue, 25 Sep 2018 11:03:11 +0200
Message-Id: <1537866192-12320-14-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a thermal zone for the little cluster, so we can handle two
sensors managing each a cluster on the SoC.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 97 ++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index dd398cb..6df7d9f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1090,42 +1090,71 @@
 		};
 
                 thermal-zones {
+			tz_a53: tz_a53 {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				sustainable-power = <4500>;
+
+				/* sensor ID */
+				thermal-sensors = <&tsensor 0>;
+
+				trips {
+					a53_temp_threshold: trip-point@0 {
+						temperature = <65000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+
+					a53_temp_target: trip-point@1 {
+						temperature = <75000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+				};
 
-                        cls0: cls0 {
-                                polling-delay = <1000>;
-                                polling-delay-passive = <100>;
-                                sustainable-power = <4500>;
-
-                                /* sensor ID */
-                                thermal-sensors = <&tsensor 1>;
-
-                                trips {
-                                        threshold: trip-point@0 {
-                                                temperature = <65000>;
-                                                hysteresis = <1000>;
-                                                type = "passive";
-                                        };
-
-                                        target: trip-point@1 {
-                                                temperature = <75000>;
-                                                hysteresis = <1000>;
-                                                type = "passive";
-                                        };
-                                };
-
-                                cooling-maps {
+				cooling-maps {
 					map0 {
-                                                trip = <&target>;
-                                                contribution = <1024>;
-                                                cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-                                        };
-					map1 {
-                                                trip = <&target>;
-                                                contribution = <512>;
-                                                cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-                                        };
-                                };
-                        };
+						trip = <&a53_temp_target>;
+						contribution = <512>;
+						cooling-device = <&cpu0
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+
+			tz_a73: tz_a73 {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				sustainable-power = <4500>;
+
+				/* sensor ID */
+				thermal-sensors = <&tsensor 1>;
+
+				trips {
+					a73_temp_threshold: trip-point@0 {
+						temperature = <65000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+
+					a73_temp_target: trip-point@1 {
+						temperature = <75000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&a73_temp_target>;
+						contribution = <1024>;
+						cooling-device = <&cpu4
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+					};
+				};
+			};
                 };
 	};
 };
-- 
2.7.4

