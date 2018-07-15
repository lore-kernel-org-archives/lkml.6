Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6405ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EF820870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EF820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeGPAEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:04:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54779 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbeGPAEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:04:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNdN2R922972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:39:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNdMVR922969;
        Sun, 15 Jul 2018 16:39:22 -0700
Date:   Sun, 15 Jul 2018 16:39:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-3d7ee348aa4127a7893c11261da9b76371a970e6@git.kernel.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de,
        ard.biesheuvel@linaro.org, leif.lindholm@linaro.org,
        peterz@infradead.org, agraf@suse.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, agraf@suse.de, tglx@linutronix.de,
          torvalds@linux-foundation.org, leif.lindholm@linaro.org,
          ard.biesheuvel@linaro.org
In-Reply-To: <20180711094040.12506-7-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-7-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/libstub/arm: Add opt-in Kconfig option for the
 DTB loader
Git-Commit-ID: 3d7ee348aa4127a7893c11261da9b76371a970e6
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

Commit-ID:  3d7ee348aa4127a7893c11261da9b76371a970e6
Gitweb:     https://git.kernel.org/tip/3d7ee348aa4127a7893c11261da9b76371a970e6
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Wed, 11 Jul 2018 11:40:38 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:43:12 +0200

efi/libstub/arm: Add opt-in Kconfig option for the DTB loader

There are various ways a platform can provide a device tree binary
to the kernel, with different levels of sophistication:

- ideally, the UEFI firmware, which is tightly coupled with the
  platform, provides a device tree image directly as a UEFI
  configuration table, and typically permits the contents to be
  manipulated either via menu options or via UEFI environment
  variables that specify a replacement image,

- GRUB for ARM has a 'devicetree' directive which allows a device
  tree image to be loaded from any location accessible to GRUB, and
  supersede the one provided by the firmware,

- the EFI stub implements a dtb= command line option that allows a
  device tree image to be loaded from a file residing in the same
  file system as the one the kernel image was loaded from.

The dtb= command line option was never intended to be more than a
development feature, to allow the other options to be implemented
in parallel. So let's make it an opt-in feature that is disabled
by default, but can be re-enabled at will.

Note that we already disable the dtb= command line option when we
detect that we are running with UEFI Secure Boot enabled.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Alexander Graf <agraf@suse.de>
Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180711094040.12506-7-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/Kconfig            | 12 ++++++++++++
 drivers/firmware/efi/libstub/arm-stub.c |  7 ++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 781a4a337557..d8e159feb573 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -87,6 +87,18 @@ config EFI_RUNTIME_WRAPPERS
 config EFI_ARMSTUB
 	bool
 
+config EFI_ARMSTUB_DTB_LOADER
+	bool "Enable the DTB loader"
+	depends on EFI_ARMSTUB
+	help
+	  Select this config option to add support for the dtb= command
+	  line parameter, allowing a device tree blob to be loaded into
+	  memory from the EFI System Partition by the stub.
+
+	  The device tree is typically provided by the platform or by
+	  the bootloader, so this option is mostly for development
+	  purposes only.
+
 config EFI_BOOTLOADER_CONTROL
 	tristate "EFI Bootloader Control"
 	depends on EFI_VARS
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 01a9d78ee415..c98b1856fc3d 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -202,9 +202,10 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 	 * 'dtb=' unless UEFI Secure Boot is disabled.  We assume that secure
 	 * boot is enabled if we can't determine its state.
 	 */
-	if (secure_boot != efi_secureboot_mode_disabled &&
-	    strstr(cmdline_ptr, "dtb=")) {
-		pr_efi(sys_table, "Ignoring DTB from command line.\n");
+	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
+	     secure_boot != efi_secureboot_mode_disabled) {
+		if (strstr(cmdline_ptr, "dtb="))
+			pr_efi(sys_table, "Ignoring DTB from command line.\n");
 	} else {
 		status = handle_cmdline_files(sys_table, image, cmdline_ptr,
 					      "dtb=",
