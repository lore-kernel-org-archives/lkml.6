Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELttrPYrMT36K9j7tOovc2asiazX+cvzGZ6DK9o6bDGd21CcVyBL3lhra13K1kZEPbvJ/5V5
ARC-Seal: i=1; a=rsa-sha256; t=1520295964; cv=none;
        d=google.com; s=arc-20160816;
        b=bAcMUCsYZqwVnyC7Y1EOCbc6N8qq8S/2sPaqDIOqKFE8pLifj//RT0/Sg/0CX3HSj+
         M3xFDTvNDGilxrzTBiib15MbZcMmr3rkSvy7uqVAf9IXD2Bho8x9XMK2PNfwnWn+gJEq
         45w4DLDhyxX5igwasubjXgXiaydjtI6Lpq58jvvvj2whzFzbldqnmBr/lbXd1sZP8247
         PjXtqbnt1Ou21+cLuoeIEikht8hE29kzVu8/nNRU7cCKw7Kfbx7Ra9gHSkY7qo0+DqTS
         CAu3pFLLpMxJ8TTUYvqOhZVEFPpm0GAJADsFklAgaUNDQjImoI7dtQ1ogIH9XD6ie5Wd
         u75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=NbVnWObOf2m0mPKrE143jFhhKQEJywxSUK6kzu8bxxI=;
        b=IntdrTbLuiZqaw8rx9hhl4lVtslGhzaMUn0d+FrhscbEEiWvlBO5GqW6Fb46GMjN8b
         WrHddVgFoR7vG5SoA+P4XtmzGdKMb42sVoQpjz76U+L826m723vrmjUm4bV0eIKiSKuw
         qGJ9u6QK3/c+qBXTxZ0N3cJn6U/OQeZvtSf7wWG6i5YtQgEMsmTCULdwE1YReG0Aqvrb
         3ZVcfB8QvjS081toqE5gWa2sgC62jLd0aRP6MOp6wuLQ/FiKmZ0t78Y3g/kP0ojE+Buk
         IVtiS7BS6F+Tx4rUbfmWvpu2vAKmH9PY6nuwRWmxD6lwojs5nAf0ydGnK+T2s1XeMLM2
         d4KQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=kMFNsTHt;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=kMFNsTHt;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 06/65] sched/core: Add switch_mm_irqs_off() and use it in the scheduler
Date: Mon,  5 Mar 2018 19:24:39 -0500
Message-Id: <20180306002538.1761-7-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=917
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145861379212068?=
X-GMAIL-MSGID: =?utf-8?q?1594145861379212068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit f98db6013c557c216da5038d9c52045be55cd039 upstream.

By default, this is the same thing as switch_mm().

x86 will override it as an optimization.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/df401df47bdd6be3e389c6f1e3f5310d70e81b2c.1461688545.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 425f13a36652523d604fd96413d6c438d415dd70)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 include/linux/mmu_context.h | 7 +++++++
 kernel/sched/core.c         | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index 70fffeba7495..a4441784503b 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -1,9 +1,16 @@
 #ifndef _LINUX_MMU_CONTEXT_H
 #define _LINUX_MMU_CONTEXT_H
 
+#include <asm/mmu_context.h>
+
 struct mm_struct;
 
 void use_mm(struct mm_struct *mm);
 void unuse_mm(struct mm_struct *mm);
 
+/* Architectures that care about IRQ state in switch_mm can override this. */
+#ifndef switch_mm_irqs_off
+# define switch_mm_irqs_off switch_mm
+#endif
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8fbedeb5553f..d253618d09c6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -32,7 +32,7 @@
 #include <linux/init.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
-#include <asm/mmu_context.h>
+#include <linux/mmu_context.h>
 #include <linux/interrupt.h>
 #include <linux/capability.h>
 #include <linux/completion.h>
@@ -2339,7 +2339,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		atomic_inc(&oldmm->mm_count);
 		enter_lazy_tlb(oldmm, next);
 	} else
-		switch_mm(oldmm, mm, next);
+		switch_mm_irqs_off(oldmm, mm, next);
 
 	if (!prev->mm) {
 		prev->active_mm = NULL;
@@ -4979,7 +4979,7 @@ void idle_task_exit(void)
 	BUG_ON(cpu_online(smp_processor_id()));
 
 	if (mm != &init_mm) {
-		switch_mm(mm, &init_mm, current);
+		switch_mm_irqs_off(mm, &init_mm, current);
 		finish_arch_post_lock_switch();
 	}
 	mmdrop(mm);
-- 
2.16.2
