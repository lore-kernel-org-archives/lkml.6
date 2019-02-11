Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CAAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BC0214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896621;
	bh=MvkvOAxkb9kz+j96JW32j7bOJG54hVi/c23BSyxELsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zZc4WBf/ZoPkU/EzB3gxpq4gkLFO0eySjwjPtzJWuEF0xrym5RyO1CdJVVJNz5KYY
	 /7KFpRCr3IIvxdpec3Yg/Kvr4UZDSBh7w9bnKFEfy6jBiq7HB59SEPCyfdvm/Ojxgf
	 WWYGLyM/6+OGXJWhqqNF0kPKCijvP7rHDTK5LJSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbfBKOuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388050AbfBKOuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EBED20855;
        Mon, 11 Feb 2019 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896615;
        bh=MvkvOAxkb9kz+j96JW32j7bOJG54hVi/c23BSyxELsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZI5fPFuyA2hAAAlQRzpbO3X7ffk7AqpO8MWl1PaTfOrLbhtbzq+gKCFp89qbxlz3
         llB02D6v0kvP6ZKaoylI8Noz6YWuZ/ZjNkprHW1hhxU2PRaOQT044gf7ITPO8JWOk/
         g2wT5RbebNaSfrMx3/5G8xl6Wc3b3UWdyiXqOs8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuansheng Liu <chuansheng.liu@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 243/313] kernel/hung_task.c: force console verbose before panic
Date:   Mon, 11 Feb 2019 15:18:43 +0100
Message-Id: <20190211141909.637942206@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 168e06f7937d96c7222037d8a05565e8a6eb00fe ]

Based on commit 401c636a0eeb ("kernel/hung_task.c: show all hung tasks
before panic"), we could get the call stack of hung task.

However, if the console loglevel is not high, we still can not see the
useful panic information in practice, and in most cases users don't set
console loglevel to high level.

This patch is to force console verbose before system panic, so that the
real useful information can be seen in the console, instead of being
like the following, which doesn't have hung task information.

  INFO: task init:1 blocked for more than 120 seconds.
        Tainted: G     U  W         4.19.0-quilt-2e5dc0ac-g51b6c21d76cc #1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  Kernel panic - not syncing: hung_task: blocked tasks
  CPU: 2 PID: 479 Comm: khungtaskd Tainted: G     U  W         4.19.0-quilt-2e5dc0ac-g51b6c21d76cc #1
  Call Trace:
   dump_stack+0x4f/0x65
   panic+0xde/0x231
   watchdog+0x290/0x410
   kthread+0x12c/0x150
   ret_from_fork+0x35/0x40
  reboot: panic mode set: p,w
  Kernel Offset: 0x34000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Link: http://lkml.kernel.org/r/27240C0AC20F114CBF8149A2696CBE4A6015B675@SHSMSX101.ccr.corp.intel.com
Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/hung_task.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index aa3c51f300aa..9eca2371f189 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -111,8 +111,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 
 	trace_sched_process_hang(t);
 
-	if (!sysctl_hung_task_warnings && !sysctl_hung_task_panic)
-		return;
+	if (sysctl_hung_task_panic) {
+		console_verbose();
+		hung_task_show_lock = true;
+		hung_task_call_panic = true;
+	}
 
 	/*
 	 * Ok, the task did not get scheduled for more than 2 minutes,
@@ -134,11 +137,6 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	}
 
 	touch_nmi_watchdog();
-
-	if (sysctl_hung_task_panic) {
-		hung_task_show_lock = true;
-		hung_task_call_panic = true;
-	}
 }
 
 /*
-- 
2.19.1



