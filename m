Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeBHTIS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:08:18 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:63845 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751544AbeBHTIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:08:17 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
From: Chris Wilson <chris@chris-wilson.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>,
        Ingo Molnar <mingo@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] khungtaskd: Kick stuck processes
Date: Thu,  8 Feb 2018 19:07:53 +0000
Message-Id: <20180208190753.17690-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.16.1
X-Originating-IP: 78.156.65.138
X-Country: code=GB country="United Kingdom" ip=78.156.65.138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After spotting a stuck process, and having decided not to panic, give
the task a kick to see if that helps it to recover (e.g. to paper over a
missed wake up).

References: https://bugs.freedesktop.org/show_bug.cgi?id=104009
References: https://bugs.freedesktop.org/show_bug.cgi?id=104682
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/hung_task.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 751593ed7c0b..b32acb6bcc63 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -132,6 +132,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		trigger_all_cpu_backtrace();
 		panic("hung_task: blocked tasks");
 	}
+
+	wake_up_process(t);
 }
 
 /*
-- 
2.16.1
