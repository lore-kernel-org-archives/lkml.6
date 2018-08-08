Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D70C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3107521A37
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UI9QXx9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3107521A37
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeHHVfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:35:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32886 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbeHHVfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:35:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so1616102pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBmzx1O6HmlvU/FJnSO+pWnBg/kMbATEjB0Ym+YfopU=;
        b=UI9QXx9r22dD/TPmhmHPT+weyjCTHgzjjaKC2JOBT9le0rzsbABrLyMA9eZIehJI4C
         XCtG3NPe03sjpSz+k/f+cFf7YYYH3Nm2v+AgUrzBIwl4tPMW0tNnoZyVC/kdE2xbv68r
         ckB+gqthzXS6O130xZrCJwNvSbsU9NV+toXtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBmzx1O6HmlvU/FJnSO+pWnBg/kMbATEjB0Ym+YfopU=;
        b=l4ODwWWYgAdXiytfdbMBoi0ArRyhYm1jcHiv6MfvL1AYbIukrm6wrfBLE+48kyTRke
         LvHzfvD3AuGnQPq2K44vHlhL/wOz4wCJjfhmtA8/ZLwlUl5DbUOuIhZv/sy8rPVrHaHk
         ytyfMeTRg1e0Zi4ttW++iCsTZ5aQDnzW8DgZ4mso3OtehpaggIzFiY2S30xVqB7kDVi9
         BNa8gb49LKoFQnBMczL2bXH/nXCLUzw5z5p6rqLsyaUp7mtoKeunDaz7ROle3mo5z3e1
         838z/O/axLNLf5Fl1sUBo1k+Z4iG1Std3iGW7c3k+6eKuRLAqrWXU94hHlvWlV95mW3l
         70/g==
X-Gm-Message-State: AOUpUlF+svAN/EpEONdfmS/DqzXd2sg3NLMBmo5wkbMvddZEFNAVrJV8
        xiUPG4iyCpwpdzHb6El/OX/yIw==
X-Google-Smtp-Source: AA+uWPyotgpIgQNhY7G1ezpVgz5o90v2hPeZF3prg8DhksX6gkugXQEZOYO3+5cRdTA/sR4zlFUF5Q==
X-Received: by 2002:a63:68c1:: with SMTP id d184-v6mr3682388pgc.239.1533755654004;
        Wed, 08 Aug 2018 12:14:14 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id f5-v6sm5431136pga.58.2018.08.08.12.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 12:14:13 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/3] arm64: dts: qcom: pm8998: Add adc node
Date:   Wed,  8 Aug 2018 12:13:38 -0700
Message-Id: <20180808191339.16875-3-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180808191339.16875-1-mka@chromium.org>
References: <20180808191339.16875-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the adc node to pm8998 based on the examples in the
bindings. It also fixes the order of the included headers.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..f70f6101bceb 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /* Copyright 2018 Google LLC. */
 
-#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
 
 &spmi_bus {
 	pm8998_lsid0: pmic@0 {
@@ -11,6 +12,16 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8998_adc: adc@3100 {
+			compatible = "qcom,spmi-adc-rev2";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			io-channel-ranges;
+		};
+
 		pm8998_gpio: gpios@c000 {
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.18.0.597.ga71716f1ad-goog

