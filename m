Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965227AbeCHICB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:02:01 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45616 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965050AbeCHIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:01:58 -0500
X-Google-Smtp-Source: AG47ELt3yrVAylKBQG2vOWbxZc7AuSxSoD+f4etCrgly44Tx25+twRP/nUCYZk8iiOJBHIZvA1qDLA==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] efi/arm*: Stop printing addresses of virtual mappings
Date: Thu,  8 Mar 2018 08:00:11 +0000
Message-Id: <20180308080020.22828-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
References: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent %p -> %px changes, we now get something like this in
the kernel boot log on ARM/arm64 EFI systems:

     Remapping and enabling EFI services.
       EFI remap 0x00000087fb830000 =>         (ptrval)
       EFI remap 0x00000087fbdb0000 =>         (ptrval)
       EFI remap 0x00000087fffc0000 =>         (ptrval)

The physical addresses of the UEFI runtime regions will also be
printed when booting with the efi=debug command line option, and the
virtual addresses can be inspected via /sys/kernel/debug/efi_page_tables
(if enabled). So let's just remove the lines above.

Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-runtime.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 86a1ad17a32e..13561aeb7396 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -83,10 +83,7 @@ static bool __init efi_virtmap_init(void)
 			return false;
 
 		ret = efi_create_mapping(&efi_mm, md);
-		if  (!ret) {
-			pr_info("  EFI remap %pa => %p\n",
-				&phys, (void *)(unsigned long)md->virt_addr);
-		} else {
+		if (ret) {
 			pr_warn("  EFI remap %pa: failed to create mapping (%d)\n",
 				&phys, ret);
 			return false;
-- 
2.15.1
