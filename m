Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x225Fk0/AFsnA6kwjDrBUeKgRpphDQTPT6OOucMgOmdaPekPURKOO7WdVVH5AMCY6IPZzQ+gT
ARC-Seal: i=1; a=rsa-sha256; t=1518470578; cv=none;
        d=google.com; s=arc-20160816;
        b=Pf2x3Jm1DDoHiJ/tf1yaYaDhrwGbKXL8zuCuy5LH7erT150+dtWiiCMS+hKBSj94Tr
         s+ykS9u/d1gCZF06FofAoxBjrb+rA6tlMCs2B1VY8+vD7Ma/GJ7PBbs6l6A48JqFbUa4
         8i3C/AOGjwlmhXnAmtygZPtXQ6W92R2wDs0KlghMek80/771HYxVx+U2ZeGRxv3ptDmv
         8IRilg+LM+kbFEvy12CytRd2wp3mGJPtxuGKqUCI5pxl7dR2wSl7SljfDG1pMGkbNr6L
         rP1aIFvRysjc0mrF7zsVdVz9i1ktrMu3vuxZCpX1Fbqb5AU2Ht6Z5xtOVl8BxkhJe7V8
         Ptqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=llg98vOHHJs4Xd8NhSyG0S5JWQtV07iQBgU9HQQKG8o=;
        b=HsctM2KWliOkNmKIPR6jvc8BODj2xWLsJONCmu5Qv/QK+Egkp3u1U/MpzvOfXrlpyx
         gXFs2Sw0b3TIbpasGnBdjm/2WEheaiuUxOWCH6OnsAHMyo9PqyvRtI0GC0APFBb4tLvq
         tvQYCsDow42AOd8aXcG/7VqdW3OocuCaGgAV1HdDl/x1B542VDMsmpgKJI2Xz22ysL2G
         4Chdde1EYlUge6CiMNnjDsLnjnShWvaXntNRyeDbb+hFXuB22oks0pJRypZNeny07WNj
         cktarccnPj0cKWfb57L37vNJcEGTIJZ1V7WSCjKt/l/axu1n0ulzt97B4N+A4MPfXzIJ
         awPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 08:22:36 +1100
Subject: [PATCH 01/19] sched/wait: add wait_event_idle() functions.
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847055644.22826.9130972646394182562.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231805961252725?=
X-GMAIL-MSGID: =?utf-8?q?1592231805961252725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The new TASK_IDLE state (TASK_UNINTERRUPTIBLE | __TASK_NOLOAD)
is not much used.  One way to make it easier to use is to
add wait_event*() family functions that make use of it.
This patch adds:
  wait_event_idle()
  wait_event_idle_timeout()
  wait_event_idle_exclusive()
  wait_event_idle_exclusive_timeout()

This set was chosen because lustre needs them before
it can discard its own l_wait_event() macro.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 include/linux/wait.h |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 55a611486bac..d9f131ecf708 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -599,6 +599,120 @@ do {										\
 	__ret;									\
 })
 
+/**
+ * wait_event_idle - wait for a condition without contributing to system load
+ * @wq_head: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ *
+ * The process is put to sleep (TASK_IDLE) until the
+ * @condition evaluates to true.
+ * The @condition is checked each time the waitqueue @wq_head is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ */
+#define wait_event_idle(wq_head, condition)					\
+do {										\
+	might_sleep();								\
+	if (!(condition))							\
+		___wait_event(wq_head, condition, TASK_IDLE, 0, 0, schedule());	\
+} while (0)
+
+/**
+ * wait_event_idle_exclusive - wait for a condition with contributing to system load
+ * @wq_head: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ *
+ * The process is put to sleep (TASK_IDLE) until the
+ * @condition evaluates to true.
+ * The @condition is checked each time the waitqueue @wq_head is woken up.
+ *
+ * The process is put on the wait queue with an WQ_FLAG_EXCLUSIVE flag
+ * set thus if other processes wait on the same list, when this
+ * process is woken further processes are not considered.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ */
+#define wait_event_idle_exclusive(wq_head, condition)				\
+do {										\
+	might_sleep();								\
+	if (!(condition))							\
+		___wait_event(wq_head, condition, TASK_IDLE, 1, 0, schedule());	\
+} while (0)
+
+#define __wait_event_idle_timeout(wq_head, condition, timeout)			\
+	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
+		      TASK_IDLE, 0, timeout,					\
+		      __ret = schedule_timeout(__ret))
+
+/**
+ * wait_event_idle_timeout - sleep without load until a condition becomes true or a timeout elapses
+ * @wq_head: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ * @timeout: timeout, in jiffies
+ *
+ * The process is put to sleep (TASK_IDLE) until the
+ * @condition evaluates to true. The @condition is checked each time
+ * the waitqueue @wq_head is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ * Returns:
+ * 0 if the @condition evaluated to %false after the @timeout elapsed,
+ * 1 if the @condition evaluated to %true after the @timeout elapsed,
+ * or the remaining jiffies (at least 1) if the @condition evaluated
+ * to %true before the @timeout elapsed.
+ */
+#define wait_event_idle_timeout(wq_head, condition, timeout)			\
+({										\
+	long __ret = timeout;							\
+	might_sleep();								\
+	if (!___wait_cond_timeout(condition))					\
+		__ret = __wait_event_idle_timeout(wq_head, condition, timeout);	\
+	__ret;									\
+})
+
+#define __wait_event_idle_exclusive_timeout(wq_head, condition, timeout)	\
+	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
+		      TASK_IDLE, 1, timeout,					\
+		      __ret = schedule_timeout(__ret))
+
+/**
+ * wait_event_idle_exclusive_timeout - sleep without load until a condition becomes true or a timeout elapses
+ * @wq_head: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ * @timeout: timeout, in jiffies
+ *
+ * The process is put to sleep (TASK_IDLE) until the
+ * @condition evaluates to true. The @condition is checked each time
+ * the waitqueue @wq_head is woken up.
+ *
+ * The process is put on the wait queue with an WQ_FLAG_EXCLUSIVE flag
+ * set thus if other processes wait on the same list, when this
+ * process is woken further processes are not considered.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ * Returns:
+ * 0 if the @condition evaluated to %false after the @timeout elapsed,
+ * 1 if the @condition evaluated to %true after the @timeout elapsed,
+ * or the remaining jiffies (at least 1) if the @condition evaluated
+ * to %true before the @timeout elapsed.
+ */
+#define wait_event_idle_exclusive_timeout(wq_head, condition, timeout)		\
+({										\
+	long __ret = timeout;							\
+	might_sleep();								\
+	if (!___wait_cond_timeout(condition))					\
+		__ret = __wait_event_idle_exclusive_timeout(wq_head, condition, timeout);\
+	__ret;									\
+})
+
 extern int do_wait_intr(wait_queue_head_t *, wait_queue_entry_t *);
 extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 
