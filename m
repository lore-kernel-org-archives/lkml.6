Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeEQHAl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:00:41 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44504 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeEQHAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:00:39 -0400
X-Google-Smtp-Source: AB8JxZqyxkzGVOu5KfeChioybrUn5ARuVZwzRy42qk7O7L8/6kBiOYai7P2GX9pkRq9VF+AWSyzu0Q==
From: ufo19890607 <ufo19890607@gmail.com>
To: akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhoujian <yuzhoujian@didichuxing.com>
Subject: [PATCH] Add the memcg print oom info for system oom
Date: Thu, 17 May 2018 08:00:28 +0100
Message-Id: <1526540428-12178-1-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

The dump_header does not print the memcg's name when the system
oom happened. Some users want to locate the certain container
which contains the task that has been killed by the oom killer.
So I add the mem_cgroup_print_oom_info when system oom events
happened.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 mm/oom_kill.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8ba6cb88cf58..244416c9834a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -433,6 +433,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 	if (is_memcg_oom(oc))
 		mem_cgroup_print_oom_info(oc->memcg, p);
 	else {
+		mem_cgroup_print_oom_info(mem_cgroup_from_task(p), p);
 		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
 		if (is_dump_unreclaim_slabs())
 			dump_unreclaimable_slab();
-- 
2.14.1
