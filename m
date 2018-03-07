Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755107AbeCGXwT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:52:19 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:34763 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755079AbeCGXwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:52:17 -0500
X-Google-Smtp-Source: AG47ELtXAXV2ZOn5E9MpYrhLvifgKFUL1fWjuB5Oyf7sHgVyOOAEXpf/fj/OWYTRJsnCbupv9+K+1A==
Date: Wed, 7 Mar 2018 15:52:15 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Gaurav Kohli <gkohli@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>
cc: mhocko@suse.com, kirill.shutemov@linux.intel.com,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [patch] mm, oom: remove 3% bonus for CAP_SYS_ADMIN processes
Message-ID: <alpine.DEB.2.20.1803071548510.6996@chino.kir.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the 2.6 kernel, the oom killer has slightly biased away from 
CAP_SYS_ADMIN processes by discounting some of its memory usage in 
comparison to other processes.

This has always been implicit and nothing exactly relies on the behavior.

Gaurav notices that __task_cred() can dereference a potentially freed 
pointer if the task under consideration is exiting because a reference to 
the task_struct is not held.

Remove the CAP_SYS_ADMIN bias so that all processes are treated equally.

If any CAP_SYS_ADMIN process would like to be biased against, it is always 
allowed to adjust /proc/pid/oom_score_adj.

Reported-by: Gaurav Kohli <gkohli@codeaurora.org>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/oom_kill.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -224,13 +224,6 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
 		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
 	task_unlock(p);
 
-	/*
-	 * Root processes get 3% bonus, just like the __vm_enough_memory()
-	 * implementation used by LSMs.
-	 */
-	if (has_capability_noaudit(p, CAP_SYS_ADMIN))
-		points -= (points * 3) / 100;
-
 	/* Normalize to oom_score_adj units */
 	adj *= totalpages / 1000;
 	points += adj;
