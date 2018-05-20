Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbeETPf3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 11:35:29 -0400
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:34138 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751348AbeETPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 11:35:27 -0400
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,:::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:966:973:988:989:1183:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2553:2559:2562:2693:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:3871:3872:3874:4385:5007:6261:7875:7901:7903:8660:8957:9040:10004:10394:10400:10848:10967:11026:11232:11658:11914:12296:12740:12760:12895:13069:13148:13161:13190:13229:13230:13311:13357:13439:13972:14181:14659:14721:21080:21324:21433:21627:30012:30054:30090:30091,0,RBL:172.56.27.111:@goodmis.org:.lbl8.mailshell.net-62.14.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: angle90_13df00abf0661
X-Filterd-Recvd-Size: 2710
Date: Sun, 20 May 2018 11:28:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, byungchul.park@lge.com,
        mathieu.desnoyers@efficios.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Message-ID: <20180520112843.57079857@grimm.local.home>
In-Reply-To: <20180520004938.GZ3803@linux.vnet.ibm.com>
References: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
        <20180519022918.GV3803@linux.vnet.ibm.com>
        <20180519225905.GB134184@joelaf.mtv.corp.google.com>
        <20180520004938.GZ3803@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Steve interrupts his time off ]

On Sat, 19 May 2018 17:49:38 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> I suggested to Steven that the rcu_read_lock() and rcu_read_unlock() might
> be outside of the trampoline, but this turned out to be infeasible.  Not
> that I remember why!  ;-)

Because the trampoline itself is what needs to be freed. The trampoline
is what mcount/fentry or an optimized kprobe jumps to.


<func>:
	nop

[ enable function tracing ]

<func>:
	call func_tramp --> set up stack
			    call function_tracer()
			    pop stack
			    ret

			    ^^^^^
			    This is the trampoline

There's no way to know when a task will be on the trampoline or not.
The trampoline is allocated, and we need RCU_tasks to know when we can
free it. The only way to make a "wrapper" is to modify more of the code
text to do whatever before calling the trampoline, which is
impractical.

The allocated trampolines were added as an optimization, where two
registered callback functions from ftrace that are attached to two
different functions don't call the same trampoline which would have to
do a loop and a hash lookup to know what callback to call per function.
If a callback is the only one attached to a specific function, then a
trampoline is allocated and will call that callback directly, keeping
the overhead down.

There is no feasible way to know when a task is on a trampoline
without adding overhead that negates the speed up we receive by making
individual trampolines to begin with.

-- Steve

[ Steve resumes his time off ]
