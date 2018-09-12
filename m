Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2651C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7DD20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSmf9G95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7DD20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeILO6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:58:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34257 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbeILO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:58:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so1278491eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DdplkWwuGrY04uo9ngGJyb9h118OGPlbF94r8PIE8s4=;
        b=CSmf9G958OeJacKZorMKFy+xTfe9oydbq9gNkUDPxEal8PbfyZIbPdS+kRrsaO6L9W
         hcgNfWG/KSkLOnbaAFEc3WEOCU6mew8ReFBr/J3Kz1VTe+N0GC1aAGrT7G9KJZNzg5GU
         rUTG8WJqrzg4xmXK3CpXlTfHE+FGN121H87gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DdplkWwuGrY04uo9ngGJyb9h118OGPlbF94r8PIE8s4=;
        b=rZXhd9a1bIeKsYfxC6vcStGPOVFhz7BNg/KUeKdYM0ywr2js+7cn7VT9aUKLfzQ3S/
         D/yLeo/SCl4jam7bv9Dl/OiN/7S0YoRipVctDMTiSHqOhFKijjbUnDgSOssVCEOraCmq
         QiBsI9hf4rth3bChhAUMIs2iXISOw+qkNdhfltIS1rSFa27eoLcWdZ4XUBIoIO3fOWTC
         swvi8dC4WfADtUmGF0OVZZG6u14i9F+ZHbL5LcwI86Gx8lzcnriI70jPXy7hr4HZO2W+
         c32144JIxXA3zowLGEZQARUuydpoMLwt6ioAfH1fkXI75Bgrx3yqfVFHE718g8/ZbV1Q
         iICA==
X-Gm-Message-State: APzg51Axu8eb4B7cXFAWEjHgIQE9Rx1M3U889bXeDz15cOCH+WwMMrkp
        RYk9mmFRxfqQXoAgaF4Tw1KA15Xkqro=
X-Google-Smtp-Source: ANB0VdagNhtzaArQP+gJ5GfkrvlvRDseU+j+MabekSXNLCYpOfgwcscgx46d+c8RanIZVNRaLTiHeg==
X-Received: by 2002:a50:de8e:: with SMTP id c14-v6mr1757958edl.196.1536746073097;
        Wed, 12 Sep 2018 02:54:33 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id a19-v6sm482112edd.69.2018.09.12.02.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:54:32 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 10/16] arm64: dts: msm8916: thermal: split address space into two
Date:   Wed, 12 Sep 2018 15:22:55 +0530
Message-Id: <226a3b61f23f27d54b4dad390d6796b429fad837.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've earlier added support to split the register address space into TM
and SROT regions. Split up the regmap address space into two for msm8916
that has a similar register layout.

Since tsens-common.c/init_common() currently only registers one address
space, the order is important (TM before SROT).  This is OK since the
code doesn't really use the SROT functionality yet.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7b32b8990d62..6a277fce3333 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -761,9 +761,10 @@
 			};
 		};
 
-		tsens: thermal-sensor@4a8000 {
+		tsens: thermal-sensor@4a9000 {
 			compatible = "qcom,msm8916-tsens";
-			reg = <0x4a8000 0x2000>;
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
 			nvmem-cell-names = "calib", "calib_sel";
 			#thermal-sensor-cells = <1>;
-- 
2.17.1

