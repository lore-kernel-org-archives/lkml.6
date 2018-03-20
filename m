Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeCTXDY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:03:24 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:34872 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCTXCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:02:19 -0400
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de
Cc: nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/5] efi/libstub/arm: add support for building with clang
Date: Wed, 21 Mar 2018 00:02:03 +0100
Message-Id: <20180320230206.25289-3-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320230206.25289-1-stefan@agner.ch>
References: <20180320230206.25289-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use cc-options call for -mno-single-pic-base since the option is
not available in clang. LLVM/clang always assumes a fixed
displacement between text/data and hence uses PC relative
addressing.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 7b3ba40f0745..2bf69cca0d87 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
 
 cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
-				   -fno-builtin -fpic -mno-single-pic-base
+				   -fno-builtin -fpic \
+				   $(call cc-option,-mno-single-pic-base,)
 
 cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
-- 
2.16.2
