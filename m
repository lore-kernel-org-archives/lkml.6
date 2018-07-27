Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DFEC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D7C20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7CIHwkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D7C20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389218AbeG0UKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:10:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41086 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389175AbeG0UKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:10:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so3716509pgu.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8n2+FQu2Gvxo8gy/+Jn/czegVyy44F6EmBEtJeMy3jE=;
        b=N7CIHwkY0uhHSsViLqspshX2I5d/5rzGCpQTC05Gdtti8JL3pXZVkC8/OYn2lGtEWR
         0VWMgfFEMmaPklElEp7J7EYHj/pHZHMirsg+LIYNuvwdvLvAJw32o/EJbX8xYjzfiU5v
         xWFHcz6fwTUTV5JSt51gBtdCmhX8fcRSM6VH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8n2+FQu2Gvxo8gy/+Jn/czegVyy44F6EmBEtJeMy3jE=;
        b=tI3TzHgMfrIx+Nb4tdKYtn9lEuqLfP0nyZygIigu49rJunJyFlYpfhwj39crL+WlIG
         qYRg2/ZvZ089uUTN8ZQDO9THRWxMO4wl8HF/vzzX79gRjlFA3DnJThOkL2njjMc6RVo5
         9xp06IqUUDRJuixrcwV4TAROKZ6D+VjpX2GP8TrPnMOjhd+a7n02n/L8f66uWMkfcNbI
         uBAygSwIaCODgXuv4W6+ScBFlqd07ztBwQII1Fjje4cEsc8tHyxFvI1VkvSyoB6XW5dC
         AROps4GDwYLx39PI3jctOWBUcs25qZ6nyefP/hAn3cl/jh94xUAF0kSpvz6UWC14vhcL
         FDhQ==
X-Gm-Message-State: AOUpUlHLyxYbCKeB9NXTW+IxZB+8UV0ZgS10fwbBk7c/R4voBqaf1F6S
        56f4onp8iNXf19GQfy0JMltH
X-Google-Smtp-Source: AAOMgpfGzm85dog72XWtM2q+4F06MSHi3UGfBQuEM7ZmRsSEmMwn42QiT4godgEjd736eQZDOGzlSg==
X-Received: by 2002:a62:384:: with SMTP id 126-v6mr7745458pfd.11.1532717249180;
        Fri, 27 Jul 2018 11:47:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7308:c330:41b:cc59:b463:ec7b])
        by smtp.gmail.com with ESMTPSA id t69-v6sm13817959pfj.7.2018.07.27.11.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 11:47:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/9] dt-bindings: reset: Add binding constants for Actions Semi S900 RMU
Date:   Sat, 28 Jul 2018 00:15:22 +0530
Message-Id: <20180727184527.13287-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding constants for Actions Semi S900 SoC Reset
Management Unit (RMU).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../dt-bindings/reset/actions,s900-reset.h    | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 include/dt-bindings/reset/actions,s900-reset.h

diff --git a/include/dt-bindings/reset/actions,s900-reset.h b/include/dt-bindings/reset/actions,s900-reset.h
new file mode 100644
index 000000000000..42c19d02e43b
--- /dev/null
+++ b/include/dt-bindings/reset/actions,s900-reset.h
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+//
+// Device Tree binding constants for Actions Semi S900 Reset Management Unit
+//
+// Copyright (c) 2018 Linaro Ltd.
+
+#ifndef __DT_BINDINGS_ACTIONS_S900_RESET_H
+#define __DT_BINDINGS_ACTIONS_S900_RESET_H
+
+#define RESET_CHIPID				0
+#define RESET_CPU_SCNT				1
+#define RESET_SRAMI				2
+#define RESET_DDR_CTL_PHY			3
+#define RESET_DMAC				4
+#define RESET_GPIO				5
+#define RESET_BISP_AXI				6
+#define RESET_CSI0				7
+#define RESET_CSI1				8
+#define RESET_DE				9
+#define RESET_DSI				10
+#define RESET_GPU3D_PA				11
+#define RESET_GPU3D_PB				12
+#define RESET_HDE				13
+#define RESET_I2C0				14
+#define RESET_I2C1				15
+#define RESET_I2C2				16
+#define RESET_I2C3				17
+#define RESET_I2C4				18
+#define RESET_I2C5				19
+#define RESET_IMX				20
+#define RESET_NANDC0				21
+#define RESET_NANDC1				22
+#define RESET_SD0				23
+#define RESET_SD1				24
+#define RESET_SD2				25
+#define RESET_SD3				26
+#define RESET_SPI0				27
+#define RESET_SPI1				28
+#define RESET_SPI2				29
+#define RESET_SPI3				30
+#define RESET_UART0				31
+#define RESET_UART1				32
+#define RESET_UART2				33
+#define RESET_UART3				34
+#define RESET_UART4				35
+#define RESET_UART5				36
+#define RESET_UART6				37
+#define RESET_HDMI				38
+#define RESET_LVDS				39
+#define RESET_EDP				40
+#define RESET_USB2HUB				41
+#define RESET_USB2HSIC				42
+#define RESET_USB3				43
+#define RESET_PCM1				44
+#define RESET_AUDIO				45
+#define RESET_PCM0				46
+#define RESET_SE				47
+#define RESET_GIC				48
+#define RESET_DDR_CTL_PHY_AXI			49
+#define RESET_CMU_DDR				50
+#define RESET_DMM				51
+#define RESET_HDCP2TX				52
+#define RESET_ETHERNET				53
+
+#endif /* __DT_BINDINGS_ACTIONS_S900_RESET_H */
-- 
2.17.1

