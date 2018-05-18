Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeERDHj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 23:07:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44085 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbeERDHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 23:07:38 -0400
X-Google-Smtp-Source: AB8JxZqHnJ+rFU4acyx6JOjhHdwjiKxH7AQS2njWn8u82TNXsbP88J/9arOr3EaehWohJpSvUCmPeg==
From: ufo19890607 <ufo19890607@gmail.com>
To: akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhoujian <yuzhoujian@didichuxing.com>
Subject: [PATCH v2] Print the memcg's name when system-wide OOM happened
Date: Fri, 18 May 2018 04:07:14 +0100
Message-Id: <1526612834-8898-1-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

The dump_header does not print the memcg's name when the system
oom happened. So users cannot locate the certain container which
contains the task that has been killed by the oom killer. System
oom report will contain the memcg's name after this patch.

Changes since v1:
- replace adding mem_cgroup_print_oom_info with printing the memcg's
  name only.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 mm/oom_kill.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8ba6cb88cf58..b0abb5930232 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -433,6 +433,9 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 	if (is_memcg_oom(oc))
 		mem_cgroup_print_oom_info(oc->memcg, p);
 	else {
+		pr_info("Task in ");
+		pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
+		pr_cont(" killed as a result of limit of ");
 		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
 		if (is_dump_unreclaim_slabs())
 			dump_unreclaimable_slab();
-- 
2.14.1
