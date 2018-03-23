Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeCWTWM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:22:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37333 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCWTWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:22:10 -0400
Date: Fri, 23 Mar 2018 12:21:54 -0700
From: tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-06ace26f4e6fcf747e890a39193be811777a048a@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        longman@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, ard.biesheuvel@linaro.org
Reply-To: longman@redhat.com, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, ard.biesheuvel@linaro.org
In-Reply-To: <1521746333-19593-1-git-send-email-longman@redhat.com>
References: <1521746333-19593-1-git-send-email-longman@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/efi: Free efi_pgd with free_pages()
Git-Commit-ID: 06ace26f4e6fcf747e890a39193be811777a048a
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

Commit-ID:  06ace26f4e6fcf747e890a39193be811777a048a
Gitweb:     https://git.kernel.org/tip/06ace26f4e6fcf747e890a39193be811777a048a
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 22 Mar 2018 15:18:53 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 23 Mar 2018 20:18:31 +0100

x86/efi: Free efi_pgd with free_pages()

The efi_pgd is allocated as PGD_ALLOCATION_ORDER pages and therefore must
also be freed as PGD_ALLOCATION_ORDER pages with free_pages().

Fixes: d9e9a6418065 ("x86/mm/pti: Allocate a separate user PGD")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1521746333-19593-1-git-send-email-longman@redhat.com

---
 arch/x86/platform/efi/efi_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index c310a8284358..f9cfbc0d1f33 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -227,7 +227,7 @@ int __init efi_alloc_page_tables(void)
 	if (!pud) {
 		if (CONFIG_PGTABLE_LEVELS > 4)
 			free_page((unsigned long) pgd_page_vaddr(*pgd));
-		free_page((unsigned long)efi_pgd);
+		free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
 		return -ENOMEM;
 	}
 
