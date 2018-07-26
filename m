Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F12FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0253D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJ+poR9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0253D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeGZGWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:22:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32858 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbeGZGWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:22:41 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so266551plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6S1u3ITpyUtI8f9vLjRwxawapUb4nLplEzTrLhyW53o=;
        b=ZJ+poR9bEL6n8zC5TAeteV5CG2TAEGT7LCnCg+0/w+RI9djByIFM46TxqhxQ/XyYuQ
         5yNpqUxOS5CWqZBn6kt2Ixrwv4Lb/KAVThHizGInaqNP0Axm3X2iTUSX3xQhOZNrwjDv
         ir8b4ljsD2A2OBg6YsKHCU5fNZAcoCyQJuQzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6S1u3ITpyUtI8f9vLjRwxawapUb4nLplEzTrLhyW53o=;
        b=DBWtFxdS28S6kbPt4EHZ+4e2BpN6M/5Qm+8dQrtCHf4CjcNc/9/yKIP1IaqacFDgNF
         3Xse7YG+dVppeZWuZmUNBK2CSGHRh4rc/n04fgg577SRx2PIVZbzRP6LFj4AyWkk1EgD
         yk5RgO8k790PPgChDBTTWG1uQj0WsYwh+6ML03Ks6h94ewsuXSstQV4CH6k4kVC8nIas
         P0UTufUP82MTDmZs6hLbjRCAJLr+aNjsoL+Xrpz2zA07lJZ4J8UhAS11lpGW4yzlfZXM
         X/pK4RPCIAfMVxRsZOH2w2heEx+1eYIgLkfhVSHyrtQjH1x3MbakU4rw5FAaI9MGRj/3
         /XpA==
X-Gm-Message-State: AOUpUlEjeb89Np4p34+EoMcacChT/dsLUJjCV+eMerIruOkvdqlj2AJI
        9+WzNhad6o9tEJyS2BciLECc
X-Google-Smtp-Source: AAOMgpcAE95Zf1MOCYSt4k782M2EBgKMS2EtIwnngspvs+qwmIx95uhj+yCtqQS8Xz2DErmoCh2d4Q==
X-Received: by 2002:a17:902:ab94:: with SMTP id f20-v6mr489119plr.231.1532581659476;
        Wed, 25 Jul 2018 22:07:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6208:6a6e:a8cb:6394:3bdf:2b97])
        by smtp.gmail.com with ESMTPSA id y4-v6sm492540pfm.137.2018.07.25.22.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 22:07:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org, dmaengine@vger.kernel.org,
        liuwei@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/4] arm64: dts: actions: Add Actions Semi S900 DMA Controller
Date:   Thu, 26 Jul 2018 10:36:56 +0530
Message-Id: <20180726050658.1399-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726050658.1399-1-manivannan.sadhasivam@linaro.org>
References: <20180726050658.1399-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMA controller node for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 7ae8b931f000..2e8178e50832 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -191,6 +191,19 @@
 				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		dma: dma-controller@e0260000 {
+			compatible = "actions,s900-dma";
+			reg = <0x0 0xe0260000 0x0 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			dma-channels = <12>;
+			dma-requests = <46>;
+			clocks = <&cmu CLK_DMAC>;
+		};
+
 		timer: timer@e0228000 {
 			compatible = "actions,s900-timer";
 			reg = <0x0 0xe0228000 0x0 0x8000>;
-- 
2.17.1

