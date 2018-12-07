Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0370C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A643920672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e++UA0uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A643920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeLGPaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:30:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44537 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeLGP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:29:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so4149702wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 07:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KvtupwCwXR8Q8slD54MYCwBpuj1TGFpcxOPBLUHvICE=;
        b=e++UA0uHQ+6kLE3FaVwB/Z/N+4Y9y2pbkIaEj9J915heUrdAw+qXrIT07nbF363x44
         UCMXcfvWRpmSW/Hvao1JtGXn+g2FcPwJ9WKqHV+S/PktliZ+gLTV0W7IKOkwyEFtiRuN
         yAU8GFYDaSQVhSpj0GfdR1Y/t6RtGDbtt8SUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvtupwCwXR8Q8slD54MYCwBpuj1TGFpcxOPBLUHvICE=;
        b=XlVvq44DAZPgeF7vhStHREF/rZyQWW+FtMGMixrPGK9IJ/JsZcSLT0aT3va5LFoqtF
         b0YnKnAPxxWeCMW/mIh4gIaqKRkqLFaQEh4dNKr22MxAJNM1fwXLAP/ZDU/mf1Uex5WZ
         y78AlVAdzBs2ibRMubj/CRtexUWmFZ2/ReWp+v3CrPiLXDlGLLbmhJ2CTRWIkgu/s7YW
         Gf6nkRFYeOmEkxKmW9dFFXxHPQ/YnsyV7RY4BL6IiwuKKM2oXcIt47nfoaT9ttKsyDP9
         BCH0Em0jA3Fw2d5MJVELiRtHm2MYieXAjkZxZFYhcxwDgdNHPetzyUNO/85Qq7U5wteT
         kF/g==
X-Gm-Message-State: AA+aEWYDxaNQvoC1+WIdf1u3jBOgC8cyxWRJXB+vKLMKHqjsA4Pwywg3
        pJmQPsfDbhxdYvxy9VbmT+8WDA==
X-Google-Smtp-Source: AFSGD/We2VLPrj12mDcerSGlNDu1Om9qxx1f9i2gEMMukYCrDczxKw7EChcfnXYsxukeA3yeka/CBA==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr2071427wrq.108.1544196573739;
        Fri, 07 Dec 2018 07:29:33 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y145sm2728721wmd.30.2018.12.07.07.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 07:29:32 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org, linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v11 6/8] arm64: dts: sdm845: Add interconnect provider DT nodes
Date:   Fri,  7 Dec 2018 17:29:15 +0200
Message-Id: <20181207152917.4862-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207152917.4862-1-georgi.djakov@linaro.org>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

Add RSC (Resource State Coordinator) provider
dictating network-on-chip interconnect bus performance
found on SDM845-based platforms.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..b3cd256a154e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1324,6 +1324,11 @@
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
 			};
+
+			rsc_hlos: interconnect {
+				compatible = "qcom,sdm845-rsc-hlos";
+				#interconnect-cells = <1>;
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
