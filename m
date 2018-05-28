Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937330AbeE1K3b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937282AbeE1K3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:29:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yisheng Xie <xieyisheng1@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>, Andi Kleen <ak@linux.intel.com>,
        Chris Salls <salls@cs.ucsb.edu>, Christopher Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 069/329] mm/mempolicy: add nodes_empty check in SYSC_migrate_pages
Date: Mon, 28 May 2018 11:59:58 +0200
Message-Id: <20180528100248.557111083@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yisheng Xie <xieyisheng1@huawei.com>

[ Upstream commit 0486a38bcc4749808edbc848f1bcf232042770fc ]

As in manpage of migrate_pages, the errno should be set to EINVAL when
none of the node IDs specified by new_nodes are on-line and allowed by
the process's current cpuset context, or none of the specified nodes
contain memory.  However, when test by following case:

	new_nodes = 0;
	old_nodes = 0xf;
	ret = migrate_pages(pid, old_nodes, new_nodes, MAX);

The ret will be 0 and no errno is set.  As the new_nodes is empty, we
should expect EINVAL as documented.

To fix the case like above, this patch check whether target nodes AND
current task_nodes is empty, and then check whether AND
node_states[N_MEMORY] is empty.

Link: http://lkml.kernel.org/r/1510882624-44342-4-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chris Salls <salls@cs.ucsb.edu>
Cc: Christopher Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mempolicy.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1442,10 +1442,14 @@ SYSCALL_DEFINE4(migrate_pages, pid_t, pi
 		goto out_put;
 	}
 
-	if (!nodes_subset(*new, node_states[N_MEMORY])) {
-		err = -EINVAL;
+	task_nodes = cpuset_mems_allowed(current);
+	nodes_and(*new, *new, task_nodes);
+	if (nodes_empty(*new))
+		goto out_put;
+
+	nodes_and(*new, *new, node_states[N_MEMORY]);
+	if (nodes_empty(*new))
 		goto out_put;
-	}
 
 	err = security_task_movememory(task);
 	if (err)
