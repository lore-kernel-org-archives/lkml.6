Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107ABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7270208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+WAK4u2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfAJRee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:34:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38907 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbfAJRe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:34:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so5108227pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cmarbxwYg7HNoDTmchA0P0EFmwoGgD4g+3dBXR4lJyQ=;
        b=Q+WAK4u2sbyObQm/Ez2TxH+W+8fap0fCd+IsfJUIyFepCOkdFBVbxas3hfiwHd7fR0
         LFFEZ96yuVyQE96noa3qbc/FxnhWnk6B76LyErUvkQY/aML86SvSiTkv6dzuudDYFBBq
         VYr+lM6NGifueQ+na4tm4ldvuF6xnHSQd1zOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cmarbxwYg7HNoDTmchA0P0EFmwoGgD4g+3dBXR4lJyQ=;
        b=QdAncwuc7W7xjxAZ6bknKdbImbuDiqdhZPo3gNfRcxMsuJ4ED7RPfuTO0J7XpwCJIl
         CN6n5/A4qI5FKPftp9ZSfpG8QrPaPJ6I4HxJ6dWdKrnEdcH5ajHwmdIlBY4qg8fPk1oF
         RkYjdzvUmRFg9FiIRmUKdalBXuaq0PbF0l85Ro3A/gt5X8t0c1pChoP/2m6gxMCSVVLC
         +zmytO839eeLI/JoE+1JgJJYwxVggmSa38KGouU3RDzDr2UNK5pYvzMv9GDv5GwhLRem
         0dS0zEvtvOoNF15QkW8vpW+shK2n8LBg+8yPr5xde2510zEOU7U/mCL03oK/6bgMRRET
         1ITw==
X-Gm-Message-State: AJcUukfb/2lmtHj6dI3d0qV3fiJV+08q2WeIO6AeXVG1E3QGCMSewZXG
        RBvgDjkA5AhprchXUihpDFMurhk/bPJRVQ==
X-Google-Smtp-Source: ALg8bN7jM1miZVLKVI4ica31RWzk6lss0oL87SAW4AXMcr/zMoA1fw86+xhkL8YjSp4vkQd8KyHDQA==
X-Received: by 2002:a62:399b:: with SMTP id u27mr11482003pfj.181.1547141668168;
        Thu, 10 Jan 2019 09:34:28 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id k15sm125977409pfb.147.2019.01.10.09.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 09:34:27 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 8/8 v3] arm64: dts: hi3660: Fixup unofficial dma-min-chan to hisi-dma-avail-chan
Date:   Thu, 10 Jan 2019 09:34:12 -0800
Message-Id: <1547141652-8660-9-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A undocumented and unimplemented binding got into the hi3660
dtsi, and this switches that binding to the now documented one.

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
v3: Renamed to hisi-dma-avail-chan
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 77a7135..472c370a3d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -560,7 +560,7 @@
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <32>;
-			dma-min-chan = <1>;
+			hisi-dma-avail-chan = <0xfffe>;
 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_DMAC>;
 			dma-no-cci;
-- 
2.7.4

