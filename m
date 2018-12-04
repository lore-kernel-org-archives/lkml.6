Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5514AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1690020834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMrB4wJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1690020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeLDWnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:43:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46764 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeLDWnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:43:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so9001150ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtC4xh0YudUWNmEFYuiZfd5wdAxs/J24hFS3Wv40Coo=;
        b=YMrB4wJUQ0cWgG9BLs5zGqAI2FGoVJfz0/FThi7YG1rjtd+rngQsOK8dEX/GY5YnPu
         Tac+Uwmiu10BeSAWww77aWL6gVX4qDaGFzxTVUyZOGWT10WN90RUcg8TmcRUxwAGtL/t
         V8c1jM6rDbMeu5PopJRLRbusefl6Caq9fUMLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtC4xh0YudUWNmEFYuiZfd5wdAxs/J24hFS3Wv40Coo=;
        b=hmsoZjcZMjGxe+iMREzaUbTVipc/0OdV4xE4HbaRST0lx7XADjcsTxvoIompkkGgdG
         5XOdti0rkXgfsltbcXsqpB9JxC68yX2azjrIKyQy/r8prYsPbCBMKU0MnVhBDB0yzZmz
         FB83kCm8OXbF6l2A5Haov/85fPEJVvTr0/96xQPUJU39GeAENbjTqpLzx71gEL7KVBrI
         6SghhDTvz/20Ff3DglRvw47+VDRynvNJqIUgdPXYjv1gq/6rXXuani7Oi2Xhgk1Ty48N
         gTUfac3x5pMqkQRUA/6DxNOyMNL6EnwDAJehHY/0QlPyr5/IyMPNGB+g5zEGPFIaBJsR
         UpOw==
X-Gm-Message-State: AA+aEWZKgrV7Fctj4lwAD4MFGbEJWI3YxkoHBXFYO5PPHO7niEby+L+v
        5CNrr/0j76RzMIiSTe9BK/pX7O8lxd8=
X-Google-Smtp-Source: AFSGD/U/ckSKO+8y+PgQxUCVYNJqsNuZbNNaj21jEgyLD7O/iX4D+1QMKvEotgi8nLVRyteaENSv/A==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr20960735pla.47.1543963400830;
        Tue, 04 Dec 2018 14:43:20 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y184sm21961917pgd.71.2018.12.04.14.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:43:20 -0800 (PST)
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
Subject: [PATCH v4 7/8] arm64: dts: sdm845: Set 'bi_tcxo' as ref clock of the DSI PHYs
Date:   Tue,  4 Dec 2018 14:42:33 -0800
Message-Id: <20181204224234.62619-8-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204224234.62619-1-mka@chromium.org>
References: <20181204224234.62619-1-mka@chromium.org>
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
based on "[v4,1/3] arm64: dts: qcom: sdm845: Add dpu to sdm845 dts file"
  (https://patchwork.kernel.org/patch/10666253/)

Changes in v4:
- added 'Reviewed-by: Stephen Boyd <swboyd@chromium.org>' tag

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

