Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C79CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C98208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b7ZA1Uhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C98208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeK0KIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:08:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44455 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbeK0KIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:08:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id k8so3955952pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1pf3V00Gr7ZLwrYl3d/KGWwyDswWV71YWAdwIZFzf4=;
        b=b7ZA1UhrLUspcx6+VH57hpguHb+MNjSq+s/81v9ZKN542dal6G91R+giuZHJTMxdBt
         q8dFuFGNykwRdEr1IKzDnKru14Ci5QbE96WlLRLHisN7qFcIcE0ELBUTg5Z2dm4BuyL0
         4pIM5Q+om2Yb/EgJzMINJKaKEquOJafDekg/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1pf3V00Gr7ZLwrYl3d/KGWwyDswWV71YWAdwIZFzf4=;
        b=DtXVResusu2bj+2tFOnuSKUdtnofh0LYblnCh9T3UwGLYuwnZDOJg4W6K25w6p0Axk
         bqT0Irzs/FRN4KowuYMG48BbQ9Lu7hLH6CWNvJV4PhkZW1wWLfrIBmg3OSVWqrdD2d41
         29yNbpq7py/MgnOnTcsZH1SJCjMvDBvWut2qlSAVTQheblEgtCibSWT3ooleAxLTPjPH
         B2mMYh18UFv44T/55W9PRBtdHzYJtGUXbxat8OGmiAy8h0jQekhT2NvOjmmZyfKgezo8
         j14RJa12TGq+z6M7CHC3IwETltnmzp94f9RgCCv22+Li378v+D8xESzDjSL7ymTaNbU8
         Gajw==
X-Gm-Message-State: AA+aEWYXDuu8Q59yDSLZWWJ7bcTnJsbluUurqxNYepoYBJxMEqKrjsJV
        OzcKDUzr4YZY0P6VK20didrsow==
X-Google-Smtp-Source: AFSGD/U6U9ueX0jueBBybeMDGxBTZG8tBNMCbWOxd7woPVdKjPlETweJa1W5jAvaPzgb0w+XBzHz9g==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr5730536plo.205.1543273955258;
        Mon, 26 Nov 2018 15:12:35 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id j6sm2128625pfg.126.2018.11.26.15.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:12:34 -0800 (PST)
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
Subject: [PATCH v2 4/7] arm64: dts: qcom: msm8916: Set 'xo_board' as ref clock of the DSI PHY
Date:   Mon, 26 Nov 2018 15:11:56 -0800
Message-Id: <20181126231159.122298-5-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181126231159.122298-1-mka@chromium.org>
References: <20181126231159.122298-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'xo_board' as ref clock for the DSI PHYs, it was previously
hardcoded in the PLL 'driver' for the 28nm PHY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
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
2.20.0.rc0.387.gc7a69e6b6c-goog

