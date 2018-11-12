Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0F1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E278921527
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E278921527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbeKLNqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:46:08 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:53607 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726777AbeKLNqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:46:08 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 12 Nov 2018 12:54:50 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO kernel.lge.com) (165.186.175.97)
        by 156.147.1.126 with ESMTP; 12 Nov 2018 12:54:49 +0900
X-Original-SENDERIP: 165.186.175.97
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Seungho Park <seungho1.park@lge.com>,
        Inkyu Hwang <inkyu.hwang@lge.com>,
        Donghwan Jung <donghwan.jung@lge.com>,
        Jongsung Kim <neidhard.kim@lge.com>,
        Chanho Min <chanho.min@lge.com>
Subject: [PATCH v2] exec: make de_thread() freezable
Date:   Mon, 12 Nov 2018 12:54:45 +0900
Message-Id: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend fails due to the exec family of functions blocking the freezer.
The casue is that de_thread() sleeps in TASK_UNINTERRUPTIBLE waiting for
all sub-threads to die, and we have the deadlock if one of them is frozen.
This also can occur with the schedule() waiting for the group thread leader
to exit if it is frozen.

In our machine, it causes freeze timeout as bellows.

Freezing of tasks failed after 20.010 seconds (1 tasks refusing to freeze, wq_busy=0):
setcpushares-ls D ffffffc00008ed70     0  5817   1483 0x0040000d
 Call trace:
[<ffffffc00008ed70>] __switch_to+0x88/0xa0
[<ffffffc000d1c30c>] __schedule+0x1bc/0x720
[<ffffffc000d1ca90>] schedule+0x40/0xa8
[<ffffffc0001cd784>] flush_old_exec+0xdc/0x640
[<ffffffc000220360>] load_elf_binary+0x2a8/0x1090
[<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
[<ffffffc00021c584>] load_script+0x20c/0x228
[<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
[<ffffffc0001ce8e0>] do_execveat_common.isra.14+0x4f8/0x6e8
[<ffffffc0001cedd0>] compat_SyS_execve+0x38/0x48
[<ffffffc00008de30>] el0_svc_naked+0x24/0x28

To fix this, make de_thread() freezable. It looks safe and works fine.

Changes in v2:
 - changes for the same reason in "if (!thread_group_leader(tsk))" branch.
   (reported by Oleg)

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 fs/exec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1ebf6e5..6da8745 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -62,6 +62,7 @@
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
+#include <linux/freezer.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1083,7 +1084,7 @@ static int de_thread(struct task_struct *tsk)
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
-		schedule();
+		freezable_schedule();
 		if (unlikely(__fatal_signal_pending(tsk)))
 			goto killed;
 		spin_lock_irq(lock);
@@ -1111,7 +1112,7 @@ static int de_thread(struct task_struct *tsk)
 			__set_current_state(TASK_KILLABLE);
 			write_unlock_irq(&tasklist_lock);
 			cgroup_threadgroup_change_end(tsk);
-			schedule();
+			freezable_schedule();
 			if (unlikely(__fatal_signal_pending(tsk)))
 				goto killed;
 		}
-- 
2.1.4

