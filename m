Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2665CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F9B2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNDalaZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfA2XUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:20:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39596 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbfA2XUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:20:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so10438759pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vxzmMPjLjvfz3gQ6gxBd9ti+dw7Tx3zD0rmYAcFHZWM=;
        b=YNDalaZPR2PNrpWmfAX0dKAqSsW7xD4N8RUkGBqBvhe+/ZQqojSvtcJcrAcEBLklSq
         LygpS1OUGtQFj5lVkF9U4qAHPNG7mW8J+5HSFso1njwDtHQzRO3OdR1y332t9C/eBqdN
         HDX+3f6IBaqrbBU++vZ2ERInu8h/rrQtjNQOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vxzmMPjLjvfz3gQ6gxBd9ti+dw7Tx3zD0rmYAcFHZWM=;
        b=HpkUrS9kuM+bO5UUXBdRQU/BHAaK2vT5PAxi7kFkzSBTJCCOmFlL0pSUzukEP1ZB0s
         yZHnFK/79tq9XyCYQfKLvSgDfHWx5K1Is5lgb/eSNoYD6yo6MRySkVdhpSNcqfAJknhq
         ayKkaZ/9ZopW+cQqJXZnijHfigzL4bK33jkdl/IkceJVda+yNTVzXNPtBpvd0DESjU9A
         ZCyzVbTFbCJwDu2CbT5M7wAfkRJSkTA5zqv2QWuXGLZJ2GJgLTCOn+/j/7Wq03GPQB/V
         hLkgkLlysGTl59PUKjBkIt9PEHZAz0+MI7Drtugqmx2tfozY+hXEVkqyF8dz6odMqqju
         RUfw==
X-Gm-Message-State: AJcUukcWOya/nogxxJ/03S5ADa049piZ6wwJcB8Lg6pKen1EgFWZHT4v
        Z9H9QKeZmfZ2/7Ek0Jd3dQ83Qw==
X-Google-Smtp-Source: ALg8bN55pIB7NtKEaUmZb2PMbsiKicwbToaV1fe5ENTQiyG+UVuQgEHSCUbCZByxRvXOtNZdO43WAw==
X-Received: by 2002:a63:a002:: with SMTP id r2mr25119305pge.212.1548804040970;
        Tue, 29 Jan 2019 15:20:40 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v70sm51182779pfa.152.2019.01.29.15.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:20:40 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 09/10] arm64: dts: qcom: Add AOSS QMP node
Date:   Tue, 29 Jan 2019 15:20:08 -0800
Message-Id: <20190129232009.5033-10-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190129232009.5033-1-bjorn.andersson@linaro.org>
References: <20190129232009.5033-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP provides a number of power domains, used for QDSS and
PIL, add the node for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d193f85e5835..24c30be974bf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/interconnect/qcom,sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
+#include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
@@ -2081,6 +2082,15 @@
 			#reset-cells = <1>;
 		};
 
+		aoss_qmp: qmp@c300000 {
+			compatible = "qcom,sdm845-aoss-qmp";
+			reg = <0 0x0c300000 0 0x100000>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&apss_shared 0>;
+
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c440000 0 0x1100>,
-- 
2.18.0

