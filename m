Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C06C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6351217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnBIEaGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfBRMfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:35:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55708 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfBRMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:35:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id q187so4885069wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KnqYkmaJQ2W98ZpgcSTL8cYq3Ka1/vJpxLFa+DKrwvs=;
        b=cnBIEaGT3S5Zm71+w6jkC8Ao6jj9Ck74dbdz6evQWOhloel+fmOSqF/vQpEDbmM0so
         WT9OQNNg50Vb3PO4hAHniS07F8Hq2ypcJpJ9iioD0RY8qt5ocl4H2WdhpjMNVd6ewOMo
         jWhX+7ebSt98fZah4Tf09J+kslYEX8IKCT1G6M0P92UsdJ1Vp1Ku9+Ywz6R02HqRKnqy
         R9IyobJ/RiQVnLn1dAGkkByy9j30VDifQode+zuaFo9GMJ2jwJVIQeJy8P+S3gogscZc
         TaMhnSXTesg1pRSrFccRyXG36+3Cg+J3b2mxYodM+EiS0S+6r1BULYLlu0he/2wf1ZbS
         Zrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=KnqYkmaJQ2W98ZpgcSTL8cYq3Ka1/vJpxLFa+DKrwvs=;
        b=JjG4ZPOFoKGovftLROfDoABHsguxVP/LOQ9mbehvABlZcS31mEM1kG9ZNXHqGisPco
         44uwS2GhmxAys9+TIByO/3fWPmTb/Do82iD8DDOgLOGmySsN2AczcHkVjMBTkOvF4DZ/
         4yq3/TXOLMpFKvmJo26ZOigvUGBu5U5GXWeLNo2w3BGbOITZ9K4AoBq7T7wLTS/G5niU
         L5yyERSneeNmXsYfhlPhvU0CWtYL2iaR/7CISpyTIQWyrB1znIuUnhrDJTpuztVZUteu
         mFWrEpnBWyJUWFrRaJtcAzb4gNPiAf5S2gV21wuR6QXUEimZqVASd8MnxgiwzEuRKtyD
         OmnA==
X-Gm-Message-State: AHQUAuaZfjDOQpCQ3zVrSeOmXSxeSzM4tr1ePJzgdO5HE9Y69eQ+xXkK
        qjYMLJ6dRxW+QZc+/MQxOkkLP0ZM9gY=
X-Google-Smtp-Source: AHgI3IYWecfDnOK3PRfhURWeGykA2dqvfn1vE17sl+OhPuiTFoGhp27YDH01PbTyWZ5k3A7gXcAAtg==
X-Received: by 2002:a1c:6c0c:: with SMTP id h12mr10339729wmc.35.1550493342790;
        Mon, 18 Feb 2019 04:35:42 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id u12sm10040467wrt.2.2019.02.18.04.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:35:42 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 01/12] arm64: dts: msm8998: thermal: split address space into two
Date:   Mon, 18 Feb 2019 18:05:15 +0530
Message-Id: <fb19401249fb49cbc62e9b5f8b49925c9d00b128.1550493113.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've earlier added support to split the register address space into TM
and SROT regions. Split up the regmap address space into two for msm8998
that has a similar register layout.

The order is important (TM before SROT) because we make an assumption
that SROT is always the second address space in order to support legacy
DTs.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 8d41b69ec2da..3c5fb2509d5f 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -579,17 +579,19 @@
 			cell-index = <0>;
 		};
 
-		tsens0: thermal@10aa000 {
+		tsens0: thermal@10ab000 {
 			compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
-			reg = <0x10aa000 0x2000>;
+			reg = <0x10ab000 0x1000>, /* TM */
+			      <0x10aa000 0x1000>; /* SROT */
 
 			#qcom,sensors = <12>;
 			#thermal-sensor-cells = <1>;
 		};
 
-		tsens1: thermal@10ad000 {
+		tsens1: thermal@10ae000 {
 			compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
-			reg = <0x10ad000 0x2000>;
+			reg = <0x10ae000 0x1000>, /* TM */
+			      <0x10ad000 0x1000>; /* SROT */
 
 			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
-- 
2.17.1

