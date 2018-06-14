Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 55197C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC70208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e18n8GM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC70208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755164AbeFNKpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:45:05 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42680 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755054AbeFNKnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:43:50 -0400
Received: by mail-lf0-f68.google.com with SMTP id v135-v6so8642884lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LboO0m9tdUv5OClL5JGmFqiWh7zVC6d1MgWg2XNw1k8=;
        b=e18n8GM9yMChDMiudEptri7Dt71qtvl/jlXU/Iklt0lISEG+w3XBpsDiMfLrTHJGnw
         SJtYbJ5Az4TkPoyUpsxipUL2MaXB8lqVFp/v8zSoRQSqT+JS7SRBxAqnpC4POeWGBhR+
         3BzymjBjoW2xSMgaRdwpTMVdbIfz5EtciXV/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LboO0m9tdUv5OClL5JGmFqiWh7zVC6d1MgWg2XNw1k8=;
        b=hwfZt+gXMk1sVTTTC6470cvEZM5X6e57WAIIZ6Yk2R3wftJYHSuuCSCS4+56AYW8M3
         69Snd+yEdVcHHB4nc+ccIfa1Iy2g5nOzVFHiiL9kboNSJgW5g8b2Ct3DsGcjB9D5RY8L
         Lhw+gVsQA+PmoSQNEtLdtHISz0MZM66q0BOd5Jo+tXiT8Bxj2FCX56A/22/oEFvxnaFF
         Wq6baoQi0tM4pt1DZ0w6NE11XRMTkTYInuUZ2OE11HQxwBf9ARAe+kdz7Nsw2pqGheDK
         elvVfFRI978Z2BtfO6Nb1lmDVFyzFd32KxvvOculmod43GBaVeZPthL4PwbiDEb1DHj3
         +Ssw==
X-Gm-Message-State: APt69E2phxAThcETAu0itv0YG4VC1K0AWqXHrQwJO+RdhRfdekudj8/V
        iz4mgvKKrLMKZ1sD7zsscC23D9EBRig=
X-Google-Smtp-Source: ADUXVKIyXQ9yD10gqRX2OtCYf+dDZ5B9AJV0sotTQf9SqWcMdAUyNhpEUNqBB1A1hwb8Q4qF05kNKA==
X-Received: by 2002:a19:1003:: with SMTP id f3-v6mr6000987lfi.114.1528973028844;
        Thu, 14 Jun 2018 03:43:48 -0700 (PDT)
Received: from localhost (85-76-96-172-nat.elisa-mobile.fi. [85.76.96.172])
        by smtp.gmail.com with ESMTPSA id y15-v6sm888556ljj.75.2018.06.14.03.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 03:43:48 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE))
Subject: [PATCH v3 2/6] dt: qcom: 8996: thermal: Move to DT initialisation
Date:   Thu, 14 Jun 2018 13:43:12 +0300
Message-Id: <e451a4dc1c885921c66da63549a720805c287a6a.1528972165.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We also split up the regmap address space into two, one for the TM
registers, the other for the SROT registers. This was required to deal with
different address offsets for the TM and SROT registers across different
SoC families.

Since tsens-common.c/init_common() currently only registers one address
space, the order is important (TM before SROT). This is OK since the code
doesn't really use the SROT functionality yet.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8c7f9ca..6c8a857 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -461,7 +461,17 @@
 
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
 
-- 
2.7.4

