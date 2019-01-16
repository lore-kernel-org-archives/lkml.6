Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1757FC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB38B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dj8ru+ME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405709AbfAPRK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:10:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44157 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405577AbfAPRKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:10:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so3078949pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VnxmDmWRiHgP8rQwZAnpNW6+tNuZ3Gwc75mIp5vRAak=;
        b=Dj8ru+MEYPo4tIYVsrDVqkIrf1cIQBZ2oFpOezoKgoAZhqRVS4MmQeK7MoimqGteIE
         OR7a8kVItg+VLBeFL0IE1BJIooeRsU8nPKSnZhQuX5B9sQPJhFarSBzuFBW+MshDzTv0
         hOYshhmO9RZWGECpU1KBIg1fQylyxfIhVbxmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VnxmDmWRiHgP8rQwZAnpNW6+tNuZ3Gwc75mIp5vRAak=;
        b=N1iYFvwV6AOSlT6I5REdLGi117yQREeoyB8cXE1u7Gil8sJ7quXBF0QMhkF1gk4LyW
         fjlKzsen/y930vAJs4AKluoUtAYsSGuomqEfO9xn77gsfodNT7SgnS61oyeeF7yE8Qll
         iSVVwsLKENxO0838MNCD7z0M/qO03FsNpcbj9Zvvl/pUAOyRAfRXFphUEqpo5TslC1wL
         2GBPf4H8AijDecSCSXZ6IHZEfpk4+ayW5DRCjr103hpR0HHLHF21DVsj/Vb4RQJjkTMs
         ef0E+/BjXJ3i8iPKLE4zHMRzEPNhN857jKeGpLfpk6BXxCJp8XKoKe9OKGBLiipFVKxO
         4UfQ==
X-Gm-Message-State: AJcUukfooXy49sS8Cjc5nzvuPinfHOUyARdkIjR45HF7oqkhapAzb+Qg
        RGsAPQsyb3wuugvnkhZvLrBFM1mGy6Z1ng==
X-Google-Smtp-Source: ALg8bN4SVqtdFgywaEtwsZtiEDfEfNePPT7gtS4fYNcRbAXAnYzannt+cRDsjufd4ZnqC/tSaPG5gQ==
X-Received: by 2002:a65:6417:: with SMTP id a23mr9838911pgv.236.1547658652983;
        Wed, 16 Jan 2019 09:10:52 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id h129sm17914023pfb.110.2019.01.16.09.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 09:10:52 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 6/8 v4] arm64: dts: hi3660: Add dma to uart nodes
Date:   Wed, 16 Jan 2019 09:10:27 -0800
Message-Id: <1547658629-25378-7-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to add DMA support to the uart nodes following
the assignments made in the dts from the victoria vendor kernel
here:
https://consumer.huawei.com/en/opensource/detail/?siteCode=worldwide&keywords=p10&fileType=openSourceSoftware&pageSize=10&curPage=1

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3:
* Remove dma enablment on uart0 which would use reserved channel 0
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 20ae40d..4c8d682 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -478,6 +478,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf00000 0x0 0x1000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 2 &dma0 3>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART1>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART1>;
 			clock-names = "uartclk", "apb_pclk";
@@ -490,6 +492,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf03000 0x0 0x1000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 4 &dma0 5>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART2>,
 				 <&crg_ctrl HI3660_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
@@ -514,6 +518,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf01000 0x0 0x1000>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 6 &dma0 7>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART4>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART4>;
 			clock-names = "uartclk", "apb_pclk";
@@ -526,6 +532,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf05000 0x0 0x1000>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 8 &dma0 9>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART5>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART5>;
 			clock-names = "uartclk", "apb_pclk";
-- 
2.7.4

