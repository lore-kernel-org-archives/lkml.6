Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00707C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8A720882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7gEpZZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8A720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbeGILoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:44:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37540 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932628AbeGILoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:44:11 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so5928047plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LboO0m9tdUv5OClL5JGmFqiWh7zVC6d1MgWg2XNw1k8=;
        b=V7gEpZZm0OGwpFFvpwBpwBmb9UDv7dab6XKaeNfVwWvuULotqtXmUVnd6Cx1QJb14L
         KFf2iT8oeypZjV0SDMx8Ni9OkfXQgylDhsN6ci/nkTFJbnoUs7C3Mt5j5d5mg/arfpbx
         6Ez+8u+PUijBrREBbLITH9OkmcCZNgNX1p1Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LboO0m9tdUv5OClL5JGmFqiWh7zVC6d1MgWg2XNw1k8=;
        b=TnOCQiKZExidTdal3P0PSMA7i3wjvrEsyqdGEy7HbmDQ6KdPG0W6zPnkmQ8rvU8M+E
         EbdekdfuY7nt2u8UFYYF8Hu3pH1JKFCu6vieVALO8fxTBzKT3VUHaCX3e6EbqPQdbojp
         RDpuTR51gvQOnrtr0M5b9Lk67Icp+Yea342/Rjz2vOyjkmLCm3cXwe6xd2E1NvW+N2Q5
         NVIeJUYXOilVCLmLwnf8G7EjLJEGfZvI57FpveFJlj2Aq39oRhASt0K3iGnl+w6vJmys
         gqMKX2iYwqt4OYAoxet2qV3GPw+y2cYfJYK/yWHe0zz+LM/hjx1kFcsiOhqWalULQEAi
         0UDw==
X-Gm-Message-State: APt69E0zSOAyv3b/l6a99UBlN4ucy5tszRQbonTH2zNK70ZXzwVrMF/n
        vhI1U/cz3Z/BCo+7cTfApB0N6LMzg1E=
X-Google-Smtp-Source: AAOMgpdHdVITWIssY0m8587gQ1hWhDyrsgy2ATd9xO5dBey9r8MLGF82iIfT91sx9mP5uzcIlusYOQ==
X-Received: by 2002:a17:902:7798:: with SMTP id o24-v6mr20713741pll.165.1531136650294;
        Mon, 09 Jul 2018 04:44:10 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id g124-v6sm24269175pfb.5.2018.07.09.04.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:44:09 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 3/7] dt: qcom: 8996: thermal: Move to DT initialisation
Date:   Mon,  9 Jul 2018 17:13:25 +0530
Message-Id: <ee06e59ae84a9b9013480c58bd4678e44d201a42.1531135999.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
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

