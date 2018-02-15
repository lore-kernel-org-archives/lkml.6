Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227R5PdLIjdZ/QRAF68hdqxweI6+6Ed4JukTj/8jqaYQ15FzxlCeYuM4dxmgtsBvJqtqUFF6
ARC-Seal: i=1; a=rsa-sha256; t=1518708709; cv=none;
        d=google.com; s=arc-20160816;
        b=M2kHJDinMw7pWvIflJ9Osqhu+KqjJwXGOr6bB56WHZn+JNm/lYg6NfJrh7kpnYLyTr
         Ncqtj2f3V2nryTE3C0/Ca6Dmj8VYLeiwAhKKLQybYRTpRoshU/Dsb0Dm44kwMxYX/U6r
         KkdHT5U9OjBsXbgI9UMWfCBQ+J7fnDesWx0jyOK45bW8kg3diSVQNowSXkkg4Zl/8RqZ
         i8q1Qg9abt5uRIo7qYeI26h8CRhMTqoCNg7X0av5IaMNoXN1MQsA8zDUfPwhW14xOC+1
         tlTCRw70nBlFdcSXDSrzdD1QTaVO8gjGZuOy9hL8Ni3mb/DRf0eaqgrdpbWUxnWZX5aV
         2rxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OyCePUPrA3so4VnpSPLA61PNCcpZ5F89zCo9VEqK1Lk=;
        b=ggPWDe44rzCwNfqyVQELWACcB6SG4CwfwUF7IiiT+tgEIMHeytwY+EdvViX7KELuMD
         6Z5Vt8b49zUzmR16+ulXX8ORVRKt0quHi+hB0Uz8oCvDuMktuUdroVaaM8kHyG45hDej
         W9LUSMDGyFKpcax+Z6S+MNvi3VyLTs6BCyK5T7jWxJZkse8jVnh3Vn0ChJV66YgcfOrA
         5kDZtWMWxzYmu/fm4yj5VuqasyhQKR904JHvJP/eJftwE9QjikDCzk81OBysTtyQRZjz
         E2YmBMlUeUbDo9VDBXrXOCsTNqmulP8iJxXKjItPEB3e0g9SyLktO/z4Seu82xoe/fsC
         A1kA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pavan Kondeti <pkondeti@codeaurora.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Galbraith <efault@gmx.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 014/195] sched/rt: Up the root domain ref count when passing it around via IPIs
Date: Thu, 15 Feb 2018 16:15:05 +0100
Message-Id: <20180215151706.446001854@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480997579543046?=
X-GMAIL-MSGID: =?utf-8?q?1592481503312596321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 364f56653708ba8bcdefd4f0da2a42904baa8eeb upstream.

When issuing an IPI RT push, where an IPI is sent to each CPU that has more
than one RT task scheduled on it, it references the root domain's rto_mask,
that contains all the CPUs within the root domain that has more than one RT
task in the runable state. The problem is, after the IPIs are initiated, the
rq->lock is released. This means that the root domain that is associated to
the run queue could be freed while the IPIs are going around.

Add a sched_get_rd() and a sched_put_rd() that will increment and decrement
the root domain's ref count respectively. This way when initiating the IPIs,
the scheduler will up the root domain's ref count before releasing the
rq->lock, ensuring that the root domain does not go away until the IPI round
is complete.

Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 4bdced5c9a292 ("sched/rt: Simplify the IPI based RT balancing logic")
Link: http://lkml.kernel.org/r/CAEU1=PkiHO35Dzna8EQqNSKW1fr1y1zRQ5y66X117MG06sQtNA@mail.gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/rt.c       |    9 +++++++--
 kernel/sched/sched.h    |    2 ++
 kernel/sched/topology.c |   13 +++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1990,8 +1990,11 @@ static void tell_cpu_to_push(struct rq *
 
 	rto_start_unlock(&rq->rd->rto_loop_start);
 
-	if (cpu >= 0)
+	if (cpu >= 0) {
+		/* Make sure the rd does not get freed while pushing */
+		sched_get_rd(rq->rd);
 		irq_work_queue_on(&rq->rd->rto_push_work, cpu);
+	}
 }
 
 /* Called from hardirq context */
@@ -2021,8 +2024,10 @@ void rto_push_irq_work_func(struct irq_w
 
 	raw_spin_unlock(&rd->rto_lock);
 
-	if (cpu < 0)
+	if (cpu < 0) {
+		sched_put_rd(rd);
 		return;
+	}
 
 	/* Try the next RT overloaded CPU */
 	irq_work_queue_on(&rd->rto_push_work, cpu);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -661,6 +661,8 @@ extern struct mutex sched_domains_mutex;
 extern void init_defrootdomain(void);
 extern int sched_init_domains(const struct cpumask *cpu_map);
 extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
+extern void sched_get_rd(struct root_domain *rd);
+extern void sched_put_rd(struct root_domain *rd);
 
 #ifdef HAVE_RT_PUSH_IPI
 extern void rto_push_irq_work_func(struct irq_work *work);
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -258,6 +258,19 @@ void rq_attach_root(struct rq *rq, struc
 		call_rcu_sched(&old_rd->rcu, free_rootdomain);
 }
 
+void sched_get_rd(struct root_domain *rd)
+{
+	atomic_inc(&rd->refcount);
+}
+
+void sched_put_rd(struct root_domain *rd)
+{
+	if (!atomic_dec_and_test(&rd->refcount))
+		return;
+
+	call_rcu_sched(&rd->rcu, free_rootdomain);
+}
+
 static int init_rootdomain(struct root_domain *rd)
 {
 	if (!zalloc_cpumask_var(&rd->span, GFP_KERNEL))
