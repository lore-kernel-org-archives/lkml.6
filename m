Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5313C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CA820840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQwdBQRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CA820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbeHAFYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:24:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38229 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732998AbeHAFYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:24:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so7118398pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 20:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M7OYzCo+MTkBBAhtXTEUhwR+M+Mzm5uYQjGa03VQRRQ=;
        b=eQwdBQRjut1X7ipS/tHZLRByxGcWzAjH38jgUhYt5SpllPcqPF9FfHVJWjkh5Oaw1i
         RqoDYnAt/kEB3oIvoqyLiSVc3LN9zKeCR6SwdLTcAAuA3EoQOlYwP+21YnHL0DH3Gx/S
         B+dyQpgIdTHGZyW6/JMmPSmEUg4U8MODm1q40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M7OYzCo+MTkBBAhtXTEUhwR+M+Mzm5uYQjGa03VQRRQ=;
        b=Z+ODeN3PeVp+wSUuLNv9sJBpzp7smlPNBZt6CnYP/d0TdXH9S+Qqhu8dxsAwrnDRVr
         0ljhnKu84La8Pc8/Kbx7TbjT1KH+8mETHerNkf8CK/xUpUpaAHhZELGve9+7iR7vIrqx
         l6/eXL2/vn67F1Mk1riwx2vzKk2XOuPJ+N1McLGjjFnNlufBMbUbbVuqj7x1gbGz6/X7
         Do7A89SMXeE4WGxBS2pKF+TYHVVnnTAOsiHd8H7Y2qXuDCjskMGNmJMafj24+f8SBDl3
         UvK1SaCSKWK92JqwK+rgZ6bcrkUpM5Kg56aTa48YlN6GpgTefrqg3YXIGAFxDQzV6BDi
         0fDA==
X-Gm-Message-State: AOUpUlGDlD4JRgHFu7akC7ofwKPpRAX3m/KvuBhg9QQUbGZCrAdh7n8Q
        884TCwsCq2uwzPd2fRC2yqSL
X-Google-Smtp-Source: AAOMgpduwT+DsDhYgRh9DAklwY/81Dw/LgQ5EL5v3BnIE4pSZNQN63qg6rytdCqV4oUEvdXw540mTg==
X-Received: by 2002:a63:d309:: with SMTP id b9-v6mr22821207pgg.163.1533094842491;
        Tue, 31 Jul 2018 20:40:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730e:f0ae:ac4e:9cdd:28a2:4bf9])
        by smtp.gmail.com with ESMTPSA id d19-v6sm34879545pgi.50.2018.07.31.20.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 20:40:41 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org, lee.jones@linaro.org,
        arnd@arndb.de
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 05/10] dt-bindings: reset: Add Actions Semi S700 SoC RMU support
Date:   Wed,  1 Aug 2018 09:09:10 +0530
Message-Id: <20180801033915.15880-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RMU (Reset Management Unit) support for the Actions Semi S700
SoC which is a part of the Actions Semi Owl family series.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/reset/actions,owl-reset.txt      |  8 +++--
 include/dt-bindings/reset/actions,s700-rmu.h  | 34 +++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/reset/actions,s700-rmu.h

diff --git a/Documentation/devicetree/bindings/reset/actions,owl-reset.txt b/Documentation/devicetree/bindings/reset/actions,owl-reset.txt
index 38e2c7051d86..a29950cb2db0 100644
--- a/Documentation/devicetree/bindings/reset/actions,owl-reset.txt
+++ b/Documentation/devicetree/bindings/reset/actions,owl-reset.txt
@@ -7,12 +7,14 @@ controller binding usage.
 The RMU registers are part of the system-controller block on Owl SoCs.
 
 Required properties:
-- compatible: Should be "actions,s900-rmu"
+- compatible: Should be one of the following,
+       "actions,s900-rmu"
+       "actions,s700-rmu"
 - #reset-cells: Should be 1
 
 All available resets are defined as preprocessor macros in corresponding
-dt-bindings/reset/actions,s900-rmu.h header and can be used in device
-tree sources.
+dt-bindings/reset/actions,s900-rmu.h or actions,s700-rmu.h header and can
+be used in device tree sources.
 
 Parent node should have the following properties :
 - compatible: "syscon", "simple-mfd"
diff --git a/include/dt-bindings/reset/actions,s700-rmu.h b/include/dt-bindings/reset/actions,s700-rmu.h
new file mode 100644
index 000000000000..8c5d4d1b8bd4
--- /dev/null
+++ b/include/dt-bindings/reset/actions,s700-rmu.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+//
+// Device Tree binding constants for Actions Semi S700 Reset Management Unit
+//
+// Copyright (c) 2018 Linaro Ltd.
+
+#ifndef _DT_BINDINGS_ACTIONS_S700_RESET_H
+#define _DT_BINDINGS_ACTIONS_S700_RESET_H
+
+#define S700_RESET_AUDIO		0
+#define S700_RESET_CSI			1
+#define S700_RESET_DE			2
+#define S700_RESET_DSI			3
+#define S700_RESET_GPIO			4
+#define S700_RESET_I2C0			5
+#define S700_RESET_I2C1			6
+#define S700_RESET_I2C2			7
+#define S700_RESET_I2C3			8
+#define S700_RESET_KEY			9
+#define S700_RESET_LCD0			10
+#define S700_RESET_SI			11
+#define S700_RESET_SPI0			12
+#define S700_RESET_SPI1			13
+#define S700_RESET_SPI2			14
+#define S700_RESET_SPI3			15
+#define S700_RESET_UART0		16
+#define S700_RESET_UART1		17
+#define S700_RESET_UART2		18
+#define S700_RESET_UART3		19
+#define S700_RESET_UART4		20
+#define S700_RESET_UART5		21
+#define S700_RESET_UART6		22
+
+#endif /* _DT_BINDINGS_ACTIONS_S700_RESET_H */
-- 
2.17.1

