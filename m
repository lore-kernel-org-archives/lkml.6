Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6196CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C467208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QitC8Qnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C467208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeH1JZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:25:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36323 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeH1JZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:25:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so251143pgo.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 22:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bYQ/D9/tqnQHU9s3i/KAkC8ou0C2cPeIRqJSFopFugQ=;
        b=QitC8QnjJelDSRsHxhFQv82zrT8BI5t1kPx6e2+myIL/i34byyzbBDndmTfS/QRcsx
         Piz+PhmFDa+q2IItw29Nd525bRiCz3czXu0k70iIZis5f4c8mDjo7aPgVVXebMjhnUMR
         LO2CjaBNSBCWC1he6NoOfp6jyn4UYvc7Ei1HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bYQ/D9/tqnQHU9s3i/KAkC8ou0C2cPeIRqJSFopFugQ=;
        b=icUkFr5MquR5Z7HSplGUEz+jmtIwjd/xA2xKeQpFQy1J9aN7uShQVV38e6uVwFpUn5
         bkXg0D4o4eVs3nvpsw48yQJ45SdIMpnLck7AJ0Z2Cisa4o+Nzq/b/OATfpt1rXCR/+6p
         shB/webQjrtUhZ+uMx4al2mY0nf/h41DT6dSLC2wXfNQ14Er+2pxa17HBxOkEuu/ayer
         RDW7YxE3TYHtuzsXrt4+Y+eZB4gAdf5B1IhgB8RJFoQFXZ5USF/0ovCTVzyqDXrV3zDH
         YA4zI8W7wpMbTHQtQ+ECO1jQ4u0kVxlmdKoXhK4FYBk1aBllY+YstwxwSenWlIPMQNq6
         ZwCA==
X-Gm-Message-State: APzg51DyF6XvjVbzaSKN0HBolx1M0wkrBuKjM5f66w7H27kYw55AP7bL
        zkCOt6fdbNYu+fcrtS8qAeHD9g==
X-Google-Smtp-Source: ANB0VdZVxQ5H8ZViW9CsvrdBx7YGWPvmEggcgv0YFNNxkmUgjZ0PgftgEOi+AaqkgKjO5D9ByA7EYA==
X-Received: by 2002:a63:e206:: with SMTP id q6-v6mr14503620pgh.223.1535434528096;
        Mon, 27 Aug 2018 22:35:28 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f75-v6sm360124pfk.85.2018.08.27.22.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 22:35:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: msm8996: Transition smp2p and smd to mailbox
Date:   Mon, 27 Aug 2018 22:37:05 -0700
Message-Id: <20180828053705.30882-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smd and smp2p drivers now support accessing the APCS GLOBAL IPC
register through the mailbox framework, so migrate the msm8996 dts to
use this and remove the syscon based APCS node.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index cd3865e7a270..21057f957468 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -409,11 +409,6 @@
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		apcs: syscon@9820000 {
-			compatible = "syscon";
-			reg = <0x9820000 0x1000>;
-		};
-
 		apcs_glb: mailbox@9820000 {
 			compatible = "qcom,msm8996-apcs-hmss-global";
 			reg = <0x9820000 0x1000>;
@@ -1140,7 +1135,7 @@
 			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
 
 			label = "lpass";
-			qcom,ipc = <&apcs 16 8>;
+			mboxes = <&apcs_glb 8>;
 			qcom,smd-edge = <1>;
 			qcom,remote-pid = <2>;
 		};
@@ -1152,7 +1147,7 @@
 
 		interrupts = <0 158 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 16 10>;
+		mboxes = <&apcs_glb 10>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <2>;
@@ -1176,7 +1171,7 @@
 
 		interrupts = <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 16 14>;
+		mboxes = <&apcs_glb 14>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <1>;
@@ -1200,7 +1195,7 @@
 
 		interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 16 26>;
+		mboxes = <&apcs_glb 26>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <3>;
-- 
2.18.0

