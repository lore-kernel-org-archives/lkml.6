Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbeEDXUp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:20:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40266 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeEDXUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:20:43 -0400
X-Google-Smtp-Source: AB8JxZovQkK0n5AwwSez1aQiZ+lyjiGancThp/jP/bcussY6Qy07cJYlfZWiyx0pHtOnFwMjY3w0+Q==
Subject: Re: rcu-bh design
To: paulmck@linux.vnet.ibm.com
Cc: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
 <20180504123050.2841f80d@gandalf.local.home>
 <CAJWu+oqXmSC3zUZobQA4=qY_acRvOsq67c6dHXfVzTGqxqdaTA@mail.gmail.com>
 <20180504174330.GS26088@linux.vnet.ibm.com>
 <CAJWu+opXqw6BoKSzoV4xD0QBJ4s3C-KL=QBESZdEZ5RQCQKphw@mail.gmail.com>
 <20180504184951.GU26088@linux.vnet.ibm.com>
 <CAEi0qN=8c6tzNq26x=BBj5u3JoZHXF0DvfwWg=1vjmTU0UC4-w@mail.gmail.com>
 <20180504201129.GX26088@linux.vnet.ibm.com>
 <CAJWu+oo+KQh4NmTf4bu_paH8k_PKuzuXRXrbi3dX8bQYKJwwAQ@mail.gmail.com>
 <20180504224921.GE26088@linux.vnet.ibm.com>
From: Joel Fernandes <joelaf@google.com>
Message-ID: <5ab0c23a-f98d-859f-593f-f32f6c470626@google.com>
Date: Fri, 4 May 2018 16:20:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180504224921.GE26088@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2018 03:49 PM, Paul E. McKenney wrote:
>> Yes just one more ;-). I am trying to write a 'probetorture' test inspired
>> by RCU torture that whacks the tracepoints in various scenarios. One of the
>> things I want to do is verify the RCU callbacks are queued and secondly,
>> they are executed. Just to verify that the garbage collect was done and
>> we're not leaking the function probe table (not that I don't have
>> confidence in the chained callback technique which you mentioned, but it
>> would be nice to assure this mechanism is working for tracepoints).
>>
>> Is there a way to detect this given a reference to srcu_struct? Mathieu and
>> we were chatting about srcu_barrier which is cool but that just tells me
>> that if there was a callback queued, it would have executed after the
>> readers were done. But not whether something was queued.
> 
> Suppose that you are queuing an RCU callback that in turn queues an SRCU
> callback on my_srcu_struct, like this:
> 
> 	void my_rcu_callback(struct rcu_head *rhp)
> 	{
> 		p = container_of(rhp, struct my_struct, my_rcu_head);
> 
> 		free_it_up_or_down(p);
> 	}
> 
> 	void my_srcu_callback(struct rcu_head *rhp)
> 	{
> 		call_rcu(rhp, my_rcu_callback);
> 	}
> 
> 	call_srcu(&my_srcu_struct, &p->my_rcu_head, my_srcu_callback);
> 
> Then to make sure that any previously submitted callback has been fully
> processed, you do this:
> 
> 	rcu_barrier();
> 	srcu_barrier(&my_srcu_struct);
> 
> Of course if you queue in the opposite order, like this:
> 
> 	void my_srcu_callback(struct rcu_head *rhp)
> 	{
> 		p = container_of(rhp, struct my_struct, my_rcu_head);
> 
> 		free_it_up_or_down(p);
> 	}
> 
> 	void my_rcu_callback(struct rcu_head *rhp)
> 	{
> 		call_srcu(&my_srcu_struct, &p->my_rcu_head, my_srcu_callback);
> 	}
> 
> 	call_rcu(rhp, my_rcu_callback);
> 
> Then you must wait in the opposite order:
> 
> 	rcu_barrier();
> 	srcu_barrier(&my_srcu_struct);
> 
> Either way, the trick is that the first *_barrier() call cannot return
> until after all previous callbacks have executed, which means that by that
> time the callback is enqueued for the other flavor of {S,}RCU.  So the
> second *_barrier() call must wait for the callback to be completely done,
> through both flavors of {S,}RCU.
> 
> So after executing the pair of *_barrier() calls, you know that the
> callback is no longer queued.
> 
> Does that cover it, or am I missing a turn in here somewhere?

Yes, that covers some of it. Thanks a lot. Btw, I was also thinking I 
want to check that srcu received a callback queuing request as well (not 
just completion but also queuing).

Say that the tracepoint code is buggy and for some reason a call_srcu 
wasn't done. For example, say the hypothetical bug I'm taking about is 
in tracepoint_remove_func which called the rcu_assign_pointer, but 
didn't call release_probes:

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index d0639d917899..f54cb358f451 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -216,7 +216,6 @@ static int tracepoint_add_func(struct tracepoint *tp,
         rcu_assign_pointer(tp->funcs, tp_funcs);
         if (!static_key_enabled(&tp->key))
                 static_key_slow_inc(&tp->key);
-       release_probes(old);
         return 0;
  }
---
I want to catching this from the test code. If I did the following, it 
would be insufficient then:

trace_probe_register(...);
srcu_barrier(&my_srcu_struct);  // only tells me any queued calls
				// are done but not that something
				// was queued

I was seeing if I could use my_srcu_struct::completed for that. but I'm 
not sure if that'll work (or that its legal to access it directly - but 
hey this is just test code! :P).

thanks,

  - Joel
