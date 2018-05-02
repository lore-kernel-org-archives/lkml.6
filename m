Return-Path: <gityuan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525271413; cv=none;
        d=google.com; s=arc-20160816;
        b=JrniMm6JEzvwyNrJiRaQ150Ke/ICV09p/ogsim8XsuQO83uyclqw6q3vzvsz/AMV94
         xbiJHAKkvmI25M9aJRNXoREFN9RJ2SpR/Gx5RFDrbEJkcSWux/N7zwoa4I2AQs8l+PpX
         Y9EM1pYvqWbSnCTqi6O9wlAITjtB4NY0hmPYi6O0qCyG13gdu6LqyL8eGug0eNlp1xA/
         obYmacWJ/m8kbewEufB/HKnUpGNi/XgEWrbV+ki9pnHdxBsLHr4wHAr4UkVxUItFD0w5
         tXyS5t7phhnzPCoGZ5aVw0XdRas0h3pmi1BbP4WeQqd440vG55CdCz8GPMDYXQoCXJ0n
         GNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Vj5pXrTn5cQmRPen7Z00dXxTqzIn5mDYyg5yVTNg4wU=;
        b=x8SnOsher/6wRITns3KUVolHezuHOYgCnoAUCbcpZMT4AQicAD2w8Loewej+YCAAMm
         D39dd8koStOBnvcuelRQFu1iDVAoUrwfnPpK7JhvNW7JnsJBEsmDgMkDQdMEsO7q9sDr
         DjhTXfM8lN8nFTIgyjct9mBeVbQTVzko2F/5rPCLGS9HMSrc00Gf5oofutZkEWaHrya9
         fA0ezaGyoHhK8TEsdD7BwkX2AIVAxkY2fD3pVNAbYk4bNVcxP/HbTG9Bbtjf8blCqwnd
         ixrn9Qq46Le/k53ESfpWIMWubK9Qjebx1IaIHEldCdg1TDAJpehxPtnh9nlOLdajDg56
         lxTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vWW0FOI3;
       spf=pass (google.com: domain of gityuan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gityuan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vWW0FOI3;
       spf=pass (google.com: domain of gityuan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gityuan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZq+7uXVPZpcEY+CIiHSpdMCCFrcipbFNXKvuMCXpmHIg+6RPeOqVp8O1fk/wQN0g73H+/SB7w==
From: gityuan@gmail.com
X-Google-Original-From: yuanhuihui@xiaomi.com
To: gregkh@linuxfoundation.org,
	maco@android.com,
	tkjos@google.com,
	arve@android.com
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	yuanhuihui <yuanhuihui@xiaomi.com>
Subject: [PATCH] ANDROID: binder: fix binder work return error is wrongly consumed
Date: Wed,  2 May 2018 22:30:08 +0800
Message-Id: <20180502143008.25582-1-yuanhuihui@xiaomi.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599362997711826317?=
X-GMAIL-MSGID: =?utf-8?q?1599362997711826317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: yuanhuihui <yuanhuihui@xiaomi.com>

transaction consume mismatched binder work. as follow:

1) Client send transaction when left binder work in the thread->todo
list.

2) in kernel space, client consumed BC_TRANSACTION, and produced
BINDER_WORK_RETURN_ERROR into thread->todo list as target proc is dead

3) Client should get return error from thread->todo firstly,
finish this transaction, and back to userspace immediately.

4) In fact, client pick up mismatched binder work cause unexpected
results because of the previous remaining binder work. maybe cause return error
consumed by other transaction context.

Recently I encountered some versions of mobile phones to reproduce this
problem that is  oneway binder call can be blocked forever in
system_server process. the root cause is that BINDER_WORK_RETURN_ERROR
is comsumed by mismatch transacation context. binder thread is waiting
for BINDER_WORK_RETURN_ERROR:

    "Binder:1253_C" prio=5 tid=107 Native
    at android.os.BinderProxy.transactNative(Native method)
    at android.os.BinderProxy.transact(Binder.java:767)
    at android.app.IApplicationThread$Stub$Proxy.bindApplication(IApplicationThread.java:1398)
    at com.android.server.am.ActivityManagerService.attachApplicationLocked(ActivityManagerService.java:7320)
    at com.android.server.am.ActivityManagerService.attachApplication(ActivityManagerService.java:7425)
    - locked <0x0bc6ee81> (a com.android.server.am.ActivityManagerService)
    at android.app.IActivityManager$Stub.onTransact(IActivityManager.java:291)
    at com.android.server.am.ActivityManagerService.onTransact(ActivityManagerService.java:2997)
    at android.os.Binder.execTransact(Binder.java:700)

I see newest binder driver fixed by "ANDROID: binder: don't enqueue
death notifications to thread todo". It really can solve the
BINDER_WORK_DEAD_BINDER nesting  scenarios :)

But there is potential risks in the future, future functional extensions
need to consider nesting issues, maybe extending more methods where we
push to thread->todo. I think that using queueing return error transaction
to the head of thread todo list is more appropriate, as follows:

1) During a transaction, the client will add BINDER_WORK_RETURN_ERROR into
thread->todo list, however, it would be better to pick up
BINDER_WORK_RETURN_ERROR firstly and finish the transaction immediately,
jump out of the nest.

2) Client pick up the left binder work from thread->todo, using the
same thread, do not need wake up other idle binder thread.

3) It works fine in the old binder version (before split big binder
lock), binder_transaction only set thread return_error when target
process has dead, do not add BINDER_WORK_RETURN_ERROR into thread->todo,
but binder_thread_read() check return_error firstly. If occurs return_error,
finish this transaction and back to userspace immediately.

So I prefer to put the BINDER_WORK_RETURN_ERROR to the head of the
queue, same as the old version of binder driver, once and for all.

Signed-off-by: yuanhuihui <yuanhuihui@xiaomi.com>
---
 drivers/android/binder.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 4eab5be3d00f..1ed1809b8769 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -861,6 +861,60 @@ binder_enqueue_thread_work(struct binder_thread *thread,
 	binder_inner_proc_unlock(thread->proc);
 }
 
+/**
+ * binder_enqueue_work_head_ilocked() - Add an item to the head of work list
+ * @work:         struct binder_work to add to list
+ * @target_list:  list to add work to
+ *
+ * Adds the work to the specified list. Asserts that work
+ * is not already on a list.
+ *
+ * Requires the proc->inner_lock to be held.
+ */
+static void
+binder_enqueue_work_head_ilocked(struct binder_work *work,
+			   struct list_head *target_list)
+{
+	BUG_ON(target_list == NULL);
+	BUG_ON(work->entry.next && !list_empty(&work->entry));
+	list_add(&work->entry, target_list);
+}
+
+/**
+ * binder_enqueue_thread_work_head_ilocked() - Add an item to the head of thread work list
+ * @thread:       thread to queue work to
+ * @work:         struct binder_work to add to list
+ *
+ * Adds the work to the head of thread todo list, and enables processing
+ * of the todo queue.
+ *
+ * Requires the proc->inner_lock to be held.
+ */
+static void
+binder_enqueue_thread_work_head_ilocked(struct binder_thread *thread,
+				   struct binder_work *work)
+{
+	binder_enqueue_work_head_ilocked(work, &thread->todo);
+	thread->process_todo = true;
+}
+
+/**
+ * binder_enqueue_thread_work_head() - Add an item to the head of thread work list
+ * @thread:       thread to queue work to
+ * @work:         struct binder_work to add to list
+ *
+ * Adds the work to the head of thread todo list, and enables processing
+ * of the todo queue.
+ */
+static void
+binder_enqueue_thread_work_head(struct binder_thread *thread,
+			   struct binder_work *work)
+{
+	binder_inner_proc_lock(thread->proc);
+	binder_enqueue_thread_work_head_ilocked(thread, work);
+	binder_inner_proc_unlock(thread->proc);
+}
+
 static void
 binder_dequeue_work_ilocked(struct binder_work *work)
 {
@@ -3287,11 +3341,11 @@ static void binder_transaction(struct binder_proc *proc,
 	BUG_ON(thread->return_error.cmd != BR_OK);
 	if (in_reply_to) {
 		thread->return_error.cmd = BR_TRANSACTION_COMPLETE;
-		binder_enqueue_thread_work(thread, &thread->return_error.work);
+		binder_enqueue_thread_work_head(thread, &thread->return_error.work);
 		binder_send_failed_reply(in_reply_to, return_error);
 	} else {
 		thread->return_error.cmd = return_error;
-		binder_enqueue_thread_work(thread, &thread->return_error.work);
+		binder_enqueue_thread_work_head(thread, &thread->return_error.work);
 	}
 }
 
@@ -3929,6 +3983,7 @@ static int binder_thread_read(struct binder_proc *proc,
 			ptr += sizeof(uint32_t);
 
 			binder_stat_br(proc, thread, e->cmd);
+			goto done; /* RETURN_ERROR notifications can finish transactions */
 		} break;
 		case BINDER_WORK_TRANSACTION_COMPLETE: {
 			binder_inner_proc_unlock(proc);
-- 
2.14.1
