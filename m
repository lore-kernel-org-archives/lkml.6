Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E07C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCB52083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vh4+W9Fh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCB52083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeIAUzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 16:55:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43850 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeIAUzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 16:55:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so6774210pgb.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uVMEsprQm9gudmgxiK82x9lkc/giPgwELqLOkGrioH0=;
        b=Vh4+W9Fh9bvn5G14X5/zRrXPS2kBhR0TBkz7MA3cMP25lLTIuU1+3/3Jvw2r1JF15P
         wqNFRwo/qFDXzXGB4/kY+MBSP3DcTjWCO8ARzg7id9b4nHDgltyUqeUMBQNEccS1FYls
         IeFAk5Zxgfnf2T0LmAv0LvzbBGHZzBV7bZf2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uVMEsprQm9gudmgxiK82x9lkc/giPgwELqLOkGrioH0=;
        b=qGnoerKNs1fPbwgtyva/4l8EhWo+0p67VGPRx69Ww85yB6ecIsVO8bcR91huTBq9p4
         Syo30WxKTIwWu7mHC2r/6vwl/YYxww7bFlA+cragN5yzN01lrpz8hRsjzPK1iO2Q615t
         2lRbGboxVO/IUN0EE1P1WtX7hCz+eXAI+eiEXZp1UcWCgBhgyyb123J31GLYRJNauVfa
         E4JLz7YrPZEvXtLJjjRiNcMuZKj39o5M6+38kbe2Ou0060uzFmcDWuMHf9k5+1Dup1AS
         Eh/B+PGcXpNxoFHUz90xCw7p8HtxQSAL3BR9OWTPfxrdbaQCK1dvxWQPcgPoRnd0c+HI
         DlYw==
X-Gm-Message-State: APzg51DHp2HiMw/zHk+lapKHf2Oz36I++f33fK2zXVeM+wgNI78aprKv
        JSmKD8WN2zS664aPkpwcgJm9
X-Google-Smtp-Source: ANB0VdZmftqi8g1Ctj2Fbwj+OXgzshNXu4yXEAPL7n2FI+vffDPYiF5Q8DhYqAeBLCK8qPtyxOr9Ew==
X-Received: by 2002:a63:5660:: with SMTP id g32-v6mr18769691pgm.227.1535820167705;
        Sat, 01 Sep 2018 09:42:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:724a:4d47:6510:16:9ba1:39a3])
        by smtp.gmail.com with ESMTPSA id y7-v6sm23763595pff.181.2018.09.01.09.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 09:42:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        liuwei@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] arm64: dts: actions: s900: Enable Tx DMA for UART5
Date:   Sat,  1 Sep 2018 22:12:13 +0530
Message-Id: <20180901164215.3683-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
References: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Tx DMA for UART5 in Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index eceba914762c..39af1236f611 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -156,6 +156,8 @@
 			compatible = "actions,s900-uart", "actions,owl-uart";
 			reg = <0x0 0xe012a000 0x0 0x2000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "tx";
+			dmas = <&dma 26>;
 			status = "disabled";
 		};
 
-- 
2.17.1

