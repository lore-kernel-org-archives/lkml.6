Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeEDXm0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:42:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751771AbeEDXmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:42:25 -0400
Date: Fri, 4 May 2018 16:43:42 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: rcu-bh design
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180504123050.2841f80d@gandalf.local.home>
 <CAJWu+oqXmSC3zUZobQA4=qY_acRvOsq67c6dHXfVzTGqxqdaTA@mail.gmail.com>
 <20180504174330.GS26088@linux.vnet.ibm.com>
 <CAJWu+opXqw6BoKSzoV4xD0QBJ4s3C-KL=QBESZdEZ5RQCQKphw@mail.gmail.com>
 <20180504184951.GU26088@linux.vnet.ibm.com>
 <CAEi0qN=8c6tzNq26x=BBj5u3JoZHXF0DvfwWg=1vjmTU0UC4-w@mail.gmail.com>
 <20180504201129.GX26088@linux.vnet.ibm.com>
 <CAJWu+oo+KQh4NmTf4bu_paH8k_PKuzuXRXrbi3dX8bQYKJwwAQ@mail.gmail.com>
 <20180504224921.GE26088@linux.vnet.ibm.com>
 <5ab0c23a-f98d-859f-593f-f32f6c470626@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab0c23a-f98d-859f-593f-f32f6c470626@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050423-0044-0000-0000-0000040FD6A9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008971; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027588; UDB=6.00524918; IPR=6.00806722;
 MB=3.00020934; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-04 23:42:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050423-0045-0000-0000-00000841E09B
Message-Id: <20180504234342.GJ26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 04:20:41PM -0700, Joel Fernandes wrote:
> 
> 
> On 05/04/2018 03:49 PM, Paul E. McKenney wrote:
> >>Yes just one more ;-). I am trying to write a 'probetorture' test inspired
> >>by RCU torture that whacks the tracepoints in various scenarios. One of the
> >>things I want to do is verify the RCU callbacks are queued and secondly,
> >>they are executed. Just to verify that the garbage collect was done and
> >>we're not leaking the function probe table (not that I don't have
> >>confidence in the chained callback technique which you mentioned, but it
> >>would be nice to assure this mechanism is working for tracepoints).
> >>
> >>Is there a way to detect this given a reference to srcu_struct? Mathieu and
> >>we were chatting about srcu_barrier which is cool but that just tells me
> >>that if there was a callback queued, it would have executed after the
> >>readers were done. But not whether something was queued.
> >
> >Suppose that you are queuing an RCU callback that in turn queues an SRCU
> >callback on my_srcu_struct, like this:
> >
> >	void my_rcu_callback(struct rcu_head *rhp)
> >	{
> >		p = container_of(rhp, struct my_struct, my_rcu_head);
> >
> >		free_it_up_or_down(p);
> >	}
> >
> >	void my_srcu_callback(struct rcu_head *rhp)
> >	{
> >		call_rcu(rhp, my_rcu_callback);
> >	}
> >
> >	call_srcu(&my_srcu_struct, &p->my_rcu_head, my_srcu_callback);
> >
> >Then to make sure that any previously submitted callback has been fully
> >processed, you do this:
> >
> >	rcu_barrier();
> >	srcu_barrier(&my_srcu_struct);
> >
> >Of course if you queue in the opposite order, like this:
> >
> >	void my_srcu_callback(struct rcu_head *rhp)
> >	{
> >		p = container_of(rhp, struct my_struct, my_rcu_head);
> >
> >		free_it_up_or_down(p);
> >	}
> >
> >	void my_rcu_callback(struct rcu_head *rhp)
> >	{
> >		call_srcu(&my_srcu_struct, &p->my_rcu_head, my_srcu_callback);
> >	}
> >
> >	call_rcu(rhp, my_rcu_callback);
> >
> >Then you must wait in the opposite order:
> >
> >	rcu_barrier();
> >	srcu_barrier(&my_srcu_struct);
> >
> >Either way, the trick is that the first *_barrier() call cannot return
> >until after all previous callbacks have executed, which means that by that
> >time the callback is enqueued for the other flavor of {S,}RCU.  So the
> >second *_barrier() call must wait for the callback to be completely done,
> >through both flavors of {S,}RCU.
> >
> >So after executing the pair of *_barrier() calls, you know that the
> >callback is no longer queued.
> >
> >Does that cover it, or am I missing a turn in here somewhere?
> 
> Yes, that covers some of it. Thanks a lot. Btw, I was also thinking
> I want to check that srcu received a callback queuing request as
> well (not just completion but also queuing).
> 
> Say that the tracepoint code is buggy and for some reason a
> call_srcu wasn't done. For example, say the hypothetical bug I'm
> taking about is in tracepoint_remove_func which called the
> rcu_assign_pointer, but didn't call release_probes:
> 
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index d0639d917899..f54cb358f451 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -216,7 +216,6 @@ static int tracepoint_add_func(struct tracepoint *tp,
>         rcu_assign_pointer(tp->funcs, tp_funcs);
>         if (!static_key_enabled(&tp->key))
>                 static_key_slow_inc(&tp->key);
> -       release_probes(old);
>         return 0;
>  }
> ---
> I want to catching this from the test code. If I did the following,
> it would be insufficient then:
> 
> trace_probe_register(...);
> srcu_barrier(&my_srcu_struct);  // only tells me any queued calls
> 				// are done but not that something
> 				// was queued
> 
> I was seeing if I could use my_srcu_struct::completed for that. but
> I'm not sure if that'll work (or that its legal to access it
> directly - but hey this is just test code! :P).

This is a bit ugly to do programmatically in the kernel.  The callbacks
are on per-CPU queues that cannot be safely accessed except by that CPU.
Plus they are on singly linked lists that can be quite long, so it could
be insanely slow as well.

But given that this is test code, why not leverage event tracing?
There are some relevant events in include/trace/events/rcu.h, starting
with the rcu_callback trace event.

							Thanx, Paul
