Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0DDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F4021852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQISw3iY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeLRPDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:03:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44225 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbeLRPDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:03:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so7925210pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNPmZXdeiPat27OKf7lQvtx2gmSw3oL4RvR/cVfcbOo=;
        b=RQISw3iYiD2dHa8oqpEBLZzzHay/RB2beToYv6DQ7GzX95iLHGvbinz53De+M9r/9g
         +K4LuKo2mw/vY/D3QsXubkHyRWAq3pnUQiEy+OfoRan7L2r5FzZVb5z5cB7VrxlyX0dk
         88fHW0WLKwMgOZ7vJArJ1h4Sqej5Oqute2HzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNPmZXdeiPat27OKf7lQvtx2gmSw3oL4RvR/cVfcbOo=;
        b=jtgFSk86Rr01QbbhngYP7iSjJ0jdeHm1Y/iGmv123w5ZYsfSPFVmkXuij2ri2TKX/T
         QTLI0z0m2fVQBOT/kRP09IZQIZpDhWY/QHEuIz9Bzh//vKvwhdw0krXqJ6disLN0A7Hr
         Mz1lzLS4XAe/k1wz825FEingoPFkApKBi7ejhw0Bpi0EvosLYgqvAbUdN3ZRxuN8uv+7
         9suH9BT7V+yZAEZBdDWrazTfDkXRch95PG+3jAlfUOf0IBpM7csaw16QWd4tqLYsl6yk
         4tARWz1U2H/mfcWjtauS/mkRZ/zQiJziryiPoMTEkR80oG5SGBwMoq7lILOSgnImQyYH
         +Xyg==
X-Gm-Message-State: AA+aEWaS9k54O9fnkxAy6+2mTm3GFATWsVi+Lj+I6fln8Fi3w+mC3pmH
        lDIhZwFb/eJTNcqclHaEy6ck
X-Google-Smtp-Source: AFSGD/VhZgtTPfsawvWHIIxym/rI4Zq09WgbYG5jZW5UJB7TWWqOiK/7LkjOgfWctAgqwHhHOVakig==
X-Received: by 2002:a63:c904:: with SMTP id o4mr3147216pgg.331.1545145397568;
        Tue, 18 Dec 2018 07:03:17 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:03:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 03/11] ARM: Prepare RDA8810PL SoC
Date:   Tue, 18 Dec 2018 20:32:30 +0530
Message-Id: <20181218150238.23010-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
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
index 000000000000..4df8b8ee1a9d
--- /dev/null
+++ b/arch/arm/mach-rda/Kconfig
@@ -0,0 +1,7 @@
+menuconfig ARCH_RDA
+	bool "RDA Micro SoCs"
+	depends on ARCH_MULTI_V7
+	select RDA_INTC
+	select RDA_TIMER
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

