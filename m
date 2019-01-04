Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E17C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3410C21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhfGSs8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfADU4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:56:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35818 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfADU4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:56:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so18820680pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7aRBKK8TkteZislwEu46QTtOuuKaw2a3j4FrskRJKXE=;
        b=BhfGSs8Q+JnK1/4i/SeXnylWTDcT0KNKJ/9Mb53e/1HtR0+yVg/hx++HaE96mhbFc7
         ZxXXnu1lY1XZilaLLBT+tRuOpGPmSxHQbPacJvd6ZkeAuXHELoJObsO+qEx8SXDrz5rV
         kunU2X0zlb2b0154uW0b821jyhSiMKNH5BVgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7aRBKK8TkteZislwEu46QTtOuuKaw2a3j4FrskRJKXE=;
        b=TJo47jwih8k3arPn/EaPYf/ny3IDYL3AtwNHvNwtzynSDyziia/RHp4ensg2Ekt6fz
         Hg6122JNcrff/clAFt8XK2SLCNVe5C30woxKVTwve+y5j291AOK+plAUkRs28dNOLh9D
         jRSniipUP0/361WXg2sUMrhAhrWughLFjpwewXF/xmFHqM3cqBGR4LobrO8/ltibuBT9
         S6x1EHwhC8VDPvZhWnUfgH0TVfCl5Xq9e1oRUoafRJv91vz5Bdueo4WcapDsX+4HjTNM
         dHO6zoH486YiNoU5H18ofukXlzf/ca4PaNe7r+gX1Iqyc2O/Xj359a4vrdRz6JXWIXz9
         hxlQ==
X-Gm-Message-State: AJcUukepg+msIep2tCJYnDNImZQRIbzYVTX+W3LtE8RMl4vjkKmcq/jM
        cttgDsUdaV8QNq0UXH3tve+K6ZAd3gmSKw==
X-Google-Smtp-Source: ALg8bN5DnREXTuhCejvjjJPX366oyQdEEZmAmGnw9cIxn64NWdFHd7pf1cXJD1YywBkIGWEPbzUuCw==
X-Received: by 2002:a62:6cc9:: with SMTP id h192mr40561294pfc.223.1546635404934;
        Fri, 04 Jan 2019 12:56:44 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id l3sm98058334pga.92.2019.01.04.12.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 12:56:44 -0800 (PST)
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
Subject: [PATCH 8/8 v2] arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-avail-chan
Date:   Fri,  4 Jan 2019 12:56:28 -0800
Message-Id: <1546635388-13795-9-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A undocumented and unimplemented binding got into the hi3660 dtsi,
and this switches that binding to the now documented one.

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
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index df4e96d..654da63 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -562,7 +562,7 @@
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <32>;
-			dma-min-chan = <1>;
+			dma-avail-chan = <0xfffe>;
 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_DMAC>;
 			dma-no-cci;
-- 
2.7.4

