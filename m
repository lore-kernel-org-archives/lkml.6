Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA67C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4BB2190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcKpYz9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfBGM51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:57:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44092 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfBGM50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:57:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id y1so4442631pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aLsMVwtpgSOaGBz4AILnRl4PUyhZEZVIsjfHxCwTaGk=;
        b=hcKpYz9w/kBfeCUVmObGrKd419Cy5vzdpLIJR5NCbYRO71/hZX3+P78339usja50Dp
         MzZL5q9bxQBvG57P+5Lj51jAYZK+ho2Gyo7+9o9yuf9M/WYBp6JHF6IypfwMfh7l8XrN
         qdH07Lnwi/oTQobDeoDHiQ+fK+NZcKuf8imN1Slz1u8Le0TDsDRVmq0KbNov6/vFoXNO
         h1b1+jvt5KXuopQZSjAXP4n2NpMpFxRAGOqQj+QG09a2K9OGn7y8MA+ZWEoUokuY29r5
         EUmyd2tKxrubbMqdRcxI6RaUMFfhS9qjmmaOl/GbSCapp6VlHSp33hZ1FDYVun2qN/M6
         njdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aLsMVwtpgSOaGBz4AILnRl4PUyhZEZVIsjfHxCwTaGk=;
        b=SQITNDZh3dzSns6lbjrxQkGblN/SgfqRd4YpAwi6BxgrTfl38qgixFTuvzeWw3n6yd
         WbtCuyT8l1Jo4w07AMvCSbH2fadpOrCkxgHuvEc8gipElrakPu1GLI2JJC2j4dFkinOm
         aLizL2Ev6HMPLyOLZ3ZqNZknLBrG+/hSz+vFwToGS9kfM66ashAgwfXZqE0b8vfaJkf8
         Kqmd3SBYNOdxF23jjb0xF3CjfxRTgJH1NiZ2RFlP8FhsdotWb33n3qS6CT5cOkyhPec4
         SBlw7K8cMPs5CH5/HlHjYXhmkAuT054KDgwni8w4xUm1s60mFB0dx6IZmlHSaXRnSxgy
         p0ZA==
X-Gm-Message-State: AHQUAuZL6i++yy9WvJE00ewZUX+jvxX3VZrl29pLAG4gWu/3wYi1+g2t
        cvYh7neVX8GEp//xhhIHpyGIrBSZP4U=
X-Google-Smtp-Source: AHgI3IbiR7dVHmBXeYACecukFxDJ23P4px09daOz/uS5ku/MfNz9ici0Oo31+FKjijwU5KiPH/kjbg==
X-Received: by 2002:a63:e711:: with SMTP id b17mr4222270pgi.363.1549544244759;
        Thu, 07 Feb 2019 04:57:24 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id z9sm30606960pfd.99.2019.02.07.04.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:57:24 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 22/24] arm64: dts: qcom: qcs404: Add tsens controller
Date:   Thu,  7 Feb 2019 16:19:40 +0530
Message-Id: <6c7b8f6f6b7df129425f7975610bd45be411f0c4.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 has a single TSENS IP block with 10 sensors. The calibration data
is stored in an eeprom (qfprom) that is accessed through the nvmem
framework. We add the qfprom node to allow the tsens sensors to be
calibrated correctly.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9b5c16562bbe..57d14d8f0c90 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -253,6 +253,16 @@
 			reg = <0x00060000 0x6000>;
 		};
 
+		qfprom: qfprom@a4000 {
+			compatible = "qcom,qfprom";
+			reg = <0x000a4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			tsens_caldata: caldata@d0 {
+				reg = <0x1f8 0x14>;
+			};
+		};
+
 		rng: rng@e3000 {
 			compatible = "qcom,prng-ee";
 			reg = <0x000e3000 0x1000>;
@@ -260,6 +270,16 @@
 			clock-names = "core";
 		};
 
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
+			nvmem-cells = <&tsens_caldata>;
+			nvmem-cell-names = "calib";
+			#qcom,sensors = <10>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,qcs404-pinctrl";
 			reg = <0x01000000 0x200000>,
-- 
2.17.1

