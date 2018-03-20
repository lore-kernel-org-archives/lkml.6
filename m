Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeCTXCx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:02:53 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35260 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeCTXCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:02:21 -0400
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de
Cc: nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 5/5] ARM: add support for building ARM kernel with clang
Date: Wed, 21 Mar 2018 00:02:06 +0100
Message-Id: <20180320230206.25289-6-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320230206.25289-1-stefan@agner.ch>
References: <20180320230206.25289-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use cc-options call for compiler options which are not available
in clang. With this patch an ARMv7 multi platform kernel can be
successfully build using clang (tested with version 5.0.1).

Based-on-patches-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Makefile                 | 2 +-
 arch/arm/boot/compressed/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e9e3fde3c657..20e9fee1ccc5 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -39,7 +39,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
 endif
 
 ifeq ($(CONFIG_FRAME_POINTER),y)
-KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
+KBUILD_CFLAGS	+=-fno-omit-frame-pointer $(call cc-option,-mapcs,) $(call cc-option,-mno-sched-prolog,)
 endif
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 45a6b9b7af2a..6a5c4ac97703 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -113,7 +113,7 @@ CFLAGS_fdt_ro.o := $(nossp_flags)
 CFLAGS_fdt_rw.o := $(nossp_flags)
 CFLAGS_fdt_wip.o := $(nossp_flags)
 
-ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
+ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
-- 
2.16.2
