Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeDXTBW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:01:22 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35338 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeDXTBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:01:19 -0400
X-Google-Smtp-Source: AIpwx48IV6ANsunogtDTxW5zgCpmIwNydShsjtr5DLIgfjXHf/I6Za+V3ENQLYuNbxoDrEsD34ALyoJlICUJZ+wERO8=
MIME-Version: 1.0
In-Reply-To: <CAJWu+opC9pLxoiXq7QDRUDe6ouC4ij398bHCfnUwp+h7Y_ssDg@mail.gmail.com>
References: <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com>
 <20180423105325.7d5d245b@gandalf.local.home> <1045420715.14686.1524495583859.JavaMail.zimbra@efficios.com>
 <20180423121800.47b173af@gandalf.local.home> <1212130312.14753.1524503541789.JavaMail.zimbra@efficios.com>
 <20180423172244.694dbc9d@gandalf.local.home> <20180424155655.GA820@linux.vnet.ibm.com>
 <CAJWu+or_-emRLeBbfOtQYyn9W8v-KHH8XecV_k-p5FX_3BLHAQ@mail.gmail.com>
 <20180424172658.GT26088@linux.vnet.ibm.com> <20180424182302.GA404@linux.vnet.ibm.com>
 <20180424182623.GA1357@linux.vnet.ibm.com> <CAJWu+opC9pLxoiXq7QDRUDe6ouC4ij398bHCfnUwp+h7Y_ssDg@mail.gmail.com>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 24 Apr 2018 12:01:17 -0700
Message-ID: <CAJWu+oosc4_X3qqx8tUEKR+g0gCdZQwBi7H6NXDdpu6HGG6MJg@mail.gmail.com>
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

On Tue, Apr 24, 2018 at 11:59 AM, Joel Fernandes <joelaf@google.com> wrote:
[...]
>>> > > By the way is there any limitation on using SRCU too early during
>>> > > boot? I backported Mathieu's srcu tracepoint patches but the kernel
>>> > > hangs pretty early in the boot. I register lockdep probes in
>>> > > start_kernel. I am hoping that's not why.
>>> > >
>>> > > I could also have just screwed up the backporting... may be for my
>>> > > testing, I will just replace the rcu API with the srcu instead of all
>>> > > of Mathieu's new TRACE_EVENT macros for SRCU, since all I am trying to
>>> > > do right now is measure the performance of my patches with SRCU.
>>> >
>>> > Gah, yes, there is an entry on my capacious todo list on making SRCU
>>> > grace periods work during early boot and mid-boot.  Let me see what
>>> > I can do...
>>>
>>> OK, just need to verify that you are OK with call_srcu()'s callbacks
>>> not being invoked until sometime during core_initcall() time.  (If you
>>> really do need them to be invoked before that, in theory it is possible,
>>> but in practice it is weird, even for RCU.)
>>
>> Oh, and that early at boot, you will need to use DEFINE_SRCU() or
>> DEFINE_STATIC_SRCU() rather than dynamic allocation and initialization.
>>
>>                                                         Thanx, Paul
>>
>
> Oh ok.
>
> About call_rcu, calling it later may be an issue since we register the
> probes in start_kernel, for the first probe call_rcu will be sched,

Sorry, I need to start proof reading my emails. s/sched/skipped/

thanks,

- Joel
