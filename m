Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Bn7OjqY+xgGRutuzEjdjk5vJphy+/wk2BwSwNs3Nn7Nlw7bJ4gO2h0/TL6pBaxiXRtw2M
ARC-Seal: i=1; a=rsa-sha256; t=1524653075; cv=none;
        d=google.com; s=arc-20160816;
        b=eVmgidgOpEbBx+K2cg2gSVDiq+3UESF2xyE1dTtYWJ6XsSH/+LxM3LQwVZVsH3hV63
         fhfA1KUDxHFWcsNUcZCpfCYTmM9nLmLF5BCc8rmWQ4KanxWQV6RdRMNyyqqU2RPnpPTX
         g8bK/reNrpdPYHeno5/wUGU1LSbwnzvzw/7vZSmWqJVtFCCuVDz400AIgrtwV9S8BoSV
         JXAtc3anVktkOv4WTejJOQUvilTnZp9KSajnbe7lSmsZG4OhiN1Hm/dmBPHjmLhhHo66
         UXNTwxn6fh/gQkiHNoGe8bZXJDwj4j4QUm0G/1d+Vy9lTNY1X43OUM0xENrgn4e4uj8T
         naSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7vCFnSr7UGIxu2xHGFGzSsF6IopczvwhJ/X3fP+an/Y=;
        b=gFqROhaFr+u3t4mKpdHG8v+xlIwYpnc4iVFDw86zV8zGXaQw+XTvh/oEupNKtWFQna
         l4Q0Quo8c4qPpGc9hehehuW54xgdHNzIE1zoqsVoFZBsrlm3tqXtepLw8NZqpC455J/U
         Fzn6HDkJZ6UGRaXEW4PLi5ZknZ/UTFgnJMwcJBIpk097Iu3L1rzFuZqTRr6q4QLwF5H1
         GZAru5PBdqh7UdHRKTdHE3wuU/2Q8s2zSxV824vGlsjDta+EGsUglTjMDk4FqLfQtBxy
         KtdtgrY4fpJ+DwYgZM9D8i1rPokGoFxofLxMcPhn6eQhPxoagFDIeojxWoC3vNd4MhIl
         j2QA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Coly Li <colyli@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Michael Lyle <mlyle@lyle.org>,
	Junhui Tang <tang.junhui@zte.com.cn>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 147/183] bcache: properly set task state in bch_writeback_thread()
Date: Wed, 25 Apr 2018 12:36:07 +0200
Message-Id: <20180425103248.448317528@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714622767470855?=
X-GMAIL-MSGID: =?utf-8?q?1598714622767470855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Coly Li <colyli@suse.de>


[ Upstream commit 99361bbf26337186f02561109c17a4c4b1a7536a ]

Kernel thread routine bch_writeback_thread() has the following code block,

447         down_write(&dc->writeback_lock);
448~450     if (check conditions) {
451                 up_write(&dc->writeback_lock);
452                 set_current_state(TASK_INTERRUPTIBLE);
453
454                 if (kthread_should_stop())
455                         return 0;
456
457                 schedule();
458                 continue;
459         }

If condition check is true, its task state is set to TASK_INTERRUPTIBLE
and call schedule() to wait for others to wake up it.

There are 2 issues in current code,
1, Task state is set to TASK_INTERRUPTIBLE after the condition checks, if
   another process changes the condition and call wake_up_process(dc->
   writeback_thread), then at line 452 task state is set back to
   TASK_INTERRUPTIBLE, the writeback kernel thread will lose a chance to be
   waken up.
2, At line 454 if kthread_should_stop() is true, writeback kernel thread
   will return to kernel/kthread.c:kthread() with TASK_INTERRUPTIBLE and
   call do_exit(). It is not good to enter do_exit() with task state
   TASK_INTERRUPTIBLE, in following code path might_sleep() is called and a
   warning message is reported by __might_sleep(): "WARNING: do not call
   blocking ops when !TASK_RUNNING; state=1 set at [xxxx]".

For the first issue, task state should be set before condition checks.
Ineed because dc->writeback_lock is required when modifying all the
conditions, calling set_current_state() inside code block where dc->
writeback_lock is hold is safe. But this is quite implicit, so I still move
set_current_state() before all the condition checks.

For the second issue, frankley speaking it does not hurt when kernel thread
exits with TASK_INTERRUPTIBLE state, but this warning message scares users,
makes them feel there might be something risky with bcache and hurt their
data.  Setting task state to TASK_RUNNING before returning fixes this
problem.

In alloc.c:allocator_wait(), there is also a similar issue, and is also
fixed in this patch.

Changelog:
v3: merge two similar fixes into one patch
v2: fix the race issue in v1 patch.
v1: initial buggy fix.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Cc: Michael Lyle <mlyle@lyle.org>
Cc: Junhui Tang <tang.junhui@zte.com.cn>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/alloc.c     |    4 +++-
 drivers/md/bcache/writeback.c |    7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -287,8 +287,10 @@ do {									\
 			break;						\
 									\
 		mutex_unlock(&(ca)->set->bucket_lock);			\
-		if (kthread_should_stop())				\
+		if (kthread_should_stop()) {				\
+			set_current_state(TASK_RUNNING);		\
 			return 0;					\
+		}							\
 									\
 		schedule();						\
 		mutex_lock(&(ca)->set->bucket_lock);			\
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -420,18 +420,21 @@ static int bch_writeback_thread(void *ar
 
 	while (!kthread_should_stop()) {
 		down_write(&dc->writeback_lock);
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (!atomic_read(&dc->has_dirty) ||
 		    (!test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags) &&
 		     !dc->writeback_running)) {
 			up_write(&dc->writeback_lock);
-			set_current_state(TASK_INTERRUPTIBLE);
 
-			if (kthread_should_stop())
+			if (kthread_should_stop()) {
+				set_current_state(TASK_RUNNING);
 				return 0;
+			}
 
 			schedule();
 			continue;
 		}
+		set_current_state(TASK_RUNNING);
 
 		searched_full_index = refill_dirty(dc);
 
