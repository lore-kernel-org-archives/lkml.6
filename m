Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226qhG+I30/UN8eBAW/HRjOhlv8NNKaevLcsURsiJ2u4YAtf9+NDCj+jE8keQbuGb2S0cPJy
ARC-Seal: i=1; a=rsa-sha256; t=1518709240; cv=none;
        d=google.com; s=arc-20160816;
        b=E6HqKFHsk0HeNPPzn/35XnZkOCPcIohFhG7HrAoaP3GZomTMM2n3/edmwpd/ntOh4A
         tLeG4yIRA2PuGXFMN0KckCBnoWnzeLmeyxvb19WO6TabbrBQZkv3HUehViG3gwdQiN8I
         yBv8NYtbs9SC7b4bTjQM5I0PDlNIIYO4+h1HlF0D1tiwSkyikC+y/nqQJDkMxPHrWUdU
         m7etIUSMEAgUg3dUIF9kk5nt/fKC+ubob5e7RQxbZirWzcyGDste+/q++ekIRhFgl/Ta
         MfvTYQvqKjMF2cDOuRVETZ/wp3BLv98D9Py6YW/mxvL6vF9xR9RGmoHduFD24bsoAJIG
         vlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o38qThj6t3kt1iX4UVs9oUEbo91zpRnwCx9dRiQ+EtY=;
        b=aguRDPOz9UO9BIjez1HSLm2clApxV5MEEdH88QwxFFJKjFnq1vIPxNDziO13Ih/+iY
         jauUDpgxUJ6E5C82jE6dwK6kN6OoGd2hb+nTYiUxtCozLW3lusaXCPC9BrZbw+72ZmX+
         MftJi3keDwy9TRw0iUQ8Y91aDP7HF9W9AbR3F3uASxj2ARxOjER+y97iw25xzcW+7T3l
         KDXfepJWXECTNzttf17PavSjkGHm/M2nWZ4KFuatyGoZbNeP7jLb/U3VRiF1eB717DAG
         PmIRpfD/sX5k6ZfMPeiuVld21w2ZfSF+/8IJ1GfwEv8K6FAUio2hVu9vhlfiNOuNgAYn
         vJgQ==
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
Subject: [PATCH 4.15 010/202] sched/rt: Use container_of() to get root domain in rto_push_irq_work_func()
Date: Thu, 15 Feb 2018 16:15:10 +0100
Message-Id: <20180215151713.352610375@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480996908357247?=
X-GMAIL-MSGID: =?utf-8?q?1592482061061511693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1907,9 +1907,8 @@ static void push_rt_tasks(struct rq *rq)
  * the rt_loop_next will cause the iterator to perform another scan.
  *
  */
-static int rto_next_cpu(struct rq *rq)
+static int rto_next_cpu(struct root_domain *rd)
 {
-	struct root_domain *rd = rq->rd;
 	int next;
 	int cpu;
 
@@ -1985,7 +1984,7 @@ static void tell_cpu_to_push(struct rq *
 	 * Otherwise it is finishing up and an ipi needs to be sent.
 	 */
 	if (rq->rd->rto_cpu < 0)
-		cpu = rto_next_cpu(rq);
+		cpu = rto_next_cpu(rq->rd);
 
 	raw_spin_unlock(&rq->rd->rto_lock);
 
@@ -1998,6 +1997,8 @@ static void tell_cpu_to_push(struct rq *
 /* Called from hardirq context */
 void rto_push_irq_work_func(struct irq_work *work)
 {
+	struct root_domain *rd =
+		container_of(work, struct root_domain, rto_push_work);
 	struct rq *rq;
 	int cpu;
 
@@ -2013,18 +2014,18 @@ void rto_push_irq_work_func(struct irq_w
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
 
