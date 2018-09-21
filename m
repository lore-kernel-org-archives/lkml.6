Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284CFECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69402154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpaoA3kk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69402154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389317AbeIULsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:48:50 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37469 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389231AbeIULsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:48:37 -0400
Received: by mail-it1-f194.google.com with SMTP id h20-v6so754303itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gzU6v5xWc9dIvDgqXb1SE74zda+5lHaIqfgTIAAAstI=;
        b=bpaoA3kkHShq4oS3lHp2c7bmW0qp5xOo0UABMUEJnzsSAOGRf8UsHbWeOQNaIeaA6x
         ajPUia5/j2rJ8Tf/Q36VGIaKBkWDwv7Ud9mn5xEUAgnq4zTrhryvsVu4JhzTX1UN3Bn4
         M+vgRt4xfR+ko28KrD/b3lXnRDKpYslIDQ/IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gzU6v5xWc9dIvDgqXb1SE74zda+5lHaIqfgTIAAAstI=;
        b=NTya4kgCIV/4K5M4Cf3V2tCTJPARWQ+twOQtiD2nVjd6wmqCBF6A9Q9cZbVdzIVLU7
         p4BJgGrU+YeeXOJMec25xGtvcveNlf7jWeMHnykWAEubQXegYcmmLyhk4ZzHmWSzMCC9
         21bi1NbAbQdTYxLr1Elfp/I7KkdAEqyEectofhE7z+PMfG0u2PeLD/ynmYKIIlATUzCo
         MfsFm10p919waQDHLkiojQLq0MHTMT1IHwjAeriKfCQiauEfrgWfOqQc2Y9y6plOnDEE
         6MHWJQtA7Z/m6Kai6kZuOPkmUDwqQQ2OcBlajETyNKJ+coh/8dEM8djBerl7cOFWOf8w
         xUHQ==
X-Gm-Message-State: APzg51C6pZ61vHyxqggJGOmWkUcQGZm/efXF3SH6+Q24wA+1gJpbRTPB
        OauSR60ChYlQVdB1ipM9LAbA
X-Google-Smtp-Source: ANB0VdahbBCCMKMcEY0OpRB7/dLe7bRn0WB0nrWtDYMObF3uNPV41QmLig490i/ieHEwzJirlzg4mA==
X-Received: by 2002:a24:1ad2:: with SMTP id 201-v6mr4968137iti.18.1537509679527;
        Thu, 20 Sep 2018 23:01:19 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id b195-v6sm1973875itc.42.2018.09.20.23.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 23:01:19 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        xuwei5@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/4] arm64: dts: hisilicon: Source SoC clock for UART6
Date:   Thu, 20 Sep 2018 23:01:02 -0700
Message-Id: <20180921060103.21370-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove fixed clock and source SoC clock for UART6 for
HiSilicon Hi3670 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 8a0ee4b08886..34a2f0dbc6f7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -187,17 +187,12 @@
 			#clock-cells = <1>;
 		};
 
-		uart6_clk: clk_19_2M {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <19200000>;
-		};
-
 		uart6: serial@fff32000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfff32000 0x0 0x1000>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart6_clk &uart6_clk>;
+			clocks = <&crg_ctrl HI3670_CLK_UART6>,
+				 <&crg_ctrl HI3670_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
-- 
2.17.1

