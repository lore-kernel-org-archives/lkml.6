Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeCIJMm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:12:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47767 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbeCIJMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:12:37 -0500
Date: Fri, 9 Mar 2018 01:12:17 -0800
From: tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-1832e64162ffbbbdf7230401298550f2b624351b@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, leif.lindholm@linaro.org,
        tglx@linutronix.de, matt@codeblueprint.co.uk,
        ard.biesheuvel@linaro.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: mingo@kernel.org, hpa@zytor.com, ard.biesheuvel@linaro.org,
        matt@codeblueprint.co.uk, tglx@linutronix.de, leif.lindholm@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
In-Reply-To: <20180308080020.22828-4-ard.biesheuvel@linaro.org>
References: <20180308080020.22828-4-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/arm*: Stop printing addresses of virtual
 mappings
Git-Commit-ID: 1832e64162ffbbbdf7230401298550f2b624351b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1832e64162ffbbbdf7230401298550f2b624351b
Gitweb:     https://git.kernel.org/tip/1832e64162ffbbbdf7230401298550f2b624351b
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Thu, 8 Mar 2018 08:00:11 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:58:22 +0100

efi/arm*: Stop printing addresses of virtual mappings

With the recent %p -> %px changes, we now get something like this in
the kernel boot log on ARM/arm64 EFI systems:

     Remapping and enabling EFI services.
       EFI remap 0x00000087fb830000 =>         (ptrval)
       EFI remap 0x00000087fbdb0000 =>         (ptrval)
       EFI remap 0x00000087fffc0000 =>         (ptrval)

The physical addresses of the UEFI runtime regions will also be
printed when booting with the efi=debug command line option, and the
virtual addresses can be inspected via /sys/kernel/debug/efi_page_tables
(if enabled).

So let's just remove the lines above.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180308080020.22828-4-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
