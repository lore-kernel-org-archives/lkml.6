Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F921C4646D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEB5217AA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vc79Fvp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEB5217AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbeHDATc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 20:19:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42378 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbeHDATc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 20:19:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so3927498pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcdkewYePpyIpVK1KIyRbnqKyslln1KqzCB53nntR3Y=;
        b=Vc79Fvp84vgdPmoK4fF7c+jd8FRSUC3nRcKOa0zB+5SLN3JFV38JPoKKDyjkfyN665
         zlcffxndd9y+6U0dwNLO2eMjlxDhb5YKjiIYWNqRwG6YUN6rYWHFqP2c3ZQBUIBZxbEk
         QJynNlh3MDob8S1tlJfQ0zdZEZyK7gLXOiMKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcdkewYePpyIpVK1KIyRbnqKyslln1KqzCB53nntR3Y=;
        b=KYu1k95BTVrpW6ulgUOxyWWtm81TwH5mMMifgX8kOymU50/nziL20BJm/1DRFpNu5J
         topffoSSE1JKFKmmg7jv8nLfZtETtsnKQiyt63YT4pvSeXZL7GGpXS+/bKipjjJ3QFQ5
         0j6hdOYoAc4WcrY4U5+k7ALfa6/p83YHBr0KZSc6cBjhtdqEq+itJdNbdZDS0OLX2+Hv
         AgsDRjcQ09ZSpXgN6brqYasrYvSd0Low9wkx0uP6L42/tZ2uba75jmnPCNMxbpvS/yrl
         z5KvpmLV+8LBkn04SHYUYczbp1X6xa8afdSycb5U54l6n7+dpJC3uNZG+8MTy6FNZXYS
         3kkA==
X-Gm-Message-State: AOUpUlFywU0tRkNU+nXMdMtoBybTp+2q+HLNBzyrv4dabQfL+5AFYF0n
        9YniWbRJFoADi1ac1lmJlCr5yg==
X-Google-Smtp-Source: AAOMgpfzGHhCqueq/+B++LXs5g1SITX6BieX0AudSG4ybY8HgyU99nNip6LNee8QC1ENnYrgWQm+OA==
X-Received: by 2002:a62:95d1:: with SMTP id c78-v6mr247052pfk.130.1533334879797;
        Fri, 03 Aug 2018 15:21:19 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id r19-v6sm7929238pgo.68.2018.08.03.15.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 15:21:19 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: sdm845: Add dispcc node
Date:   Fri,  3 Aug 2018 15:20:59 -0700
Message-Id: <20180803222059.146666-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the display clock controller node to sdm845 based on the
examples in the bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
The dispcc driver and DT bindings landed in the clk-qcom-dispcc-845
branch of the clk tree.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9c10ff5e5843..d0b4a78c79e5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5,6 +5,7 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,dispcc-sdm845.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -962,6 +963,14 @@
 			};
 		};
 
+		dispcc: clock-controller@af00000 {
+			compatible = "qcom,sdm845-dispcc";
+			reg = <0xaf00000 0x10000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.18.0.597.ga71716f1ad-goog

