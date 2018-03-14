Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeCNT2c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:28:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51049 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeCNT23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:28:29 -0400
Date: Wed, 14 Mar 2018 12:27:53 -0700
From: tip-bot for Toshi Kani <tipbot@zytor.com>
Message-ID: <tip-18a955219bf7d9008ce480d4451b6b8bf4483a22@git.kernel.org>
Cc: tglx@linutronix.de, luto@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, toshi.kani@hpe.com, bp@alien8.de, hpa@zytor.com,
        gratian.crisan@ni.com
Reply-To: toshi.kani@hpe.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, luto@kernel.org, gratian.crisan@ni.com,
        hpa@zytor.com, bp@alien8.de
In-Reply-To: <20180313170347.3829-2-toshi.kani@hpe.com>
References: <20180313170347.3829-2-toshi.kani@hpe.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Fix vmalloc_fault to use pXd_large
Git-Commit-ID: 18a955219bf7d9008ce480d4451b6b8bf4483a22
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

Commit-ID:  18a955219bf7d9008ce480d4451b6b8bf4483a22
Gitweb:     https://git.kernel.org/tip/18a955219bf7d9008ce480d4451b6b8bf4483a22
Author:     Toshi Kani <toshi.kani@hpe.com>
AuthorDate: Tue, 13 Mar 2018 11:03:46 -0600
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 14 Mar 2018 20:22:42 +0100

x86/mm: Fix vmalloc_fault to use pXd_large

Gratian Crisan reported that vmalloc_fault() crashes when CONFIG_HUGETLBFS
is not set since the function inadvertently uses pXn_huge(), which always
return 0 in this case.  ioremap() does not depend on CONFIG_HUGETLBFS.

Fix vmalloc_fault() to call pXd_large() instead.

Fixes: f4eafd8bcd52 ("x86/mm: Fix vmalloc_fault() to handle large pages properly")
Reported-by: Gratian Crisan <gratian.crisan@ni.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20180313170347.3829-2-toshi.kani@hpe.com

---
 arch/x86/mm/fault.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index c88573d90f3e..25a30b5d6582 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -330,7 +330,7 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (!pmd_k)
 		return -1;
 
-	if (pmd_huge(*pmd_k))
+	if (pmd_large(*pmd_k))
 		return 0;
 
 	pte_k = pte_offset_kernel(pmd_k, address);
@@ -475,7 +475,7 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (pud_none(*pud) || pud_pfn(*pud) != pud_pfn(*pud_ref))
 		BUG();
 
-	if (pud_huge(*pud))
+	if (pud_large(*pud))
 		return 0;
 
 	pmd = pmd_offset(pud, address);
@@ -486,7 +486,7 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (pmd_none(*pmd) || pmd_pfn(*pmd) != pmd_pfn(*pmd_ref))
 		BUG();
 
-	if (pmd_huge(*pmd))
+	if (pmd_large(*pmd))
 		return 0;
 
 	pte_ref = pte_offset_kernel(pmd_ref, address);
