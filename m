Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758299AbeD0Smb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 14:42:31 -0400
Received: from mail.efficios.com ([167.114.142.138]:42260 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757577AbeD0Sma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 14:42:30 -0400
Date: Fri, 27 Apr 2018 14:42:28 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Joel Fernandes <joelaf@google.com>
Cc: rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        fweisbec <fweisbec@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>,
        kernel-team <kernel-team@android.com>
Message-ID: <1612196617.5918.1524854548327.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAJWu+ore5pOF9Ld7H2K=Y4JZiRvy8T86MA+dN8-8BTHPCsau1w@mail.gmail.com>
References: <20180427042656.190746-1-joelaf@google.com> <1169911546.5820.1524839189395.JavaMail.zimbra@efficios.com> <20180427104747.2d965925@gandalf.local.home> <CAJWu+ortS=BQ98BSmExHPz_vQ6-rgcKQC7dhSR2_3e6714QVzA@mail.gmail.com> <20180427123759.0bc4b8de@gandalf.local.home> <CAJWu+ore5pOF9Ld7H2K=Y4JZiRvy8T86MA+dN8-8BTHPCsau1w@mail.gmail.com>
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks
 executing with preempt on
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: tracepoint: Introduce tracepoint callbacks executing with preempt on
Thread-Index: hDqheKS1TE59hH+N7DiwFmKPLeKWqg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 27, 2018, at 2:11 PM, Joel Fernandes joelaf@google.com wrote:

> On Fri, Apr 27, 2018 at 9:37 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> On Fri, 27 Apr 2018 09:30:05 -0700
>> Joel Fernandes <joelaf@google.com> wrote:
>>
>>> On Fri, Apr 27, 2018 at 7:47 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>>> > On Fri, 27 Apr 2018 10:26:29 -0400 (EDT)
>>> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>> >
>>> >> The general approach and the implementation look fine, except for
>>> >> one small detail: I would be tempted to explicitly disable preemption
>>> >> around the call to the tracepoint callback for the rcuidle variant,
>>> >> unless we plan to audit every tracer right away to remove any assumption
>>> >> that preemption is disabled in the callback implementation.
>>> >
>>> > I'm thinking that we do that audit. There shouldn't be many instances
>>> > of it. I like the idea that a tracepoint callback gets called with
>>> > preemption enabled.
>>>
>>> Here is the list of all callers of the _rcuidle :
>>
>> I was thinking of auditing who registers callbacks to any tracepoints.
> 
> Ok. If you feel strongly about this, I think for now I could also just
> wrap the callback execution with preempt_disable_notrace. And, when/if
> we get to doing the blocking callbacks work, we can considering
> keeping preempts on.

My main point here is to introduce the minimal change (keeping preemption
disabled) needed for the rcuidle variant, and only tackle the work of
dealing with preemptible callbacks when we really need it and when we can
properly test it (e.g. by using it for syscall entry/exit tracing).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
