Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28A7C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D6620836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ekko/zFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D6620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936954AbeFRU4w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:56:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41902 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935937AbeFRU4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:56:49 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so8170136ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Sl3vfp9MwUw3VPUIHW1sx95xFUiRxfmcRWmzKaDKZQ=;
        b=ekko/zFJiV0890mx9xYG5EQOXAcrW+T0dDF7nUSwXh0hF4rkovzixyuz6d1OTxvVu7
         amDrLuziA4iTZ5VWtCuSPTCNu3oWL1F90osNWNvaHz0Kszgvlt1kcjaPrTnIN/r6hJTW
         NC9+43IqrlGWwLMA2TANn6pwqpM1F6BNHP2Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Sl3vfp9MwUw3VPUIHW1sx95xFUiRxfmcRWmzKaDKZQ=;
        b=scnE+eMLGZ8ggwFx2UQ6oHUi9gnXaj09xvt1ETZnBmHNvGtMX3Syyw8vnUJV58f34b
         8dk7Ev6NK5ieOQeA3APJnpLdawvOQmohwpbkUEciOMx6QGz6xwieaP8AtljEYlGdUnIB
         w5bzbKCApc4ePz81/9ZmVbUcY2mI6kGX2aMRoMd6DKVlEODqoCfrlZxHFFUPvN2Q7mJv
         32QjIc+OBC35XawyeZdDDqsmceM5mMbeqTZrzzVckNKx/SbQJVhqgOfJeKkpSRRaCY60
         yTNDQKaaeGC1oPDmiDr1KtPQEibvmX0J0eCfsNzoDFnF3MBbmPMUKeZehqzFneAJF5GM
         vVig==
X-Gm-Message-State: APt69E3QI0PHIm+jR3KK/NvMuCzNwyW7dTzUmnFLVtFvTLgbC5SlZ7TL
        67LF1NGgTC05RsR17FkliF/ySw==
X-Google-Smtp-Source: ADUXVKLhBwWvuXLTdWX0f4qyORNabfYlzMjNbzH7Sfhyrd7SBJagmN3s3LZ7CdZEg5OBBdWxOXySOg==
X-Received: by 2002:a17:902:74cc:: with SMTP id f12-v6mr15827323plt.7.1529355408777;
        Mon, 18 Jun 2018 13:56:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id n70-v6sm34167955pfh.140.2018.06.18.13.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 13:56:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     andy.gross@linaro.org
Cc:     sboyd@kernel.org, tdas@codeaurora.org, rplsssn@codeaurora.org,
        ilina@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm64: dts: sdm845: Add rpmh-clk node
Date:   Mon, 18 Jun 2018 13:56:16 -0700
Message-Id: <20180618205616.102750-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618205616.102750-1-dianders@chromium.org>
References: <20180618205616.102750-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the rpmh-clk node to sdm845 based on the examples in the
bindings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
NOTE: to apply this patch cleanly, apply it atop:
  arm64: dts: qcom: sdm845: Add I2C, SPI, and UART9 nodes
  https://patchwork.kernel.org/patch/10462691/

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 19b006293d3b..c61ae815a697 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -1001,6 +1002,11 @@
 					  <WAKE_TCS    3>,
 					  <ACTIVE_TCS  2>,
 					  <CONTROL_TCS 1>;
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,sdm845-rpmh-clk";
+				#clock-cells = <1>;
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
-- 
2.18.0.rc1.244.gcf134e6275-goog

