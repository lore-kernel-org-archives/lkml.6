Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06652C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB84F2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gL8Jp57H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfBFFOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:14:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35244 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfBFFNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:13:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so2583532plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mrkl5VM69wq7IZYdl1FKPkbga/hB//VCoDnZzElgaXE=;
        b=gL8Jp57HJpu47gYmCWJeW9k4OMF27ReiPmhs2wR98y8IXIzIzTVIN92UynHSBdNWcT
         uSjOquQ1g4F18QoXzqP6k0b2ZRWh9O8B9zgYMz2tkdfp31BT01IM0iXsrq5dUYrOlks3
         hbVAyEWiijjhwg27P97A5CAnwWYWkZJcXaeh+cGpoY2Zso98MVGgAifKoD53bMfJgjBH
         KrZPPyIxIbnecltS0+d7Tm++PwJm6igltgw/E1xi3zBNUJZwpNEGecMCmetxweTN6XQX
         yaPaWGJjH2azAhHryjUQCMICLkr3snC0/v/uzVCOW53AopdaG8TMtSAFCPVD5HscYu3s
         0hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mrkl5VM69wq7IZYdl1FKPkbga/hB//VCoDnZzElgaXE=;
        b=ZsYC8GMmd5mg90rleKW5pln+F0oFgiKo6C8chTGavAO+DuX+Z8zDYgvoO0O6Ujcd4t
         6m4yT+VqVqth5bA3kVJGKeAtM6SJ6F3EImRpD+UFCToXzHO6gJ76DgmbyRmtvPPyjBb9
         NCa9ErExl5nX3Kp1vpoZ0O3+JtuVbpyhkqIqliXsLN/vDR7jlLxn7opRgwtTvQPGBZA0
         s4TkD8EuWYylf9+AZFp4qoiHPoOJCeeIZGemMd1u92G4qboSDNpYH8Afq4EWjkvdPkkN
         g/2XqvbpzMzcDPnZ4i2CGVkNijTtgk+oMePC457FVXI3SLkf5sUM3H8W1+cygiJmOhsI
         1s4Q==
X-Gm-Message-State: AHQUAua1kwL+qLZ6Fw8NqDz1EPHbBZB9MH1hcaZtFCgNZSdjt6cAn93U
        RfdEg5BASw9V0OubI9TRk4PhTA==
X-Google-Smtp-Source: AHgI3IaLyrbCYAgzHOlzea4Jn+wtRVyVuuqLkEqrOZ8vQr9HboPsjAx68EKmpYStaQOMxM5fxNNUxQ==
X-Received: by 2002:a17:902:b114:: with SMTP id q20mr4387028plr.48.1549430032494;
        Tue, 05 Feb 2019 21:13:52 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y71sm10735012pfi.123.2019.02.05.21.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 21:13:51 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/8] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
Date:   Tue,  5 Feb 2019 21:13:35 -0800
Message-Id: <20190206051335.23799-9-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190206051335.23799-1-bjorn.andersson@linaro.org>
References: <20190206051335.23799-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v5:
- None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 58 ++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 560c16616ee6..5c41f6fe3e1b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1612,6 +1612,64 @@
 			};
 		};
 
+		mss_pil: remoteproc@4080000 {
+			compatible = "qcom,sdm845-mss-pil";
+			reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended =
+				<&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&gcc GCC_MSS_GPLL0_DIV_CLK_SRC>,
+				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+				 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
+				 <&gcc GCC_PRNG_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "bus", "mem", "gpll0_mss",
+				      "snoc_axi", "mnoc_axi", "prng", "xo";
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
+				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
+			reset-names = "mss_restart", "pdc_reset";
+
+			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_LS_MODEM>,
+					<&rpmhpd SDM845_CX>,
+					<&rpmhpd SDM845_MX>,
+					<&rpmhpd SDM845_MSS>;
+			power-domain-names = "load_state", "cx", "mx", "mss";
+
+			mba {
+				memory-region = <&mba_region>;
+			};
+
+			mpss {
+				memory-region = <&mpss_region>;
+			};
+
+			glink-edge {
+				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+				label = "modem";
+				qcom,remote-pid = <1>;
+				mboxes = <&apss_shared 12>;
+			};
+		};
+
 		gpucc: clock-controller@5090000 {
 			compatible = "qcom,sdm845-gpucc";
 			reg = <0 0x05090000 0 0x9000>;
-- 
2.18.0

