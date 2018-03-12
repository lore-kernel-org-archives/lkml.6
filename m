Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeCLJcF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:32:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41783 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLJcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:32:03 -0400
Date: Mon, 12 Mar 2018 02:31:30 -0700
From: tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-136d5d57e35cc6985c57d23d0c823133e3508bed@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tbaicar@codeaurora.org, peterz@infradead.org, mingo@kernel.org,
        matt@codeblueprint.co.uk, ard.biesheuvel@linaro.org, pjones@redhat.com,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, tbaicar@codeaurora.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, matt@codeblueprint.co.uk,
        ard.biesheuvel@linaro.org, pjones@redhat.com
In-Reply-To: <20180312084500.10764-5-ard.biesheuvel@linaro.org>
References: <20180312084500.10764-5-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/esrt: Fix handling of early ESRT table mapping
Git-Commit-ID: 136d5d57e35cc6985c57d23d0c823133e3508bed
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

Commit-ID:  136d5d57e35cc6985c57d23d0c823133e3508bed
Gitweb:     https://git.kernel.org/tip/136d5d57e35cc6985c57d23d0c823133e3508bed
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Mon, 12 Mar 2018 08:44:59 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 10:05:01 +0100

efi/esrt: Fix handling of early ESRT table mapping

As reported by Tyler, efi_esrt_init() will return without releasing the
ESRT table header mapping if it encounters a table with an unexpected
version. Replacing the 'return' with 'goto err_memunmap' would fix this
particular occurrence, but, as it turns out, the code is rather peculiar
to begin with:

 - it never uses the header mapping after memcpy()'ing out its contents,
 - it maps and unmaps the entire table without ever looking at the
   contents.

So let's refactor this code to unmap the table header right after the
memcpy() so we can get rid of the error handling path altogether, and
drop the second mapping entirely.

Reported-by: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180312084500.10764-5-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/esrt.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index c47e0c6ec00f..1ab80e06e7c5 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -279,6 +279,7 @@ void __init efi_esrt_init(void)
 	}
 
 	memcpy(&tmpesrt, va, sizeof(tmpesrt));
+	early_memunmap(va, size);
 
 	if (tmpesrt.fw_resource_version == 1) {
 		entry_size = sizeof (*v1_entries);
@@ -291,7 +292,7 @@ void __init efi_esrt_init(void)
 	if (tmpesrt.fw_resource_count > 0 && max - size < entry_size) {
 		pr_err("ESRT memory map entry can only hold the header. (max: %zu size: %zu)\n",
 		       max - size, entry_size);
-		goto err_memunmap;
+		return;
 	}
 
 	/*
@@ -304,7 +305,7 @@ void __init efi_esrt_init(void)
 	if (tmpesrt.fw_resource_count > 128) {
 		pr_err("ESRT says fw_resource_count has very large value %d.\n",
 		       tmpesrt.fw_resource_count);
-		goto err_memunmap;
+		return;
 	}
 
 	/*
@@ -315,18 +316,10 @@ void __init efi_esrt_init(void)
 	if (max < size + entries_size) {
 		pr_err("ESRT does not fit on single memory map entry (size: %zu max: %zu)\n",
 		       size, max);
-		goto err_memunmap;
+		return;
 	}
 
-	/* remap it with our (plausible) new pages */
-	early_memunmap(va, size);
 	size += entries_size;
-	va = early_memremap(efi.esrt, size);
-	if (!va) {
-		pr_err("early_memremap(%p, %zu) failed.\n", (void *)efi.esrt,
-		       size);
-		return;
-	}
 
 	esrt_data = (phys_addr_t)efi.esrt;
 	esrt_data_size = size;
@@ -336,8 +329,6 @@ void __init efi_esrt_init(void)
 	efi_mem_reserve(esrt_data, esrt_data_size);
 
 	pr_debug("esrt-init: loaded.\n");
-err_memunmap:
-	early_memunmap(va, size);
 }
 
 static int __init register_entries(void)
