Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0162C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DEC2145D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hhP5BAw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DEC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeLAMEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:04:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38085 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeLAMEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:04:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so3592788plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DloFiMteLjLHfxEkqAo7uWEc5+Pr5GKUVqhPyBTZvlM=;
        b=hhP5BAw1MnFqSdIDqz6FXTrFKfrM4VR2JYzSjZNmZvEvAZuZ4vaJ2TNfMJWAn5u+yd
         yeO/82B2gV/LT5ZgLWvYuQd+hpPIMtySnbmrDguiAqTWgc1wcq8A+8OxYGUIeyAh57eI
         wMNeb8biAKxF29v07D29Uy8NRUThf29FVDupk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DloFiMteLjLHfxEkqAo7uWEc5+Pr5GKUVqhPyBTZvlM=;
        b=ECCbI9i0BXPYmc0aFoKlgbYenZdkHr4UAOjHSfUuON0yzgHZ4E5Be48Q/2dFxqY/Kg
         4ZzUC3zQETZQ5MRn5Bd9i4eYt7Nkdv6ZPc86qn6zI5N2nSDdXpu5DvXCPBz5wx54OTWI
         QGXBqUYetXRGVd7o9oP4SqE5XSM3drHabZHkqzZPxc8smf7wrQrqrSFBpQT2kJ7wDuvS
         sMz2dkGX5CK0bg90ojgwIFGQOxLzBulmHGljMSOpsJqMXxAjMqQyGdeOx64Gtu8kP55+
         yWq8wM6q8vjrim6EoDfNXsLe9rgVKemVbhVMHM3NqnvmPvvvUQ9ZIC6rRtMZhl4BSDy+
         g5dA==
X-Gm-Message-State: AA+aEWadNK1GoUKtmY5wriwzv+KOfTntSLGWB7vXyZCdRGFhoZU7fVLw
        sTlW4DBAIAPnSc9BJzk/K6TpTg==
X-Google-Smtp-Source: AFSGD/XJuCi6B6MFtqfOS99Rn7yzOIegpsaXxL6TZ6fcmukGUpskRIWVVsr6CzvbVGFU6r9KHQCrwA==
X-Received: by 2002:a17:902:66e6:: with SMTP id e93mr7524936plk.92.1543625611218;
        Fri, 30 Nov 2018 16:53:31 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z8sm16518566pgz.53.2018.11.30.16.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:53:30 -0800 (PST)
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
Subject: [PATCH v3 6/8] arm64: dts: qcom: msm8916: Set 'xo_board' as ref clock of the DSI PHY
Date:   Fri, 30 Nov 2018 16:52:52 -0800
Message-Id: <20181201005254.139908-7-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181201005254.139908-1-mka@chromium.org>
References: <20181201005254.139908-1-mka@chromium.org>
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
---
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

