Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532A5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB6521872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FplvEqJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfADU4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:56:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41735 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfADU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:56:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so17914579plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x8FLQ+g/7eCfd1VnKMng4eZMRIm7A0veiMcyJNgJ9zM=;
        b=FplvEqJn0/GhoTUK07SiH49OQp68tTWAGSKbl7VAyGPJk7zanN45ArCR3O3leEDbrv
         WCcNlwlqYl0bQO3X/K/DTgXkIcOr8uu03Sa3QPooUhaoLOQnBBKKBXjE+F+Q57s6TQj9
         xHhgQoiP0kjYyMcc8y62SRf+HvNniKIA0zabE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x8FLQ+g/7eCfd1VnKMng4eZMRIm7A0veiMcyJNgJ9zM=;
        b=GWDMPOa+gwp5Asrff1Vx6Sye6EUg9/+uCa/vmyAhbKm9FT5OJKohkiOBMiRcwwr05/
         FYQxO52YnaFBVEU49em6/mTWKW/q8f2lJiwjRdIzfTWCgiISHqFh04TK1pw1AW++ARwY
         plcB2qdKpQc3lNE15NujqYZia3D/x9A46UpEU9PjQdjow5oUQXNpDVxJ+btoERjkBc7Y
         R6VfumiPIQfzb3trwxciWDQpXynq2j6A347Cv6fPN+rHupFPa3EO09vNnDr9tP+NBweG
         CERQrbzsH00AgGoz5IGFHu11dFKq9yJR4yGHnYL+HeOss7TFKrGXGC3llKWZfV0LGelX
         1OhQ==
X-Gm-Message-State: AJcUukcJoH3OurxNJOQeyIxGcmSyDH8yvEBhbyn1WyQb1j+j1q+UcvaV
        YpvKfXFfP0YRPuiLzQZIWxdCc+hsNRg0ZQ==
X-Google-Smtp-Source: ALg8bN7ybpmqlKyfxFKQLyfVL7T+0oXkm3rFJgCaTiIMKOKiHEBeeKw0/TfjDCeMGdQXg6oV1C0Wmw==
X-Received: by 2002:a17:902:6113:: with SMTP id t19mr50809853plj.248.1546635403461;
        Fri, 04 Jan 2019 12:56:43 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id l3sm98058334pga.92.2019.01.04.12.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 12:56:42 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Youlin Wang <wwx575822@notesmail.huawei.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 7/8 v2] arm64: dts: hi3660: Add hisi asp dma device
Date:   Fri,  4 Jan 2019 12:56:27 -0800
Message-Id: <1546635388-13795-8-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Add asp-dma device to hi3660 dts

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Removed undocumented bindings
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index aaa2b04..df4e96d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -569,6 +569,16 @@
 			dma-type = "hi3660_dma";
 		};
 
+		asp_dmac: dma-controller@e804b000 {
+			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
+			reg = <0x0 0xe804b000 0x0 0x1000>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			dma-requests = <32>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "asp_dma_irq";
+		};
+
 		rtc0: rtc@fff04000 {
 			compatible = "arm,pl031", "arm,primecell";
 			reg = <0x0 0Xfff04000 0x0 0x1000>;
-- 
2.7.4

