Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24615C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A4820882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFiLC00P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A4820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932992AbeGILoo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:44:44 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34424 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932921AbeGILoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:44:34 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so5925793plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ta7IG6QU9uQXIMjNn801Ta4qAYhVBfB/2Z+Ht5f83MQ=;
        b=CFiLC00PdmvxxS4DWrqNLL2khUpysqVR9W5y8s+6Nd759wpdjdIV2oxPaNQ1bBy0Os
         z8SkqZdO227jVfb0T7jF6gIKdLSce6lnHMOkU80XXBKpRoSTsnqh8ff1qPYhl30pzakI
         9pJ4wCJEddidbDIemgPT0oUyjxjs0IIkc5/Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ta7IG6QU9uQXIMjNn801Ta4qAYhVBfB/2Z+Ht5f83MQ=;
        b=NqEvei0jFk3fsuFaiLGipiRd1NcW1fD4hwZQqhILXPBmWHrFxNxR2LIk8wKOkmTEEg
         oOknk9GxD8UV5LvmJuicmt/W5sOf2/3Q9O04Q0jcyOFMyKIVn6Yw0i+xiOxeMzoeT+Pu
         L1LY/2DfQ4Gpm82ZRKFQjcZS9OwhQGKAOoJo0Y+BqjHV615cCJGDLwizJqhvf0qj71SU
         Dv5Q14OwyuC1D3KGglPcQBgD1bVGLo9z1c/53c6nKhq9I+hlminbgweo4C9k/aGtW3fM
         oNErfVz9JsJnkEIuaBH1pOSBpli/rKxFJGVKT91Scc1XhX8OToGG8WPR8uPTOXY3Q2Ga
         Yqrw==
X-Gm-Message-State: APt69E1Rst6Chvbfsz0/nhrJ5fsHWsNlJ39HX5Mf1sl7X2DBAOO41dka
        634Gj8qayuNBfzd4XCvjj4xArlvd0og=
X-Google-Smtp-Source: AAOMgpdnwJ4DJHfBhcqRQ5N/dZm2Gz/fsUycyC08Epz465UVY08NJHREo/jc7tB8gDWlFLRHlrXcWw==
X-Received: by 2002:a17:902:8309:: with SMTP id bd9-v6mr6236123plb.321.1531136673840;
        Mon, 09 Jul 2018 04:44:33 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id n80-v6sm5409828pfb.95.2018.07.09.04.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:44:33 -0700 (PDT)
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
Subject: [PATCH v6 7/7] arm64: dts: sdm845: Add tsens nodes
Date:   Mon,  9 Jul 2018 17:13:29 +0530
Message-Id: <65c39c405076627bd43ec94c211c6998191b9f16.1531136000.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 has two tsens blocks, one with 13 sensors and the other with 8
sensors. It uses version 2 of the TSENS IP, so use the fallback property to
allow more common code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdaabeb..ba2899c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -221,6 +221,22 @@
 			#interrupt-cells = <2>;
 		};
 
+		tsens0: tsens@c263000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0xc263000 0x1ff>, /* TM */
+			      <0xc222000 0x1ff>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: tsens@c265000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0xc265000 0x1ff>, /* TM */
+			      <0xc223000 0x1ff>; /* SROT */
+			#qcom,sensors = <8>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.7.4

