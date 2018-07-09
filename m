Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A55AC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349062086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/g0mtb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349062086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbeGIL2d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:28:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35069 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932862AbeGIL23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:28:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so1360906wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LboO0m9tdUv5OClL5JGmFqiWh7zVC6d1MgWg2XNw1k8=;
        b=A/g0mtb0jokK/Zde6XuLfjxTTtg6h3hQJZF9JIcvbRbwAzfhJtYj+sep0ubtKo4GQ7
         7aUUny3kxn21N3RXBmnegF8lGiPq/5p13zCpKzNMu5lP8O+HQVWixGmos+Adpu10EdqX
         nbc1R2O4KhpdeFNYWqnrKUmBwJgp+yrfDK39w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LboO0m9tdUv5OClL5JGmFqiWh7zVC6d1MgWg2XNw1k8=;
        b=CwQGJqnbqwfoUrBHwFxTB/GQcVAd7VILIke74MwbDxNBfTcaCePFxm9ndNGKPz8xKY
         KU1EZ1OZrC5Ib2sgySbvqpvsCTyFBQhXCmx2gStJmDH3lrn8+nQ8foFLQv0LBdAKP6JZ
         NJb5h1Y2HNt/K4eO8tr+T/e3LTG+wmuNWtf2OfyPDEg5RW9tbzpevLlYDj280Lgg6+/5
         MpDaBvGO0TNDchHTpBMrqqM1vH7Dxz76bCPYj0KcmucN606EJtchATkIOwwKofcRJ+zR
         HeEtzRRfJACwzR8AhtMu+k4Xwpb8E4lvt3J6Rr+yoQil9IAEtyBdqw/SaqUxhx1K8hts
         QRAA==
X-Gm-Message-State: APt69E1lKnTXA1o9GngewcmxTFGYyJeMBTUsNgwBnmtV5EPu61Pj1k/B
        wTqV7Gq3XrWk12NHO7zjfKOGZEqUNW8=
X-Google-Smtp-Source: AAOMgpftEvf9iFQ1qh0Y3FXeocMoEEB0DlL21BzgMxMrMYXUHkP5IdSTeS0Cd0oRQWT9i3uir78VvA==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12-v6mr13824589wrt.71.1531135708058;
        Mon, 09 Jul 2018 04:28:28 -0700 (PDT)
Received: from localhost ([49.248.189.240])
        by smtp.gmail.com with ESMTPSA id h5-v6sm1095318wrr.19.2018.07.09.04.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:28:27 -0700 (PDT)
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
Subject: [PATCH v5 3/7] dt: qcom: 8996: thermal: Move to DT initialisation
Date:   Mon,  9 Jul 2018 16:57:36 +0530
Message-Id: <ee06e59ae84a9b9013480c58bd4678e44d201a42.1531133612.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
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

