Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeCOMiL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:38:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeCOMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:39 -0400
Message-Id: <20180315123202.735998040@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 08/11] sched/wait,ocfs2: Replace wait_on_atomic_t usage
References: <20180315121902.942902000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-wait_var-8.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the wait_on_atomic_t() usage to the new wait_var_event() API.

Cc: Joel Becker <jlbec@evilplan.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/ocfs2/filecheck.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/ocfs2/filecheck.c
+++ b/fs/ocfs2/filecheck.c
@@ -134,9 +134,10 @@ ocfs2_filecheck_sysfs_free(struct ocfs2_
 {
 	struct ocfs2_filecheck_entry *p;
 
-	if (!atomic_dec_and_test(&entry->fs_count))
-		wait_on_atomic_t(&entry->fs_count, atomic_t_wait,
-				 TASK_UNINTERRUPTIBLE);
+	if (!atomic_dec_and_test(&entry->fs_count)) {
+		wait_var_event(&entry->fs_count,
+			       !atomic_read(&entry->fs_count));
+	}
 
 	spin_lock(&entry->fs_fcheck->fc_lock);
 	while (!list_empty(&entry->fs_fcheck->fc_head)) {
@@ -183,7 +184,7 @@ static void
 ocfs2_filecheck_sysfs_put(struct ocfs2_filecheck_sysfs_entry *entry)
 {
 	if (atomic_dec_and_test(&entry->fs_count))
-		wake_up_atomic_t(&entry->fs_count);
+		wake_up_var(&entry->fs_count);
 }
 
 static struct ocfs2_filecheck_sysfs_entry *
