Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD18C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8723E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvA7xev2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8723E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeKWFMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:12:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39725 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKWFMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:12:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so2181475wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uiT7mql3LrIBSapvTsOqHQS+ZJhwkLcsbyLxK1A1yks=;
        b=VvA7xev20L3m+TpF2gwnYyh3BlgayVedZzAVjvWYZxBDpgNWpTIkBbZtnIaKFIZ3jS
         e/2mzDiU4QMqFKDqXzzCWm0Xu00JVbRJiKLvUYYC5vZh/2b+zVTm3NfZQOlAQjXIAAi4
         5wsm8hbExqTe5z0Q53yNqzXJaH/W9Rg+KvJfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uiT7mql3LrIBSapvTsOqHQS+ZJhwkLcsbyLxK1A1yks=;
        b=sMFqMXSqpKa1bhlXb8GhT3gXwptIARqnsekNUSAp1YgzmQqKJwysnktDwEkROqG3uf
         tBAHIX/906EcBAZ284mWKcT1bWo/S2IQaBc0cUPAsMFVaXmLJlUJjNveNjJloRaWEpVP
         4J31Z16Bq+Rx4oJNcJHp6H+Y8nLUWgKd4wtSgk5Rfv4HzlgoVDtK3KxSUTypneHN++01
         1IO105LM7Gg8MMb8fFGEENoyUpg0x+k15iZySAoANnGyh3oCsGPtqxMxa7Ayn8FjX3cp
         2GH6jFNl1iusrqH1hxrPQzidJkE9Pgsz2wJmZroYACsYDJG7HPx/o2xrkl1GIDIZl3yi
         upBw==
X-Gm-Message-State: AA+aEWbnRR5drtGX2y6SmTx4emPrMfeu+PMTkm6ye5LcpZmLYK1d2T8j
        TE/CU8yfNWKp/dt3E7buv0vdsOZIDAQ=
X-Google-Smtp-Source: AFSGD/V+QI8VoxQ+e1iN4UXGb7hqzVbzBfu2Irm+gdhfdMZ09qDxBvFeBYaIS/MGLY5j8xqg4LqCoQ==
X-Received: by 2002:adf:f984:: with SMTP id f4mr10916793wrr.234.1542911533683;
        Thu, 22 Nov 2018 10:32:13 -0800 (PST)
Received: from localhost ([103.8.150.191])
        by smtp.gmail.com with ESMTPSA id f2sm8562778wru.14.2018.11.22.10.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 10:32:13 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1] arm64: dts: msm8998: thermal: split address space into two
Date:   Fri, 23 Nov 2018 00:02:04 +0530
Message-Id: <565873e4dd152df24c86d091327687f4aa3505e2.1542911304.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1542911304.git.amit.kucheria@linaro.org>
References: <cover.1542911304.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We added support to split the register address space for
tsens into TM and SROT regions in 'Commit 5b1283984fa3 ("thermal: tsens:
Add support to split up register address space into two")'.

Split up the tsens address space for msm8998 since it has a similar
register layout to other versions of the IP to allow for better code
sharing.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
(Compile-tested only, since I don't have the hardware)
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 78227cce16db..eb4f6f77969f 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -577,17 +577,18 @@
 			cell-index = <0>;
 		};
 
-		tsens0: thermal@10aa000 {
+		tsens0: thermal@10ab000 {
 			compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
-			reg = <0x10aa000 0x2000>;
-
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

