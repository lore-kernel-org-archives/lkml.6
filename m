Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C9DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF368216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cuPwzdqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF368216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeI1DnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:43:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37779 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeI1DnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:43:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so2854553pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSiC127F7IOBvrqTT2K6nS5eFQbyh4RproSH88MznjU=;
        b=cuPwzdqgxy6Khx4WECZh3r6tMAWK0gPstPqUpJWchwfR0gZknQENpaT1AIEHELNOwp
         xCyXPxicignsr17CH/iIDbDc204vm9nsxTGXlE7DbydLqKWxNjA7G/W73Lx2SWAwkFrM
         4xpXI9zdqW0WDkuOuzD2VAbguM9rwoponJyo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSiC127F7IOBvrqTT2K6nS5eFQbyh4RproSH88MznjU=;
        b=aNTHknrWzahFtu983ME14/wt4Ne2HS7Qvz9iL938m4Xa+sYXEdxBFfN0Oie0ip2r68
         9oxj91u/t68c2zq60Dgx6TgJQgCwbJJf4sN0gz0H02mk20QIbmbEVnbytYQyogPUoNgh
         Z1oLOu7GLm4UZUNFJM1F7+I03TNIC6YpXA3AB5fPDERMo5FnOOAEyrxjGAEwsOagscZE
         tGv2U28NIohUj4a4lnYpdnw/HlXVM4c7I/iaNvF1OonLU1Tpu47a1JbH3yjYe/0On4u9
         8Ry3Q/0q28bTWphMcNPdM4HiS56zN+Xwrd+tNW4VrK7/V0tkOXtngmnF/KP/d9eOcXHk
         sAQQ==
X-Gm-Message-State: ABuFfoh4jBIjIbXEAsbTEsqPPlEjGYeRZot6xQkEf7gzSaFGWqq+pqZ4
        JNNlWv5E5sjuG+JhnJrHB0I/dg==
X-Google-Smtp-Source: ACcGV62rbiH+80eYHWmbN02nYq71QvgtWIPheSWKZC/6qVHWvLj3kwdopgYX7OuvpX2Dq/WZH8owEw==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21-v6mr10740859plo.21.1538083388411;
        Thu, 27 Sep 2018 14:23:08 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id u65-v6sm5818968pfb.144.2018.09.27.14.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 14:23:07 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: pm8998: Use ADC temperature to temp-alarm node
Date:   Thu, 27 Sep 2018 14:22:53 -0700
Message-Id: <20180927212253.177200-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The temperature information from the temp-alarm block itself is very
coarse ("temperature is above/below trip points"). Provide the driver
with the die temperature channel of the ADC on the PMIC for more precise
readings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
- based on agross/for-next (7a002fe0179c "Merge branch
  'defconfig-for-4.20' into all-for-4.20-redo"))
- depends on e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
  from IIO pull request:
  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.20a
- to work properly https://patchwork.kernel.org/patch/10594491/ is
  needed
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 048f19fa0150..fab5a826fb01 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -58,6 +58,8 @@
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
 			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm8998_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
 			#thermal-sensor-cells = <0>;
 		};
 
-- 
2.19.0.605.g01d371f741-goog

