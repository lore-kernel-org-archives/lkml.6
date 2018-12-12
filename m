Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5175FC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E5020672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAAxp8Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E5020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLLALL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:11:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35753 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLALL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:11:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so7699687plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zURcSulZ3bk3CM6s/TkG7szyZKknfdO5/AOWCy6FGe8=;
        b=XAAxp8Bno13Pb6LEHQ2MLfT3PDqPF6okkdSfO15WDSfy8Ns9myQsvBISrryXB8IYUL
         IeKJkoks8Ymxbrqj0dHgXkxVOIi6ofvOHP5PLoi/iAXptJoVpkOOem19ULedYJg3m6D4
         WJzFOT5w6VYY1ZRdUzK5+L0c02WyAw85P6x/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zURcSulZ3bk3CM6s/TkG7szyZKknfdO5/AOWCy6FGe8=;
        b=UXeb2TA8bnPCTXMOmxm32uOeuA7ZykIxeS501hZVGwEZ52dOOGvAdz6lQgUSeRCSdm
         9oMaXQt+Nq9+/rjxN3rvJsTbIRVolaDX51X03LJ1mDqg6dKtGEMpKB9iDLUts3oTjSb/
         SOVK1fGdHFfKNqIrETABC/FuEMEFBRGRj7WYsKx0mNLfN3FCcDzAhbU7QNSB+DjtpMxQ
         eJFB7B/kQjaGmTnV9rIFxdExAA44vCw1Qes92WZaRe01F1SzocuAWXSRvqw9XiXpcBpq
         /9R7AUgxumXNnxspR5tJnPhAVcUdCB1xVsijb30sz4dGbzqKZTb8dc9s9SxmFhR9aXXH
         ybIQ==
X-Gm-Message-State: AA+aEWZGlJD6pn1H04Pe9zBYjrBTVP1q8RQbD21OAg3SC26s0pPPzLMi
        hwraas3Zm2N9U1MmTDrHGLXJG5S2Y5I=
X-Google-Smtp-Source: AFSGD/XvCjDscH5ByJSyC1jMS7b4mHycs5351lEnuq37djH1TqVJcM80CCXLGUgwLjy4MhEzb+8hZg==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr17583636plb.41.1544573469271;
        Tue, 11 Dec 2018 16:11:09 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id u186sm22821188pfu.51.2018.12.11.16.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 16:11:08 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [RFC][PATCH] arm64: dts: hikey: Add DMA entries for Bluetooth UART
Date:   Tue, 11 Dec 2018 16:11:05 -0800
Message-Id: <1544573465-32314-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma0 references for bluetooth uart to enable dma
for bt transfers.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: I85d36cc492a5f392cde214b144b19469e951585a
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 97d5bf2..c3b17dd 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -319,6 +319,8 @@
 			clock-names = "uartclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func1 &uart1_cfg_func2>;
+			dmas = <&dma0 8 &dma0 9>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.7.4

