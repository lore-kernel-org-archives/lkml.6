Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66410C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C41820673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DJcxkDcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C41820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeLAMEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:04:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42311 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeLAMEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:04:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so3593051pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HOtbCRNtEJv+CkEKZnSbEou+cNOE2l3Xvsy9ozDZFL0=;
        b=DJcxkDczA+pUB2+99vUBdnlYP/xoaCz9WwzaK7Yuy6mosbjalaRQnnPytfBPMbWPpT
         OkinmFXlGPn6lgRBg1K7LRA+kax5xuOFzGJOUYWMhHd+dOcdmmspBeMucHjfbvs7RuFR
         zd2hXXRVezh+0fz4S/E3TJpkSrMjQBSdTB6uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HOtbCRNtEJv+CkEKZnSbEou+cNOE2l3Xvsy9ozDZFL0=;
        b=Z0fd24jwsIpX16yEMLniQmFvSqUe7pXrKivAyQrlEYUUEmw0swG4aYqgiyVL0OnCVk
         mHL9SVppG8777KnjKhn5FmK9jqZPVGC4OclCmHPLhQwMcXTGO+ZLDEMMYEbKQXOV2BAu
         lQ+B7Ps9AGFh/jO1CsZ2Nh4VCRRuBkhSHsuyT0Zt1lTJqUgesoL2/mdNBRPdvWCJLkj5
         MWXTuCGbqx5TKvJXu+vdIhwT0iokp+EJqcPf+y5Aolsd8lPO6xA3kYnxAmDHEMwMZLHc
         KyZ8EJ49uCMEAG38FSpBAzfsI9TD2mGpuHq4UGVGMDaklDCr8hrizD3bVm98X4U3nAZ9
         yUGw==
X-Gm-Message-State: AA+aEWYsDXmRuHD446q+nzlcIxAXAg/S83V/hjXyKTvdM38MN3XieDFm
        70uprdoWD2jPxn/OGVNSh42KzQ==
X-Google-Smtp-Source: AFSGD/UFcEBtIhMQVEC6k2F+FwHoRgAzwLXNBFWplJNxIbq25v5VlOXRsnFzybqcAcAol+yhzauyeA==
X-Received: by 2002:a62:9419:: with SMTP id m25mr8035769pfe.147.1543625613340;
        Fri, 30 Nov 2018 16:53:33 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z8sm16518566pgz.53.2018.11.30.16.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:53:32 -0800 (PST)
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
Subject: [PATCH v3 8/8] ARM: dts: qcom-apq8064: Set 'xo_board' as ref clock of the DSI PHY
Date:   Fri, 30 Nov 2018 16:52:54 -0800
Message-Id: <20181201005254.139908-9-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181201005254.139908-1-mka@chromium.org>
References: <20181201005254.139908-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'xo_board' as ref clock for the DSI PHY, it was previously
hardcoded in the PLL 'driver' for the 28nm 8960 PHY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- patch added to the series
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 48c3cf4276101..d337ae9326cd8 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1338,8 +1338,9 @@
 				<0x04700300 0x200>,
 				<0x04700500 0x5c>;
 			reg-names = "dsi_pll", "dsi_phy", "dsi_phy_regulator";
-			clock-names = "iface_clk";
-			clocks = <&mmcc DSI_M_AHB_CLK>;
+			clock-names = "iface_clk", "ref";
+			clocks = <&mmcc DSI_M_AHB_CLK>,
+				 <&xo_board>;
 		};
 
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

