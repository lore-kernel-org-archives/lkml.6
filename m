Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753737AbeFDOQ6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:16:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753654AbeFDOQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:16:42 -0400
From: Miroslav Benes <mbenes@suse.cz>
To: jikos@kernel.org, jpoimboe@redhat.com, jeyu@kernel.org
Cc: pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 2/2] livepatch: Remove signal sysfs attribute
Date: Mon,  4 Jun 2018 16:16:36 +0200
Message-Id: <20180604141636.11523-3-mbenes@suse.cz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604141636.11523-1-mbenes@suse.cz>
References: <20180604141636.11523-1-mbenes@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fake signal is send automatically now. We can rely on it completely
and remove the sysfs attribute.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 .../ABI/testing/sysfs-kernel-livepatch        | 12 ---
 Documentation/livepatch/livepatch.txt         | 16 ++--
 kernel/livepatch/core.c                       | 32 --------
 kernel/livepatch/transition.c                 | 80 +++++++++----------
 kernel/livepatch/transition.h                 |  1 -
 5 files changed, 47 insertions(+), 94 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index dac7e1e62a8b..85db352f68f9 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -33,18 +33,6 @@ Contact:	live-patching@vger.kernel.org
 		An attribute which indicates whether the patch is currently in
 		transition.
 
-What:		/sys/kernel/livepatch/<patch>/signal
-Date:		Nov 2017
-KernelVersion:	4.15.0
-Contact:	live-patching@vger.kernel.org
-Description:
-		A writable attribute that allows administrator to affect the
-		course of an existing transition. Writing 1 sends a fake
-		signal to all remaining blocking tasks. The fake signal
-		means that no proper signal is delivered (there is no data in
-		signal pending structures). Tasks are interrupted or woken up,
-		and forced to change their patched state.
-
 What:		/sys/kernel/livepatch/<patch>/force
 Date:		Nov 2017
 KernelVersion:	4.15.0
diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index 011897e2392f..b738d70ab002 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -158,13 +158,11 @@ If a patch is in transition, this file shows 0 to indicate the task is
 unpatched and 1 to indicate it's patched.  Otherwise, if no patch is in
 transition, it shows -1.  Any tasks which are blocking the transition
 can be signaled with SIGSTOP and SIGCONT to force them to change their
-patched state. This may be harmful to the system though.
-/sys/kernel/livepatch/<patch>/signal attribute provides a better alternative.
-Writing 1 to the attribute sends a fake signal to all remaining blocking
-tasks. No proper signal is actually delivered (there is no data in signal
-pending structures). Tasks are interrupted or woken up, and forced to change
-their patched state. Despite the sysfs attribute the fake signal is also sent
-every 10 seconds automatically.
+patched state. This may be harmful to the system though. Sending a fake signal
+to all remaining blocking tasks is a better alternative. No proper signal is
+actually delivered (there is no data in signal pending structures). Tasks are
+interrupted or woken up, and forced to change their patched state. The fake
+signal is automatically sent every 10 seconds.
 
 Administrator can also affect a transition through
 /sys/kernel/livepatch/<patch>/force attribute. Writing 1 there clears
@@ -419,8 +417,8 @@ Information about the registered patches can be found under
 /sys/kernel/livepatch. The patches could be enabled and disabled
 by writing there.
 
-/sys/kernel/livepatch/<patch>/signal and /sys/kernel/livepatch/<patch>/force
-attributes allow administrator to affect a patching operation.
+/sys/kernel/livepatch/<patch>/force attributes allow administrator to affect a
+patching operation.
 
 See Documentation/ABI/testing/sysfs-kernel-livepatch for more details.
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 3a4656fb7047..064dee4caf4f 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -449,7 +449,6 @@ EXPORT_SYMBOL_GPL(klp_enable_patch);
  * /sys/kernel/livepatch/<patch>
  * /sys/kernel/livepatch/<patch>/enabled
  * /sys/kernel/livepatch/<patch>/transition
- * /sys/kernel/livepatch/<patch>/signal
  * /sys/kernel/livepatch/<patch>/force
  * /sys/kernel/livepatch/<patch>/<object>
  * /sys/kernel/livepatch/<patch>/<object>/<function,sympos>
@@ -525,35 +524,6 @@ static ssize_t transition_show(struct kobject *kobj,
 			patch == klp_transition_patch);
 }
 
-static ssize_t signal_store(struct kobject *kobj, struct kobj_attribute *attr,
-			    const char *buf, size_t count)
-{
-	struct klp_patch *patch;
-	int ret;
-	bool val;
-
-	ret = kstrtobool(buf, &val);
-	if (ret)
-		return ret;
-
-	if (!val)
-		return count;
-
-	mutex_lock(&klp_mutex);
-
-	patch = container_of(kobj, struct klp_patch, kobj);
-	if (patch != klp_transition_patch) {
-		mutex_unlock(&klp_mutex);
-		return -EINVAL;
-	}
-
-	klp_send_signals();
-
-	mutex_unlock(&klp_mutex);
-
-	return count;
-}
-
 static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
 			   const char *buf, size_t count)
 {
@@ -585,12 +555,10 @@ static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
 static struct kobj_attribute transition_kobj_attr = __ATTR_RO(transition);
-static struct kobj_attribute signal_kobj_attr = __ATTR_WO(signal);
 static struct kobj_attribute force_kobj_attr = __ATTR_WO(force);
 static struct attribute *klp_patch_attrs[] = {
 	&enabled_kobj_attr.attr,
 	&transition_kobj_attr.attr,
-	&signal_kobj_attr.attr,
 	&force_kobj_attr.attr,
 	NULL
 };
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index c33d29c74ac6..988dbc270aea 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -356,6 +356,46 @@ static bool klp_try_switch_task(struct task_struct *task)
 
 }
 
+/*
+ * Sends a fake signal to all non-kthread tasks with TIF_PATCH_PENDING set.
+ * Kthreads with TIF_PATCH_PENDING set are woken up.
+ */
+static void klp_send_signals(void)
+{
+	struct task_struct *g, *task;
+
+	pr_notice("signaling remaining tasks\n");
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, task) {
+		if (!klp_patch_pending(task))
+			continue;
+
+		/*
+		 * There is a small race here. We could see TIF_PATCH_PENDING
+		 * set and decide to wake up a kthread or send a fake signal.
+		 * Meanwhile the task could migrate itself and the action
+		 * would be meaningless. It is not serious though.
+		 */
+		if (task->flags & PF_KTHREAD) {
+			/*
+			 * Wake up a kthread which sleeps interruptedly and
+			 * still has not been migrated.
+			 */
+			wake_up_state(task, TASK_INTERRUPTIBLE);
+		} else {
+			/*
+			 * Send fake signal to all non-kthread tasks which are
+			 * still not migrated.
+			 */
+			spin_lock_irq(&task->sighand->siglock);
+			signal_wake_up(task, 0);
+			spin_unlock_irq(&task->sighand->siglock);
+		}
+	}
+	read_unlock(&tasklist_lock);
+}
+
 /*
  * Try to switch all remaining tasks to the target patch state by walking the
  * stacks of sleeping tasks and looking for any to-be-patched or
@@ -583,46 +623,6 @@ void klp_copy_process(struct task_struct *child)
 	/* TIF_PATCH_PENDING gets copied in setup_thread_stack() */
 }
 
-/*
- * Sends a fake signal to all non-kthread tasks with TIF_PATCH_PENDING set.
- * Kthreads with TIF_PATCH_PENDING set are woken up.
- */
-void klp_send_signals(void)
-{
-	struct task_struct *g, *task;
-
-	pr_notice("signaling remaining tasks\n");
-
-	read_lock(&tasklist_lock);
-	for_each_process_thread(g, task) {
-		if (!klp_patch_pending(task))
-			continue;
-
-		/*
-		 * There is a small race here. We could see TIF_PATCH_PENDING
-		 * set and decide to wake up a kthread or send a fake signal.
-		 * Meanwhile the task could migrate itself and the action
-		 * would be meaningless. It is not serious though.
-		 */
-		if (task->flags & PF_KTHREAD) {
-			/*
-			 * Wake up a kthread which sleeps interruptedly and
-			 * still has not been migrated.
-			 */
-			wake_up_state(task, TASK_INTERRUPTIBLE);
-		} else {
-			/*
-			 * Send fake signal to all non-kthread tasks which are
-			 * still not migrated.
-			 */
-			spin_lock_irq(&task->sighand->siglock);
-			signal_wake_up(task, 0);
-			spin_unlock_irq(&task->sighand->siglock);
-		}
-	}
-	read_unlock(&tasklist_lock);
-}
-
 /*
  * Drop TIF_PATCH_PENDING of all tasks on admin's request. This forces an
  * existing transition to finish.
diff --git a/kernel/livepatch/transition.h b/kernel/livepatch/transition.h
index f9d0bc016067..322db16233de 100644
--- a/kernel/livepatch/transition.h
+++ b/kernel/livepatch/transition.h
@@ -11,7 +11,6 @@ void klp_cancel_transition(void);
 void klp_start_transition(void);
 void klp_try_complete_transition(void);
 void klp_reverse_transition(void);
-void klp_send_signals(void);
 void klp_force_transition(void);
 
 #endif /* _LIVEPATCH_TRANSITION_H */
-- 
2.17.0
