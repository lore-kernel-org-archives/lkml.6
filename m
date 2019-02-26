Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF19AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0D42173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfBZJ6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:58:09 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:43540 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfBZJ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:58:08 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1Q9w6nM079974;
        Tue, 26 Feb 2019 18:58:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Tue, 26 Feb 2019 18:58:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1Q9w2eh079953
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Feb 2019 18:58:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] kernel/hung_task.c: Use continuously blocked time when reporting.
Date:   Tue, 26 Feb 2019 18:58:03 +0900
Message-Id: <1551175083-10669-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a2e514453861dd39 ("kernel/hung_task.c: allow to set checking
interval separately from timeout") added hung_task_check_interval_secs,
setting a value different from hung_task_timeout_secs

  echo 0 > /proc/sys/kernel/hung_task_panic
  echo 120 > /proc/sys/kernel/hung_task_timeout_secs
  echo 5 > /proc/sys/kernel/hung_task_check_interval_secs

causes confusing output as if the task was blocked for
hung_task_timeout_secs seconds from the previous report.

  [  399.395930] INFO: task kswapd0:75 blocked for more than 120 seconds.
  [  405.027637] INFO: task kswapd0:75 blocked for more than 120 seconds.
  [  410.659725] INFO: task kswapd0:75 blocked for more than 120 seconds.
  [  416.292860] INFO: task kswapd0:75 blocked for more than 120 seconds.
  [  421.932305] INFO: task kswapd0:75 blocked for more than 120 seconds.

Although we could update t->last_switch_time after sched_show_task(t) if
we want to report only every 120 seconds, reporting every 5 seconds might
not be very bad for monitoring after a problematic situation has started.
Thus, let's use continuously blocked time instead of updating previously
reported time.

  [  677.985011] INFO: task kswapd0:80 blocked for more than 122 seconds.
  [  693.856126] INFO: task kswapd0:80 blocked for more than 138 seconds.
  [  709.728075] INFO: task kswapd0:80 blocked for more than 154 seconds.
  [  725.600018] INFO: task kswapd0:80 blocked for more than 170 seconds.
  [  741.473133] INFO: task kswapd0:80 blocked for more than 186 seconds.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/hung_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 4a91916..6429139 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -126,7 +126,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-			t->comm, t->pid, timeout);
+		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
 		pr_err("      %s %s %.*s\n",
 			print_tainted(), init_utsname()->release,
 			(int)strcspn(init_utsname()->version, " "),
-- 
1.8.3.1
