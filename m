Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360A2C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0F3206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UIUHu2IW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0F3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeLDWn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:43:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33624 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeLDWnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:43:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so9024478plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POJkLmzf0EBbNO1Gqx1qcgLLyKEIpU4x8mfKX4r793g=;
        b=UIUHu2IWVaAICOuvbro6NFx/K3GrHa+yb+ATgKE5G9xQrh6QEKQcyDySNDMO5fGjx7
         gsytpYRX8nqmgCMO7CUxqjcjRO+Dhxl8xYcG790gADl52uIIGk2HyvAcVG+g4LEVzGR/
         7FAaKzR+KJXEnpWbremQAveblpPFPtjvlEtvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POJkLmzf0EBbNO1Gqx1qcgLLyKEIpU4x8mfKX4r793g=;
        b=fG9oyilTLcBAQtR4+Tx8QRS81hfP7vomoXvAj+2E6octIeDAR0ODrqRPxfqws8yROh
         eR4spxy44/mWB3uvTzNlqJrrvUrsDMnlHsQccEsN/Zko+Ffq2rKVqvisAxMxY9l79Vhb
         Nmp8ol9Dp+FO1/7XzVIKP/mfzaQnCQHG83Tb8tO0suAfdu/IXhYWe+KRJuTNyXvMzTah
         FxddeedPRPeAMcaP2eVlPtTIS1Y+yYFzhQ1RK2wZ+5xik5xe/S1Qm3Gv1xxR+QJS/L8v
         DrQVKPcOIhlKt5IO7hefaDheS6kBkkDL6YKQ6CUuyi4DMS3P/V5r62aSTcVC2FMe4Ps2
         9T4A==
X-Gm-Message-State: AA+aEWYMwcbJ+C5Ix0lE5zwh2GVyIHDACLRPqS2s29bfu5aasfLTEyQr
        UNmdwg5c4js4Y0khEfpwYp5aCw==
X-Google-Smtp-Source: AFSGD/UabchqrSCPH8owAoEj3OayuNubPveJ8EnJUqLe/e4/vPPqQasD1BfNncLFCWblSQ2m7wPUJQ==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2mr21802557plz.110.1543963399602;
        Tue, 04 Dec 2018 14:43:19 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y184sm21961917pgd.71.2018.12.04.14.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:43:19 -0800 (PST)
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
Subject: [PATCH v4 6/8] arm64: dts: qcom: msm8916: Set 'xo_board' as ref clock of the DSI PHY
Date:   Tue,  4 Dec 2018 14:42:32 -0800
Message-Id: <20181204224234.62619-7-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204224234.62619-1-mka@chromium.org>
References: <20181204224234.62619-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'xo_board' as ref clock for the DSI PHYs, it was previously
hardcoded in the PLL 'driver' for the 28nm PHY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in v4:
- added 'Reviewed-by: Stephen Boyd <swboyd@chromium.org>' tag

Changes in v3:
- added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag

Changes in v2:
- patch added to the series
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index d302d8d639a12..89f30f34ff896 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -959,8 +959,9 @@
 				#clock-cells = <1>;
 				#phy-cells = <0>;
 
-				clocks = <&gcc GCC_MDSS_AHB_CLK>;
-				clock-names = "iface";
+				clocks = <&gcc GCC_MDSS_AHB_CLK>,
+					 <&xo_board>;
+				clock-names = "iface", "ref";
 			};
 		};
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

