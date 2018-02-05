Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbeBEBgj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:36:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:43469 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752562AbeBEB3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:29:00 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 42/64] arch/frv: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:32 +0100
Message-Id: <20180205012754.23615-43-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

This becomes quite straightforward with the mmrange in place.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/frv/mm/fault.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/frv/mm/fault.c b/arch/frv/mm/fault.c
index 494d33b628fc..a5da0586e6cc 100644
--- a/arch/frv/mm/fault.c
+++ b/arch/frv/mm/fault.c
@@ -86,7 +86,7 @@ asmlinkage void do_page_fault(int datammu, unsigned long esr0, unsigned long ear
 	if (user_mode(__frame))
 		flags |= FAULT_FLAG_USER;
 
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 
 	vma = find_vma(mm, ear0);
 	if (!vma)
@@ -181,7 +181,7 @@ asmlinkage void do_page_fault(int datammu, unsigned long esr0, unsigned long ear
 	else
 		current->min_flt++;
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	return;
 
 /*
@@ -189,7 +189,7 @@ asmlinkage void do_page_fault(int datammu, unsigned long esr0, unsigned long ear
  * Fix it, but check if it's kernel or user first..
  */
  bad_area:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(__frame)) {
@@ -259,14 +259,14 @@ asmlinkage void do_page_fault(int datammu, unsigned long esr0, unsigned long ear
  * us unable to handle the page fault gracefully.
  */
  out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	if (!user_mode(__frame))
 		goto no_context;
 	pagefault_out_of_memory();
 	return;
 
  do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
-- 
2.13.6
