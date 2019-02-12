Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9210C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22E020449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="m/Q6M+Ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfBLKlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:41:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40631 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbfBLKjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so2078577wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fA+uLGx9M+6AGQxmQT53ySxAJPrPBENTyOLtHiIytQw=;
        b=m/Q6M+OvrW4I/qo0iwyh9z2j34nvBqBtTF/aieEjVNfGoyiP1XSRN1iHJEn/2NB6mA
         C5Hxr+u3/NuTB+uc0uwKI5fEmNtzswu11p4SXEWJziKf2RTnLhR/XyN1QrMHEbDgclGn
         hEaA0oVR+/5kYZ2cSDmKsSWNkNsn4cTd4VO7V7j38rcM/35YKkSVwca7uvUlmA3lhkqI
         SfMDcWsK0BV/QMLkJQwc8JWxKkGgGnFGgqgL/TWmOF7sxQOgXojICO6+4Ezh1H09/MDH
         LcZidoiSzlFR5N6oxajiylIMJnlTIWVBeVWhGZaRiMv0MzaS7AQKHKQ2b5t2GO5edpRD
         3Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fA+uLGx9M+6AGQxmQT53ySxAJPrPBENTyOLtHiIytQw=;
        b=YQrQ2sZ15nytKFfMTE5O8M0FFa0uKC3p/UXAN1+WG2ogvKraeqeL1GwN7m08P+ZjZy
         Iu7uYq4FBptcrTLgkjsVQRzXYJZTYUcw41OniYwovP+UKY50Itv+yT1rF5CVO/H0Mmmh
         QbLUcHcQn3XCpPofwLLWfybBDW9WuQ/e0pgGMJS1Pdng4yGrQ/3Cjmw/BZcu45EWS1Kp
         +3CXiYLvzxWk9ePN6QrsN3GmjoW0D0u3yINNh4iIcrfoQZ8nnQzG5PMcuDyrX6XMxGtq
         GQO46gDiEe7aaGtaATgjI/SyhLE30S5MJIHvfn91Nlm6I3dNrpuvlZjQJH4ThqD8CnKB
         upgg==
X-Gm-Message-State: AHQUAuZxIFFXB2Fzy8ZoJsA3gshH9eudhjS/lX+u6k/uovfUHG1a7bgw
        lbGOLMjhcJXm95+RDH70W+mIiw==
X-Google-Smtp-Source: AHgI3IYYIzIVWhqLoxnYNJI5PNq+PKAxihOOi80YUF2KNzzzsduA4+tgDzzRyvpeh0qCZ3g71khh6Q==
X-Received: by 2002:adf:91a7:: with SMTP id 36mr2209584wri.77.1549967947447;
        Tue, 12 Feb 2019 02:39:07 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 09/37] ARM: davinci: make irqs.h a local header
Date:   Tue, 12 Feb 2019 11:38:07 +0100
Message-Id: <20190212103835.7768-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The existence of irqs.h in mach-davinci/include/mach only makes sense
without SPARSE_IRQ as it's then expected to define NR_IRQS and is
included from asm/irq.h. As we now support SPARSE_IRQ, this header can
be moved to mach-davinci and used as the source of HW interrupt numbers.

While updating the includes in various files - also rearrange the
headers by directory (linux/asm/mach).

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c         | 5 +++--
 arch/arm/mach-davinci/board-da850-evm.c         | 5 +++--
 arch/arm/mach-davinci/board-dm644x-evm.c        | 7 ++++---
 arch/arm/mach-davinci/board-dm646x-evm.c        | 3 ++-
 arch/arm/mach-davinci/da830.c                   | 2 +-
 arch/arm/mach-davinci/da850.c                   | 2 +-
 arch/arm/mach-davinci/devices-da8xx.c           | 2 +-
 arch/arm/mach-davinci/devices.c                 | 9 ++++-----
 arch/arm/mach-davinci/dm355.c                   | 2 +-
 arch/arm/mach-davinci/dm365.c                   | 2 +-
 arch/arm/mach-davinci/dm644x.c                  | 2 +-
 arch/arm/mach-davinci/dm646x.c                  | 2 +-
 arch/arm/mach-davinci/irq.c                     | 3 ++-
 arch/arm/mach-davinci/{include/mach => }/irqs.h | 0
 arch/arm/mach-davinci/usb-da8xx.c               | 3 ++-
 arch/arm/mach-davinci/usb.c                     | 6 +++---
 16 files changed, 30 insertions(+), 25 deletions(-)
 rename arch/arm/mach-davinci/{include/mach => }/irqs.h (100%)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 41f5a51fee9a..7b8c4aeca096 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -36,11 +36,12 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
-#include "cp_intc.h"
 #include <mach/mux.h>
 #include <mach/da8xx.h>
 
+#include "cp_intc.h"
+#include "irqs.h"
+
 #define DA830_EVM_PHY_ID		""
 /*
  * USB1 VBUS is controlled by GPIO1[15], over-current is reported on GPIO2[4].
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 317f48560534..b0814bd30a1f 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -43,10 +43,11 @@
 #include <linux/spi/flash.h>
 
 #include <mach/common.h>
-#include "cp_intc.h"
 #include <mach/da8xx.h>
 #include <mach/mux.h>
-#include <mach/irqs.h>
+
+#include "cp_intc.h"
+#include "irqs.h"
 #include "sram.h"
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 16ffed2525e6..a6bc48c9ecd9 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -36,10 +36,10 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
-#include <linux/platform_data/i2c-davinci.h>
-#include <mach/serial.h>
 #include <mach/mux.h>
+#include <mach/serial.h>
+
+#include <linux/platform_data/i2c-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mmc-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
@@ -47,6 +47,7 @@
 #include <linux/platform_data/ti-aemif.h>
 
 #include "davinci.h"
+#include "irqs.h"
 
 #define DM644X_EVM_PHY_ID		"davinci_mdio-0:01"
 #define LXT971_PHY_ID	(0x001378e2)
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 8d5be6dd2019..26c123f35350 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -44,10 +44,11 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
+
 #include <mach/serial.h>
 
 #include "davinci.h"
+#include "irqs.h"
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index aa8da725a325..ca903c9105e4 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -19,9 +19,9 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/irqs.h>
 #include <mach/time.h>
 
+#include "irqs.h"
 #include "mux.h"
 
 /* Offsets of the 8 compare registers on the da830 */
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index d22b19833326..486d53481636 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -32,10 +32,10 @@
 #include <mach/cpufreq.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/irqs.h>
 #include <mach/pm.h>
 #include <mach/time.h>
 
+#include "irqs.h"
 #include "mux.h"
 
 #define DA850_PLL1_BASE		0x01e1a000
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 3104a3eb2ddf..b8dc674e06bc 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -25,10 +25,10 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/time.h>
-#include <mach/irqs.h>
 
 #include "asp.h"
 #include "cpuidle.h"
+#include "irqs.h"
 #include "sram.h"
 
 #define DA8XX_TPCC_BASE			0x01c00000
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 722c463f9b18..40bd8029e457 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -11,21 +11,20 @@
 
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/i2c-davinci.h>
+#include <linux/platform_data/mmc-davinci.h>
+#include <linux/platform_data/edma.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
 
 #include <mach/hardware.h>
-#include <linux/platform_data/i2c-davinci.h>
-#include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <mach/mux.h>
-#include <linux/platform_data/mmc-davinci.h>
 #include <mach/time.h>
-#include <linux/platform_data/edma.h>
-
 
 #include "davinci.h"
+#include "irqs.h"
 
 #define DAVINCI_I2C_BASE	     0x01C21000
 #define DAVINCI_ATA_BASE	     0x01C66000
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index cb725244fa13..b27ea4fc1d51 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -26,13 +26,13 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
 
 #include "asp.h"
 #include "davinci.h"
+#include "irqs.h"
 #include "mux.h"
 
 #define DM355_UART2_BASE	(IO_PHYS + 0x206000)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index ae1b53ea956a..d9c6ab9215a6 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -31,13 +31,13 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
 
 #include "asp.h"
 #include "davinci.h"
+#include "irqs.h"
 #include "mux.h"
 
 #define DM365_REF_FREQ		24000000	/* 24 MHz on the DM365 EVM */
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 5ccb49196a71..b2748c82b747 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -23,13 +23,13 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
 
 #include "asp.h"
 #include "davinci.h"
+#include "irqs.h"
 #include "mux.h"
 
 /*
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 2b55625e8fb5..cf210741dfe5 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -24,13 +24,13 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
 
 #include "asp.h"
 #include "davinci.h"
+#include "irqs.h"
 #include "mux.h"
 
 #define DAVINCI_VPIF_BASE       (0x01C12000)
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 34b0eec4de4e..5bfbd9c70a2e 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -28,10 +28,11 @@
 #include <mach/hardware.h>
 #include <mach/cputype.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
+#include "irqs.h"
+
 #define FIQ_REG0_OFFSET		0x0000
 #define FIQ_REG1_OFFSET		0x0004
 #define IRQ_REG0_OFFSET		0x0008
diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/irqs.h
similarity index 100%
rename from arch/arm/mach-davinci/include/mach/irqs.h
rename to arch/arm/mach-davinci/irqs.h
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 2de5a04ffc24..25f21ee86f1a 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -18,7 +18,8 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/irqs.h>
+
+#include "irqs.h"
 
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index 9d4a58a3113a..1e14e964c34d 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -5,13 +5,13 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-
+#include <linux/platform_data/usb-davinci.h>
 #include <linux/usb/musb.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/cputype.h>
-#include <linux/platform_data/usb-davinci.h>
+
+#include "irqs.h"
 
 #define DAVINCI_USB_OTG_BASE	0x01c64000
 
-- 
2.20.1

