Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D062C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE4E20693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n5uIuTjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE4E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936928AbeFRU4u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:56:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46122 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935789AbeFRU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:56:47 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so9666774pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TAhZkM8g10id+k7jla75V5bMEwKuvB7ErPxv6Sfq2h8=;
        b=n5uIuTjXS+XP1KwTWz8+9wzxzK5pBMVheJ3bech56Lzp7sfxA9rkSQz8K+MCJMIc+Q
         lEkxQybSg52sKVLOe6uGY9HVLaDKXQXzTN4XEEhIGLm7mxSrSJRZHYg/OfgAvSlfbjWN
         S5Qqo+mhE8R6j/wxuKdVXpus7dSL0Ae4aKOe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TAhZkM8g10id+k7jla75V5bMEwKuvB7ErPxv6Sfq2h8=;
        b=I0geLkoZni5TJvMX8VkAZwNlXSRNxHBiwUtpctq6ZL6MIih+S98KqR5Kc2FaaMbywJ
         4I5J6/HIhdl2znuNT5qKz9IcBRZ5AUueYjRLcCwU8wQjWZbLF+DCRInWI1vfWmepAbER
         4ZDtCcjakpd8euxsCs0rwJzUnq2aqKD0GjU66G22UxGv7Oh1lZpVGxHT7qJguhc9pIje
         VOpI9zWI//ydY9whptxDvNuOod+MQeOUjjrDoeEGf6rIwvTC5Rh5sAcPXNlD+aaO7XS9
         SJlZL4AHG7B05s3RyX92IJaRrJDJZLc/3weHQuBe9xox3nYOwsa/W4YVccPhGY2YlK0l
         Jg8w==
X-Gm-Message-State: APt69E0UTmJ0k7X2LzW5HhfaYiBfnC5EGz97wP15nPcx0keeKASgQEPc
        y7fwEbwhzhga4hsTAPnpYV7odw==
X-Google-Smtp-Source: ADUXVKKciT3KJnX2wBMhvIv6J9r19HKZxZGvbDaDbN4ubeKEUACaVpJN6p8x0XERYSieXqjhkYSJdg==
X-Received: by 2002:a17:902:205:: with SMTP id 5-v6mr15532806plc.301.1529355407383;
        Mon, 18 Jun 2018 13:56:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id n70-v6sm34167955pfh.140.2018.06.18.13.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 13:56:46 -0700 (PDT)
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
Subject: [PATCH 1/2] arm64: dts: sdm845: Add rpmh-rsc node
Date:   Mon, 18 Jun 2018 13:56:15 -0700
Message-Id: <20180618205616.102750-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the rpmh-rsc node to sdm845 based on the examples in the
bindings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cd308b84bed7..19b006293d3b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -984,6 +985,24 @@
 			#mbox-cells = <1>;
 		};
 
+		apps_rsc: rsc@179c0000 {
+			label = "apps_rsc";
+			compatible = "qcom,rpmh-rsc";
+			reg = <0x179c0000 0x10000>,
+			      <0x179d0000 0x10000>,
+			      <0x179e0000 0x10000>;
+			reg-names = "drv-0", "drv-1", "drv-2";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <SLEEP_TCS   3>,
+					  <WAKE_TCS    3>,
+					  <ACTIVE_TCS  2>,
+					  <CONTROL_TCS 1>;
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			#address-cells = <1>;
-- 
2.18.0.rc1.244.gcf134e6275-goog

