Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421DEECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F016C20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYZeDePB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F016C20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbeGWFRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:17:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44669 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387769AbeGWFR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:17:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so11273714pgp.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 21:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6S1u3ITpyUtI8f9vLjRwxawapUb4nLplEzTrLhyW53o=;
        b=XYZeDePBL1n6YaT11eF/4AEvOEES+W1JiB/rlV79NwuOXDtFieT79R+iIFQnLxDUeI
         qbJiBbCXJmd5ZS0x/PFK131bctq/Pp3AG0Uc1dd4htqymn4VGgdnvPefg3l50VV4Af7h
         p1Yj5hYgreX46ZZrNR+NiONiaeNhtm8qIl4+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6S1u3ITpyUtI8f9vLjRwxawapUb4nLplEzTrLhyW53o=;
        b=YnmSSC/cOuQo4uoceEuYQ7zfy29Y+dt+y57TyzeoW7KTT+3a1eSLDKDSWmimhuDfCl
         GCrP3+XF4aUXqOla8701ygCExwSvyw3iB2zehquX31LLJIO8A2M1mSG43A/NYyHbSbp7
         xZxOskdM3sc3mgVUhcPODeRBTTiAmRitfXo2YwVTvI3rnc0VxOiW3FgtipQPXRE4iVdk
         XYlzqXON8HipfYydIGtOTMaWifU2cFo90uDcVmLRrI+0S3QGc5sxroaCaBA1KfRjdC2g
         gmgLzffjm3rpnWnLQGrcLXnJjYwJMmFEw/tbSknza5xNM4UlbwPc/fRtZN1PZV/2Chw1
         D+yg==
X-Gm-Message-State: AOUpUlHmj88CPiHoj6A32noqIbt8SMIs66N+DyCQcTA560gQIvlQ4mo3
        NtQZpfOrnSPc7IBEul174DG4
X-Google-Smtp-Source: AAOMgpfreUU4+ORski+uAZNnSCFRp3vO227FocQpGvDHMBEsjNKZI25RzZanazilCM3OntccGBuBpg==
X-Received: by 2002:a63:f206:: with SMTP id v6-v6mr10673163pgh.319.1532319497014;
        Sun, 22 Jul 2018 21:18:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:802:a98c:b568:c01f:49a2:2aa5])
        by smtp.gmail.com with ESMTPSA id i20-v6sm13369282pfj.82.2018.07.22.21.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 21:18:16 -0700 (PDT)
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
Subject: [PATCH v2 2/4] arm64: dts: actions: Add Actions Semi S900 DMA Controller
Date:   Mon, 23 Jul 2018 09:47:41 +0530
Message-Id: <20180723041743.32024-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
References: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
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

