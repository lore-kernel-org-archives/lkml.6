Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELs4kp8d26PG/4/6VPBAYfKrSKK6ZO8IW6tXfbmdh+78ElVvFTpB8hquE3d6r57WT2OlR46N
ARC-Seal: i=1; a=rsa-sha256; t=1519947212; cv=none;
        d=google.com; s=arc-20160816;
        b=eDLqF4YVaTllbNYoIK9qirbIT6JSVoAUbPc7tdC/T8SBnrlRVwOTupmYnJMgQsVFzG
         FxZdmSHpSWJL65AA3acf4MuYD0Oj9Sr4PR+0nRc0YYh9fEWOigN1KN6opwlnd78oDejO
         vf8N/Jgu6ubDoE40NUiMxQlQqRPagxt14jnN0uWy6nzSGP/xQsUvjaxUgvuD7/0J9F9J
         DgZRMu/MwDhqdVqKcfk5yH431c1Wl443xffd4EB0pm1FtZrnG35HbdbpOLHfpO6wwqft
         n1NQhIILubbwHTx6bW8LGF3zuX/fWfWQDHGoUPKj6xGsjJXvoIIlNyOlK3LjmJqEPeTK
         Tj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=oMZiuk0VCC7XmlTTBqDVmFIuUIuFs7cmskFqRD8Dpzo=;
        b=S2yvmeWJtZIzoNyYK5zgRb7Dn28ZH+4j7Y7gShe7LhDjMkp45WBOtQrTc6sjVjH3tj
         DOPzVM/D/Eqk2l0C1h60JMYVDQbXxt++bWwBFMzWAG+8mUvQE0mtJ0UFamGDkFKgx2D7
         zfpV/xqyBL2JatW2AuFGaoc4V7EymK/e4fRYFpHcnkMDly8nKDBjEktdYny/LK7HKrYN
         aSvPVmS00zUWN0S5Ad3nxIuyZV6E0xYJLlHgGeRYc6aAFky9EhQjMa4jQSG2rtyTH0Ub
         ZdE9mztIGyqjXWZUJ4NjRj3XWNAGIo4q9EWFeLHzy2my0PboH7F2ksuz3f4yB2oja13b
         8WdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 11/17] staging: lustre: ptlrpc: use workqueue for pinger
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994708541.7628.5813099904100247526.stgit@noble>
In-Reply-To: <151994679573.7628.1024109499321778846.stgit@noble>
References: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780168307156480?=
X-GMAIL-MSGID: =?utf-8?q?1593780168307156480?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

lustre has a "Pinger" kthread which periodically pings peers
to ensure all hosts are functioning.

This can more easily be done using a work queue.

As maintaining contact with other peers is import for
keeping the filesystem running, and as the filesystem might
be involved in freeing memory, it is safest to have a
separate WQ_MEM_RECLAIM workqueue.

The SVC_EVENT functionality to wake up the thread can be
replaced with mod_delayed_work().

Also use round_jiffies_up_relative() rather than setting a
minimum of 1 second delay.  The PING_INTERVAL is measured in
seconds so this meets the need is allow the workqueue to
keep wakeups synchronized.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/ptlrpc/pinger.c |   81 +++++++------------------
 1 file changed, 24 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/pinger.c b/drivers/staging/lustre/lustre/ptlrpc/pinger.c
index b5f3cfee8e75..0775b7a048bb 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/pinger.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/pinger.c
@@ -217,21 +217,18 @@ static void ptlrpc_pinger_process_import(struct obd_import *imp,
 	}
 }
 
-static int ptlrpc_pinger_main(void *arg)
-{
-	struct ptlrpc_thread *thread = arg;
-
-	/* Record that the thread is running */
-	thread_set_flags(thread, SVC_RUNNING);
-	wake_up(&thread->t_ctl_waitq);
+static struct workqueue_struct *pinger_wq;
+static void ptlrpc_pinger_main(struct work_struct *ws);
+static DECLARE_DELAYED_WORK(ping_work, ptlrpc_pinger_main);
 
-	/* And now, loop forever, pinging as needed. */
-	while (1) {
-		unsigned long this_ping = cfs_time_current();
-		long time_to_next_wake;
-		struct timeout_item *item;
-		struct obd_import *imp;
+static void ptlrpc_pinger_main(struct work_struct *ws)
+{
+	unsigned long this_ping = cfs_time_current();
+	long time_to_next_wake;
+	struct timeout_item *item;
+	struct obd_import *imp;
 
+	do {
 		mutex_lock(&pinger_mutex);
 		list_for_each_entry(item, &timeout_list, ti_chain) {
 			item->ti_cb(item, item->ti_cb_data);
@@ -260,50 +257,24 @@ static int ptlrpc_pinger_main(void *arg)
 		       time_to_next_wake,
 		       cfs_time_add(this_ping,
 				    PING_INTERVAL * HZ));
-		if (time_to_next_wake > 0) {
-			wait_event_idle_timeout(thread->t_ctl_waitq,
-						thread_is_stopping(thread) ||
-						thread_is_event(thread),
-						max_t(long, time_to_next_wake, HZ));
-			if (thread_test_and_clear_flags(thread, SVC_STOPPING))
-				break;
-			/* woken after adding import to reset timer */
-			thread_test_and_clear_flags(thread, SVC_EVENT);
-		}
-	}
+	} while (time_to_next_wake <= 0);
 
-	thread_set_flags(thread, SVC_STOPPED);
-	wake_up(&thread->t_ctl_waitq);
-
-	CDEBUG(D_NET, "pinger thread exiting, process %d\n", current_pid());
-	return 0;
+	queue_delayed_work(pinger_wq, &ping_work,
+			   round_jiffies_up_relative(time_to_next_wake));
 }
 
-static struct ptlrpc_thread pinger_thread;
-
 int ptlrpc_start_pinger(void)
 {
-	struct task_struct *task;
-	int rc;
-
-	if (!thread_is_init(&pinger_thread) &&
-	    !thread_is_stopped(&pinger_thread))
+	if (pinger_wq)
 		return -EALREADY;
 
-	init_waitqueue_head(&pinger_thread.t_ctl_waitq);
-
-	strcpy(pinger_thread.t_name, "ll_ping");
-
-	task = kthread_run(ptlrpc_pinger_main, &pinger_thread,
-			   pinger_thread.t_name);
-	if (IS_ERR(task)) {
-		rc = PTR_ERR(task);
-		CERROR("cannot start pinger thread: rc = %d\n", rc);
-		return rc;
+	pinger_wq = alloc_workqueue("ptlrpc_pinger", WQ_MEM_RECLAIM, 1);
+	if (!pinger_wq) {
+		CERROR("cannot start pinger workqueue\n");
+		return -ENOMEM;
 	}
-	wait_event_idle(pinger_thread.t_ctl_waitq,
-			thread_is_running(&pinger_thread));
 
+	queue_delayed_work(pinger_wq, &ping_work, 0);
 	return 0;
 }
 
@@ -313,16 +284,13 @@ int ptlrpc_stop_pinger(void)
 {
 	int rc = 0;
 
-	if (thread_is_init(&pinger_thread) ||
-	    thread_is_stopped(&pinger_thread))
+	if (!pinger_wq)
 		return -EALREADY;
 
 	ptlrpc_pinger_remove_timeouts();
-	thread_set_flags(&pinger_thread, SVC_STOPPING);
-	wake_up(&pinger_thread.t_ctl_waitq);
-
-	wait_event_idle(pinger_thread.t_ctl_waitq,
-			thread_is_stopped(&pinger_thread));
+	cancel_delayed_work_sync(&ping_work);
+	destroy_workqueue(pinger_wq);
+	pinger_wq = NULL;
 
 	return rc;
 }
@@ -505,6 +473,5 @@ static int ptlrpc_pinger_remove_timeouts(void)
 
 void ptlrpc_pinger_wake_up(void)
 {
-	thread_add_flags(&pinger_thread, SVC_EVENT);
-	wake_up(&pinger_thread.t_ctl_waitq);
+	mod_delayed_work(pinger_wq, &ping_work, 0);
 }
