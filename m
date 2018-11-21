Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B17FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D6B213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uq7l61FK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D6B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeKUOKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:10:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36377 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeKUOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:10:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id y6-v6so3380545plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1KWePsWaBzwLQi7BjylxNbKfiBht2SJGcZ6HLjFNIc=;
        b=Uq7l61FK2hkFYDcIF/7AYAttg4dHsxzr8gH/8SQofU3BZFwjSPrc6HaEMMHXJ/0ltw
         8gpc76+gMb5EhfJMZFOr/im5nPIZORPQZ0g3jS6e37CYXKaKwm28vuYdQexR3vBQsMa7
         hDrnd10MuZywIW8ypa9HTY+z2tvFAC0wphzMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1KWePsWaBzwLQi7BjylxNbKfiBht2SJGcZ6HLjFNIc=;
        b=Cjxi0qT5Mkhqp9Hpz7xCIn2A3jYD79bKqrE0S+Jr6TCFOdJ7ys0v+mxw0ui/vI1/0t
         rhM661BRYmI++O55JTkrqDqiF7jNdugpjnP4GIDBGwL6SXWYCSpUPg9rpsrX6r4Z3iBl
         ykE/c1C2RAHnhQlwZNThj03FY4rGi99j1nFsaX19N49Ba+vL9oCcENu0JvNf+vStmXOO
         tnVu0faZVOCmzXF6W5V1RVpOjC+gGXwScwl93EpzX06cbw9hZckbd2BYF3LLvoPeTy/V
         FPyD+6Q0q9Hdr9E+XMvm8t0oQJwDYLFowAFWTQH5eTenhwR4EpHBu2LILku+yMQlyzbq
         vSdg==
X-Gm-Message-State: AA+aEWYUhAx0bx4AfRhESMc2/uuDNRCUiPBLW3AZdfkHYv4/yv7RhkMM
        d5uwuS8VQkTX1pElbcsMJmeG
X-Google-Smtp-Source: AFSGD/X+aXeNEz7FORAdHdi0RD1vt1pPmVaA0g46+ABcyIbjbDHcL5I/UlIKU8ojx/A1HkKyf5BypQ==
X-Received: by 2002:a17:902:854b:: with SMTP id d11-v6mr5126362plo.205.1542771463658;
        Tue, 20 Nov 2018 19:37:43 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:37:43 -0800 (PST)
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
Subject: [PATCH v2 03/15] ARM: Prepare RDA8810PL SoC
Date:   Wed, 21 Nov 2018 09:06:40 +0530
Message-Id: <20181121033652.12247-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Introduce ARCH_RDA and mach-rda for RDA Micro SoCs.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/Kconfig           | 2 ++
 arch/arm/Makefile          | 1 +
 arch/arm/mach-rda/Kconfig  | 7 +++++++
 arch/arm/mach-rda/Makefile | 1 +
 4 files changed, 11 insertions(+)
 create mode 100644 arch/arm/mach-rda/Kconfig
 create mode 100644 arch/arm/mach-rda/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d8df65..084f0983e6b2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -804,6 +804,8 @@ source "arch/arm/plat-pxa/Kconfig"
 
 source "arch/arm/mach-qcom/Kconfig"
 
+source "arch/arm/mach-rda/Kconfig"
+
 source "arch/arm/mach-realview/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 05a91d8b89f3..10056ccdb8be 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -202,6 +202,7 @@ machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
 machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_QCOM)		+= qcom
+machine-$(CONFIG_ARCH_RDA)		+= rda
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
new file mode 100644
index 000000000000..dafab78d7aab
--- /dev/null
+++ b/arch/arm/mach-rda/Kconfig
@@ -0,0 +1,7 @@
+menuconfig ARCH_RDA
+	bool "RDA Micro SoCs"
+	depends on ARCH_MULTI_V7
+	select COMMON_CLK
+	select GENERIC_IRQ_CHIP
+	help
+	  This enables support for the RDA Micro 8810PL SoC family.
diff --git a/arch/arm/mach-rda/Makefile b/arch/arm/mach-rda/Makefile
new file mode 100644
index 000000000000..6bea3d3a2dd7
--- /dev/null
+++ b/arch/arm/mach-rda/Makefile
@@ -0,0 +1 @@
+obj- += dummy.o
-- 
2.17.1

