Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FDDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9C42081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kz/EvwqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9C42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbeK2GAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:00:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39498 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbeK2GAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:00:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so9905355pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 10:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o4JaW6KsachO2boGyRKX4iE75v/yjSYr68O1hs1YRx4=;
        b=kz/EvwqWHWxqYmUARzxdAL/Zs9HlCxG5QK2h/ULQilFoJmpzYwA3b5cGFmLgGFyvd6
         2VPNJnNgVEo9Oe31ixOV/2iXH7g4rOsWcpZ0F0IQ8fIJlCEORl6C78ynciqH28T5dqlc
         RJ0aYnlG1RmTIDtEdGdsSbCHKn9OC9I5lwAfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4JaW6KsachO2boGyRKX4iE75v/yjSYr68O1hs1YRx4=;
        b=R20s4jkRZ7Tm0Ua/LQnCW1a/4gANdYPBJGBWKea7KkTXUl/hyv25FLjWhuYvvLufXz
         8YNJTRew7k2WSgGaurTQuCYs7K6nXXKl/aZl5X+Vy8gLHfAEUnEde1jQ+2gb0gXMta9K
         +8Lei1Y3k+udDA37brd6XbtiIjvoWBjobgN660HvwMBLbSDOV48VAszGpbLsOnPtG/Sf
         mrUZyRlM8DIVHGR0arTpHyRvdzcLN5Svs0oZoZwikSfvZQaJ0SJ3a2DEU9DC/5zrUVor
         oqabJvOauLJ18PYjN7V/jhalrvdMbrmodBd7dztxQmFYjgz7D73WVH9QiX5yFzAdG6FS
         7e2Q==
X-Gm-Message-State: AA+aEWa3TIxJ1aFHGsJxqayOiJORGovuSi7JPaoVrB+4LqnumpyMLb9O
        QgHvAFLgIWCpu4AEF+yBWMRTWg==
X-Google-Smtp-Source: AFSGD/X2AsbMXlXlHpwT3l8HhNJE2uZi9sUs5TQgj6X7n4Vhsorv8VVNv+PML7tNhSFN2fa+wjcv2g==
X-Received: by 2002:a62:c505:: with SMTP id j5mr2651863pfg.149.1543431485440;
        Wed, 28 Nov 2018 10:58:05 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id f6sm13204214pfg.188.2018.11.28.10.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 10:58:04 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: sdm845: Add gpu clock controller node
Date:   Wed, 28 Nov 2018 10:57:43 -0800
Message-Id: <20181128185743.75328-2-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128185743.75328-1-dianders@chromium.org>
References: <20181128185743.75328-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the GPU clock controller nodes as per the example.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1419b0098cb3..300688e92439 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
@@ -1078,6 +1079,16 @@
 			};
 		};
 
+		gpucc: clock-controller@5090000 {
+			compatible = "qcom,sdm845-gpucc";
+			reg = <0x5090000 0x9000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+		};
+
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sdm845-qusb2-phy";
 			reg = <0x88e2000 0x400>;
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

