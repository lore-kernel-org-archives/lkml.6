Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD59C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748BB223FD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuXdaSZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748BB223FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeHJMWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:22:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45899 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbeHJMWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:22:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so4150383pgq.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m7omJghwxry92mB545Mlp7I5QhKBRVC7Mla03NRy+O4=;
        b=YuXdaSZPOcUZGWicnsdd5aQ0bxt9kAq5u11vC0dNJA6nntRT7TtR+wZpTtWo7S0SiM
         K9NPtvPF1J6gyxNmMfM+Ib6Hrcx6AjTdTPc21H1nrd9VXePJOGGOCzVA9VIY8Xx2fCop
         K8HggOPeYhYh+wmAF4vWryB4F+1OhSaG9S5Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m7omJghwxry92mB545Mlp7I5QhKBRVC7Mla03NRy+O4=;
        b=gL9hyzeewq7LQ49gLHV3gsDRYhnOE4z1bTMw1DBY/iyXkVwdX/EbVHFZlgV9YqTaQf
         As/1fj3DR+SewN51L14XFDaZ5ICLSH8sT7WglU5C8qH/ed5tOhBng8pbAQM/HW6+euh5
         WaIC/iMZMSj+VJ9d5cQ1n8/FhdDXs6nAwK+nOa7sJtmSuJz0KCpsPxCdpwxByJb+HdR2
         IQHQCY7AO0bzuWl+DnWiRosCCu9g2ganKbNMmzL68V3zxZhFGjQtmlo3e0G9r92abMmi
         kYEdzhgYQqLtASy8iAaeYjD/Jh3SjWrd2cly+9q9Xg5oiWv528wf3/UPPdV2a0NQFsqH
         DyyQ==
X-Gm-Message-State: AOUpUlE41RXtAnzUwzsDFjtQZcOiezx+XSpWDG0L94oCc2HhiiypCza8
        hEAj4O5GA9SK+e6cTLjYfigQ
X-Google-Smtp-Source: AA+uWPzDMrlshO0VTWf9rXr/miMWMAl8l5qeLWTiPXkZM14vfF+jDXSDC9003eRcm+Uur+jAL6CLOQ==
X-Received: by 2002:a63:7252:: with SMTP id c18-v6mr5592481pgn.186.1533894781179;
        Fri, 10 Aug 2018 02:53:01 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id n83-v6sm25315120pfk.19.2018.08.10.02.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:53:00 -0700 (PDT)
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
Subject: [PATCH v3 4/9] dt-bindings: reset: Add binding constants for Actions Semi S900 RMU
Date:   Fri, 10 Aug 2018 15:21:08 +0530
Message-Id: <20180810095113.25292-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding constants for Actions Semi S900 SoC Reset
Management Unit (RMU).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

