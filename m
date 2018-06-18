Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920C5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4868720693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Og3hbALU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4868720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936996AbeFRVv2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:51:28 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37159 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936935AbeFRVvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:51:25 -0400
Received: by mail-pg0-f67.google.com with SMTP id r21-v6so8143079pgv.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cKnQJ2FS57kjM+GVRuXrjmLAI9XYxzJ4PH1B6CALx9g=;
        b=Og3hbALULJ0x7J+oYqilVbYx8RMH5ASWdYp/XwnihSy4TOnpFluWs1qjLjrF8K2BBH
         4/Cb6qWOC+cKAbkJXTPAxx4NiaDNy4mYepLHF1Sy6ThEPRbJMSMuln4GfITpa0nNbH4f
         5BqMLffSjDMc90nsyXNeEqRAzbETjrtFVYYSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cKnQJ2FS57kjM+GVRuXrjmLAI9XYxzJ4PH1B6CALx9g=;
        b=DMfIssI/XjeJofzqQez24AbZ4EHgcbZve1JR0dW/f/8MGkXX0S7ttWEi1Q3ytBb2dk
         xA3rddKK9cUOXPn7dRKS+YogOPGNY470+hJCcy5wZFfZsS2OjyoWOHuSPaVEtQT2S2dl
         wcHxZv6qh53lRS+Rig5vlgF6hpnq4C11q9WpyxFvaYx8hReNA0j+w/HtYSwVmnnYOGo+
         Z5YN+pBJecGkHTsAk4mY0eU+LjO4PgN+4/nKs7xvhqRSxEuQVj4IXJwSiHLAVIGTWaxE
         cfNSfSm3GTyZitF4DYbxjPKxKuNPpTTTTlGsTwZaPBF5izx0niyHQHIPKJIXtWnYjYJH
         wPHw==
X-Gm-Message-State: APt69E0DeDFbitkOqvbtUNacvh0RTnxXmQzVeaaFopZWqas2EYLRwn2F
        G5qieevOSIIdm7h/KGiebORHWQ==
X-Google-Smtp-Source: ADUXVKLoPO9GdW0mOYBSwTacnuNKDlpvwGH0jH42Y8tv+7qusbmkoDyGvFI5s3EkWMEypegcykD2HQ==
X-Received: by 2002:a62:ba13:: with SMTP id k19-v6mr15200355pff.245.1529358684652;
        Mon, 18 Jun 2018 14:51:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id l8-v6sm29433880pfb.102.2018.06.18.14.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 14:51:23 -0700 (PDT)
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
Subject: [PATCH v2 1/2] arm64: dts: sdm845: Add rpmh-rsc node
Date:   Mon, 18 Jun 2018 14:50:50 -0700
Message-Id: <20180618215051.156270-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the rpmh-rsc node to sdm845 based on the examples in the
bindings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Fixed ordering of tcs-config as per Lina.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cd308b84bed7..43a182fb42c9 100644
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
+			qcom,tcs-config = <ACTIVE_TCS  2>,
+					  <SLEEP_TCS   3>,
+					  <WAKE_TCS    3>,
+					  <CONTROL_TCS 1>;
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			#address-cells = <1>;
-- 
2.18.0.rc1.244.gcf134e6275-goog

