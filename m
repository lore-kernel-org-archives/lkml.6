Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeBEBcn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:32:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:44098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752796AbeBEB3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:29:25 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 50/64] arch/unicore32: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:40 +0100
Message-Id: <20180205012754.23615-51-dbueso@wotan.suse.de>
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
 arch/unicore32/mm/fault.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index dd35b6191798..f806ade79afd 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -233,12 +233,12 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * validly references user space from well defined areas of the code,
 	 * we can bug out early if this is from code which shouldn't.
 	 */
-	if (!down_read_trylock(&mm->mmap_sem)) {
+	if (!mm_read_trylock(mm, &mmrange)) {
 		if (!user_mode(regs)
 		    && !search_exception_tables(regs->UCreg_pc))
 			goto no_context;
 retry:
-		down_read(&mm->mmap_sem);
+		mm_read_lock(mm, &mmrange);
 	} else {
 		/*
 		 * The above down_read_trylock() might have succeeded in
@@ -275,7 +275,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		}
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 
 	/*
 	 * Handle the "normal" case first - VM_FAULT_MAJOR
-- 
2.13.6
