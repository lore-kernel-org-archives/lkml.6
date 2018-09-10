Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1BDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3550F2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jldr7OQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3550F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeIJU6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:58:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33166 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbeIJU6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:58:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so10713726pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCTI6zUgI1gXw+J5bYAFkLhTXruI8Pq5CKHSMb95CuA=;
        b=jldr7OQVxg2Q8xWnIvJtqyCKsb74pG5bDBinbgszhiaXd/FCECaaLDfLs2vT37Mw6K
         HLXIXggTBV36zp0m6LW6pR77xwntGjdCPDuL2dT15VMSj2HnRWYMWkvt2N4R++h2jEyj
         Dk+lsWOzjSNM+t/6w3KFCob5oxngu+u5FqRsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCTI6zUgI1gXw+J5bYAFkLhTXruI8Pq5CKHSMb95CuA=;
        b=d9MNKmPwR63y6GyGiCPZz++gzaJFPceR1vaKz1jN8J/lRcLBcsYR5Suk5ZWVwNvo82
         5ehrzVL6PYKBUdr0HvI92nkdmoxZeWkS/XUHLdUKM/qA/CjqwGCg5KqWpQCCMQ8jj/8Q
         wze9XLW2l8lb45MIjhkslGpSNfemUilQ85OZVzaV4y1holL4LZ+rI7pmm0q/daE6FGqK
         BFXBQ323uMVB8zY0DFYf4Sem7CC473S5B07rw1w92BUP/1u0DeOF12B7g0wKWab+peqo
         eAsYabh6H+HoENbWWGUXdORlcfsljzkZgJ6FM2fi+Be8UsU69f1v6ui8+9XoL4kpCS/A
         qckg==
X-Gm-Message-State: APzg51DjA8urgikiVdkXIyjhBwKSj3ByirjyehEO0snPaVyeXLuPdyuw
        9qwGGqC5I9xqS1+wD5eYkMD97g==
X-Google-Smtp-Source: ANB0VdYhXN4l/F9KglBcwnq+fyZi7iEb8q9wawY2TvMj3r+RwigA8upV5LfST/nw0nT72lTOzBXc3w==
X-Received: by 2002:a63:28c7:: with SMTP id o190-v6mr23450675pgo.84.1536595424687;
        Mon, 10 Sep 2018 09:03:44 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b3-v6sm33893517pgm.74.2018.09.10.09.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 09:03:44 -0700 (PDT)
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
Subject: [PATCH v3 2/3] arm64: dts: qcom: pm8998: Add adc node
Date:   Mon, 10 Sep 2018 09:03:00 -0700
Message-Id: <20180910160301.237538-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180910160301.237538-1-mka@chromium.org>
References: <20180910160301.237538-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the adc node to pm8998 based on the examples in the
bindings. It also fixes the order of the included headers.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v3:
- fixed separator in commit message
- added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag

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

