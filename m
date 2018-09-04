Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835FDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C04320843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ciD4hvD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C04320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeIDJXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:23:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41126 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbeIDJXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:23:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so1023865plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 21:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/aa3wEBhtjtAKzmRHg7WHS2RWv5ZeQrbHownJf2FpBM=;
        b=ciD4hvD0agA1DC/n+5dZ2bUO+FzGVsk0EEHtYRvSP03c/JMXyUzSpEjr/bHxcNUULW
         uduCQ2cM2vjUHrciM6gpROIRR3hpUbulME9SeUx8MNSIeZlhp7JTAN/Nb3owCjnuhFAF
         rFEEIsA7ycCIuOFaZ5jhN4AMvb47BpIOyoioI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/aa3wEBhtjtAKzmRHg7WHS2RWv5ZeQrbHownJf2FpBM=;
        b=RdwWxIoVkHhiGteHxKA4ugaqw627ZfXNwZMu6wvyPvsMaTL7ZW2sIuXL4NPu44y5gn
         Uw2h0GHN6F9gdYj7MdF4n4bcVcqFJ1zMWyy9/Gp+rugJLFsQWvYFdx9XG1bvukNm58Qk
         ahsvFnvRsaSsoWzYRcqO6WDNFGfgmAnhD0d5qjsqwnNqvFpTtRkPCy7zBRELofOqeitP
         7n8yVsnPTLnBPR3YuOz3C+KSsquVTo6ZbVMaCkOzGK5BEnSCUtevHC/cx0Ay1uEX8Qwv
         zHFlDC1Pl7xxqoh8CFqkRcb5wEG47zFc90Q1OZC1hAuHrcqUuJ2HSZjtZAcb2aDCeMvF
         EYew==
X-Gm-Message-State: APzg51CCIWgCJleJiR3QXQYDvW8MHuASuXLknaiMF+Yov2Z2YmMe+Ooe
        le1lxYyJ6930rAzyrm2JdDd89w==
X-Google-Smtp-Source: ANB0VdbjLr1innlNQNWPqWRIwX/tf44adC/h6OEqaRJK1zTYGDHdHdNWjEe6RswYcZiD+HN8f3P/9g==
X-Received: by 2002:a17:902:42c3:: with SMTP id h61-v6mr32071175pld.319.1536037182043;
        Mon, 03 Sep 2018 21:59:42 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v72-v6sm41180378pfj.22.2018.09.03.21.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 21:59:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] arm64: dts: qcom: msm8998: Add the qfprom node
Date:   Mon,  3 Sep 2018 22:01:22 -0700
Message-Id: <20180904050123.26601-8-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904050123.26601-1-bjorn.andersson@linaro.org>
References: <20180904050123.26601-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the QFPROM nvmem node to msm8998

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch

 arch/arm64/boot/dts/qcom/msm8998.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 7cf655f04489..f0cdad91b6c9 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -471,6 +471,13 @@
 			reg = <0x778000 0x7000>;
 		};
 
+		qfprom: qfprom@780000 {
+			compatible = "qcom,qfprom";
+			reg = <0x780000 0x621c>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		gcc: clock-controller@100000 {
 			compatible = "qcom,gcc-msm8998";
 			#clock-cells = <1>;
-- 
2.18.0

