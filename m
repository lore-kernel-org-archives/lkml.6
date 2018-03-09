Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbeCIJNn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:13:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41709 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeCIJNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:13:41 -0500
Date: Fri, 9 Mar 2018 01:13:19 -0800
From: tip-bot for Jia-Ju Bai <tipbot@zytor.com>
Message-ID: <tip-9f66d8d73e654c5f867daa6aa186300ecaf49d3a@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, ard.biesheuvel@linaro.org,
        peterz@infradead.org, baijiaju1990@gmail.com, hpa@zytor.com,
        matt@codeblueprint.co.uk
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        ard.biesheuvel@linaro.org, mingo@kernel.org,
        torvalds@linux-foundation.org, matt@codeblueprint.co.uk, hpa@zytor.com,
        baijiaju1990@gmail.com, peterz@infradead.org
In-Reply-To: <20180308080020.22828-7-ard.biesheuvel@linaro.org>
References: <20180308080020.22828-7-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] x86/efi: Replace GFP_ATOMIC with GFP_KERNEL in
 efi_query_variable_store()
Git-Commit-ID: 9f66d8d73e654c5f867daa6aa186300ecaf49d3a
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

Commit-ID:  9f66d8d73e654c5f867daa6aa186300ecaf49d3a
Gitweb:     https://git.kernel.org/tip/9f66d8d73e654c5f867daa6aa186300ecaf49d3a
Author:     Jia-Ju Bai <baijiaju1990@gmail.com>
AuthorDate: Thu, 8 Mar 2018 08:00:14 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:58:22 +0100

x86/efi: Replace GFP_ATOMIC with GFP_KERNEL in efi_query_variable_store()

efi_query_variable_store() does an atomic kzalloc() unnecessarily,
because we can never get this far when called in an atomic context,
namely when nonblocking == 1.

Replace it with GFP_KERNEL.

This was found by the DCNS static analysis tool written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180308080020.22828-7-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
