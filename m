Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D06EECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F34205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPM4VirE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F34205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbeGRHUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:20:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39459 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbeGRHUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:20:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so3422817wre.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 23:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AQma1INj9PDjYURj+rLLqne78i7V0ruv9qs3xa+leU0=;
        b=dPM4VirE34Z7s4dwJRj6na8ombwtmojaSITUtP+xGLiG5SNgYZCLlzxjRhmZX6ZhlX
         aGsgbCBzQw5ds2xPHDlOuouUGAQrTgqU+ZHrABjcYVM8aYXjy0dWLY5VLk99oQS5JB/F
         ifGkQS+LB7YGbEsgF6Q1CfbhGJDJifwUVgBkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AQma1INj9PDjYURj+rLLqne78i7V0ruv9qs3xa+leU0=;
        b=S/fdyw8Ni/Gqj0am1WZh5bTJFQGUT1dU8V4wSj6TfUf9yTFIzV+STpZOB4p0lMYeW5
         G6qD5mmGdbZ2pq8FFyyAaMBKq+0MxlJifzsU+YllzUIJ3RHo0Aks0wTMcn7P8tsdTGWz
         R1VUx8m2fcwPGBWO2kIMWxcpFij/U7KN1E7Z6dvCEUQwXhgk5RAriQWC1mlP8MUMfFZR
         Wp4y0hWi7mG//Kf1H38zs+3u0T/YtM+LBXjv8Qlnwgc5LG6vH5mtnIziFB4R03fMb4Y8
         4ZO8TNCw+8DnVVB4Ou/7jUS4kqW11pvtAy5xYcvrnuQ7a5375YyMYWPIzfOMVPYfxuap
         sz6A==
X-Gm-Message-State: AOUpUlFbSgO/klffF5/e2y4alrJnjC12EAtEZX2uP85m2J51rde36oKf
        jPYgJovc2t/JfyVSFqEEz3t2EHj67jc=
X-Google-Smtp-Source: AAOMgpdVlKwm6n8h3N82iM8fucQp7F5x93YX7qbjwqMvtP0kxARDLIDcfnNex9q4BFrdPmO9eqS51Q==
X-Received: by 2002:adf:8b01:: with SMTP id n1-v6mr3500964wra.282.1531896229031;
        Tue, 17 Jul 2018 23:43:49 -0700 (PDT)
Received: from localhost ([103.249.91.115])
        by smtp.gmail.com with ESMTPSA id y102-v6sm2544665wmh.9.2018.07.17.23.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 23:43:48 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v8 2/7] dt: thermal: tsens: Document the fallback DT property for v2 of TSENS IP
Date:   Wed, 18 Jul 2018 12:13:08 +0530
Message-Id: <842b6fb711b9be401a0b3fdb2827dcb8980699b2.1531895128.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to create common code for v2 of the TSENS IP block that is used in
a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
most of the common functionality start with a common get_temp() function.

It is also necessary to split out the memory regions for the TM and SROT
register banks because their offsets are not constant across SoC families.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 .../devicetree/bindings/thermal/qcom-tsens.txt     | 31 +++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 06195e8..1d9e8cf 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -1,18 +1,28 @@
 * QCOM SoC Temperature Sensor (TSENS)
 
 Required properties:
-- compatible :
- - "qcom,msm8916-tsens" : For 8916 Family of SoCs
- - "qcom,msm8974-tsens" : For 8974 Family of SoCs
- - "qcom,msm8996-tsens" : For 8996 Family of SoCs
+- compatible:
+  Must be one of the following:
+    - "qcom,msm8916-tsens" (MSM8916)
+    - "qcom,msm8974-tsens" (MSM8974)
+    - "qcom,msm8996-tsens" (MSM8996)
+    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
+    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
+  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC
+  with version 2 of the TSENS IP. MSM8996 is the only exception because the
+  generic property did not exist when support was added.
+
+- reg: Address range of the thermal registers.
+  New platforms containing v2.x.y of the TSENS IP must specify the SROT and TM
+  register spaces separately, with order being TM before SROT.
+  See Example 2, below.
 
-- reg: Address range of the thermal registers
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
 - #qcom,sensors: Number of sensors in tsens block
 - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
 nvmem cells
 
-Example:
+Example 1 (legacy support before a fallback tsens-v2 property was introduced):
 tsens: thermal-sensor@900000 {
 		compatible = "qcom,msm8916-tsens";
 		reg = <0x4a8000 0x2000>;
@@ -20,3 +30,12 @@ tsens: thermal-sensor@900000 {
 		nvmem-cell-names = "caldata", "calsel";
 		#thermal-sensor-cells = <1>;
 	};
+
+Example 2 (for any platform containing v2 of the TSENS IP):
+tsens0: thermal-sensor@c263000 {
+		compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+		reg = <0xc263000 0x1ff>, /* TM */
+			<0xc222000 0x1ff>; /* SROT */
+		#qcom,sensors = <13>;
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.7.4

