Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCD2C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252132084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtyXJRWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252132084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeI2OOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:14:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40926 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbeI2OOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:14:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so5794765pfj.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uVMEsprQm9gudmgxiK82x9lkc/giPgwELqLOkGrioH0=;
        b=QtyXJRWs7uIbraMJGQFWjTOq0ThdPmG7FaAZVP4W80xr2iiohY9GdxboO5o6AydQAj
         L9VssystDcpRn0Bg3N4FUXfipMUFewlZKrS8dYo9lqcUfQH1p59zvZFGPYmQB5szEuBH
         BQpDIQqhEZPDafOWCBuXssAJ8xfiehh/J5wrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uVMEsprQm9gudmgxiK82x9lkc/giPgwELqLOkGrioH0=;
        b=Jj/xGoMuoM0qaGfnsH/+jT9WUXLwoJIUwQTMXVVtd3HKQTLf7/oKfKCyImc0gQmmf4
         LjhOhzO6UsdAIAYq2NKPg5xhfnUMBYj6Htlp8hG/7SvK9DCZzZAEmpfrjDra+QYHdP2i
         aFa8/YhLY0JlJRROSRmqiAiEFcedM0nPhadTLY8opeq05RkSlIsUN88XuvglCyYW9HFm
         Xtate+UziZKqohHva8yv4ZGml4PnVc/UP6PD23BPzqeYAKQLgiCnzhzRs4nQdIKxuha5
         2gl+7DcnUXhsXdQmYbK/JfVD/AijHyQBAG/m394nmExp8+YxRAOHvKIBpu75jvNteQ2d
         Te3A==
X-Gm-Message-State: ABuFfoi+198z+cMeUWwys3mpAZ05zHpF1EshSlOAgAEQe4r6Rw6B5KBI
        2V9s4EZCVPqUgI40Idc9H+wT
X-Google-Smtp-Source: ACcGV60SMyaA3GJZNMwRYEWcWYgMOgNcXN1rCg6dOywa0iGhSTUK6gx14Om2uLC4r85WISQccMGatg==
X-Received: by 2002:a63:9e0a:: with SMTP id s10-v6mr1928388pgd.326.1538207225764;
        Sat, 29 Sep 2018 00:47:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:717:b0f2:f0af:8cc:da39:e2c3])
        by smtp.gmail.com with ESMTPSA id m21-v6sm9926570pgd.6.2018.09.29.00.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 00:47:05 -0700 (PDT)
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
Subject: [PATCH v2 1/3] arm64: dts: actions: s900: Enable Tx DMA for UART5
Date:   Sat, 29 Sep 2018 13:16:35 +0530
Message-Id: <20180929074637.9766-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929074637.9766-1-manivannan.sadhasivam@linaro.org>
References: <20180929074637.9766-1-manivannan.sadhasivam@linaro.org>
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

