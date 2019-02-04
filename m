Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA50C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802DF20820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfBDIrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:47:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfBDIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:47:30 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148kr4g356609
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:46:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148kqMR356606;
        Mon, 4 Feb 2019 00:46:52 -0800
Date:   Mon, 4 Feb 2019 00:46:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-69c1f396f25b805aeff08f06d2e992c315ee5b1e@git.kernel.org>
Cc:     pjones@redhat.com, agraf@suse.de, xypron.glpk@gmx.de,
        torvalds@linux-foundation.org, leif.lindholm@linaro.org,
        sai.praneeth.prakhya@intel.com, mingo@kernel.org,
        takahiro.akashi@linaro.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, jhugo@codeaurora.org,
        lee.jones@linaro.org, ard.biesheuvel@linaro.org,
        matt@codeblueprint.co.uk
Reply-To: linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
          hpa@zytor.com, peterz@infradead.org, takahiro.akashi@linaro.org,
          matt@codeblueprint.co.uk, ard.biesheuvel@linaro.org,
          lee.jones@linaro.org, bjorn.andersson@linaro.org,
          jhugo@codeaurora.org, sai.praneeth.prakhya@intel.com,
          torvalds@linux-foundation.org, leif.lindholm@linaro.org,
          xypron.glpk@gmx.de, agraf@suse.de, pjones@redhat.com,
          mingo@kernel.org
In-Reply-To: <20190202094119.13230-10-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-10-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/x86: Convert x86 EFI earlyprintk into generic
 earlycon implementation
Git-Commit-ID: 69c1f396f25b805aeff08f06d2e992c315ee5b1e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  69c1f396f25b805aeff08f06d2e992c315ee5b1e
Gitweb:     https://git.kernel.org/tip/69c1f396f25b805aeff08f06d2e992c315ee5b1e
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Sat, 2 Feb 2019 10:41:18 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:27:30 +0100

efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation

Move the x86 EFI earlyprintk implementation to a shared location under
drivers/firmware and tweak it slightly so we can expose it as an earlycon
implementation (which is generic) rather than earlyprintk (which is only
implemented for a few architectures)

This also involves switching to write-combine mappings by default (which
is required on ARM since device mappings lack memory semantics, and so
memcpy/memset may not be used on them), and adding support for shared
memory framebuffers on cache coherent non-x86 systems (which do not
tolerate mismatched attributes).

Note that 32-bit ARM does not populate its struct screen_info early
enough for earlycon=efifb to work, so it is disabled there.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Alexander Graf <agraf@suse.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190202094119.13230-10-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |   8 +-
 arch/x86/Kconfig.debug                          |  10 -
 arch/x86/include/asm/efi.h                      |   1 -
 arch/x86/kernel/early_printk.c                  |   4 -
 arch/x86/platform/efi/Makefile                  |   1 -
 arch/x86/platform/efi/early_printk.c            | 240 ------------------------
 drivers/firmware/efi/Kconfig                    |   6 +
 drivers/firmware/efi/Makefile                   |   1 +
 drivers/firmware/efi/earlycon.c                 | 206 ++++++++++++++++++++
 9 files changed, 220 insertions(+), 257 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf67d7b..76dd3baa31e0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1073,9 +1073,15 @@
 			specified address. The serial port must already be
 			setup and configured. Options are not yet supported.
 
+		efifb,[options]
+			Start an early, unaccelerated console on the EFI
+			memory mapped framebuffer (if available). On cache
+			coherent non-x86 systems that use system memory for
+			the framebuffer, pass the 'ram' option so that it is
+			mapped with the correct attributes.
+
 	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
-			earlyprintk=efi
 			earlyprintk=sclp
 			earlyprintk=xen
 			earlyprintk=serial[,ttySn[,baudrate]]
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 0723dff17e6c..15d0fbe27872 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -40,16 +40,6 @@ config EARLY_PRINTK_DBGP
 	  with klogd/syslogd or the X server. You should normally say N here,
 	  unless you want to debug such a crash. You need usb debug device.
 
-config EARLY_PRINTK_EFI
-	bool "Early printk via the EFI framebuffer"
-	depends on EFI && EARLY_PRINTK
-	select FONT_SUPPORT
-	---help---
-	  Write kernel log output directly into the EFI framebuffer.
-
-	  This is useful for kernel debugging when your machine crashes very
-	  early before the console code is initialized.
-
 config EARLY_PRINTK_USB_XDBC
 	bool "Early printk via the xHCI debug port"
 	depends on EARLY_PRINTK && PCI
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 107283b1eb1e..606a4b6a9812 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -170,7 +170,6 @@ static inline bool efi_runtime_supported(void)
 	return false;
 }
 
-extern struct console early_efi_console;
 extern void parse_efi_setup(u64 phys_addr, u32 data_len);
 
 extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 374a52fa5296..9b33904251a9 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -388,10 +388,6 @@ static int __init setup_early_printk(char *buf)
 		if (!strncmp(buf, "xen", 3))
 			early_console_register(&xenboot_console, keep);
 #endif
-#ifdef CONFIG_EARLY_PRINTK_EFI
-		if (!strncmp(buf, "efi", 3))
-			early_console_register(&early_efi_console, keep);
-#endif
 #ifdef CONFIG_EARLY_PRINTK_USB_XDBC
 		if (!strncmp(buf, "xdbc", 4))
 			early_xdbc_parse_parameter(buf + 4);
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index e4dc3862d423..fe29f3f5d384 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -3,5 +3,4 @@ OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
 OBJECT_FILES_NON_STANDARD_efi_stub_$(BITS).o := y
 
 obj-$(CONFIG_EFI) 		+= quirks.o efi.o efi_$(BITS).o efi_stub_$(BITS).o
-obj-$(CONFIG_EARLY_PRINTK_EFI)	+= early_printk.o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
deleted file mode 100644
index 7138bc7a265c..000000000000
--- a/arch/x86/platform/efi/early_printk.c
+++ /dev/null
@@ -1,240 +0,0 @@
-/*
- * Copyright (C) 2013 Intel Corporation; author Matt Fleming
- *
- *  This file is part of the Linux kernel, and is made available under
- *  the terms of the GNU General Public License version 2.
- */
-
-#include <linux/console.h>
-#include <linux/efi.h>
-#include <linux/font.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <asm/setup.h>
-
-static const struct font_desc *font;
-static u32 efi_x, efi_y;
-static void *efi_fb;
-static bool early_efi_keep;
-
-/*
- * efi earlyprintk need use early_ioremap to map the framebuffer.
- * But early_ioremap is not usable for earlyprintk=efi,keep, ioremap should
- * be used instead. ioremap will be available after paging_init() which is
- * earlier than initcall callbacks. Thus adding this early initcall function
- * early_efi_map_fb to map the whole efi framebuffer.
- */
-static __init int early_efi_map_fb(void)
-{
-	u64 base, size;
-
-	if (!early_efi_keep)
-		return 0;
-
-	base = boot_params.screen_info.lfb_base;
-	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
-	size = boot_params.screen_info.lfb_size;
-	efi_fb = ioremap(base, size);
-
-	return efi_fb ? 0 : -ENOMEM;
-}
-early_initcall(early_efi_map_fb);
-
-/*
- * early_efi_map maps efi framebuffer region [start, start + len -1]
- * In case earlyprintk=efi,keep we have the whole framebuffer mapped already
- * so just return the offset efi_fb + start.
- */
-static __ref void *early_efi_map(unsigned long start, unsigned long len)
-{
-	u64 base;
-
-	base = boot_params.screen_info.lfb_base;
-	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
-
-	if (efi_fb)
-		return (efi_fb + start);
-	else
-		return early_ioremap(base + start, len);
-}
-
-static __ref void early_efi_unmap(void *addr, unsigned long len)
-{
-	if (!efi_fb)
-		early_iounmap(addr, len);
-}
-
-static void early_efi_clear_scanline(unsigned int y)
-{
-	unsigned long *dst;
-	u16 len;
-
-	len = boot_params.screen_info.lfb_linelength;
-	dst = early_efi_map(y*len, len);
-	if (!dst)
-		return;
-
-	memset(dst, 0, len);
-	early_efi_unmap(dst, len);
-}
-
-static void early_efi_scroll_up(void)
-{
-	unsigned long *dst, *src;
-	u16 len;
-	u32 i, height;
-
-	len = boot_params.screen_info.lfb_linelength;
-	height = boot_params.screen_info.lfb_height;
-
-	for (i = 0; i < height - font->height; i++) {
-		dst = early_efi_map(i*len, len);
-		if (!dst)
-			return;
-
-		src = early_efi_map((i + font->height) * len, len);
-		if (!src) {
-			early_efi_unmap(dst, len);
-			return;
-		}
-
-		memmove(dst, src, len);
-
-		early_efi_unmap(src, len);
-		early_efi_unmap(dst, len);
-	}
-}
-
-static void early_efi_write_char(u32 *dst, unsigned char c, unsigned int h)
-{
-	const u32 color_black = 0x00000000;
-	const u32 color_white = 0x00ffffff;
-	const u8 *src;
-	u8 s8;
-	int m;
-
-	src = font->data + c * font->height;
-	s8 = *(src + h);
-
-	for (m = 0; m < 8; m++) {
-		if ((s8 >> (7 - m)) & 1)
-			*dst = color_white;
-		else
-			*dst = color_black;
-		dst++;
-	}
-}
-
-static void
-early_efi_write(struct console *con, const char *str, unsigned int num)
-{
-	struct screen_info *si;
-	unsigned int len;
-	const char *s;
-	void *dst;
-
-	si = &boot_params.screen_info;
-	len = si->lfb_linelength;
-
-	while (num) {
-		unsigned int linemax;
-		unsigned int h, count = 0;
-
-		for (s = str; *s && *s != '\n'; s++) {
-			if (count == num)
-				break;
-			count++;
-		}
-
-		linemax = (si->lfb_width - efi_x) / font->width;
-		if (count > linemax)
-			count = linemax;
-
-		for (h = 0; h < font->height; h++) {
-			unsigned int n, x;
-
-			dst = early_efi_map((efi_y + h) * len, len);
-			if (!dst)
-				return;
-
-			s = str;
-			n = count;
-			x = efi_x;
-
-			while (n-- > 0) {
-				early_efi_write_char(dst + x*4, *s, h);
-				x += font->width;
-				s++;
-			}
-
-			early_efi_unmap(dst, len);
-		}
-
-		num -= count;
-		efi_x += count * font->width;
-		str += count;
-
-		if (num > 0 && *s == '\n') {
-			efi_x = 0;
-			efi_y += font->height;
-			str++;
-			num--;
-		}
-
-		if (efi_x + font->width > si->lfb_width) {
-			efi_x = 0;
-			efi_y += font->height;
-		}
-
-		if (efi_y + font->height > si->lfb_height) {
-			u32 i;
-
-			efi_y -= font->height;
-			early_efi_scroll_up();
-
-			for (i = 0; i < font->height; i++)
-				early_efi_clear_scanline(efi_y + i);
-		}
-	}
-}
-
-static __init int early_efi_setup(struct console *con, char *options)
-{
-	struct screen_info *si;
-	u16 xres, yres;
-	u32 i;
-
-	si = &boot_params.screen_info;
-	xres = si->lfb_width;
-	yres = si->lfb_height;
-
-	/*
-	 * early_efi_write_char() implicitly assumes a framebuffer with
-	 * 32-bits per pixel.
-	 */
-	if (si->lfb_depth != 32)
-		return -ENODEV;
-
-	font = get_default_font(xres, yres, -1, -1);
-	if (!font)
-		return -ENODEV;
-
-	efi_y = rounddown(yres, font->height) - font->height;
-	for (i = 0; i < (yres - efi_y) / font->height; i++)
-		early_efi_scroll_up();
-
-	/* early_console_register will unset CON_BOOT in case ,keep */
-	if (!(con->flags & CON_BOOT))
-		early_efi_keep = true;
-	return 0;
-}
-
-struct console early_efi_console = {
-	.name =		"earlyefi",
-	.write =	early_efi_write,
-	.setup =	early_efi_setup,
-	.flags =	CON_PRINTBUFFER,
-	.index =	-1,
-};
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 89110dfc7127..190be0b1d109 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -198,3 +198,9 @@ config EFI_DEV_PATH_PARSER
 	bool
 	depends on ACPI
 	default n
+
+config EFI_EARLYCON
+	def_bool y
+	depends on SERIAL_EARLYCON && !ARM && !IA64
+	select FONT_SUPPORT
+	select ARCH_USE_MEMREMAP_PROT
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 5f9f5039de50..d2d0d2030620 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -30,5 +30,6 @@ arm-obj-$(CONFIG_EFI)			:= arm-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
+obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
new file mode 100644
index 000000000000..c9a0efca17b0
--- /dev/null
+++ b/drivers/firmware/efi/earlycon.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2013 Intel Corporation; author Matt Fleming
+ */
+
+#include <linux/console.h>
+#include <linux/efi.h>
+#include <linux/font.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/serial_core.h>
+#include <linux/screen_info.h>
+
+#include <asm/early_ioremap.h>
+
+static const struct font_desc *font;
+static u32 efi_x, efi_y;
+static u64 fb_base;
+static pgprot_t fb_prot;
+
+static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
+{
+	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
+}
+
+static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
+{
+	early_memunmap(addr, len);
+}
+
+static void efi_earlycon_clear_scanline(unsigned int y)
+{
+	unsigned long *dst;
+	u16 len;
+
+	len = screen_info.lfb_linelength;
+	dst = efi_earlycon_map(y*len, len);
+	if (!dst)
+		return;
+
+	memset(dst, 0, len);
+	efi_earlycon_unmap(dst, len);
+}
+
+static void efi_earlycon_scroll_up(void)
+{
+	unsigned long *dst, *src;
+	u16 len;
+	u32 i, height;
+
+	len = screen_info.lfb_linelength;
+	height = screen_info.lfb_height;
+
+	for (i = 0; i < height - font->height; i++) {
+		dst = efi_earlycon_map(i*len, len);
+		if (!dst)
+			return;
+
+		src = efi_earlycon_map((i + font->height) * len, len);
+		if (!src) {
+			efi_earlycon_unmap(dst, len);
+			return;
+		}
+
+		memmove(dst, src, len);
+
+		efi_earlycon_unmap(src, len);
+		efi_earlycon_unmap(dst, len);
+	}
+}
+
+static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
+{
+	const u32 color_black = 0x00000000;
+	const u32 color_white = 0x00ffffff;
+	const u8 *src;
+	u8 s8;
+	int m;
+
+	src = font->data + c * font->height;
+	s8 = *(src + h);
+
+	for (m = 0; m < 8; m++) {
+		if ((s8 >> (7 - m)) & 1)
+			*dst = color_white;
+		else
+			*dst = color_black;
+		dst++;
+	}
+}
+
+static void
+efi_earlycon_write(struct console *con, const char *str, unsigned int num)
+{
+	struct screen_info *si;
+	unsigned int len;
+	const char *s;
+	void *dst;
+
+	si = &screen_info;
+	len = si->lfb_linelength;
+
+	while (num) {
+		unsigned int linemax;
+		unsigned int h, count = 0;
+
+		for (s = str; *s && *s != '\n'; s++) {
+			if (count == num)
+				break;
+			count++;
+		}
+
+		linemax = (si->lfb_width - efi_x) / font->width;
+		if (count > linemax)
+			count = linemax;
+
+		for (h = 0; h < font->height; h++) {
+			unsigned int n, x;
+
+			dst = efi_earlycon_map((efi_y + h) * len, len);
+			if (!dst)
+				return;
+
+			s = str;
+			n = count;
+			x = efi_x;
+
+			while (n-- > 0) {
+				efi_earlycon_write_char(dst + x*4, *s, h);
+				x += font->width;
+				s++;
+			}
+
+			efi_earlycon_unmap(dst, len);
+		}
+
+		num -= count;
+		efi_x += count * font->width;
+		str += count;
+
+		if (num > 0 && *s == '\n') {
+			efi_x = 0;
+			efi_y += font->height;
+			str++;
+			num--;
+		}
+
+		if (efi_x + font->width > si->lfb_width) {
+			efi_x = 0;
+			efi_y += font->height;
+		}
+
+		if (efi_y + font->height > si->lfb_height) {
+			u32 i;
+
+			efi_y -= font->height;
+			efi_earlycon_scroll_up();
+
+			for (i = 0; i < font->height; i++)
+				efi_earlycon_clear_scanline(efi_y + i);
+		}
+	}
+}
+
+static int __init efi_earlycon_setup(struct earlycon_device *device,
+				     const char *opt)
+{
+	struct screen_info *si;
+	u16 xres, yres;
+	u32 i;
+
+	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
+		return -ENODEV;
+
+	fb_base = screen_info.lfb_base;
+	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		fb_base |= (u64)screen_info.ext_lfb_base << 32;
+
+	if (opt && !strcmp(opt, "ram"))
+		fb_prot = PAGE_KERNEL;
+	else
+		fb_prot = pgprot_writecombine(PAGE_KERNEL);
+
+	si = &screen_info;
+	xres = si->lfb_width;
+	yres = si->lfb_height;
+
+	/*
+	 * efi_earlycon_write_char() implicitly assumes a framebuffer with
+	 * 32 bits per pixel.
+	 */
+	if (si->lfb_depth != 32)
+		return -ENODEV;
+
+	font = get_default_font(xres, yres, -1, -1);
+	if (!font)
+		return -ENODEV;
+
+	efi_y = rounddown(yres, font->height) - font->height;
+	for (i = 0; i < (yres - efi_y) / font->height; i++)
+		efi_earlycon_scroll_up();
+
+	device->con->write = efi_earlycon_write;
+	return 0;
+}
+EARLYCON_DECLARE(efifb, efi_earlycon_setup);
