Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358CD2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+PCdRuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfBFFOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:14:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41016 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfBFFNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:13:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so2565946pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y5b4GKIVU1IGTA+9VX8pZ7gfhsVcFY8TsawWTkm+7H8=;
        b=g+PCdRuFYac9WmuOTNH4nnFSxNSsKVGA461FEhziv+mZzNjv1GjcDd3adcmpWihTbp
         OM4uyMKoKKlPP/rW6P1C94SfeV+0DNBbI+CJeyZ22duQVdMKwh476ZnK1Q2YQ1PhcXsO
         iqyaSlxJWiYOei7z+dBK/0IPr/VWXzqUY4h2hFBmVuR+mJ6U/R4351AlqKrnx7BSckdg
         JtzHESjLgX1brLH9tebQh0R/WyqACDc/KSNXTcMwq/o7vQltwnzjo0jAh7jSSEgJwjXP
         0sPcAaFVaOBoeMDxjVl/W4CQi3ZBuHsUQgjy/SLMSeF+yKBdZZeTakjjCKv4VS1dgNMk
         jrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y5b4GKIVU1IGTA+9VX8pZ7gfhsVcFY8TsawWTkm+7H8=;
        b=DZrcG0kViCiXuh2yAz5yePJAx5T0WawgcCHkK3iXUGZ0je2ETZTZwzI6tAqY87MmXQ
         arElBsv05voCsowSDczxwpjaIX7VwBBqxihY+6EtngHbA0YXdQWjki28QFrHmSwmETYm
         DdNqtCoY/oXX6V7GR6L2BDVZEPmMDl9VuUyGb8Wm/hCbR4nBmuLi94RrHOwIcyQCZ5mz
         W3rpeDFOG4l2Syu8LFGZKmgHQk+fxjIaxyEjK309DixpGQewG0c8DJQntW9Lc5D28wmw
         SPx0KTwLe46nh8v2Vwp6baUKdjwaQ86J0DhGFi2f12TFq1Q6sRQsha1lvSYMKXV9V+ra
         F19A==
X-Gm-Message-State: AHQUAuaDHVn0ZT4aw3bEYtxfanllrczWqz3J0NeifTwIDSEnLeUYwxv4
        rpURPVe7aYekz6Pwnhgpr2/rbg==
X-Google-Smtp-Source: AHgI3IY13G36qavs2D4lpVXhV4OljvgGjc00XZltERFWqC+Jc59uWHfxI4UH+o69Zk9rHv7CwpG1Kw==
X-Received: by 2002:a62:9fcf:: with SMTP id v76mr8650037pfk.144.1549430031179;
        Tue, 05 Feb 2019 21:13:51 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y71sm10735012pfi.123.2019.02.05.21.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 21:13:50 -0800 (PST)
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
Subject: [PATCH v6 7/8] arm64: dts: qcom: Add AOSS QMP node
Date:   Tue,  5 Feb 2019 21:13:34 -0800
Message-Id: <20190206051335.23799-8-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190206051335.23799-1-bjorn.andersson@linaro.org>
References: <20190206051335.23799-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP provides a number of power domains, used for QDSS and
PIL, add the node for this.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v5:
- None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 12efbdb1fa2e..560c16616ee6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/clock/qcom,videocc-sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
+#include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
@@ -2080,6 +2081,15 @@
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

