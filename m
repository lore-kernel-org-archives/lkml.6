Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E83CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E1B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8dhGcxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E1B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeK2RGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:06:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbeK2RGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:06:41 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6258213A2;
        Thu, 29 Nov 2018 06:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471350;
        bh=q+QxCI+Fxjshjm62J4/HS3sFKLsxZSYLxI+7C+9iChE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q8dhGcxFK5NODs4iZUCgeNAQ6weYmesqmEt3AANh9mnAAygN+rKCA4xSHTAHV1rem
         sMTlpX9aNpgXWmBnWRFLtvQtE+m7iR5wY3pfpbKB2AqYodtwvs1YdRHO8bHwL27rUn
         S1iNIFgkLc81cD6DR6Au/bDQGW7HpiIx7skuC1zM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chanho Min <chanho.min@lge.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 20/35] exec: make de_thread() freezable
Date:   Thu, 29 Nov 2018 01:00:54 -0500
Message-Id: <20181129060110.159878-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chanho Min <chanho.min@lge.com>

[ Upstream commit c22397888f1eed98cd59f0a88f2a5f6925f80e15 ]

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

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Chanho Min <chanho.min@lge.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 0da4d748b4e6..25c529f46aaa 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -62,6 +62,7 @@
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
+#include <linux/freezer.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1079,7 +1080,7 @@ static int de_thread(struct task_struct *tsk)
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
-		schedule();
+		freezable_schedule();
 		if (unlikely(__fatal_signal_pending(tsk)))
 			goto killed;
 		spin_lock_irq(lock);
@@ -1107,7 +1108,7 @@ static int de_thread(struct task_struct *tsk)
 			__set_current_state(TASK_KILLABLE);
 			write_unlock_irq(&tasklist_lock);
 			cgroup_threadgroup_change_end(tsk);
-			schedule();
+			freezable_schedule();
 			if (unlikely(__fatal_signal_pending(tsk)))
 				goto killed;
 		}
-- 
2.17.1

