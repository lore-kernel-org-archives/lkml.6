Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA35C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A942121104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GN32gwz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A942121104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbeK1D2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:28:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39244 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbeK1D2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:28:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so15392044wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ySS9ak8736GKuz1GUi70Wz4dUI9Ax/bqLZ13e7Wb3I8=;
        b=GN32gwz6a40w4VNUMQAm1giD/L8kZ0ljSCYaGM8U0EDH+IVi+geVy5+tuQgmwZJOB8
         CWvstXEIiz5PbxNq3qrCiy/0lcx5jhfrC8mZRSdnPgEYSzydQUIdH9Jap12PpR/vFLw2
         GITimkipCpZmMumNmuqSgpMV6aIp77E4GALTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ySS9ak8736GKuz1GUi70Wz4dUI9Ax/bqLZ13e7Wb3I8=;
        b=lfgKkrarqudkPRCTjpV1Y9dRW8oKm25Jy+4TkD7IwhVH7IWlE9dlvD2TYPcS0oQg8E
         tSRxLHzjXaLUjb4BQkm511quwOoLWz3nRIhI/TpPXIWqaPGdMzSY2Di194eXQT2BODm5
         wVChjepzKMs0283Aky9Bir2u4ZBNryqAa3O+sulJrrXtSXRhQbSDXyYdnUQqadFVSDig
         CoJk43+WL+lXsbPt6vB7EOGPuCNAlyuqWfEPIQXE0ZhaIltbUGB5ujhcgAGIYDCVuNFC
         j1+RGSMa+6C2Ni2pT8duXHe78fp05rdmvpP/8MAJffjl4SiT+2LmPDIhHXNpWOOLNFKv
         N2wA==
X-Gm-Message-State: AA+aEWb5/AyX9jIbDfG150wPH1AniCDpMiBY4Sdc9juc6TDtXB9a61t/
        72yRx6AFiLSsv8LfZtL3XpOHQyXlgRI=
X-Google-Smtp-Source: AFSGD/V9gqNFYO1fniDSmj4w6mL+P00CPB28gzA8NoZagPdfwnqqrRmFr7CP4/MJO7eggq4WmI1xMg==
X-Received: by 2002:adf:de91:: with SMTP id w17mr12831912wrl.320.1543336187565;
        Tue, 27 Nov 2018 08:29:47 -0800 (PST)
Received: from localhost ([49.248.92.105])
        by smtp.gmail.com with ESMTPSA id a1sm5158091wrw.76.2018.11.27.08.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 08:29:46 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        khasim.mohammed@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 3/4] arm64: dts: qcom: qcs404: Add tsens controller
Date:   Tue, 27 Nov 2018 21:59:06 +0530
Message-Id: <3491110ccf708efed795bfc756b2d108f8dbb710.1543335819.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1543335819.git.amit.kucheria@linaro.org>
References: <cover.1543335819.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1543335819.git.amit.kucheria@linaro.org>
References: <cover.1543335819.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 has a single TSENS IP block with 10 sensors. The calibration data
is stored in an eeprom (qfprom) that is accessed through the nvmem
framework. We add the qfprom node to allow the tsens sensors to be
calibrated correctly.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
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

