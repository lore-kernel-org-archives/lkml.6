Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33385C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0734E20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSJYPPQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfAODeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:34:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41409 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfAODeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:34:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so594184pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 19:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xnTFjl+GiCKiqWScUNzvjAlPROFJTsMxFZH/vteR13U=;
        b=KSJYPPQHYCKO/l2r4rZBK4OAdG04CVUdVDmoYcG7ST+tf+myncWW+OHrcD5mY7CuX2
         sT/s3qNmsbYtBTUWh+QzEosgr2c5GmOwDqEWij8yVx9KjN6u5USyPNUG9AEtX8yRrPCT
         wwPOWt59DLPBlsV9v8i//MAD42zuOUgs/tAPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xnTFjl+GiCKiqWScUNzvjAlPROFJTsMxFZH/vteR13U=;
        b=e7XHpAhOipBUR7TbQFbGb1SpsGxXeqi51iRZdspLCQbPZ+uR2t5JK6yjdOt1x3bJkb
         cTIG2QvqvGEoZ4tjUk86Cq9lxKsEmByFmEfvdWL42Uswljc+G/mUnR1FnT+YC+KD/Bvz
         jDn4lBs2aby/ebsP+7/pnv8giMgCccqqlAbyhZN8siSsssRogrTen5GIWgI3mziwOzCG
         4K4YyydFHDA4XJNg7b9SnRQ82kLULED/zZgByDBqzXVKjm1DZYrDChAtYZfQZJN3neXc
         QdgSE6FKFmc76bEqq91VW0p6dEKqoypXixPnKFH39kjl8mfhqMC/yKQr4roVQAxrY+lv
         GCrA==
X-Gm-Message-State: AJcUukcj7UxyHTUMvuOZqWBA4p4Xpj/mjrFyZqA471NDeiRimUzAz5N5
        uVqbyObivcvUxOXBvWIeh0P8
X-Google-Smtp-Source: ALg8bN6/ddsnp8BrTIrA0u520y91d7bXcRebBkdnn3X/OPNHe1f7i66C9FyPxEf7x8JmchG3Id+Xug==
X-Received: by 2002:a63:9712:: with SMTP id n18mr1777491pge.295.1547523260000;
        Mon, 14 Jan 2019 19:34:20 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6084:4813:7cd6:42d1:f14c:3e90])
        by smtp.gmail.com with ESMTPSA id s9sm2137023pgl.88.2019.01.14.19.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 19:34:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Subject: [PATCH v2 4/6] ARM: dts: Remove fake UART clock for S500 based SBCs
Date:   Tue, 15 Jan 2019 09:03:38 +0530
Message-Id: <20190115033340.25016-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Actions Semi S500 SoC has gained support for Clock Management Unit
in kernel, let's remove the fake UART clocks from Cubieboard6, Guitar and
Sparky SBCs.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/owl-s500-cubieboard6.dts     | 7 -------
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts | 7 -------
 arch/arm/boot/dts/owl-s500-sparky.dts          | 7 -------
 3 files changed, 21 deletions(-)

diff --git a/arch/arm/boot/dts/owl-s500-cubieboard6.dts b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
index 7c96c59b610d..c2b02895910c 100644
--- a/arch/arm/boot/dts/owl-s500-cubieboard6.dts
+++ b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
@@ -25,12 +25,6 @@
 		device_type = "memory";
 		reg = <0x0 0x80000000>;
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -39,5 +33,4 @@
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
index e610d49395d2..7ae34a23e320 100644
--- a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
+++ b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
@@ -18,15 +18,8 @@
 	chosen {
 		stdout-path = "serial3:115200n8";
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-sparky.dts b/arch/arm/boot/dts/owl-s500-sparky.dts
index c665ce8b88b4..9d8f7336bec0 100644
--- a/arch/arm/boot/dts/owl-s500-sparky.dts
+++ b/arch/arm/boot/dts/owl-s500-sparky.dts
@@ -25,12 +25,6 @@
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1 or 2 GiB */
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -39,5 +33,4 @@
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
-- 
2.17.1

