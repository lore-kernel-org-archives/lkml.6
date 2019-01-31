Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC3DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF692085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KDpyOegR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387923AbfAaNka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35885 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbfAaNk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so3350825wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8zirslUFbMuRJ2+Uv/jUm1rRBXue3Kxa80gKIwXI0g=;
        b=KDpyOegR9UttHZU7A3OCdPN8nGCLlEmA+QEwWFr+4BhyVtk9HKAAmip+wEIevIhI4R
         3GFgCFQlEfXZx3UNS0iLxz5iPHhkN0JaKfF/zBCtikFNMxeD8CwMcB2OMpOwxWW2MH/r
         syMvcdGqFNZO4H2fX2DFrIrPEea0Onr6aXjmCcRNcJ1T5GUc7l4+neyKQOucviSD6SSX
         4RKAOLJ9Yw7QGwToKIY7QOCCmPesSBniVQrxE8kGRZUnalhKcYeGQMbn9gFjDDyrTbWJ
         dpNPfMqcAvDRus89z9P4liqgnOj4MBBtoMH2bCWuoiKQnUNHYvSv0odPa/pvd7mZzxUF
         JN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8zirslUFbMuRJ2+Uv/jUm1rRBXue3Kxa80gKIwXI0g=;
        b=RTP0o/2FRM/827LS4G3Sqtv/kqNqf7fw1AZHXFWusrjK3Ed623Qn/mjn0ZbDTJDSgE
         D1RlUL9KqTK7k0BH8Av90zA5nmTXUPiSVpOsOho+1LDlj5eZab3VgtVImQJlpm0nLu/R
         hyRucYxk1k1zON9tH7r9WJD7XEPcdP5vM0JWsnKwwkccWGUiECCaWZUtsDqqNQ0Baqy+
         AmnIWqgul+DYWx5UqmuCbWw1OZzSddWhWX6eznn/hZeCxXCmXcGclbXtfakfLiu2xmPH
         ssLkysE8E2+cj4liy3O5UQsBXraxO0knUz5BlkAv7YEgmEQC5I5txpKfvgIzRJ2FtG/9
         x6pg==
X-Gm-Message-State: AJcUukceOcyxFRsVJCKedIBYYUKa+i0TwAbqEHLp7GNrPyWS2nPjoB5l
        xzgzvrf3lYBbJ8m/Skb8ctln8w==
X-Google-Smtp-Source: ALg8bN4Mu6BWH+2DGxJU3AKBv6lRfxAr4ZximVaWWNvHWifnDhcvxp6Qc2HOoDqCqB7FFjLvmeldSg==
X-Received: by 2002:adf:c846:: with SMTP id e6mr33257588wrh.243.1548942023243;
        Thu, 31 Jan 2019 05:40:23 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 35/35] ARM: davinci: remove mach/irqs.h
Date:   Thu, 31 Jan 2019 14:39:28 +0100
Message-Id: <20190131133928.17985-36-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can now remove mach/irqs.h as there are no more users.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c   |   1 -
 arch/arm/mach-davinci/board-da850-evm.c   |   1 -
 arch/arm/mach-davinci/board-dm644x-evm.c  |   1 -
 arch/arm/mach-davinci/board-dm646x-evm.c  |   1 -
 arch/arm/mach-davinci/da830.c             |   1 -
 arch/arm/mach-davinci/da850.c             |   1 -
 arch/arm/mach-davinci/devices-da8xx.c     |   1 -
 arch/arm/mach-davinci/devices.c           |   1 -
 arch/arm/mach-davinci/dm355.c             |   1 -
 arch/arm/mach-davinci/dm365.c             |   1 -
 arch/arm/mach-davinci/dm644x.c            |   1 -
 arch/arm/mach-davinci/dm646x.c            |   1 -
 arch/arm/mach-davinci/include/mach/irqs.h | 392 ----------------------
 arch/arm/mach-davinci/usb-da8xx.c         |   1 -
 arch/arm/mach-davinci/usb.c               |   1 -
 15 files changed, 406 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/irqs.h

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 950e98e4eda5..123b424058e2 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -36,7 +36,6 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/da8xx.h>
 
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 27acba6fe5f8..1da3d79f2757 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -45,7 +45,6 @@
 #include <mach/common.h>
 #include <mach/da8xx.h>
 #include <mach/mux.h>
-#include <mach/irqs.h>
 #include "sram.h"
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index d04ce0c206b6..dac5ad9ff91c 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -36,7 +36,6 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <linux/platform_data/i2c-davinci.h>
 #include <mach/serial.h>
 #include <mach/mux.h>
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 2ddc03a95acd..b8c7c50212bc 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -44,7 +44,6 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/serial.h>
 
 #include "davinci.h"
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index a8407c1d1a68..e4d781a36aa1 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -20,7 +20,6 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/irqs.h>
 #include <mach/time.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 84b30c70ddf1..3872eedb0b23 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -33,7 +33,6 @@
 #include <mach/cpufreq.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/irqs.h>
 #include <mach/pm.h>
 #include <mach/time.h>
 
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index fda6d35c415c..262dcd0a3528 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -25,7 +25,6 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/time.h>
-#include <mach/irqs.h>
 
 #include "asp.h"
 #include "cpuidle.h"
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index b8e5c5998872..1337630868f0 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -17,7 +17,6 @@
 
 #include <mach/hardware.h>
 #include <linux/platform_data/i2c-davinci.h>
-#include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <linux/platform_data/mmc-davinci.h>
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 8d53d0c0a4a2..a653defd6418 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -27,7 +27,6 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 00d90cf81e7f..35e547a145a9 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -32,7 +32,6 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index a17ae9d66c53..a86b20ff2966 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -25,7 +25,6 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index f5506216321e..80193b8bd92a 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -26,7 +26,6 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
deleted file mode 100644
index 27c9f89f2a7f..000000000000
--- a/arch/arm/mach-davinci/include/mach/irqs.h
+++ /dev/null
@@ -1,392 +0,0 @@
-/*
- * DaVinci interrupt controller definitions
- *
- *  Copyright (C) 2006 Texas Instruments.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-#ifndef __ASM_ARCH_IRQS_H
-#define __ASM_ARCH_IRQS_H
-
-#include <asm/irq.h>
-
-/* Interrupt lines */
-#define IRQ_VDINT0       DAVINCI_INTC_IRQ(0)
-#define IRQ_VDINT1       DAVINCI_INTC_IRQ(1)
-#define IRQ_VDINT2       DAVINCI_INTC_IRQ(2)
-#define IRQ_HISTINT      DAVINCI_INTC_IRQ(3)
-#define IRQ_H3AINT       DAVINCI_INTC_IRQ(4)
-#define IRQ_PRVUINT      DAVINCI_INTC_IRQ(5)
-#define IRQ_RSZINT       DAVINCI_INTC_IRQ(6)
-#define IRQ_VFOCINT      DAVINCI_INTC_IRQ(7)
-#define IRQ_VENCINT      DAVINCI_INTC_IRQ(8)
-#define IRQ_ASQINT       DAVINCI_INTC_IRQ(9)
-#define IRQ_IMXINT       DAVINCI_INTC_IRQ(10)
-#define IRQ_VLCDINT      DAVINCI_INTC_IRQ(11)
-#define IRQ_USBINT       DAVINCI_INTC_IRQ(12)
-#define IRQ_EMACINT      DAVINCI_INTC_IRQ(13)
-
-#define IRQ_CCINT0       DAVINCI_INTC_IRQ(16)
-#define IRQ_CCERRINT     DAVINCI_INTC_IRQ(17)
-#define IRQ_TCERRINT0    DAVINCI_INTC_IRQ(18)
-#define IRQ_TCERRINT     DAVINCI_INTC_IRQ(19)
-#define IRQ_PSCIN        DAVINCI_INTC_IRQ(20)
-
-#define IRQ_IDE          DAVINCI_INTC_IRQ(22)
-#define IRQ_HPIINT       DAVINCI_INTC_IRQ(23)
-#define IRQ_MBXINT       DAVINCI_INTC_IRQ(24)
-#define IRQ_MBRINT       DAVINCI_INTC_IRQ(25)
-#define IRQ_MMCINT       DAVINCI_INTC_IRQ(26)
-#define IRQ_SDIOINT      DAVINCI_INTC_IRQ(27)
-#define IRQ_MSINT        DAVINCI_INTC_IRQ(28)
-#define IRQ_DDRINT       DAVINCI_INTC_IRQ(29)
-#define IRQ_AEMIFINT     DAVINCI_INTC_IRQ(30)
-#define IRQ_VLQINT       DAVINCI_INTC_IRQ(31)
-#define IRQ_TINT0_TINT12 DAVINCI_INTC_IRQ(32)
-#define IRQ_TINT0_TINT34 DAVINCI_INTC_IRQ(33)
-#define IRQ_TINT1_TINT12 DAVINCI_INTC_IRQ(34)
-#define IRQ_TINT1_TINT34 DAVINCI_INTC_IRQ(35)
-#define IRQ_PWMINT0      DAVINCI_INTC_IRQ(36)
-#define IRQ_PWMINT1      DAVINCI_INTC_IRQ(37)
-#define IRQ_PWMINT2      DAVINCI_INTC_IRQ(38)
-#define IRQ_I2C          DAVINCI_INTC_IRQ(39)
-#define IRQ_UARTINT0     DAVINCI_INTC_IRQ(40)
-#define IRQ_UARTINT1     DAVINCI_INTC_IRQ(41)
-#define IRQ_UARTINT2     DAVINCI_INTC_IRQ(42)
-#define IRQ_SPINT0       DAVINCI_INTC_IRQ(43)
-#define IRQ_SPINT1       DAVINCI_INTC_IRQ(44)
-
-#define IRQ_DSP2ARM0     DAVINCI_INTC_IRQ(46)
-#define IRQ_DSP2ARM1     DAVINCI_INTC_IRQ(47)
-#define IRQ_GPIO0        DAVINCI_INTC_IRQ(48)
-#define IRQ_GPIO1        DAVINCI_INTC_IRQ(49)
-#define IRQ_GPIO2        DAVINCI_INTC_IRQ(50)
-#define IRQ_GPIO3        DAVINCI_INTC_IRQ(51)
-#define IRQ_GPIO4        DAVINCI_INTC_IRQ(52)
-#define IRQ_GPIO5        DAVINCI_INTC_IRQ(53)
-#define IRQ_GPIO6        DAVINCI_INTC_IRQ(54)
-#define IRQ_GPIO7        DAVINCI_INTC_IRQ(55)
-#define IRQ_GPIOBNK0     DAVINCI_INTC_IRQ(56)
-#define IRQ_GPIOBNK1     DAVINCI_INTC_IRQ(57)
-#define IRQ_GPIOBNK2     DAVINCI_INTC_IRQ(58)
-#define IRQ_GPIOBNK3     DAVINCI_INTC_IRQ(59)
-#define IRQ_GPIOBNK4     DAVINCI_INTC_IRQ(60)
-#define IRQ_COMMTX       DAVINCI_INTC_IRQ(61)
-#define IRQ_COMMRX       DAVINCI_INTC_IRQ(62)
-#define IRQ_EMUINT       DAVINCI_INTC_IRQ(63)
-
-/* DaVinci DM6467-specific Interrupts */
-#define IRQ_DM646X_VP_VERTINT0  DAVINCI_INTC_IRQ(0)
-#define IRQ_DM646X_VP_VERTINT1  DAVINCI_INTC_IRQ(1)
-#define IRQ_DM646X_VP_VERTINT2  DAVINCI_INTC_IRQ(2)
-#define IRQ_DM646X_VP_VERTINT3  DAVINCI_INTC_IRQ(3)
-#define IRQ_DM646X_VP_ERRINT    DAVINCI_INTC_IRQ(4)
-#define IRQ_DM646X_RESERVED_1   DAVINCI_INTC_IRQ(5)
-#define IRQ_DM646X_RESERVED_2   DAVINCI_INTC_IRQ(6)
-#define IRQ_DM646X_WDINT        DAVINCI_INTC_IRQ(7)
-#define IRQ_DM646X_CRGENINT0    DAVINCI_INTC_IRQ(8)
-#define IRQ_DM646X_CRGENINT1    DAVINCI_INTC_IRQ(9)
-#define IRQ_DM646X_TSIFINT0     DAVINCI_INTC_IRQ(10)
-#define IRQ_DM646X_TSIFINT1     DAVINCI_INTC_IRQ(11)
-#define IRQ_DM646X_VDCEINT      DAVINCI_INTC_IRQ(12)
-#define IRQ_DM646X_USBINT       DAVINCI_INTC_IRQ(13)
-#define IRQ_DM646X_USBDMAINT    DAVINCI_INTC_IRQ(14)
-#define IRQ_DM646X_PCIINT       DAVINCI_INTC_IRQ(15)
-#define IRQ_DM646X_TCERRINT2    DAVINCI_INTC_IRQ(20)
-#define IRQ_DM646X_TCERRINT3    DAVINCI_INTC_IRQ(21)
-#define IRQ_DM646X_IDE          DAVINCI_INTC_IRQ(22)
-#define IRQ_DM646X_HPIINT       DAVINCI_INTC_IRQ(23)
-#define IRQ_DM646X_EMACRXTHINT  DAVINCI_INTC_IRQ(24)
-#define IRQ_DM646X_EMACRXINT    DAVINCI_INTC_IRQ(25)
-#define IRQ_DM646X_EMACTXINT    DAVINCI_INTC_IRQ(26)
-#define IRQ_DM646X_EMACMISCINT  DAVINCI_INTC_IRQ(27)
-#define IRQ_DM646X_MCASP0TXINT  DAVINCI_INTC_IRQ(28)
-#define IRQ_DM646X_MCASP0RXINT  DAVINCI_INTC_IRQ(29)
-#define IRQ_DM646X_MCASP1TXINT  DAVINCI_INTC_IRQ(30)
-#define IRQ_DM646X_RESERVED_3   DAVINCI_INTC_IRQ(31)
-#define IRQ_DM646X_VLQINT       DAVINCI_INTC_IRQ(38)
-#define IRQ_DM646X_UARTINT2     DAVINCI_INTC_IRQ(42)
-#define IRQ_DM646X_SPINT0       DAVINCI_INTC_IRQ(43)
-#define IRQ_DM646X_SPINT1       DAVINCI_INTC_IRQ(44)
-#define IRQ_DM646X_DSP2ARMINT   DAVINCI_INTC_IRQ(45)
-#define IRQ_DM646X_RESERVED_4   DAVINCI_INTC_IRQ(46)
-#define IRQ_DM646X_PSCINT       DAVINCI_INTC_IRQ(47)
-#define IRQ_DM646X_GPIO0        DAVINCI_INTC_IRQ(48)
-#define IRQ_DM646X_GPIO1        DAVINCI_INTC_IRQ(49)
-#define IRQ_DM646X_GPIO2        DAVINCI_INTC_IRQ(50)
-#define IRQ_DM646X_GPIO3        DAVINCI_INTC_IRQ(51)
-#define IRQ_DM646X_GPIO4        DAVINCI_INTC_IRQ(52)
-#define IRQ_DM646X_GPIO5        DAVINCI_INTC_IRQ(53)
-#define IRQ_DM646X_GPIO6        DAVINCI_INTC_IRQ(54)
-#define IRQ_DM646X_GPIO7        DAVINCI_INTC_IRQ(55)
-#define IRQ_DM646X_GPIOBNK0     DAVINCI_INTC_IRQ(56)
-#define IRQ_DM646X_GPIOBNK1     DAVINCI_INTC_IRQ(57)
-#define IRQ_DM646X_GPIOBNK2     DAVINCI_INTC_IRQ(58)
-#define IRQ_DM646X_DDRINT       DAVINCI_INTC_IRQ(59)
-#define IRQ_DM646X_AEMIFINT     DAVINCI_INTC_IRQ(60)
-
-/* DaVinci DM355-specific Interrupts */
-#define IRQ_DM355_CCDC_VDINT0	DAVINCI_INTC_IRQ(0)
-#define IRQ_DM355_CCDC_VDINT1	DAVINCI_INTC_IRQ(1)
-#define IRQ_DM355_CCDC_VDINT2	DAVINCI_INTC_IRQ(2)
-#define IRQ_DM355_IPIPE_HST	DAVINCI_INTC_IRQ(3)
-#define IRQ_DM355_H3AINT	DAVINCI_INTC_IRQ(4)
-#define IRQ_DM355_IPIPE_SDR	DAVINCI_INTC_IRQ(5)
-#define IRQ_DM355_IPIPEIFINT	DAVINCI_INTC_IRQ(6)
-#define IRQ_DM355_OSDINT	DAVINCI_INTC_IRQ(7)
-#define IRQ_DM355_VENCINT	DAVINCI_INTC_IRQ(8)
-#define IRQ_DM355_IMCOPINT	DAVINCI_INTC_IRQ(11)
-#define IRQ_DM355_RTOINT	DAVINCI_INTC_IRQ(13)
-#define IRQ_DM355_TINT4		DAVINCI_INTC_IRQ(13)
-#define IRQ_DM355_TINT2_TINT12	DAVINCI_INTC_IRQ(13)
-#define IRQ_DM355_UARTINT2	DAVINCI_INTC_IRQ(14)
-#define IRQ_DM355_TINT5		DAVINCI_INTC_IRQ(14)
-#define IRQ_DM355_TINT2_TINT34	DAVINCI_INTC_IRQ(14)
-#define IRQ_DM355_TINT6		DAVINCI_INTC_IRQ(15)
-#define IRQ_DM355_TINT3_TINT12	DAVINCI_INTC_IRQ(15)
-#define IRQ_DM355_SPINT1_0	DAVINCI_INTC_IRQ(17)
-#define IRQ_DM355_SPINT1_1	DAVINCI_INTC_IRQ(18)
-#define IRQ_DM355_SPINT2_0	DAVINCI_INTC_IRQ(19)
-#define IRQ_DM355_SPINT2_1	DAVINCI_INTC_IRQ(21)
-#define IRQ_DM355_TINT7		DAVINCI_INTC_IRQ(22)
-#define IRQ_DM355_TINT3_TINT34	DAVINCI_INTC_IRQ(22)
-#define IRQ_DM355_SDIOINT0	DAVINCI_INTC_IRQ(23)
-#define IRQ_DM355_MMCINT0	DAVINCI_INTC_IRQ(26)
-#define IRQ_DM355_MSINT		DAVINCI_INTC_IRQ(26)
-#define IRQ_DM355_MMCINT1	DAVINCI_INTC_IRQ(27)
-#define IRQ_DM355_PWMINT3	DAVINCI_INTC_IRQ(28)
-#define IRQ_DM355_SDIOINT1	DAVINCI_INTC_IRQ(31)
-#define IRQ_DM355_SPINT0_0	DAVINCI_INTC_IRQ(42)
-#define IRQ_DM355_SPINT0_1	DAVINCI_INTC_IRQ(43)
-#define IRQ_DM355_GPIO0		DAVINCI_INTC_IRQ(44)
-#define IRQ_DM355_GPIO1		DAVINCI_INTC_IRQ(45)
-#define IRQ_DM355_GPIO2		DAVINCI_INTC_IRQ(46)
-#define IRQ_DM355_GPIO3		DAVINCI_INTC_IRQ(47)
-#define IRQ_DM355_GPIO4		DAVINCI_INTC_IRQ(48)
-#define IRQ_DM355_GPIO5		DAVINCI_INTC_IRQ(49)
-#define IRQ_DM355_GPIO6		DAVINCI_INTC_IRQ(50)
-#define IRQ_DM355_GPIO7		DAVINCI_INTC_IRQ(51)
-#define IRQ_DM355_GPIO8		DAVINCI_INTC_IRQ(52)
-#define IRQ_DM355_GPIO9		DAVINCI_INTC_IRQ(53)
-#define IRQ_DM355_GPIOBNK0	DAVINCI_INTC_IRQ(54)
-#define IRQ_DM355_GPIOBNK1	DAVINCI_INTC_IRQ(55)
-#define IRQ_DM355_GPIOBNK2	DAVINCI_INTC_IRQ(56)
-#define IRQ_DM355_GPIOBNK3	DAVINCI_INTC_IRQ(57)
-#define IRQ_DM355_GPIOBNK4	DAVINCI_INTC_IRQ(58)
-#define IRQ_DM355_GPIOBNK5	DAVINCI_INTC_IRQ(59)
-#define IRQ_DM355_GPIOBNK6	DAVINCI_INTC_IRQ(60)
-
-/* DaVinci DM365-specific Interrupts */
-#define IRQ_DM365_INSFINT	DAVINCI_INTC_IRQ(7)
-#define IRQ_DM365_IMXINT1	DAVINCI_INTC_IRQ(8)
-#define IRQ_DM365_IMXINT0	DAVINCI_INTC_IRQ(10)
-#define IRQ_DM365_KLD_ARMINT	DAVINCI_INTC_IRQ(10)
-#define IRQ_DM365_IMCOPINT	DAVINCI_INTC_IRQ(11)
-#define IRQ_DM365_RTOINT	DAVINCI_INTC_IRQ(13)
-#define IRQ_DM365_TINT5		DAVINCI_INTC_IRQ(14)
-#define IRQ_DM365_TINT6		DAVINCI_INTC_IRQ(15)
-#define IRQ_DM365_SPINT2_1	DAVINCI_INTC_IRQ(21)
-#define IRQ_DM365_TINT7		DAVINCI_INTC_IRQ(22)
-#define IRQ_DM365_SDIOINT0	DAVINCI_INTC_IRQ(23)
-#define IRQ_DM365_MMCINT1	DAVINCI_INTC_IRQ(27)
-#define IRQ_DM365_PWMINT3	DAVINCI_INTC_IRQ(28)
-#define IRQ_DM365_RTCINT	DAVINCI_INTC_IRQ(29)
-#define IRQ_DM365_SDIOINT1	DAVINCI_INTC_IRQ(31)
-#define IRQ_DM365_SPIINT0_0	DAVINCI_INTC_IRQ(42)
-#define IRQ_DM365_SPIINT3_0	DAVINCI_INTC_IRQ(43)
-#define IRQ_DM365_GPIO0		DAVINCI_INTC_IRQ(44)
-#define IRQ_DM365_GPIO1		DAVINCI_INTC_IRQ(45)
-#define IRQ_DM365_GPIO2		DAVINCI_INTC_IRQ(46)
-#define IRQ_DM365_GPIO3		DAVINCI_INTC_IRQ(47)
-#define IRQ_DM365_GPIO4		DAVINCI_INTC_IRQ(48)
-#define IRQ_DM365_GPIO5		DAVINCI_INTC_IRQ(49)
-#define IRQ_DM365_GPIO6		DAVINCI_INTC_IRQ(50)
-#define IRQ_DM365_GPIO7		DAVINCI_INTC_IRQ(51)
-#define IRQ_DM365_EMAC_RXTHRESH	DAVINCI_INTC_IRQ(52)
-#define IRQ_DM365_EMAC_RXPULSE	DAVINCI_INTC_IRQ(53)
-#define IRQ_DM365_EMAC_TXPULSE	DAVINCI_INTC_IRQ(54)
-#define IRQ_DM365_EMAC_MISCPULSE DAVINCI_INTC_IRQ(55)
-#define IRQ_DM365_GPIO12	DAVINCI_INTC_IRQ(56)
-#define IRQ_DM365_GPIO13	DAVINCI_INTC_IRQ(57)
-#define IRQ_DM365_GPIO14	DAVINCI_INTC_IRQ(58)
-#define IRQ_DM365_GPIO15	DAVINCI_INTC_IRQ(59)
-#define IRQ_DM365_ADCINT	DAVINCI_INTC_IRQ(59)
-#define IRQ_DM365_KEYINT	DAVINCI_INTC_IRQ(60)
-#define IRQ_DM365_TCERRINT2	DAVINCI_INTC_IRQ(61)
-#define IRQ_DM365_TCERRINT3	DAVINCI_INTC_IRQ(62)
-#define IRQ_DM365_EMUINT	DAVINCI_INTC_IRQ(63)
-
-/* DA8XX interrupts */
-#define IRQ_DA8XX_COMMTX		DAVINCI_INTC_IRQ(0)
-#define IRQ_DA8XX_COMMRX		DAVINCI_INTC_IRQ(1)
-#define IRQ_DA8XX_NINT			DAVINCI_INTC_IRQ(2)
-#define IRQ_DA8XX_EVTOUT0		DAVINCI_INTC_IRQ(3)
-#define IRQ_DA8XX_EVTOUT1		DAVINCI_INTC_IRQ(4)
-#define IRQ_DA8XX_EVTOUT2		DAVINCI_INTC_IRQ(5)
-#define IRQ_DA8XX_EVTOUT3		DAVINCI_INTC_IRQ(6)
-#define IRQ_DA8XX_EVTOUT4		DAVINCI_INTC_IRQ(7)
-#define IRQ_DA8XX_EVTOUT5		DAVINCI_INTC_IRQ(8)
-#define IRQ_DA8XX_EVTOUT6		DAVINCI_INTC_IRQ(9)
-#define IRQ_DA8XX_EVTOUT7		DAVINCI_INTC_IRQ(10)
-#define IRQ_DA8XX_CCINT0		DAVINCI_INTC_IRQ(11)
-#define IRQ_DA8XX_CCERRINT		DAVINCI_INTC_IRQ(12)
-#define IRQ_DA8XX_TCERRINT0		DAVINCI_INTC_IRQ(13)
-#define IRQ_DA8XX_AEMIFINT		DAVINCI_INTC_IRQ(14)
-#define IRQ_DA8XX_I2CINT0		DAVINCI_INTC_IRQ(15)
-#define IRQ_DA8XX_MMCSDINT0		DAVINCI_INTC_IRQ(16)
-#define IRQ_DA8XX_MMCSDINT1		DAVINCI_INTC_IRQ(17)
-#define IRQ_DA8XX_ALLINT0		DAVINCI_INTC_IRQ(18)
-#define IRQ_DA8XX_RTC			DAVINCI_INTC_IRQ(19)
-#define IRQ_DA8XX_SPINT0		DAVINCI_INTC_IRQ(20)
-#define IRQ_DA8XX_TINT12_0		DAVINCI_INTC_IRQ(21)
-#define IRQ_DA8XX_TINT34_0		DAVINCI_INTC_IRQ(22)
-#define IRQ_DA8XX_TINT12_1		DAVINCI_INTC_IRQ(23)
-#define IRQ_DA8XX_TINT34_1		DAVINCI_INTC_IRQ(24)
-#define IRQ_DA8XX_UARTINT0		DAVINCI_INTC_IRQ(25)
-#define IRQ_DA8XX_KEYMGRINT		DAVINCI_INTC_IRQ(26)
-#define IRQ_DA8XX_SECINT		DAVINCI_INTC_IRQ(26)
-#define IRQ_DA8XX_SECKEYERR		DAVINCI_INTC_IRQ(26)
-#define IRQ_DA8XX_CHIPINT0		DAVINCI_INTC_IRQ(28)
-#define IRQ_DA8XX_CHIPINT1		DAVINCI_INTC_IRQ(29)
-#define IRQ_DA8XX_CHIPINT2		DAVINCI_INTC_IRQ(30)
-#define IRQ_DA8XX_CHIPINT3		DAVINCI_INTC_IRQ(31)
-#define IRQ_DA8XX_TCERRINT1		DAVINCI_INTC_IRQ(32)
-#define IRQ_DA8XX_C0_RX_THRESH_PULSE	DAVINCI_INTC_IRQ(33)
-#define IRQ_DA8XX_C0_RX_PULSE		DAVINCI_INTC_IRQ(34)
-#define IRQ_DA8XX_C0_TX_PULSE		DAVINCI_INTC_IRQ(35)
-#define IRQ_DA8XX_C0_MISC_PULSE		DAVINCI_INTC_IRQ(36)
-#define IRQ_DA8XX_C1_RX_THRESH_PULSE	DAVINCI_INTC_IRQ(37)
-#define IRQ_DA8XX_C1_RX_PULSE		DAVINCI_INTC_IRQ(38)
-#define IRQ_DA8XX_C1_TX_PULSE		DAVINCI_INTC_IRQ(39)
-#define IRQ_DA8XX_C1_MISC_PULSE		DAVINCI_INTC_IRQ(40)
-#define IRQ_DA8XX_MEMERR		DAVINCI_INTC_IRQ(41)
-#define IRQ_DA8XX_GPIO0			DAVINCI_INTC_IRQ(42)
-#define IRQ_DA8XX_GPIO1			DAVINCI_INTC_IRQ(43)
-#define IRQ_DA8XX_GPIO2			DAVINCI_INTC_IRQ(44)
-#define IRQ_DA8XX_GPIO3			DAVINCI_INTC_IRQ(45)
-#define IRQ_DA8XX_GPIO4			DAVINCI_INTC_IRQ(46)
-#define IRQ_DA8XX_GPIO5			DAVINCI_INTC_IRQ(47)
-#define IRQ_DA8XX_GPIO6			DAVINCI_INTC_IRQ(48)
-#define IRQ_DA8XX_GPIO7			DAVINCI_INTC_IRQ(49)
-#define IRQ_DA8XX_GPIO8			DAVINCI_INTC_IRQ(50)
-#define IRQ_DA8XX_I2CINT1		DAVINCI_INTC_IRQ(51)
-#define IRQ_DA8XX_LCDINT		DAVINCI_INTC_IRQ(52)
-#define IRQ_DA8XX_UARTINT1		DAVINCI_INTC_IRQ(53)
-#define IRQ_DA8XX_MCASPINT		DAVINCI_INTC_IRQ(54)
-#define IRQ_DA8XX_ALLINT1		DAVINCI_INTC_IRQ(55)
-#define IRQ_DA8XX_SPINT1		DAVINCI_INTC_IRQ(56)
-#define IRQ_DA8XX_UHPI_INT1		DAVINCI_INTC_IRQ(57)
-#define IRQ_DA8XX_USB_INT		DAVINCI_INTC_IRQ(58)
-#define IRQ_DA8XX_IRQN			DAVINCI_INTC_IRQ(59)
-#define IRQ_DA8XX_RWAKEUP		DAVINCI_INTC_IRQ(60)
-#define IRQ_DA8XX_UARTINT2		DAVINCI_INTC_IRQ(61)
-#define IRQ_DA8XX_DFTSSINT		DAVINCI_INTC_IRQ(62)
-#define IRQ_DA8XX_EHRPWM0		DAVINCI_INTC_IRQ(63)
-#define IRQ_DA8XX_EHRPWM0TZ		DAVINCI_INTC_IRQ(64)
-#define IRQ_DA8XX_EHRPWM1		DAVINCI_INTC_IRQ(65)
-#define IRQ_DA8XX_EHRPWM1TZ		DAVINCI_INTC_IRQ(66)
-#define IRQ_DA8XX_ECAP0			DAVINCI_INTC_IRQ(69)
-#define IRQ_DA8XX_ECAP1			DAVINCI_INTC_IRQ(70)
-#define IRQ_DA8XX_ECAP2			DAVINCI_INTC_IRQ(71)
-#define IRQ_DA8XX_ARMCLKSTOPREQ		DAVINCI_INTC_IRQ(90)
-
-/* DA830 specific interrupts */
-#define IRQ_DA830_MPUERR		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA830_IOPUERR		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA830_BOOTCFGERR		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA830_EHRPWM2		DAVINCI_INTC_IRQ(67)
-#define IRQ_DA830_EHRPWM2TZ		DAVINCI_INTC_IRQ(68)
-#define IRQ_DA830_EQEP0			DAVINCI_INTC_IRQ(72)
-#define IRQ_DA830_EQEP1			DAVINCI_INTC_IRQ(73)
-#define IRQ_DA830_T12CMPINT0_0		DAVINCI_INTC_IRQ(74)
-#define IRQ_DA830_T12CMPINT1_0		DAVINCI_INTC_IRQ(75)
-#define IRQ_DA830_T12CMPINT2_0		DAVINCI_INTC_IRQ(76)
-#define IRQ_DA830_T12CMPINT3_0		DAVINCI_INTC_IRQ(77)
-#define IRQ_DA830_T12CMPINT4_0		DAVINCI_INTC_IRQ(78)
-#define IRQ_DA830_T12CMPINT5_0		DAVINCI_INTC_IRQ(79)
-#define IRQ_DA830_T12CMPINT6_0		DAVINCI_INTC_IRQ(80)
-#define IRQ_DA830_T12CMPINT7_0		DAVINCI_INTC_IRQ(81)
-#define IRQ_DA830_T12CMPINT0_1		DAVINCI_INTC_IRQ(82)
-#define IRQ_DA830_T12CMPINT1_1		DAVINCI_INTC_IRQ(83)
-#define IRQ_DA830_T12CMPINT2_1		DAVINCI_INTC_IRQ(84)
-#define IRQ_DA830_T12CMPINT3_1		DAVINCI_INTC_IRQ(85)
-#define IRQ_DA830_T12CMPINT4_1		DAVINCI_INTC_IRQ(86)
-#define IRQ_DA830_T12CMPINT5_1		DAVINCI_INTC_IRQ(87)
-#define IRQ_DA830_T12CMPINT6_1		DAVINCI_INTC_IRQ(88)
-#define IRQ_DA830_T12CMPINT7_1		DAVINCI_INTC_IRQ(89)
-
-/* DA850 speicific interrupts */
-#define IRQ_DA850_MPUADDRERR0		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_MPUPROTERR0		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUADDRERR0		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUPROTERR0		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUADDRERR1		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUPROTERR1		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUADDRERR2		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUPROTERR2		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_BOOTCFG_ADDR_ERR	DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_BOOTCFG_PROT_ERR	DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_MPUADDRERR1		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_MPUPROTERR1		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUADDRERR3		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUPROTERR3		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUADDRERR4		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUPROTERR4		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUADDRERR5		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_IOPUPROTERR5		DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_MIOPU_BOOTCFG_ERR	DAVINCI_INTC_IRQ(27)
-#define IRQ_DA850_SATAINT		DAVINCI_INTC_IRQ(67)
-#define IRQ_DA850_TINT12_2		DAVINCI_INTC_IRQ(68)
-#define IRQ_DA850_TINT34_2		DAVINCI_INTC_IRQ(68)
-#define IRQ_DA850_TINTALL_2		DAVINCI_INTC_IRQ(68)
-#define IRQ_DA850_MMCSDINT0_1		DAVINCI_INTC_IRQ(72)
-#define IRQ_DA850_MMCSDINT1_1		DAVINCI_INTC_IRQ(73)
-#define IRQ_DA850_T12CMPINT0_2		DAVINCI_INTC_IRQ(74)
-#define IRQ_DA850_T12CMPINT1_2		DAVINCI_INTC_IRQ(75)
-#define IRQ_DA850_T12CMPINT2_2		DAVINCI_INTC_IRQ(76)
-#define IRQ_DA850_T12CMPINT3_2		DAVINCI_INTC_IRQ(77)
-#define IRQ_DA850_T12CMPINT4_2		DAVINCI_INTC_IRQ(78)
-#define IRQ_DA850_T12CMPINT5_2		DAVINCI_INTC_IRQ(79)
-#define IRQ_DA850_T12CMPINT6_2		DAVINCI_INTC_IRQ(80)
-#define IRQ_DA850_T12CMPINT7_2		DAVINCI_INTC_IRQ(81)
-#define IRQ_DA850_T12CMPINT0_3		DAVINCI_INTC_IRQ(82)
-#define IRQ_DA850_T12CMPINT1_3		DAVINCI_INTC_IRQ(83)
-#define IRQ_DA850_T12CMPINT2_3		DAVINCI_INTC_IRQ(84)
-#define IRQ_DA850_T12CMPINT3_3		DAVINCI_INTC_IRQ(85)
-#define IRQ_DA850_T12CMPINT4_3		DAVINCI_INTC_IRQ(86)
-#define IRQ_DA850_T12CMPINT5_3		DAVINCI_INTC_IRQ(87)
-#define IRQ_DA850_T12CMPINT6_3		DAVINCI_INTC_IRQ(88)
-#define IRQ_DA850_T12CMPINT7_3		DAVINCI_INTC_IRQ(89)
-#define IRQ_DA850_RPIINT		DAVINCI_INTC_IRQ(91)
-#define IRQ_DA850_VPIFINT		DAVINCI_INTC_IRQ(92)
-#define IRQ_DA850_CCINT1		DAVINCI_INTC_IRQ(93)
-#define IRQ_DA850_CCERRINT1		DAVINCI_INTC_IRQ(94)
-#define IRQ_DA850_TCERRINT2		DAVINCI_INTC_IRQ(95)
-#define IRQ_DA850_TINT12_3		DAVINCI_INTC_IRQ(96)
-#define IRQ_DA850_TINT34_3		DAVINCI_INTC_IRQ(96)
-#define IRQ_DA850_TINTALL_3		DAVINCI_INTC_IRQ(96)
-#define IRQ_DA850_MCBSP0RINT		DAVINCI_INTC_IRQ(97)
-#define IRQ_DA850_MCBSP0XINT		DAVINCI_INTC_IRQ(98)
-#define IRQ_DA850_MCBSP1RINT		DAVINCI_INTC_IRQ(99)
-#define IRQ_DA850_MCBSP1XINT		DAVINCI_INTC_IRQ(100)
-
-#endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index fdfe03669d9f..eec6a14d034a 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -18,7 +18,6 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/irqs.h>
 
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index feb300670f43..42ffc6c7e5d8 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -9,7 +9,6 @@
 #include <linux/usb/musb.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <linux/platform_data/usb-davinci.h>
 
-- 
2.20.1

