Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeBEBgb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:36:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:44106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752758AbeBEB25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:57 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 46/64] arch/metag: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:36 +0100
Message-Id: <20180205012754.23615-47-dbueso@wotan.suse.de>
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
 arch/metag/mm/fault.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/metag/mm/fault.c b/arch/metag/mm/fault.c
index e16ba0ea7ea1..47ab10069fde 100644
--- a/arch/metag/mm/fault.c
+++ b/arch/metag/mm/fault.c
@@ -114,7 +114,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 retry:
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 
 	vma = find_vma_prev(mm, address, &prev_vma);
 
@@ -169,7 +169,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		}
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	return 0;
 
 check_expansion:
@@ -178,7 +178,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		goto good_area;
 
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 
 bad_area_nosemaphore:
 	if (user_mode(regs)) {
@@ -206,7 +206,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	goto no_context;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
@@ -230,7 +230,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * us unable to handle the page fault gracefully.
 	 */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	if (user_mode(regs)) {
 		pagefault_out_of_memory();
 		return 1;
-- 
2.13.6
