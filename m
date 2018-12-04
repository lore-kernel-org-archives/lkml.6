Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3F4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA78206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ed92oC8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA78206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLDWne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:43:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42696 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbeLDWnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:43:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so8032872pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xlMXzrv29FE6wYW2xJyRjVPKQcP2QW3ahzcQIOcRU8=;
        b=Ed92oC8awKbmBQwnsTyr6PZlqONLnMoCUeV8Y/twwwLuUA2q9f6gVvNv0/CDx2ApDb
         C5ZOj+8g16kbx1pGbEeKfHyh5mo/m46C2C7EXJbLG85rPt2HNsLXF4mssUxsNEPY9Oso
         Rm+3sK01nQcRRtsBkc4G9qrlsTqqbJsiSzjsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xlMXzrv29FE6wYW2xJyRjVPKQcP2QW3ahzcQIOcRU8=;
        b=kVtlufalWFXObXa2pqnJJS7mtgK4gJ9gEmKL7I9tnZhkC395pEdP2GTEZvKqp/tWlR
         gYRZaSH/dHKyoxy0HkHgmXFq0iCHn+zBOQBwUCdtQVLP1j+E3zhRXFI2Xb9V5vDZIGwU
         meAn/eDe4hC+rbkMhBe+ZRZ+xrjFdAXi3RBOKMna6zJ1bsOSSSZEZY6j1VEXUMf6bSaf
         GqNbQStt2QQBe0Wc7Pae6q8QCmHs3t7F7Qi/Xl0fFMP9Q9uQpkP5ERVEgffb8GjNcEde
         RZXigTYX95qZqCZ4lPnKgDR8W2s46pdGaYAjT5fQE0pq0Jo2bsR2VB1pBR5MtdwMIv8B
         qtYg==
X-Gm-Message-State: AA+aEWYPlXWCNmS/YWzfHcQTHIX5va2cdvTSxZppVg/aohxrn+jkw/Mg
        W1gtz6nf+TRdGIAIsUKvWoz0nw==
X-Google-Smtp-Source: AFSGD/V4mVYKBTVAoE4I3HurCb/iZSPJvWvlXBNYW7ijRWkLh+Slh84+kBetMqIO2RhMxQ2YxDpn7Q==
X-Received: by 2002:a62:5793:: with SMTP id i19mr22153955pfj.49.1543963402277;
        Tue, 04 Dec 2018 14:43:22 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y184sm21961917pgd.71.2018.12.04.14.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:43:21 -0800 (PST)
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
Subject: [PATCH v4 8/8] ARM: dts: qcom-apq8064: Set 'xo_board' as ref clock of the DSI PHY
Date:   Tue,  4 Dec 2018 14:42:34 -0800
Message-Id: <20181204224234.62619-9-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204224234.62619-1-mka@chromium.org>
References: <20181204224234.62619-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'xo_board' as ref clock for the DSI PHY, it was previously
hardcoded in the PLL 'driver' for the 28nm 8960 PHY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in v4:
- added 'Reviewed-by: Stephen Boyd <swboyd@chromium.org>' tag

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

