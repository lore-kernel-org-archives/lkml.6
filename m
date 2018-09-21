Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082BFECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BC02147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6RWy3YR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BC02147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbeIULsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:48:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46996 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389239AbeIULsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:48:36 -0400
Received: by mail-io1-f68.google.com with SMTP id y12-v6so11038585ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 23:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HWT3twxDE9rajVaHTUWulfxI8G27u4GTCDXe+LGxpPw=;
        b=G6RWy3YRam/B/N4P3ZwsDol/oMhyEvNrMHCB/0oz+rqJ67JVLAaywTclNxR38L7Khp
         Pw1ysQ2VJp1W+kgEsoNoj9fHR4w49aK51uQM++PW71jRG9r6Rd3EeQf6dFljxTeswUln
         dfEKGRegRr5m32H5UEfwCPQWac1itNgmhFR5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HWT3twxDE9rajVaHTUWulfxI8G27u4GTCDXe+LGxpPw=;
        b=AdnR4vZqEFoHSJ4ACSrb9CldtzRVq9aGVHpxvm9v/hiW0dNWH6o7VqZrqizS2E2OVR
         1tv4VKEEmqofjDuZO9PqfkOl516nuQH9vwDNtjXc+p9VNnW3rv7btprg2kb2BT1YyFAe
         ZOhVM3tMEcKPlYCY3HmHepYdBYU43r3Ns5F01e/DNer3ZJ2D9woIGl/V9OwldiMYjODc
         EXOZNGt+PKTYHy7d1AzuaaQV+sKf1v/+8RMfPnampjG/alYK7fqtcY8uQK07Cs6/Yz/w
         72iO0ML6uuWAkuLcdvQ/6DajlqFP30x7fS0ZnI6mvRIu6eINuraMM95jsA3fJr+mu+n5
         QK9g==
X-Gm-Message-State: APzg51B37Xk7TULOm19v6G7um2AkWvlLGW/zESE5tmipsfe0vnXCY3Y2
        Wrs8ZnJ4ThFNng+31U5oePn0
X-Google-Smtp-Source: ANB0VdbuEfJkxfJ0Y+xxvdH9F6hES69ww8g/af69ZQRsxiq/j3RiK2jCh4tL1zBpXDOC818rs3A/Sw==
X-Received: by 2002:a6b:2495:: with SMTP id k143-v6mr31079959iok.122.1537509678073;
        Thu, 20 Sep 2018 23:01:18 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id b195-v6sm1973875itc.42.2018.09.20.23.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 23:01:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        xuwei5@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/4] arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
Date:   Thu, 20 Sep 2018 23:01:01 -0700
Message-Id: <20180921060103.21370-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock nodes for HiSilicon Hi3670 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 43 +++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index c90e6f6a34ec..8a0ee4b08886 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/hi3670-clock.h>
 
 / {
 	compatible = "hisilicon,hi3670";
@@ -144,6 +145,48 @@
 		#size-cells = <2>;
 		ranges;
 
+		crg_ctrl: crg_ctrl@fff35000 {
+			compatible = "hisilicon,hi3670-crgctrl", "syscon";
+			reg = <0x0 0xfff35000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pctrl: pctrl@e8a09000 {
+			compatible = "hisilicon,hi3670-pctrl", "syscon";
+			reg = <0x0 0xe8a09000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pmuctrl: crg_ctrl@fff34000 {
+			compatible = "hisilicon,hi3670-pmuctrl", "syscon";
+			reg = <0x0 0xfff34000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		sctrl: sctrl@fff0a000 {
+			compatible = "hisilicon,hi3670-sctrl", "syscon";
+			reg = <0x0 0xfff0a000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		iomcu: iomcu@ffd7e000 {
+			compatible = "hisilicon,hi3670-iomcu", "syscon";
+			reg = <0x0 0xffd7e000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		media1_crg: media1_crgctrl@e87ff000 {
+			compatible = "hisilicon,hi3670-media1-crg", "syscon";
+			reg = <0x0 0xe87ff000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		media2_crg: media2_crgctrl@e8900000 {
+			compatible = "hisilicon,hi3670-media2-crg","syscon";
+			reg = <0x0 0xe8900000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		uart6_clk: clk_19_2M {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-- 
2.17.1

