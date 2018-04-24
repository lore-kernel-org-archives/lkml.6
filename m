Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeDXQBj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:01:39 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34400 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeDXQBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:01:36 -0400
X-Google-Smtp-Source: AB8JxZpS9wp8epxAAC8L8I+FWIP2dGJeJUW1afTh4cEb1GVeJYDUm0GKhd0HmiBxftk28Aa1ZTUOgpKU+qZ3dc+/MW4=
MIME-Version: 1.0
In-Reply-To: <20180424155655.GA820@linux.vnet.ibm.com>
References: <20180417040748.212236-1-joelaf@google.com> <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com>
 <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com>
 <20180423031926.GF26088@linux.vnet.ibm.com> <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com>
 <20180423105325.7d5d245b@gandalf.local.home> <1045420715.14686.1524495583859.JavaMail.zimbra@efficios.com>
 <20180423121800.47b173af@gandalf.local.home> <1212130312.14753.1524503541789.JavaMail.zimbra@efficios.com>
 <20180423172244.694dbc9d@gandalf.local.home> <20180424155655.GA820@linux.vnet.ibm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 24 Apr 2018 09:01:34 -0700
Message-ID: <CAJWu+or_-emRLeBbfOtQYyn9W8v-KHH8XecV_k-p5FX_3BLHAQ@mail.gmail.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you can
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
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

On Tue, Apr 24, 2018 at 8:56 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Mon, Apr 23, 2018 at 05:22:44PM -0400, Steven Rostedt wrote:
>> On Mon, 23 Apr 2018 13:12:21 -0400 (EDT)
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>>
>> > I'm inclined to explicitly declare the tracepoints with their given
>> > synchronization method. Tracepoint probe callback functions for currently
>> > existing tracepoints expect to have preemption disabled when invoked.
>> > This assumption will not be true anymore for srcu-tracepoints.
>>
>> Actually, why not have a flag attached to the tracepoint_func that
>> states if it expects preemption to be enabled or not? If a
>> trace_##event##_srcu() is called, then simply disable preemption before
>> calling the callbacks for it. That way if a callback is fine for use
>> with srcu, then it would require calling
>>
>>       register_trace_##event##_may_sleep();
>>
>> Then if someone uses this on a tracepoint where preemption is disabled,
>> we simply do not call it.
>
> One more stupid question...  If we are having to trace so much stuff
> in the idle loop, are we perhaps grossly overstating the extent of that
> "idle" loop?  For being called "idle", this code seems quite busy!

;-)
The performance hit I am observing is when running a heavy workload,
like hackbench or something like that. That's what I am trying to
correct.
By the way is there any limitation on using SRCU too early during
boot? I backported Mathieu's srcu tracepoint patches but the kernel
hangs pretty early in the boot. I register lockdep probes in
start_kernel. I am hoping that's not why.

I could also have just screwed up the backporting... may be for my
testing, I will just replace the rcu API with the srcu instead of all
of Mathieu's new TRACE_EVENT macros for SRCU, since all I am trying to
do right now is measure the performance of my patches with SRCU.

thanks,

- Joel
