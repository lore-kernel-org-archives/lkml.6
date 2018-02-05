Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeBEB2U (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:28:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:43363 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752343AbeBEB2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:01 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 04/64] mm: add a range parameter to the vm_fault structure
Date: Mon,  5 Feb 2018 02:26:54 +0100
Message-Id: <20180205012754.23615-5-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

When handling a page fault, it happens that the mmap_sem is released
during the processing. As moving to range lock requires to pass the
range parameter to the lock/unlock operation, this patch add a pointer
to the range structure used when locking the mmap_sem to vm_fault
structure.

It is currently unused, but will be in the next patches.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9d2ed23aa894..bcf2509d448d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -361,6 +361,10 @@ struct vm_fault {
 					 * page table to avoid allocation from
 					 * atomic context.
 					 */
+	struct range_lock *lockrange;	/* Range lock interval in use for when
+					 * the mm lock is manipulated throughout
+					 * its lifespan.
+					 */
 };
 
 /* page entry size for vm->huge_fault() */
-- 
2.13.6
