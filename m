Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8528F2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="MBnQ77Ch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8528F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbeHWQrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:47:46 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55104 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeHWQrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:47:45 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/4] clk: ingenic: Add proper Kconfig entries
Date:   Thu, 23 Aug 2018 15:17:41 +0200
Message-Id: <20180823131744.744-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535030277; bh=A+57HMvsMvXzZlM0c0kOXJ+ywgGecPlH8r9R60Puapc=; h=From:To:Cc:Subject:Date:Message-Id; b=MBnQ77Ch8duc/ktlEQSxWxn7hc8ebS1Ne0ht9uVo1pa4dA5rBIl+HIXRM78UWZ4VJ9WRQKGonxtsyrbYc0HEt4edKujxsLUx9kvvXi5lfR0d6BWd1ZXJublEMeAY9N8VYJcfZgLXCrtKRrxZg1QkwuewkfM/MwSNy7dzxNMU4j8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the CGU code corresponding to the SoC for which we're
compiling the kernel was the only one enabled, which made it impossible
to build one kernel that supports them all.

Now, it is possible to select more than one SoC to support.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Drop dependency on COMPILE_TEST since it does not compile fine on
        non-MIPS architectures.

 drivers/clk/Kconfig          |  1 +
 drivers/clk/Makefile         |  2 +-
 drivers/clk/ingenic/Kconfig  | 37 +++++++++++++++++++++++++++++++++++++
 drivers/clk/ingenic/Makefile |  8 ++++----
 4 files changed, 43 insertions(+), 5 deletions(-)
 create mode 100644 drivers/clk/ingenic/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 721572a8c429..95a9627cdf1d 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -281,6 +281,7 @@ source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
+source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
 source "drivers/clk/meson/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 0bb25dd009d1..3b3da7d84496 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -71,7 +71,7 @@ obj-$(CONFIG_H8300)			+= h8300/
 obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
 obj-y					+= imgtec/
 obj-$(CONFIG_ARCH_MXC)			+= imx/
-obj-$(CONFIG_MACH_INGENIC)		+= ingenic/
+obj-y					+= ingenic/
 obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
 obj-$(CONFIG_MACH_LOONGSON32)		+= loongson1/
 obj-y					+= mediatek/
diff --git a/drivers/clk/ingenic/Kconfig b/drivers/clk/ingenic/Kconfig
new file mode 100644
index 000000000000..2445437f8286
--- /dev/null
+++ b/drivers/clk/ingenic/Kconfig
@@ -0,0 +1,37 @@
+menu "Ingenic JZ47xx CGU drivers"
+	depends on MIPS
+
+config INGENIC_CGU_COMMON
+	bool
+
+config INGENIC_CGU_JZ4740
+	bool "Ingenic JZ4740 CGU driver"
+	default MACH_JZ4740
+	select INGENIC_CGU_COMMON
+	help
+	  Support the clocks provided by the CGU hardware on Ingenic JZ4740
+	  and compatible SoCs.
+
+	  If building for a JZ4740 SoC, you want to say Y here.
+
+config INGENIC_CGU_JZ4770
+	bool "Ingenic JZ4770 CGU driver"
+	default MACH_JZ4770
+	select INGENIC_CGU_COMMON
+	help
+	  Support the clocks provided by the CGU hardware on Ingenic JZ4770
+	  and compatible SoCs.
+
+	  If building for a JZ4770 SoC, you want to say Y here.
+
+config INGENIC_CGU_JZ4780
+	bool "Ingenic JZ4780 CGU driver"
+	default MACH_JZ4780
+	select INGENIC_CGU_COMMON
+	help
+	  Support the clocks provided by the CGU hardware on Ingenic JZ4780
+	  and compatible SoCs.
+
+	  If building for a JZ4780 SoC, you want to say Y here.
+
+endmenu
diff --git a/drivers/clk/ingenic/Makefile b/drivers/clk/ingenic/Makefile
index 1456e4cdb562..8b8dc79c7ce6 100644
--- a/drivers/clk/ingenic/Makefile
+++ b/drivers/clk/ingenic/Makefile
@@ -1,4 +1,4 @@
-obj-y				+= cgu.o
-obj-$(CONFIG_MACH_JZ4740)	+= jz4740-cgu.o
-obj-$(CONFIG_MACH_JZ4770)	+= jz4770-cgu.o
-obj-$(CONFIG_MACH_JZ4780)	+= jz4780-cgu.o
+obj-$(CONFIG_INGENIC_CGU_COMMON)	+= cgu.o
+obj-$(CONFIG_INGENIC_CGU_JZ4740)	+= jz4740-cgu.o
+obj-$(CONFIG_INGENIC_CGU_JZ4770)	+= jz4770-cgu.o
+obj-$(CONFIG_INGENIC_CGU_JZ4780)	+= jz4780-cgu.o
-- 
2.11.0

