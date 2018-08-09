Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09702C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BDC21DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUbM4/SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BDC21DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbeHIO5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:57:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40804 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbeHIO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:57:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so2689286pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zyKbfUOB0Y9T8bByL2E46QXLNpmRHMe5dD12vKApofY=;
        b=EUbM4/SIh7RAHxEjlJgTq6apupexB9/sDI3QO/YPngFPr1iC4TZjnKT5uHU6TgXbuq
         Dl54WWuhj2nbaU1XD6L0VEmkEMb+nW0TmZayNnpC5aMQIzPfP7O4XdQmGSix83xM7Sh+
         Ur517vJlbwHPuKQVBIb5oughoqod27z2WwCT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zyKbfUOB0Y9T8bByL2E46QXLNpmRHMe5dD12vKApofY=;
        b=q4wlZrmmXwnNm+smwj+nIY6sBDtq4jWrEu+cIUt9Y0u0Z6hJgbKIeGKF8AGvOFT8cd
         B+BCrpe6mxHjTymf/ZYMn1LqhuFXrtLKzK9q7PP+HhKtMQ2Qf6YIBeKGI4cPHmfGIYum
         CX/ZRg/WyEHQlxWD8OlyUByWAilj9VF6Ip7+QgPo8YUd1nWbVxJadrC6vaCp6RXCgPCs
         EIQlRoRDltANzgb/OiT1exExz5lZQqNBTe/IFUTbjPOnrm2PXOeUYrPN3il/qrHyrhiT
         zsj4IUPOqr8YAxwkKhH5nU6AuIEEkkC3z+Hp7U94BrwFdxssULha2rRnDGGBUkySxETm
         y+sA==
X-Gm-Message-State: AOUpUlFzxuoJQBMSVX8eABPpVr+d78m3t018OCTaoV41q/VmNZJwvnKW
        A9V2RN9BqSfQVfDp0LBdRtbNTuN8giA=
X-Google-Smtp-Source: AA+uWPynNbgSQQ9l/E1L3209WPLgCT7lV5BhDtWZ/Il0/Cm1U8gFwDoKDqPAPWZltPnd5jdW8qvJ1g==
X-Received: by 2002:a63:8f03:: with SMTP id n3-v6mr2051619pgd.166.1533817978957;
        Thu, 09 Aug 2018 05:32:58 -0700 (PDT)
Received: from localhost ([45.113.251.134])
        by smtp.gmail.com with ESMTPSA id r1-v6sm20812005pfi.17.2018.08.09.05.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:32:58 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 01/10] arm/arm64: dts: msm8974/msm8916: thermal: Split address space into two
Date:   Thu,  9 Aug 2018 18:02:33 +0530
Message-Id: <d01f560abed221b536b27bfaa42a530257642974.1533815718.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've earlier added support to split the register address space into TM
and SROT regions.

Split up the regmap address space into two for the remaining platforms that
have a similar register layout and make corresponding changes to the
get_temp_common() function used by these platforms.

Since tsens-common.c/init_common() currently only registers one address
space, the order is important (TM before SROT).  This is OK since the code
doesn't really use the SROT functionality yet.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 6 ++++--
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 ++++--
 drivers/thermal/qcom/tsens-common.c   | 5 +++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d9019a49b292..3c4b81c29798 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -427,11 +427,13 @@
 			};
 		};
 
-		tsens: thermal-sensor@fc4a8000 {
+		tsens: thermal-sensor@fc4a9000 {
 			compatible = "qcom,msm8974-tsens";
-			reg = <0xfc4a8000 0x2000>;
+			reg = <0xfc4a9000 0x1000>, /* TM */
+			      <0xfc4a8000 0x1000>; /* SROT */
 			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
 			nvmem-cell-names = "calib", "calib_backup";
+			#qcom,sensors = <11>;
 			#thermal-sensor-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index cc1040eacdf5..abf84df5a7bc 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -774,11 +774,13 @@
 			};
 		};
 
-		tsens: thermal-sensor@4a8000 {
+		tsens: thermal-sensor@4a9000 {
 			compatible = "qcom,msm8916-tsens";
-			reg = <0x4a8000 0x2000>;
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
 			nvmem-cell-names = "calib", "calib_sel";
+			#qcom,sensors = <5>;
 			#thermal-sensor-cells = <1>;
 		};
 
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 6207d8d92351..478739543bbc 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -21,7 +21,7 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
-#define S0_ST_ADDR		0x1030
+#define STATUS_OFFSET		0x30
 #define SN_ADDR_OFFSET		0x4
 #define SN_ST_TEMP_MASK		0x3ff
 #define CAL_DEGC_PT1		30
@@ -107,8 +107,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 	unsigned int status_reg;
 	int last_temp = 0, ret;
 
-	status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
+	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
 	ret = regmap_read(tmdev->map, status_reg, &code);
+
 	if (ret)
 		return ret;
 	last_temp = code & SN_ST_TEMP_MASK;
-- 
2.17.1

