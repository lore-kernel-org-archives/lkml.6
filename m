Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeCLIqP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:46:15 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37854 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751911AbeCLIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:45:37 -0400
X-Google-Smtp-Source: AG47ELtuXrHemPRkFbFgDk5ZP4xPCPCcQSfvTsiG0S4h9c+aAs+Nc3rCjW/ouCvQ+mIf3F+IBPB5xA==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>
Subject: [PATCH 4/5] efi/esrt: fix handling of early ESRT table mapping
Date: Mon, 12 Mar 2018 08:44:59 +0000
Message-Id: <20180312084500.10764-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180312084500.10764-1-ard.biesheuvel@linaro.org>
References: <20180312084500.10764-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Peter Jones <pjones@redhat.com>
Reported-by: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
-- 
2.15.1
