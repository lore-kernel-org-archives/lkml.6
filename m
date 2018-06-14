Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E41D5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9985A208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNNqEQEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9985A208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935994AbeFNKog (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:44:36 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38715 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935675AbeFNKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:44:20 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so8670359lfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IdYsJPMEv4nuycJs7YJd5jalqQSPROp1IR5aOtwfvBY=;
        b=DNNqEQElx/o/FooOuj/KOGS343kpzBhxS//J1XqxLMibkMX3qzeC2TPfg3egF1pB4p
         7x46NgwySjceY/F5/i+5ABu1s+gxVo/UflwsLdK7qBb8e3Xe+q4/74QHQMBAV9cjdeVy
         chCktPDFQtA/wYCLzL2oRbpWNoYBpD/5v7iMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IdYsJPMEv4nuycJs7YJd5jalqQSPROp1IR5aOtwfvBY=;
        b=B/eHiA08jEldWBY1i9B8kenURxNASyyIA9z+9IuwT+ZztoX3KIqfPrsIrwH+EX3JZx
         ZSMwdSFGaEVDPv1Y1gnD/bNnsSvXn+2KW0L4QJc5b+Pwma2r84renILynGXZ/kpRiKSS
         7b9gkPBPljM8HnRXTludxGjJjPlHjQU7W+f49skFCJ+ZRl++Nz/yK2IUFl3BfYZlgylz
         VyXxuD6Yxx/08w5U8GqvsyHEWT8UXTY3xwoSHqNkzpr0caXk3rEDljmy5vbgcFgQZhdu
         ZJCjnkRtfzscbTUDYQa1p1iRu86l6vu3fxsD9ACk9a2nXDOWIgCztjyE7DzmHWlQpm5M
         1sWw==
X-Gm-Message-State: APt69E0CB3PgM+Pzn8KTuOkYE9SBoZKvi8dUmC8hlhN60silNeUPOUG/
        hq5NWA7f9yiw2vu1mvL+tAn+gBPsfqw=
X-Google-Smtp-Source: ADUXVKLehiQHnKb/K9YnOcZii8QKBTvYIxcmJ5p+w1z7FsqqDHZ80UvTBrK+/PcOjW2H25orA0GXZA==
X-Received: by 2002:a2e:5047:: with SMTP id v7-v6mr1475075ljd.122.1528973058659;
        Thu, 14 Jun 2018 03:44:18 -0700 (PDT)
Received: from localhost (85-76-96-172-nat.elisa-mobile.fi. [85.76.96.172])
        by smtp.gmail.com with ESMTPSA id u85-v6sm1022465lfi.5.2018.06.14.03.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 03:44:17 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE))
Subject: [PATCH v3 6/6] arm64: dts: sdm845: Add tsens nodes
Date:   Thu, 14 Jun 2018 13:43:16 +0300
Message-Id: <448cdc793c6ac83ab6d0ba2a6bef00036ad20801.1528972165.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 has two tsens blocks, one with 13 sensors and the other with 8
sensors.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdaabeb..7dd59b4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -221,6 +221,22 @@
 			#interrupt-cells = <2>;
 		};
 
+		tsens0: tsens@c222000 {
+			compatible = "qcom,tsens-v2";
+			reg = <0xc263000 0x1ff>, /* TM */
+			      <0xc222000 0x1ff>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: tsens@c223000 {
+			compatible = "qcom,tsens-v2";
+			reg = <0xc265000 0x1ff>, /* TM */
+			      <0xc223000 0x1ff>; /* SROT */
+			#qcom,sensors = <8>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.7.4

