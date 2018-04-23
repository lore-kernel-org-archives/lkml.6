Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754905AbeDWMiz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:38:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754786AbeDWMiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:38:52 -0400
Date: Mon, 23 Apr 2018 05:40:00 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel.opensrc@gmail.com
Subject: Re: [PATCH tip/core/rcu 01/22] sched: Make non-production PREEMPT
 cond_resched() help Tasks RCU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180423023150.GA21533@linux.vnet.ibm.com>
 <1524450747-22778-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180423085127.GR4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423085127.GR4064@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042312-0048-0000-0000-00000261B03E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008905; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022090; UDB=6.00521656; IPR=6.00801325;
 MB=3.00020724; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 12:38:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042312-0049-0000-0000-000044E090D7
Message-Id: <20180423124000.GL26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:51:27AM +0200, Peter Zijlstra wrote:
> On Sun, Apr 22, 2018 at 07:32:06PM -0700, Paul E. McKenney wrote:
> > In CONFIG_PREEMPT=y kernels, cond_resched() is a complete no-op, and
> > thus cannot help advance Tasks-RCU grace periods.  However, such grace
> > periods are only an issue in non-production benchmarking runs of the
> > Linux kernel.  This commit therefore makes cond_resched() invoke
> > rcu_note_voluntary_context_switch() for kernels implementing Tasks RCU
> > even in CONFIG_PREEMPT=y kernels.
> 
> I'm confused.. why is having this conditional on TRACEPOINT_BENCHMARK a
> sane idea?

Because the TRACEPOINT_BENCHMARK tests are insane, so a similar
level of insanity is required to make things work.  Plus having this
be unconditional would not be good for performance, as 0day has been
telling me frequently over the past couple of years.

All that aside, I am very open to ideas.  What would you suggest?

							Thanx, Paul

> > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  include/linux/sched.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index b3d697f3b573..fe8f7178a22d 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1617,6 +1617,12 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
> >   */
> >  #ifndef CONFIG_PREEMPT
> >  extern int _cond_resched(void);
> > +#elif defined(CONFIG_TRACEPOINT_BENCHMARK)
> > +static inline int _cond_resched(void)
> > +{
> > +	rcu_note_voluntary_context_switch(current);
> > +	return 0;
> > +}
> >  #else
> >  static inline int _cond_resched(void) { return 0; }
> >  #endif
> > -- 
> > 2.5.2
> > 
> 
