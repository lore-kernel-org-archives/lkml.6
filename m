Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeENDMD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:12:03 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:33094 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751953AbeENDMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:12:02 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.220.135
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [PATCH] rcu: Report a quiescent state when it's exactly in the
 state
To: Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        peterz@infradead.org
References: <1526027434-21237-1-git-send-email-byungchul.park@lge.com>
 <3af4cec0-4019-e3ac-77f9-8631252fb6da@lge.com>
 <20180511161746.GX26088@linux.vnet.ibm.com>
 <20180511224138.GA89902@joelaf.mtv.corp.google.com>
 <20180512050824.GF26088@linux.vnet.ibm.com>
 <20180512063037.GC192642@joelaf.mtv.corp.google.com>
 <20180512144119.GJ26088@linux.vnet.ibm.com>
 <20180512132647.2923f7cf@gandalf.local.home>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <f35aa0d8-3bbf-0900-7bcd-81ba6e03fe86@lge.com>
Date: Mon, 14 May 2018 12:11:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180512132647.2923f7cf@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-05-13 오전 2:26, Steven Rostedt wrote:
> On Sat, 12 May 2018 07:41:19 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
>> Don't get me wrong, this discussion was quite useful to me.  We probably
>> need to at least change the comments, and perhaps the code as well.  But
>> I agree that we need input from Peter and Steven to make much more forward
>> progress.
> 
> It's the weekend so I skimmed more than read this thread, but I will
> just add this.
> 
> The table Joel posted is interesting, and perhaps we should keep things
> consistent with that. But that said, with respect to task-RCU, as
> nothing on a trampoline should ever call cond_resched() (and perhaps I
> should add code in lockdep that verifies this), we just want a
> quiescent state that tells us that the task has left the trampoline. A
> cond_resched() should be one of those points that does.
> 
> It really has nothing to do with scheduling or preemption. The issue is
> that if a task is on a trampoline and gets preempted, there's no
> knowing when it is off that trampoline where we can free it. We need to
> have places in the kernel that we know is a quiescent state to move
> task-RCU forward. cond_resched() seems to be one of them. schedule
> itself can not be, because it can be called from an interrupt preempting
> a task while it is on the trampoline.

Exactly. I think Steven explained how we should consider them exactly.

> -- Steve
-- 
Thanks,
Byungchul
