Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeDYV1M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:27:12 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:51228 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeDYV1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:27:10 -0400
X-Google-Smtp-Source: AB8JxZpkiogDvadAGDI47tD6A0gEpL82zkRUNY0Bfktiibl0Cn8nAmRqXmkTKRZFeACuE+xlohIy+c3Tgy+bUDPoeZ0=
MIME-Version: 1.0
In-Reply-To: <20180425042056.GA21412@linux.vnet.ibm.com>
References: <20180423172244.694dbc9d@gandalf.local.home> <20180424155655.GA820@linux.vnet.ibm.com>
 <CAJWu+or_-emRLeBbfOtQYyn9W8v-KHH8XecV_k-p5FX_3BLHAQ@mail.gmail.com>
 <20180424172658.GT26088@linux.vnet.ibm.com> <20180424182302.GA404@linux.vnet.ibm.com>
 <20180424182623.GA1357@linux.vnet.ibm.com> <CAJWu+opC9pLxoiXq7QDRUDe6ouC4ij398bHCfnUwp+h7Y_ssDg@mail.gmail.com>
 <849066633.939.1524612064698.JavaMail.zimbra@efficios.com>
 <68e4c123-a223-5e26-e57a-da2515041bf3@google.com> <20180425001049.GX26088@linux.vnet.ibm.com>
 <20180425042056.GA21412@linux.vnet.ibm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Wed, 25 Apr 2018 14:27:08 -0700
Message-ID: <CAJWu+orWC=W0Jn2Jo7f+u5mbHMi+D1yuCmhD-xSgjWZ6Ynw32Q@mail.gmail.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you can
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 9:20 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
[..]
>> >
>> > Sounds good, thanks.
>> >
>> > Also I found the reason for my boot issue. It was because the
>> > init_srcu_struct in the prototype was being done in an initcall.
>> > Instead if I do it in start_kernel before the tracepoint is used, it
>> > fixes it (although I don't know if this is dangerous to do like this
>> > but I can get it to boot atleast.. Let me know if this isn't the
>> > right way to do it, or if something else could go wrong)
>> >
>> > diff --git a/init/main.c b/init/main.c
>> > index 34823072ef9e..ecc88319c6da 100644
>> > --- a/init/main.c
>> > +++ b/init/main.c
>> > @@ -631,6 +631,7 @@ asmlinkage __visible void __init start_kernel(void)
>> >         WARN(!irqs_disabled(), "Interrupts were enabled early\n");
>> >         early_boot_irqs_disabled = false;
>> >
>> > +       init_srcu_struct(&tracepoint_srcu);
>> >         lockdep_init_early();
>> >
>> >         local_irq_enable();
>> > --
>> >
>> > I benchmarked it and the performance also looks quite good compared
>> > to the rcu tracepoint version.
>> >
>> > If you, Paul and other think doing the init_srcu_struct like this
>> > should be Ok, then I can try to work more on your srcu prototype and
>> > roll into my series and post them in the next RFC series (or let me
>> > know if you wanted to work your srcu stuff in a separate series..).
>>
>> That is definitely not what I was expecting, but let's see if it works
>> anyway...  ;-)
>>
>> But first, I was instead expecting something like this:
>>
>> DEFINE_SRCU(tracepoint_srcu);
>>
>> With this approach, some of the initialization happens at compile time
>> and the rest happens at the first call_srcu().
>>
>> This will work -only- if the first call_srcu() doesn't happen until after
>> workqueue_init_early() has been invoked.  Which I believe must have been
>> the case in your testing, because otherwise it looks like __call_srcu()
>> would have complained bitterly.
>>
>> On the other hand, if you need to invoke call_srcu() before the call
>> to workqueue_init_early(), then you need the patch that I am beating
>> into shape.  Plus you would need to use DEFINE_SRCU() and to avoid
>> invoking init_srcu_struct().
>
> And here is the patch.  I do not intend to send it upstream unless it
> actually proves necessary, and it appears that current SRCU does what
> you need.
>
> You would only need this patch if you wanted to invoke call_srcu()
> before workqueue_init_early() was called, which does not seem likely.

Cool. So I was chatting with Paul and just to update everyone as well,
I tried the DEFINE_SRCU instead of the late init_srcu_struct call and
can make it past boot too (thanks Paul!). Also I don't see a reason we
need the RCU callback to execute early and its fine if it runs later.

Also, I was thinking of introducing a separate trace_*event*_srcu API
as a replacement to the _rcuidle API. Then I can make use of it for my
tracepoints, and then later can use it for the other tracepoints
needing _rcuidle. After that we can finally get rid of the _rcuidle
API if there are no other users of it. This is just a rough plan, but
let me know if there's any issue with this plan that you can think
off.
IMO, I believe its simpler if the caller worries about whether it can
tolerate if tracepoint probes can block or not, than making it a
property of the tracepoint. That would also simplify the patch to
introduce srcu and keep the tracepoint creation API simple and less
confusing, but let me know if I'm missing something about this.

Thanks,

 - Joel
