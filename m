Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23775C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E867F20840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197972;
	bh=TON0jWu7Z48cGnW3MRq5Cs1m2Hlpe+QDwDUQJgb6nwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i5tcqjEqGgMDh8IzTiedFHGf7IuCGCrY8ahDmWPMQoUrR7QE0oa2wgH8prDRDPzSq
	 /SB0/G8Fhreli7Y4BJwyyapULA8pkoygnKGO+e7DIS2ffv93HsPag/Az2+bO0Bkyom
	 wzHAVGnfe8uyWA3rrTjTKG+QJgk5ClJPO8NQtlwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbfBOCct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:32:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404094AbfBOCMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6792521934;
        Fri, 15 Feb 2019 02:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196732;
        bh=TON0jWu7Z48cGnW3MRq5Cs1m2Hlpe+QDwDUQJgb6nwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nH2q6V65RqWWGh4AhPLHbUEDDh03SxJ7T4BVePiquPFUKnjy2PeEWcNuS8l46ED4v
         IzrV29xn/0QuWcF3N8DvxRWFTQCzNAbsMt+YTkNLP7Q/+n8CHxWqid6kwnPZAOdMR6
         ygUpbaNtEl753XSSF0GHTo1jobaNFtBZ0wgg4Oxs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Prateek Sood <prsood@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 30/65] sched/wait: Fix rcuwait_wake_up() ordering
Date:   Thu, 14 Feb 2019 21:10:46 -0500
Message-Id: <20190215021121.177674-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prateek Sood <prsood@codeaurora.org>

[ Upstream commit 6dc080eeb2ba01973bfff0d79844d7a59e12542e ]

For some peculiar reason rcuwait_wake_up() has the right barrier in
the comment, but not in the code.

This mistake has been observed to cause a deadlock in the following
situation:

    P1					P2

    percpu_up_read()			percpu_down_write()
      rcu_sync_is_idle() // false
					  rcu_sync_enter()
					  ...
      __percpu_up_read()

[S] ,-  __this_cpu_dec(*sem->read_count)
    |   smp_rmb();
[L] |   task = rcu_dereference(w->task) // NULL
    |
    |				    [S]	    w->task = current
    |					    smp_mb();
    |				    [L]	    readers_active_check() // fail
    `-> <store happens here>

Where the smp_rmb() (obviously) fails to constrain the store.

[ peterz: Added changelog. ]

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 8f95c90ceb54 ("sched/wait, RCU: Introduce rcuwait machinery")
Link: https://lkml.kernel.org/r/1543590656-7157-1-git-send-email-prsood@codeaurora.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 55b4fa6d01eb..d607e23fd0c3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -307,7 +307,7 @@ void rcuwait_wake_up(struct rcuwait *w)
 	 *        MB (A)	      MB (B)
 	 *    [L] cond		  [L] tsk
 	 */
-	smp_rmb(); /* (B) */
+	smp_mb(); /* (B) */
 
 	/*
 	 * Avoid using task_rcu_dereference() magic as long as we are careful,
-- 
2.19.1

