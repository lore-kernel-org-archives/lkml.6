Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965930AbeCHIEN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:04:13 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41896 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965250AbeCHICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:02:06 -0500
X-Google-Smtp-Source: AG47ELv1wcVElydKaO5xn8zpop50MW1E0PI+ZZP1fygwUtoQQ2rzAjQlxAZI3GiJvlyIBzkRxAZ8PA==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] x86: efi: Replace GFP_ATOMIC with GFP_KERNEL in efi_query_variable_store
Date: Thu,  8 Mar 2018 08:00:14 +0000
Message-Id: <20180308080020.22828-7-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
References: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

The function kzalloc here is not called in atomic context.
If nonblocking in efi_query_variable_store is true,
namely it is in atomic context, efi_query_variable_store will return before
this kzalloc is called.
Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 5b513ccffde4..1ef11c26f79b 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -177,7 +177,7 @@ efi_status_t efi_query_variable_store(u32 attributes, unsigned long size,
 		 * that by attempting to use more space than is available.
 		 */
 		unsigned long dummy_size = remaining_size + 1024;
-		void *dummy = kzalloc(dummy_size, GFP_ATOMIC);
+		void *dummy = kzalloc(dummy_size, GFP_KERNEL);
 
 		if (!dummy)
 			return EFI_OUT_OF_RESOURCES;
-- 
2.15.1
