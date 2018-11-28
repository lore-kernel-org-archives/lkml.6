Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CDBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9D72133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hJ0g1vPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9D72133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeK2JiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:38:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34461 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeK2JiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:38:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so10144800pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3rIAJU2JmCgKJB3gRbw/LLuNiP36MPTv3n4dNfB1CJE=;
        b=hJ0g1vPx8ecbBHOwJqQkbaQ6HUkjJ7UO4AQviHyNB5Ta8HxChOXS4vnK/qwGd9QoZN
         OMxPpFT1ISTWqhgrS4yiqNA31mubLck8leDQVc6W+laA6hCAKmNPrPRFVx1exSi0up09
         6sGyM1aZDRt+W23VxbSuPKnRjX/F35lsK48Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3rIAJU2JmCgKJB3gRbw/LLuNiP36MPTv3n4dNfB1CJE=;
        b=rSAO44Vg3BgrwWCEHQ+sepC5eqgIC51nHz1yXEhGWsFe7k8T78KhK/VLaMctDn1hbT
         +F/J8SyL+1EZm2J2zXExscGhPlkesZcfUP8KF+PgZIngR68IAPwUG5i2eBDxWwPeEhrp
         nPduO4OSb45Db2n0cCO2sdDyLlsUVBunRMcKIQ1O3UC0oSQpbztgl92zndMPFe0QfTnO
         +0f69/SILyguG87z84tWX2VVQhPc+zkQKRSbx8cRlUHIRPguKRxcTyx5p5ihsIhSxk1E
         tpCRRtgNiCcAV1wUgCZ16z0LIDybWBtl8YrcnpPkj7xacKkkhKkF0L8i96khtWEkKRll
         nGqA==
X-Gm-Message-State: AA+aEWawkMrwmBzxu1soSrOmB2/dirOcgHTP6ldac1Sb1i/JLVKnleFk
        U7vWWB+aI2qdtxAgB8ut2WfVMA==
X-Google-Smtp-Source: AFSGD/V87NUC7iVsSkre8+8q5WZzCWAkGZQkcybbUh82zfBlFiB+H2DpclgNlp/Gry+uqrW4hUARXw==
X-Received: by 2002:a63:cc43:: with SMTP id q3mr34350431pgi.291.1543444490716;
        Wed, 28 Nov 2018 14:34:50 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id y26-v6sm12364813pfi.123.2018.11.28.14.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:50 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v1 2/3] arm64: dts: qcom: sdm845: Add SD nodes
Date:   Wed, 28 Nov 2018 14:34:27 -0800
Message-Id: <20181128223428.177313-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181128223428.177313-1-evgreen@chromium.org>
References: <20181128223428.177313-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SD controller to SDM845.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1419b0098cb38..bb8eacdf40910 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1078,6 +1078,21 @@
 			};
 		};
 
+		sdhc_2: sdhci@8804000 {
+			compatible = "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x8804000 0x1000>;
+
+			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>;
+			clock-names = "iface", "core";
+
+			status = "disabled";
+		};
+
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sdm845-qusb2-phy";
 			reg = <0x88e2000 0x400>;
-- 
2.18.1

