Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8F389C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4312D208D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D+ynAtcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4312D208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935377AbeFMQyg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:54:36 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32923 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935256AbeFMQyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:54:32 -0400
Received: by mail-pg0-f68.google.com with SMTP id e11-v6so1564604pgq.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jSLBqRxT+ZFcOg9lk1He7s8WA0TWh42RAgdSH1Pt4XU=;
        b=D+ynAtcJbCul9HZk5I/g4M9qAgxhai1Xx+S66g/b05yQfnN8B2wlKkdzcp6ccajsHS
         ++IxJVFAvnfoF9Ah0X1qXDdOC+pUVlgKgGp9wi9OteHuCDMzhQl7B+9WYoLp31kkPB1z
         6S5EYwPngDN/Ioih04aSKdSrcoj819+BSzM04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jSLBqRxT+ZFcOg9lk1He7s8WA0TWh42RAgdSH1Pt4XU=;
        b=sk3943LpCbtbAY5G7q0IGBWwXGlPlHTBaGX1VQMuukX6gYnxpCKM4q8ng5TFQJknyL
         WaI1BQenFE2knpq9RvPTaKc1T6+EYlLvfy2493XbpRa0VG42jkQPgRuR7JnJX1+MUmUC
         fGs1BiMNKC9cZkcPLXp9f5zs3hpyr83XzDCZq03u+Lyj2a1+3bHn8DjcK0Rftdoum6XM
         6i7AXpMbqBZAwGkPFpJRgv+K57ow11W61AYWQZMUFUH+MvXp1lfyGdhJlSM8cq/wgLiP
         aWH3L0EcgLJ/ECvW8clE3vTR2lE1u1/8qzHA2SLZ+BuRdOtLTrxw76Y16bvIvosFS7E6
         M0Tw==
X-Gm-Message-State: APt69E0cBVQbapBCX3MU/WUvKcBlNa6sQWRP7IdYjwDz/lOOQkPxy4YS
        SUxM9uxBkKgypxkIV6M7flv6gg==
X-Google-Smtp-Source: ADUXVKLeziVQPOOTEXL7LgOOffOvnkYbLtGdSPC5Ep5zvU7PcTz5R2H0WUWjS+edw8HwpO5ACRNB7w==
X-Received: by 2002:a62:6941:: with SMTP id e62-v6mr5734873pfc.56.1528908871552;
        Wed, 13 Jun 2018 09:54:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id x72-v6sm6903237pff.176.2018.06.13.09.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 09:54:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     andy.gross@linaro.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        kramasub@codeaurora.org, sdharia@codeaurora.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: dts: qcom: sdm845: Enable debug UART and I2C10 on sdm845-mtp
Date:   Wed, 13 Jun 2018 09:53:52 -0700
Message-Id: <20180613165352.139060-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180613165352.139060-1-dianders@chromium.org>
References: <20180613165352.139060-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug UART is very useful to have.  I2C10 is enabled as an example
of a I2C port we can talk on for now.  Eventually we'll want to put
peripherals under it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes in v2:
- Got rid of all sleep pinctrl states for now
- Add Bjorn's tags.

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 45 +++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 979ab49913f1..6d651f314193 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -12,4 +12,49 @@
 / {
 	model = "Qualcomm Technologies, Inc. SDM845 MTP";
 	compatible = "qcom,sdm845-mtp";
+
+	aliases {
+		serial0 = &uart9;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	clock-frequency = <400000>;
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&uart9 {
+	status = "okay";
+};
+
+/* PINCTRL - additions to nodes defined in sdm845.dtsi */
+
+&qup_i2c10_default {
+	pinconf {
+		pins = "gpio55", "gpio56";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&qup_uart9_default {
+	pinconf-tx {
+		pins = "gpio4";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pinconf-rx {
+		pins = "gpio5";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
-- 
2.18.0.rc1.244.gcf134e6275-goog

