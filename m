Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B862CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCBC208A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="svwt050l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCBC208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeKITYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeKITYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:24:51 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01FA6208E3;
        Fri,  9 Nov 2018 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541756704;
        bh=Zd8PV7kk+UNbU2udL9bffX4RclBdeswcwmlojPfvOOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svwt050lLbX659yUjjNirr7t6+Lg7sXr7txFz5OFf46j3cI2qzVYRymlVzA/WdMLx
         d2DyDDzU64TmSNf2IbccWGJqq9cL5C75TgaQVn9YA++ayzHjT5XBfAxfdGndjP78yq
         B5+6yFiX3nOB1uqdY3VHqKXDCQTsyRq8GWV8oSjY=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 04/18] arm64: dts: qcom: qcs404: Add RPM GLINK related nodes
Date:   Fri,  9 Nov 2018 15:14:03 +0530
Message-Id: <20181109094417.12109-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add RPM GLINK node and the RPM message ram, hwspinlock, APCS apps global
and smem nodes it depends on.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index d40f3923ed69..6bc0925acda9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -114,12 +114,45 @@
 		};
 	};
 
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
+
+		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		mboxes = <&apcs_glb 0>;
+
+		rpm_requests: glink-channel {
+			compatible = "qcom,rpm-qcs404";
+			qcom,glink-channels = "rpm_requests";
+		};
+	};
+
+	smem {
+		compatible = "qcom,smem";
+
+		memory-region = <&smem_region>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
+	tcsr_mutex: hwlock {
+		compatible = "qcom,tcsr-mutex";
+		syscon = <&tcsr_mutex_regs 0 0x1000>;
+		#hwlock-cells = <1>;
+	};
+
 	soc: soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
+		rpm_msg_ram: memory@60000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x00060000 0x6000>;
+		};
+
 		gcc: clock-controller@1800000 {
 			compatible = "qcom,gcc-qcs404";
 			reg = <0x01800000 0x80000>;
@@ -129,6 +162,11 @@
 			assigned-clock-rates = <19200000>;
 		};
 
+		tcsr_mutex_regs: syscon@1905000 {
+			compatible = "syscon";
+			reg = <0x01905000 0x20000>;
+		};
+
 		blsp1_uart2: serial@78b1000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078b1000 0x200>;
@@ -146,6 +184,12 @@
 			      <0x0b002000 0x1000>;
 		};
 
+		apcs_glb: mailbox@b011000 {
+			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
+			reg = <0x0b011000 0x1000>;
+			#mbox-cells = <1>;
+		};
+
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.14.4

