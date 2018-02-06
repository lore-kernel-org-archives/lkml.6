Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeBFAys (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:54:48 -0500
Received: from ozlabs.org ([103.22.144.67]:53715 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752222AbeBFAyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:54:40 -0500
Date: Tue, 6 Feb 2018 11:54:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20180206115438.7008ac91@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  include/linux/sched/mm.h

between commit:

  d70f2a14b72a ("include/linux/sched/mm.h: uninline mmdrop_async(), etc")

from Linus' tree and commit:

  306e060435d7 ("membarrier: Document scheduler barrier requirements")

from the tip tree.

I fixed it up (I used the former version ofinclude/linux/sched/mm.h
and adde the following merge fix patch) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 6 Feb 2018 11:51:34 +1100
Subject: [PATCH] membarrier: fix up for mmdrop move

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/fork.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5c372c954f3b..c7c112391d79 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -606,6 +606,11 @@ static void __mmdrop(struct mm_struct *mm)
 
 void mmdrop(struct mm_struct *mm)
 {
+	/*
+	 * The implicit full barrier implied by atomic_dec_and_test() is
+	 * required by the membarrier system call before returning to
+	 * user-space, after storing to rq->curr.
+	 */
 	if (unlikely(atomic_dec_and_test(&mm->mm_count)))
 		__mmdrop(mm);
 }
-- 
2.15.1

-- 
Cheers,
Stephen Rothwell
