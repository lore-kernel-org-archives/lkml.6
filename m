Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C227FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB502148E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeLZAqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 19:46:06 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57338 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeLZAn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 19:43:59 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 19C3A2951F; Tue, 25 Dec 2018 19:43:56 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <f94994916e3899b2c41e067105877ead8fdc91b1.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 09/25] m68k/atari: Implement arch_nvram_ops methods and
 enable CONFIG_HAVE_ARCH_NVRAM_OPS
Date:   Wed, 26 Dec 2018 11:37:59 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atari RTC NVRAM has a checksum so implement the remaining arch_nvram_ops
methods for the set_checksum and initialize ioctls. Enable
CONFIG_HAVE_ARCH_NVRAM_OPS.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Changed since v7:
 - Changed the default for CONFIG_NVRAM, because "select NVRAM" was
removed from ATARI_SCSI in patch 1.
---
 arch/m68k/Kconfig         |  3 +++
 arch/m68k/Kconfig.machine |  1 +
 arch/m68k/atari/nvram.c   | 24 ++++++++++++++++++++++++
 drivers/char/Kconfig      |  3 ++-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 1bc9f1ba759a..79e545f2520a 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -70,6 +70,9 @@ config ZONE_DMA
 	bool
 	default y
 
+config HAVE_ARCH_NVRAM_OPS
+	bool
+
 config HZ
 	int
 	default 1000 if CLEOPATRA
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 64a641467736..0c8c4c7982c1 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -16,6 +16,7 @@ config ATARI
 	bool "Atari support"
 	depends on MMU
 	select MMU_MOTOROLA if MMU
+	select HAVE_ARCH_NVRAM_OPS
 	help
 	  This option enables support for the 68000-based Atari series of
 	  computers (including the TT, Falcon and Medusa). If you plan to use
diff --git a/arch/m68k/atari/nvram.c b/arch/m68k/atari/nvram.c
index bafc9dc32830..4b27f1683a37 100644
--- a/arch/m68k/atari/nvram.c
+++ b/arch/m68k/atari/nvram.c
@@ -74,6 +74,26 @@ static void __nvram_set_checksum(void)
 	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
 }
 
+static long nvram_set_checksum(void)
+{
+	spin_lock_irq(&rtc_lock);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+}
+
+static long nvram_initialize(void)
+{
+	loff_t i;
+
+	spin_lock_irq(&rtc_lock);
+	for (i = 0; i < NVRAM_BYTES; ++i)
+		__nvram_write_byte(0, i);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+}
+
 static ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
 {
 	char *p = buf;
@@ -120,6 +140,8 @@ static ssize_t nvram_write(char *buf, size_t count, loff_t *ppos)
 
 static ssize_t nvram_get_size(void)
 {
+	if (!MACH_IS_ATARI)
+		return -ENODEV;
 	return NVRAM_BYTES;
 }
 
@@ -127,6 +149,8 @@ const struct nvram_ops arch_nvram_ops = {
 	.read           = nvram_read,
 	.write          = nvram_write,
 	.get_size       = nvram_get_size,
+	.set_checksum   = nvram_set_checksum,
+	.initialize     = nvram_initialize,
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 5b54595dfe30..f9960bd65481 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -236,7 +236,8 @@ source "drivers/char/hw_random/Kconfig"
 
 config NVRAM
 	tristate "/dev/nvram support"
-	depends on X86 || GENERIC_NVRAM
+	depends on X86 || GENERIC_NVRAM || HAVE_ARCH_NVRAM_OPS
+	default M68K
 	---help---
 	  If you say Y here and create a character special file /dev/nvram
 	  with major number 10 and minor number 144 using mknod ("man mknod"),
-- 
2.19.2

