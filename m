Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02816C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B048C20693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GcnCbmrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B048C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937013AbeFRVv3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:51:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41248 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933942AbeFRVv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:51:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so8826777pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GgKH7KmSqiOGhuCEVJGFdHsPeq9lF9K2JNBhX4/OF2Q=;
        b=GcnCbmrBuEynqB85kckorHsC66srPLXzkEEyZboOC28R4c4x8fERFo1B8xuAyafOlU
         ayitVejnc19D7SneqwC0N8z0RrBTUpZsMOVD6Tp1hDRFsl928FGw3ntFbmGOoE86qD7p
         g/XzVDY2ytLHdG8O+bCCZ1GKn4Ef1U2rvkM0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GgKH7KmSqiOGhuCEVJGFdHsPeq9lF9K2JNBhX4/OF2Q=;
        b=YZ8piOd/NMM0eo4SZq5v8yF35s6FTXcs6mmnjW7Mp+d7mAyBdwlH5sYqzB2rmDrDjc
         a6QBNNkQ98qBXf6PZrDsBIrpH8frvce+Zl+0OOblYwAjjREF/uZvNtwAQnWaNKhCyL03
         b/H2fBi8UWiqHgpGAPh4+f/hy/8iww5cVhLPN3uPaAU6BbqjBYxH2A9vVsq9R+yfWObB
         V816NDHQthf9zgT7VkJt/wlO4F2lPsFqvl2QteeN873rfxo2PQkU3sy1fsU631Psa1xX
         EFpeBxCAmRZqdfjNbSun1DqYbpuN65kxR6Ib8kN+eXeXM16nMTP+UvjP7nrsI/3ffdYl
         Io0w==
X-Gm-Message-State: APt69E1rT25X6twvavyjuwOvv5aZDkxQpfPkFrig9Gz/Zey1VzrrdWBL
        O0spEgwB+DnDxeB7r7F0/+CGQw==
X-Google-Smtp-Source: ADUXVKKUOXWPNwctPWhMQSoJ2s4zzvKw7TZgkbLt0q3ILlKtShEOkhzbcL1fgJaA+a9X54Ei0qBKkg==
X-Received: by 2002:a62:5d83:: with SMTP id n3-v6mr15372911pfj.68.1529358686151;
        Mon, 18 Jun 2018 14:51:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id l8-v6sm29433880pfb.102.2018.06.18.14.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 14:51:25 -0700 (PDT)
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
Subject: [PATCH v2 2/2] arm64: dts: sdm845: Add rpmh-clk node
Date:   Mon, 18 Jun 2018 14:50:51 -0700
Message-Id: <20180618215051.156270-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618215051.156270-1-dianders@chromium.org>
References: <20180618215051.156270-1-dianders@chromium.org>
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

Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 43a182fb42c9..00722b533a92 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -1001,6 +1002,11 @@
 					  <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>,
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

