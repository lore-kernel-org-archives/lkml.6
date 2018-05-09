Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZqN5T4b2VLofFK1si6ezeSbIh58QBvkfBm8Ls7uPJSrYApF8yEvOLm+SEEQUuAJd+fVAO8V
ARC-Seal: i=1; a=rsa-sha256; t=1525844155; cv=none;
        d=google.com; s=arc-20160816;
        b=VQdRHf7WLyfsKpX/jdVnmGepHpPRozoDojtjiXMXEperFqbqIWDVKSkMmbSj7ZKJin
         HaNcuoIo+AgA6FelwuUyJCmZglv8gSvnq6++g1ZifPCbqPjoiMqcx64D1mg4tpRP5oN0
         VwNopqDE00/bWTT2kk/DYrfWVeWI4eP5Q8mli9VuQyd5Idak/C+aw9tTEVFKRsWBIQ2J
         yrs8pgarogMqT7mO3wzcJa+vv1Jb2smy9jx89/+Lo3ZtGGklRqXETY/w6lwVZpNr0Hmg
         bzE0ph+KdwI3WGayCmU8SHVh7A+Me4m5msuEafGRJQkS3FBmAV1jKHg2qjxNDb4zO9k6
         70xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:message-id:references
         :in-reply-to:date:subject:cc:to:from:arc-authentication-results;
        bh=GDjfUzQsstksQKHGgHJCpuro5gFGahEhVt63v2ntlME=;
        b=eUIhJMwSwPvyBLbB44RGMJH484mAich8glE2oeGHp9ehliIXR+GXHPB8hwnbiMzpBl
         0NIHCbhYpH24MYP05mBiqQWRaFHkqruDg+5+vmL6DdqGaWCudHKV+jMa2cRD3Eg3Zbvt
         xKYzFKO3+1fk2Pysi84TIopLqqrCnBMOcSZSYGMF3ZvHa/Dm2d9kAZuPzYSSzhAhG+CB
         7vESuweQr51xmxBBsj8Ysf9fvzQTIk4OSkXRknlef0EQ6+l4sOLzx7iG2I7d2PQhExud
         I3LsCW7jkZbxjreE0L14GH+2/+ubelIIAbkiTgV8zBpLTA9Z6JB8I9yzJsWjomZzK/s0
         zaiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v4 3/7] powerpc: use task_pid_nr() for TID allocation
Date: Wed,  9 May 2018 15:35:02 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180509053506.9754-1-alastair@au1.ibm.com>
References: <20180509004212.4506-1-alastair@au1.ibm.com>
 <20180509053506.9754-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050905-0044-0000-0000-000005509EA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050905-0045-0000-0000-00002891E433
Message-Id: <20180509053506.9754-4-alastair@au1.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090056
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550726280592?=
X-GMAIL-MSGID: =?utf-8?q?1599963561886653721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

The current implementation of TID allocation, using a global IDR, may
result in an errant process starving the system of available TIDs.
Instead, use task_pid_nr(), as mentioned by the original author. The
scenario described which prevented it's use is not applicable, as
set_thread_tidr can only be called after the task struct has been
populated.

In the unlikely event that 2 threads share the TID and are waiting,
all potential outcomes have been determined safe.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/include/asm/switch_to.h |   1 -
 arch/powerpc/kernel/process.c        | 122 ++++++++---------------------------
 2 files changed, 28 insertions(+), 95 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index be8c9fa23983..5b03d8a82409 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -94,6 +94,5 @@ static inline void clear_task_ebb(struct task_struct *t)
 extern int set_thread_uses_vas(void);
 
 extern int set_thread_tidr(struct task_struct *t);
-extern void clear_thread_tidr(struct task_struct *t);
 
 #endif /* _ASM_POWERPC_SWITCH_TO_H */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3b00da47699b..c5b8e53acbae 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1496,103 +1496,41 @@ int set_thread_uses_vas(void)
 }
 
 #ifdef CONFIG_PPC64
-static DEFINE_SPINLOCK(vas_thread_id_lock);
-static DEFINE_IDA(vas_thread_ida);
-
-/*
- * We need to assign a unique thread id to each thread in a process.
+/**
+ * Assign a TIDR (thread ID) for task @t and set it in the thread
+ * structure. For now, we only support setting TIDR for 'current' task.
  *
- * This thread id, referred to as TIDR, and separate from the Linux's tgid,
- * is intended to be used to direct an ASB_Notify from the hardware to the
- * thread, when a suitable event occurs in the system.
+ * Since the TID value is a truncated form of it PID, it is possible
+ * (but unlikely) for 2 threads to have the same TID. In the unlikely event
+ * that 2 threads share the same TID and are waiting, one of the following
+ * cases will happen:
  *
- * One such event is a "paste" instruction in the context of Fast Thread
- * Wakeup (aka Core-to-core wake up in the Virtual Accelerator Switchboard
- * (VAS) in POWER9.
+ * 1. The correct thread is running, the wrong thread is not
+ * In this situation, the correct thread is woken and proceeds to pass it's
+ * condition check.
  *
- * To get a unique TIDR per process we could simply reuse task_pid_nr() but
- * the problem is that task_pid_nr() is not yet available copy_thread() is
- * called. Fixing that would require changing more intrusive arch-neutral
- * code in code path in copy_process()?.
+ * 2. Neither threads are running
+ * In this situation, neither thread will be woken. When scheduled, the waiting
+ * threads will execute either a wait, which will return immediately, followed
+ * by a condition check, which will pass for the correct thread and fail
+ * for the wrong thread, or they will execute the condition check immediately.
  *
- * Further, to assign unique TIDRs within each process, we need an atomic
- * field (or an IDR) in task_struct, which again intrudes into the arch-
- * neutral code. So try to assign globally unique TIDRs for now.
+ * 3. The wrong thread is running, the correct thread is not
+ * The wrong thread will be woken, but will fail it's condition check and
+ * re-execute wait. The correct thread, when scheduled, will execute either
+ * it's condition check (which will pass), or wait, which returns immediately
+ * when called the first time after the thread is scheduled, followed by it's
+ * condition check (which will pass).
  *
- * NOTE: TIDR 0 indicates that the thread does not need a TIDR value.
- *	 For now, only threads that expect to be notified by the VAS
- *	 hardware need a TIDR value and we assign values > 0 for those.
- */
-#define MAX_THREAD_CONTEXT	((1 << 16) - 1)
-static int assign_thread_tidr(void)
-{
-	int index;
-	int err;
-	unsigned long flags;
-
-again:
-	if (!ida_pre_get(&vas_thread_ida, GFP_KERNEL))
-		return -ENOMEM;
-
-	spin_lock_irqsave(&vas_thread_id_lock, flags);
-	err = ida_get_new_above(&vas_thread_ida, 1, &index);
-	spin_unlock_irqrestore(&vas_thread_id_lock, flags);
-
-	if (err == -EAGAIN)
-		goto again;
-	else if (err)
-		return err;
-
-	if (index > MAX_THREAD_CONTEXT) {
-		spin_lock_irqsave(&vas_thread_id_lock, flags);
-		ida_remove(&vas_thread_ida, index);
-		spin_unlock_irqrestore(&vas_thread_id_lock, flags);
-		return -ENOMEM;
-	}
-
-	return index;
-}
-
-static void free_thread_tidr(int id)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&vas_thread_id_lock, flags);
-	ida_remove(&vas_thread_ida, id);
-	spin_unlock_irqrestore(&vas_thread_id_lock, flags);
-}
-
-/*
- * Clear any TIDR value assigned to this thread.
- */
-void clear_thread_tidr(struct task_struct *t)
-{
-	if (!t->thread.tidr)
-		return;
-
-	if (!cpu_has_feature(CPU_FTR_P9_TIDR)) {
-		WARN_ON_ONCE(1);
-		return;
-	}
-
-	mtspr(SPRN_TIDR, 0);
-	free_thread_tidr(t->thread.tidr);
-	t->thread.tidr = 0;
-}
-
-void arch_release_task_struct(struct task_struct *t)
-{
-	clear_thread_tidr(t);
-}
-
-/*
- * Assign a unique TIDR (thread id) for task @t and set it in the thread
- * structure. For now, we only support setting TIDR for 'current' task.
+ * 4. Both threads are running
+ * Both threads will be woken. The wrong thread will fail it's condition check
+ * and execute another wait, while the correct thread will pass it's condition
+ * check.
+ *
+ * @t: the task to set the thread ID for
  */
 int set_thread_tidr(struct task_struct *t)
 {
-	int rc;
-
 	if (!cpu_has_feature(CPU_FTR_P9_TIDR))
 		return -EINVAL;
 
@@ -1602,11 +1540,7 @@ int set_thread_tidr(struct task_struct *t)
 	if (t->thread.tidr)
 		return 0;
 
-	rc = assign_thread_tidr();
-	if (rc < 0)
-		return rc;
-
-	t->thread.tidr = rc;
+	t->thread.tidr = (u16)task_pid_nr(t);
 	mtspr(SPRN_TIDR, t->thread.tidr);
 
 	return 0;
-- 
2.14.3
