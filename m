Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeCOM0y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:26:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751547AbeCOM0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:26:52 -0400
Date: Thu, 15 Mar 2018 13:26:49 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: WARNING in tracepoint_probe_register_prio (2)
Message-ID: <20180315122649.GB27628@krava>
References: <001a114465e241a8720567419a72@google.com>
 <539259484.8875.1520954991870.JavaMail.zimbra@efficios.com>
 <20180314173746.3a6ab6eb@vmware.local.home>
 <20180315083125.GU4064@hirez.programming.kicks-ass.net>
 <20180315091950.GA7600@krava>
 <343055951.10185.1521114743799.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343055951.10185.1521114743799.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 07:52:23AM -0400, Mathieu Desnoyers wrote:
> ----- On Mar 15, 2018, at 5:19 AM, Jiri Olsa jolsa@redhat.com wrote:
> 
> > On Thu, Mar 15, 2018 at 09:31:25AM +0100, Peter Zijlstra wrote:
> >> On Wed, Mar 14, 2018 at 05:37:46PM -0400, Steven Rostedt wrote:
> >> > On Tue, 13 Mar 2018 11:29:51 -0400 (EDT)
> >> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >> > 
> >> > > Here is a WARN_ON() splat in tracepoint.c, which I suspect is caused
> >> > > by perf trying to register the same probe twice to the tracepoint API.
> >> > > We got another splat on unregister too, which I will forward in a
> >> > > separate email.
> >> > > 
> >> > > Thoughts ?
> >> > 
> >> > Yes, it looks like it's perf not accounting for registered events
> >> > properly.
> >> > 
> >> > Peter?
> >> 
> >> I've not yet managed to reproduce, but if you look at the provided
> >> repro.c file, you'll see it opens two _different_ events.
> > 
> > from the log it looks like they inject the slab error,
> > and the allocation fails.. looks like we need to change
> > the WARN to skip ENOMEM.. something like below?
> 
> Oh, I missed this important point. Then we should only
> warn if !-ENOMEM for both tracepoint_add_func and tracepoint_remove_func,
> because each performs memory allocation under the hood.
> Like the following:
> 
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -207,7 +207,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
>                         lockdep_is_held(&tracepoints_mutex));
>         old = func_add(&tp_funcs, func, prio);
>         if (IS_ERR(old)) {
> -               WARN_ON_ONCE(1);
> +               WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
>                 return PTR_ERR(old);
>         }
>  
> @@ -239,7 +239,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>                         lockdep_is_held(&tracepoints_mutex));
>         old = func_remove(&tp_funcs, func);

right, overlooked this one ;-) looks good

jirka

>         if (IS_ERR(old)) {
> -               WARN_ON_ONCE(1);
> +               WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
>                 return PTR_ERR(old);
>         }
>  
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
