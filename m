Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B1FC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F2421741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695346;
	bh=R9UjbWR42N1bMFqAXz7fxRNMKrSK7hO0KZrzRCFmMK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ne9E2fOsHg12/yGop9+7O+P/1kDZtrRNSmfvEN2EniNibbz5Nbg3v8VkzX2mV7CRM
	 ydHfqLNpl/oGU4VXW04bIqPX2VwJc3vktsI3LzVVdnD7B0XusIr8cPCH1aNts9euLC
	 oseXvMsqNUZeoNeVAOxo44eUvdUjCk/DH+NeXYG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbfA1QLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733015AbfA1QLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:11:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2321C2147A;
        Mon, 28 Jan 2019 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691906;
        bh=R9UjbWR42N1bMFqAXz7fxRNMKrSK7hO0KZrzRCFmMK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iECl/Wp8bbodenMP8msL4+ZyvtXA4zzeXmEd0yNG8hmeINFulH9dHB+qcb+DnFqjV
         0jv5vAczz9fsXpoMevA1llssQHFvI5YMCmKDFoRk48P8+KesdIrn9lufdYaVNqZKaE
         NoCkMuBzynPFJCoCBz5wMCpGHi8xvgSNlkb+EsWc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 254/258] kernel/hung_task.c: force console verbose before panic
Date:   Mon, 28 Jan 2019 10:59:20 -0500
Message-Id: <20190128155924.51521-254-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liu, Chuansheng" <chuansheng.liu@intel.com>

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

