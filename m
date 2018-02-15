Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225yVxntnSY31Wh4SsMzQ4k/H9xXeYfCdInQkmwrqFZ4oZmayxPX5GkPxkzux9qsXGVwtwya
ARC-Seal: i=1; a=rsa-sha256; t=1518708383; cv=none;
        d=google.com; s=arc-20160816;
        b=hrZ7QR2+K+IWk5HXg5SEZ+LlTnZiUmXwi20nSi8vyg1aM6TsYU1dBX+td1h9W7DRMO
         VX19vnH7/yIXa6OkblU4GQQGJmm9rznLWZSqKPsGHsvnML29hhRxNa8ojhkZJRvjhwwQ
         huPh77N80tb1Yw0iVJA4JFCiOtODQgyoqj0/Nlsn+ogHOTexPrCEcN+phKX4TywRf/Z7
         VCJZXVpxTDaULH67jARddldjN4k1EuHWAiBQPd6nrPcHTZFIF4WyXVmGMS9l6GNTvKQd
         iMMDLb1/ayCuZq34+J0KlTivr2H4wFRNFlcfSFZLKjvhOHBn48qAKcAeM86icOPQpJ1p
         HnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VCtBLl3w6aGChdWK9iZL3d5XFOpZRq8yOerg+ZV+wiM=;
        b=htMwO36JDP0clHRPAkAgi8giMCtLPgkZDYt268jikMYJoTwMf1Clu0BReVW4E+I8gP
         7HVwkRT+LBG9nPIvUvSv1XhyCn++6w+R+uWIjs1nZrsgdP8dWtuh5RGdKJHVUgd/9b0e
         H88JMNGqzvG29/NfZHauYLGQZLD+EnBepVA2qkMu7ZuchOfMS6Tb9w8DuJLc6xNy1VqR
         HkYa+gNU+sCD563WsDDe8ahx5ISs42JAVyvF3tgOB1bq8tSWeLD3mxH6ngop7mCMHGj1
         C7s+gVzP6JN23f4oeFfG1A2RVePSNT6fKExcO0MFRhxAVA1XomSZ2YREUEDFxXRxlrdo
         kYfg==
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
Subject: [PATCH 4.9 09/88] sched/rt: Use container_of() to get root domain in rto_push_irq_work_func()
Date: Thu, 15 Feb 2018 16:16:36 +0100
Message-Id: <20180215151223.878579863@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480996908357247?=
X-GMAIL-MSGID: =?utf-8?q?1592481162132006010?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit ad0f1d9d65938aec72a698116cd73a980916895e upstream.

When the rto_push_irq_work_func() is called, it looks at the RT overloaded
bitmask in the root domain via the runqueue (rq->rd). The problem is that
during CPU up and down, nothing here stops rq->rd from changing between
taking the rq->rd->rto_lock and releasing it. That means the lock that is
released is not the same lock that was taken.

Instead of using this_rq()->rd to get the root domain, as the irq work is
part of the root domain, we can simply get the root domain from the irq work
that is passed to the routine:

 container_of(work, struct root_domain, rto_push_work)

This keeps the root domain consistent.

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
 kernel/sched/rt.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1895,9 +1895,8 @@ static void push_rt_tasks(struct rq *rq)
  * the rt_loop_next will cause the iterator to perform another scan.
  *
  */
-static int rto_next_cpu(struct rq *rq)
+static int rto_next_cpu(struct root_domain *rd)
 {
-	struct root_domain *rd = rq->rd;
 	int next;
 	int cpu;
 
@@ -1973,7 +1972,7 @@ static void tell_cpu_to_push(struct rq *
 	 * Otherwise it is finishing up and an ipi needs to be sent.
 	 */
 	if (rq->rd->rto_cpu < 0)
-		cpu = rto_next_cpu(rq);
+		cpu = rto_next_cpu(rq->rd);
 
 	raw_spin_unlock(&rq->rd->rto_lock);
 
@@ -1986,6 +1985,8 @@ static void tell_cpu_to_push(struct rq *
 /* Called from hardirq context */
 void rto_push_irq_work_func(struct irq_work *work)
 {
+	struct root_domain *rd =
+		container_of(work, struct root_domain, rto_push_work);
 	struct rq *rq;
 	int cpu;
 
@@ -2001,18 +2002,18 @@ void rto_push_irq_work_func(struct irq_w
 		raw_spin_unlock(&rq->lock);
 	}
 
-	raw_spin_lock(&rq->rd->rto_lock);
+	raw_spin_lock(&rd->rto_lock);
 
 	/* Pass the IPI to the next rt overloaded queue */
-	cpu = rto_next_cpu(rq);
+	cpu = rto_next_cpu(rd);
 
-	raw_spin_unlock(&rq->rd->rto_lock);
+	raw_spin_unlock(&rd->rto_lock);
 
 	if (cpu < 0)
 		return;
 
 	/* Try the next RT overloaded CPU */
-	irq_work_queue_on(&rq->rd->rto_push_work, cpu);
+	irq_work_queue_on(&rd->rto_push_work, cpu);
 }
 #endif /* HAVE_RT_PUSH_IPI */
 
