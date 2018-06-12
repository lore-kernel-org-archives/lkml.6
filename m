Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 284D3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24332086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQO+AqLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24332086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933119AbeFLKzh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:55:37 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36710 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932811AbeFLKzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:55:32 -0400
Received: by mail-lf0-f66.google.com with SMTP id u4-v6so35317780lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FhQ3e9gC5p6WExs3bb82v6CtoZfQFTo9EGSLXEduIAI=;
        b=fQO+AqLrFnsGd6ljfxqQ4QrzpUlkP2SvBd3pxXeAS1wS8oSx+eZeUKSEM63LDYg+nh
         I9Qk6qJqjo/0ho/YczOBrxA0E78sxzBLEtAPvZ1ZlDpvxmSEeRu4bhcjpHO/bB2bsTb8
         mM6IqT6a6vPP3QIsTBDWYSw8KhSxl00fEWZDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FhQ3e9gC5p6WExs3bb82v6CtoZfQFTo9EGSLXEduIAI=;
        b=fK2wqupxjkYZwGJo/B0xa3DjNncunOWeyOi8lfQ60srn++Bbz8VQppRnxSywEvQWkY
         gyTzyc0E4AJe1CwD8WKpYd7Iq2U0YCtf9Wpsx8hf8svKhtk33XJIhd7i7+jOa8l8fWl/
         ScI0jlGOkMjZG2FwOc67nU4sty/DwwldHwZjkttBDcX8J4P9iNYvjidig2QPA6UrVbEs
         ZNnFJrc+XlwteF2RD7J93bahAdgWcigTuk0KWdsUBDJrgl0NLUahrknUQ9Luuu4WlnQm
         9NL/wqV5JHCs+pYPZ2R/Vr78d++UIZFufanyhkj5hw2k4Gtch/s88cssRs6TqwrtvxP6
         DF9g==
X-Gm-Message-State: APt69E0Z6/SFW3dmOnxKsFIPlVrFXX8AQ0ztx98iLsB9tgijKjZiliWF
        3VbaHxoEuowcnVuAsUicWsotpabfTB0=
X-Google-Smtp-Source: ADUXVKI0i2mQZvuNwX5SCXImGBFrjAJspDl/S3SaQGa9OE1hEVQ5uNd10HRum13zAlUTHVoVw29Ptw==
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr2028012ljj.143.1528800930670;
        Tue, 12 Jun 2018 03:55:30 -0700 (PDT)
Received: from localhost (85-76-96-64-nat.elisa-mobile.fi. [85.76.96.64])
        by smtp.gmail.com with ESMTPSA id d4-v6sm160166ljg.44.2018.06.12.03.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 03:55:29 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v2 2/5] dt: qcom: 8996: thermal: Move to DT initialisation
Date:   Tue, 12 Jun 2018 13:54:54 +0300
Message-Id: <683ceb9a7d283bcad47fc6e8e4fcfbd7e76c1018.1528799892.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We also split up the regmap address space into two, one for the TM
registers, the other for the SROT registers. This was required to deal with
different address offsets for the TM and SROT registers across different
SoC families.

Since tsens-common.c/init_common() currently only registers one address space, the order is important (TM before SROT).This is OK since the code doesn't really use the SROT functionality yet.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
 drivers/thermal/qcom/tsens-8996.c     |  1 -
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 410ae78..b4aab18 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -451,7 +451,17 @@
 
 		tsens0: thermal-sensor@4a8000 {
 			compatible = "qcom,msm8996-tsens";
-			reg = <0x4a8000 0x2000>;
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@4ac000 {
+			compatible = "qcom,msm8996-tsens";
+			reg = <0x4ad000 0x1000>, /* TM */
+			      <0x4ac000 0x1000>; /* SROT */
+			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
 		};
 
diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
index e1f7781..6e59078 100644
--- a/drivers/thermal/qcom/tsens-8996.c
+++ b/drivers/thermal/qcom/tsens-8996.c
@@ -79,6 +79,5 @@ static const struct tsens_ops ops_8996 = {
 };
 
 const struct tsens_data data_8996 = {
-	.num_sensors	= 13,
 	.ops		= &ops_8996,
 };
-- 
2.7.4

