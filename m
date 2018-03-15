Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeCOJTz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:19:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751289AbeCOJTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:19:54 -0400
Date: Thu, 15 Mar 2018 10:19:50 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        syzbot <syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        syzkaller-bugs@googlegroups.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: WARNING in tracepoint_probe_register_prio (2)
Message-ID: <20180315091950.GA7600@krava>
References: <001a114465e241a8720567419a72@google.com>
 <539259484.8875.1520954991870.JavaMail.zimbra@efficios.com>
 <20180314173746.3a6ab6eb@vmware.local.home>
 <20180315083125.GU4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315083125.GU4064@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 09:31:25AM +0100, Peter Zijlstra wrote:
> On Wed, Mar 14, 2018 at 05:37:46PM -0400, Steven Rostedt wrote:
> > On Tue, 13 Mar 2018 11:29:51 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > > Here is a WARN_ON() splat in tracepoint.c, which I suspect is caused
> > > by perf trying to register the same probe twice to the tracepoint API.
> > > We got another splat on unregister too, which I will forward in a
> > > separate email.
> > > 
> > > Thoughts ?
> > 
> > Yes, it looks like it's perf not accounting for registered events
> > properly.
> > 
> > Peter?
> 
> I've not yet managed to reproduce, but if you look at the provided
> repro.c file, you'll see it opens two _different_ events.

from the log it looks like they inject the slab error,
and the allocation fails.. looks like we need to change
the WARN to skip ENOMEM.. something like below?

jirka


---
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 671b13457387..815625288c65 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -207,7 +207,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
 
