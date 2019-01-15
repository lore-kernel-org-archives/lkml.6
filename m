Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FD2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2DA20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfAOEW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:22:29 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37482 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfAOEW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:22:27 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 552DE29E67; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <833b60b5efaac347849e2bd438f383f921f7469a.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 10/22] m68k/atari: Implement arch_nvram_ops methods and
 enable CONFIG_HAVE_ARCH_NVRAM_OPS
Date:   Tue, 15 Jan 2019 15:18:56 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atari RTC NVRAM uses a checksum so implement the remaining arch_nvram_ops
methods for the set_checksum and initialize ioctls. Enable
CONFIG_HAVE_ARCH_NVRAM_OPS.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v8:
 - Moved the HAVE_ARCH_NVRAM_OPS symbol to common code as suggested by
Christoph Hellwig.
 - Renamed functions to avoid name collisions with nvram.h.

Changed since v7:
 - Changed the default for CONFIG_NVRAM, because "select NVRAM" was
removed from ATARI_SCSI in patch 1.
---
 arch/Kconfig              |  3 +++
 arch/m68k/Kconfig.machine |  1 +
 arch/m68k/atari/nvram.c   | 24 ++++++++++++++++++++++++
 drivers/char/Kconfig      |  3 ++-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de48f79..87393fb8141c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -701,6 +701,9 @@ config HAVE_ARCH_HASH
 	  file which provides platform-specific implementations of some
 	  functions in <linux/hash.h> or fs/namei.c.
 
+config HAVE_ARCH_NVRAM_OPS
+	bool
+
 config ISA_BUS_API
 	def_bool ISA
 
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 328ba83d735b..ad584e3eb8f7 100644
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
index e75adebe6e7d..c347fd206ddf 100644
--- a/arch/m68k/atari/nvram.c
+++ b/arch/m68k/atari/nvram.c
@@ -74,6 +74,26 @@ static void __nvram_set_checksum(void)
 	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
 }
 
+static long atari_nvram_set_checksum(void)
+{
+	spin_lock_irq(&rtc_lock);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+}
+
+static long atari_nvram_initialize(void)
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
 static ssize_t atari_nvram_read(char *buf, size_t count, loff_t *ppos)
 {
 	char *p = buf;
@@ -113,6 +133,8 @@ static ssize_t atari_nvram_write(char *buf, size_t count, loff_t *ppos)
 
 static ssize_t atari_nvram_get_size(void)
 {
+	if (!MACH_IS_ATARI)
+		return -ENODEV;
 	return NVRAM_BYTES;
 }
 
@@ -120,6 +142,8 @@ const struct nvram_ops arch_nvram_ops = {
 	.read           = atari_nvram_read,
 	.write          = atari_nvram_write,
 	.get_size       = atari_nvram_get_size,
+	.set_checksum   = atari_nvram_set_checksum,
+	.initialize     = atari_nvram_initialize,
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index a8cac68de177..ce9979529cf3 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -244,7 +244,8 @@ source "drivers/char/hw_random/Kconfig"
 
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

