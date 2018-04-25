Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeDYVlA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:41:00 -0400
Received: from mail.efficios.com ([167.114.142.138]:42402 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeDYVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:40:58 -0400
Date: Wed, 25 Apr 2018 17:40:56 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Joel Fernandes <joelaf@google.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        rostedt <rostedt@goodmis.org>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, fweisbec <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>,
        kernel-team <kernel-team@lge.com>
Message-ID: <1267842641.1791.1524692456344.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAJWu+orWC=W0Jn2Jo7f+u5mbHMi+D1yuCmhD-xSgjWZ6Ynw32Q@mail.gmail.com>
References: <20180423172244.694dbc9d@gandalf.local.home> <20180424182623.GA1357@linux.vnet.ibm.com> <CAJWu+opC9pLxoiXq7QDRUDe6ouC4ij398bHCfnUwp+h7Y_ssDg@mail.gmail.com> <849066633.939.1524612064698.JavaMail.zimbra@efficios.com> <68e4c123-a223-5e26-e57a-da2515041bf3@google.com> <20180425001049.GX26088@linux.vnet.ibm.com> <20180425042056.GA21412@linux.vnet.ibm.com> <CAJWu+orWC=W0Jn2Jo7f+u5mbHMi+D1yuCmhD-xSgjWZ6Ynw32Q@mail.gmail.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: irqflags: Avoid unnecessary calls to trace_ if you can
Thread-Index: VjvA7WgrmQxZIVKtN4OK9jWKYBBJow==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 25, 2018, at 5:27 PM, Joel Fernandes joelaf@google.com wrote:

> On Tue, Apr 24, 2018 at 9:20 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> [..]
>>> >
>>> > Sounds good, thanks.
>>> >
>>> > Also I found the reason for my boot issue. It was because the
>>> > init_srcu_struct in the prototype was being done in an initcall.
>>> > Instead if I do it in start_kernel before the tracepoint is used, it
>>> > fixes it (although I don't know if this is dangerous to do like this
>>> > but I can get it to boot atleast.. Let me know if this isn't the
>>> > right way to do it, or if something else could go wrong)
>>> >
>>> > diff --git a/init/main.c b/init/main.c
>>> > index 34823072ef9e..ecc88319c6da 100644
>>> > --- a/init/main.c
>>> > +++ b/init/main.c
>>> > @@ -631,6 +631,7 @@ asmlinkage __visible void __init start_kernel(void)
>>> >         WARN(!irqs_disabled(), "Interrupts were enabled early\n");
>>> >         early_boot_irqs_disabled = false;
>>> >
>>> > +       init_srcu_struct(&tracepoint_srcu);
>>> >         lockdep_init_early();
>>> >
>>> >         local_irq_enable();
>>> > --
>>> >
>>> > I benchmarked it and the performance also looks quite good compared
>>> > to the rcu tracepoint version.
>>> >
>>> > If you, Paul and other think doing the init_srcu_struct like this
>>> > should be Ok, then I can try to work more on your srcu prototype and
>>> > roll into my series and post them in the next RFC series (or let me
>>> > know if you wanted to work your srcu stuff in a separate series..).
>>>
>>> That is definitely not what I was expecting, but let's see if it works
>>> anyway...  ;-)
>>>
>>> But first, I was instead expecting something like this:
>>>
>>> DEFINE_SRCU(tracepoint_srcu);
>>>
>>> With this approach, some of the initialization happens at compile time
>>> and the rest happens at the first call_srcu().
>>>
>>> This will work -only- if the first call_srcu() doesn't happen until after
>>> workqueue_init_early() has been invoked.  Which I believe must have been
>>> the case in your testing, because otherwise it looks like __call_srcu()
>>> would have complained bitterly.
>>>
>>> On the other hand, if you need to invoke call_srcu() before the call
>>> to workqueue_init_early(), then you need the patch that I am beating
>>> into shape.  Plus you would need to use DEFINE_SRCU() and to avoid
>>> invoking init_srcu_struct().
>>
>> And here is the patch.  I do not intend to send it upstream unless it
>> actually proves necessary, and it appears that current SRCU does what
>> you need.
>>
>> You would only need this patch if you wanted to invoke call_srcu()
>> before workqueue_init_early() was called, which does not seem likely.
> 
> Cool. So I was chatting with Paul and just to update everyone as well,
> I tried the DEFINE_SRCU instead of the late init_srcu_struct call and
> can make it past boot too (thanks Paul!). Also I don't see a reason we
> need the RCU callback to execute early and its fine if it runs later.
> 
> Also, I was thinking of introducing a separate trace_*event*_srcu API
> as a replacement to the _rcuidle API. Then I can make use of it for my
> tracepoints, and then later can use it for the other tracepoints
> needing _rcuidle. After that we can finally get rid of the _rcuidle
> API if there are no other users of it. This is just a rough plan, but
> let me know if there's any issue with this plan that you can think
> off.
> IMO, I believe its simpler if the caller worries about whether it can
> tolerate if tracepoint probes can block or not, than making it a
> property of the tracepoint. That would also simplify the patch to
> introduce srcu and keep the tracepoint creation API simple and less
> confusing, but let me know if I'm missing something about this.

One problem with your approach is that you can have multiple callers
for the same tracepoint name, where some could be non-preemptible and
others blocking. Also, there is then no clear way for the callback
registration API to enforce whether the callback expects the tracepoint
to be blocking or non-preemptible. This can introduce hard to diagnose
issues in a kernel without debug options enabled.

Regarding the name, I'm OK with having something along the lines of
trace_*event*_blocking or such. Please don't use "srcu" or other naming
that is explicitly tied to the underlying mechanism used internally
however: what we want to convey is that this specific tracepoint probe
can be preempted and block. The underlying implementation could move to
a different RCU flavor brand in the future, and it should not impact
users of the tracepoint APIs.

In order to ensure that probes that may block only register themselves
to tracepoints that allow blocking, we should introduce new tracepoint
declaration/definition *and* registration APIs also contain the
"BLOCKING/blocking" keywords (or such), so we can ensure that a
tracepoint probe being registered to a "blocking" tracepoint is indeed
allowed to block.

Thanks,

Mathieu


> 
> Thanks,
> 
>  - Joel

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
