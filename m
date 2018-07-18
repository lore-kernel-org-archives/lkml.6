Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5962ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FD22075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMD+M0q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FD22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeGRUsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:48:36 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42725 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeGRUsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:48:35 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so746163plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6S1u3ITpyUtI8f9vLjRwxawapUb4nLplEzTrLhyW53o=;
        b=JMD+M0q7CpGABkRdEhGBe7lJwymV4jtv6c2C8/KsEkpz1ZCiGNC2ceTXuzbznokPgP
         N2cwi5Oa4SUsWb7sdd4pyEaPsQhv0wOXePcjQwcfrcqPOI+eqtAiqqXjRB/YuzIoXOkG
         WorHJnKRL+CoPs9S/cpv326KNuMnz9z2qbHMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6S1u3ITpyUtI8f9vLjRwxawapUb4nLplEzTrLhyW53o=;
        b=NpJziO+CeL76mC/zxGseyv6PZOt08ATMHEPkI5jo6whsze3WmEJWe0jeuKrJBxvpJD
         J8n9xcEbj6p9HNlQvmsA2BO6HFdtrekme2ksPVYMKBYcm2CEfLPHhOUA83CvvjopNiVk
         C/yVbu09RZ9tCKBJjGKJ+S3QiZb3tTI3tcr1Aeye6dHTsnyXOyploaQCj8kH/GayAf2K
         IcqygERooOkVIwjDVrDYcZYb36Mv0BKH02C9VvRuZ50QIANP51urX8BxU+j/fiEi0D/v
         F2DQEy2RrDlorykl+mOjrxW1durducmR+Vu9REMiwRfq9EEK3N582sXcL6rJlGz2Tc5c
         wp7w==
X-Gm-Message-State: AOUpUlF/uOKZo336O1Ofp6xxdPzjwnMEQfnGdlC0L5ZZDv7wAfKXcb3+
        e9N7hclZ1+HLR6QvNvPCyWyB
X-Google-Smtp-Source: AAOMgpejdN7d04oTaJwW9NH6JR1HFa1b6qu/5QY97JhtB6y69wjGCFBC3+JYzKDcG7WLO9k8lrQ7kQ==
X-Received: by 2002:a17:902:bd4b:: with SMTP id b11-v6mr7046055plx.243.1531944547132;
        Wed, 18 Jul 2018 13:09:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:628d:5c0b:b467:58cc:4c91:39b3])
        by smtp.gmail.com with ESMTPSA id c7-v6sm6924697pfh.25.2018.07.18.13.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 13:09:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/4] arm64: dts: actions: Add Actions Semi S900 DMA Controller
Date:   Thu, 19 Jul 2018 01:37:07 +0530
Message-Id: <20180718200709.27102-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718200709.27102-1-manivannan.sadhasivam@linaro.org>
References: <20180718200709.27102-1-manivannan.sadhasivam@linaro.org>
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

