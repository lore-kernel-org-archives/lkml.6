Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36A4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A879920832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrSfjSua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A879920832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeK2AzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:55:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36629 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeK2AzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:55:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so9544276pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
        b=ZrSfjSuaCoaLwDdqvwLg594jNZTxDQtDGKueO/sDG2oAKS90l8k5Cm6LVB3+qZH3Xb
         doJwIdMKUo4WHLb+WdFc4Vrpk5BZj+ShHk+RI4uC62KdhJH4pUirJ/5LW27uXYfaM/Si
         h/ntBy5qvtnxYuDkSkFG+z6YZwfcVzFnK6PIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
        b=qy7ki7Vn3Nv1ocF7B2pZ52Wb8YRGrXxtyISQA/wl5LpSwR0ekpMikQGhrJ8bPOnZFD
         8iDSZtMMTRu5ngAbgR1TWpnCwfLDXkLTOG79+hqEU/axDPBtOv6FOLgEHqnYd/X+nRTw
         Jk2Z5VizRRrhymBHTw0gtDhdLW+/3S2wGYEbei9hNt8uCFMoxvWvCnkjwPDzl3eDKglK
         RCZixOzLqXl/C8Ef9Z9NPu1jcump/NbozFM4mBCCzUTSB7lrYceXNutOS0sEa6Y9cAH1
         keOXJSFaW68f5ahBde48D8DM7sKeqdmHSMwC1WezeLSKTLu35frvKGECSbf5YtALpwgz
         Ox3w==
X-Gm-Message-State: AA+aEWarkhCRVs5dILkRVvyM/HLt7Jv8ZHbD3eSDiWXGtYkONptC0fKT
        Tyd9rtlUX5Lp6gEvVSWIFatG
X-Google-Smtp-Source: AFSGD/VDLzJYCupstJP6fDPUivqSLi2/ERluEGsMSuUy9E5ROHKxW+pl2Hj4LN9jNwveqPMZnm9/jw==
X-Received: by 2002:a65:534b:: with SMTP id w11mr33350973pgr.125.1543413206325;
        Wed, 28 Nov 2018 05:53:26 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:53:25 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 13/15] arm: dts: rda8810pl: Add interrupt support for UART
Date:   Wed, 28 Nov 2018 19:21:04 +0530
Message-Id: <20181128135106.9255-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt support for UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index 84baa4c0a14c..19cde895bf65 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -71,18 +71,21 @@
 		uart1: serial@0 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x0 0x1000>;
+			interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		uart2: serial@10000 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x10000 0x1000>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		uart3: serial@90000 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 	};
-- 
2.17.1

