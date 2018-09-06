Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEE4C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAB920659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0qpNjwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAB920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeIGBmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:42:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36359 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbeIGBmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:42:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id e11-v6so5540369plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsxEEp1YuaF4+Xx32M6ZV98/mEpGcOtgX+T6zkFwWxs=;
        b=W0qpNjwpuHXr9j6ogd/zGiLkWy1viJkfbBcBVmzrM4KCDoRemM6X9tBRhtAOrZtOpc
         QxLGhEJ5vvmMQpkbpi0KNDN/Ro/Fu2Whzmc0h+uA0PwtWl4LwD7hnQOzMf525PEytw6d
         3pUIC4CpdF5P9X2dXHVTrh1tZOeuaKCiR8+30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsxEEp1YuaF4+Xx32M6ZV98/mEpGcOtgX+T6zkFwWxs=;
        b=BKcUDvElfO3J6CbNCvkV6WTsM0Q/wSKh7eT4xCRdF13389dHXhCtbDwWWGU6CHeMgM
         1cnp3QXA1gvlPvotVVOYNNQHqfd1CXyDIcVgIJ52e4P+/9ZQRVFqQzuGE+NNL7iW546Q
         jmSDySHdgn0DxUST01r1H8F1SOQNkxy2lQ0+XbMurpx5jrgJ9sl4OiGJcOluStp97qO5
         UUGq/okFXrx+eqtivr2MKRv5YaXcG3KD74OPVp02wLzx3zeFTMNLwUWJ/tmftGeMIQ5Q
         xNdH5VwTBxK4ETjU6sgzTuoW7Fmg17P/oyFGGBCKTPdvuM0eGpsCN5g49siuH4hG+bzz
         evww==
X-Gm-Message-State: APzg51BatR1A+ZfsIWpZRuu/MsD9jEokgSzqMZ6JizITy8GptnbW5AE/
        ZXnPb8z1YnWMcexXE34MHAuGmA==
X-Google-Smtp-Source: ANB0Vdbvoe/ZfyQVL3cONjbwWKa7iwkpti0ZUm5U1MBJXyKVywvQvC2LjV9W9nnb41Kz0cOyxVt1/g==
X-Received: by 2002:a17:902:4601:: with SMTP id o1-v6mr4751820pld.202.1536267934905;
        Thu, 06 Sep 2018 14:05:34 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y4-v6sm8271288pfn.123.2018.09.06.14.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:05:34 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 2/3] arm64: dts: qcom: pm8998: Add adc node
Date:   Thu,  6 Sep 2018 14:04:53 -0700
Message-Id: <20180906210454.247219-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180906210454.247219-1-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the adc node to pm8998 based on the examples in the
bindings. It also fixes the order of the included headers.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
--
Changes in v2:
- removed io-channel-ranges attribute
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..41593ebbea2c 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /* Copyright 2018 Google LLC. */
 
-#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
 
 &spmi_bus {
 	pm8998_lsid0: pmic@0 {
@@ -11,6 +12,15 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8998_adc: adc@3100 {
+			compatible = "qcom,spmi-adc-rev2";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+		};
+
 		pm8998_gpio: gpios@c000 {
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

