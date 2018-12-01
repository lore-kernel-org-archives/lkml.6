Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE180C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F03120673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q/xcXPh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F03120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeLAMEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:04:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41031 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeLAMEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:04:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so3597854pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qaxLMCAB1G+6SIVdyeMOaOPPp9x4osIUQ9Kn7JRFmZI=;
        b=Q/xcXPh7HtVRsRfF60tUsgTlaB/NySnb/oSio3et9JwmfMahaIpV2jefGW4OYfP036
         3Rmwj86AzagNMiC/P80DZnqYqtGEfKv5wWiijF5qIVeSVrZxMxfnaOa8OvMeJe18X+Gj
         gUW67Pddg+j4nEAMtGuOw277s6CLJHVaPvCc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qaxLMCAB1G+6SIVdyeMOaOPPp9x4osIUQ9Kn7JRFmZI=;
        b=Uy9xPADrisFAxuN3qAkYtNNlmrHEyf4octEFcgxv/Szs2t59A8U3IGfwjqfzd5LGRi
         oxCyMNOtb5VrvRtUwND+ZzEB7LvDw4osB4Uv4B7ePdcUrsj4BCz+vPE4odRQWap9um+B
         uwJgZq6glnN/aTO87TCrDXV4XGCP7NvFcJJPYGXan9CfBYJqJGJwjBo18hKk06/o5PVO
         W5Nadf9poiN0CRWgGUuSI16lOYRAh8W8xGkbEqP1wZy/6d1qVde0sis8tNRuCq76doJv
         vyNWhkEZXFgS8AdkMo0VdY00SN8mM/vEzRVhZIs2Pwi6KGvYQgtrg0s1Y660aTOGvwFL
         LTGw==
X-Gm-Message-State: AA+aEWZLZonDdhHAtQBVfFjWbYH7jkdY/I93nnVaOMoxK6zZnk0bZOmK
        Q2NK8c0SFlQHaBukSUMGRK8Msw==
X-Google-Smtp-Source: AFSGD/WiRSrQAqNF1UVr1P9XO3Qvv1iYVKYO7OPUUV20XeY34PK1I1nwuDc7XzDytoRb1vc+KJT96w==
X-Received: by 2002:a63:4d:: with SMTP id 74mr6717605pga.248.1543625612386;
        Fri, 30 Nov 2018 16:53:32 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z8sm16518566pgz.53.2018.11.30.16.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:53:31 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 7/8] arm64: dts: sdm845: Set 'bi_tcxo' as ref clock of the DSI PHYs
Date:   Fri, 30 Nov 2018 16:52:53 -0800
Message-Id: <20181201005254.139908-8-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181201005254.139908-1-mka@chromium.org>
References: <20181201005254.139908-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'bi_tcxo' as ref clock for the DSI PHYs, it was previously
hardcoded in the PLL 'driver' for the 10nm PHY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
based on "[v4,1/3] arm64: dts: qcom: sdm845: Add dpu to sdm845 dts file"
  (https://patchwork.kernel.org/patch/10666253/)

Changes in v3:
- added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag

Changes in v2:
- patch added to the series
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5728b4cfae269..cdb5a9bb23e69 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1372,8 +1372,9 @@
 				#clock-cells = <1>;
 				#phy-cells = <0>;
 
-				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>;
-				clock-names = "iface";
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface", "ref";
 			};
 
 			dsi1: dsi@ae96000 {
@@ -1434,8 +1435,9 @@
 				#clock-cells = <1>;
 				#phy-cells = <0>;
 
-				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>;
-				clock-names = "iface";
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface", "ref";
 			};
 		};
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

