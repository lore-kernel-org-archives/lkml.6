Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbeDYWv5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752661AbeDYWvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:51:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEFA21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 25 Apr 2018 18:51:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joelaf@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
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
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
Message-ID: <20180425185149.64f89922@vmware.local.home>
In-Reply-To: <1267842641.1791.1524692456344.JavaMail.zimbra@efficios.com>
References: <20180423172244.694dbc9d@gandalf.local.home>
        <20180424182623.GA1357@linux.vnet.ibm.com>
        <CAJWu+opC9pLxoiXq7QDRUDe6ouC4ij398bHCfnUwp+h7Y_ssDg@mail.gmail.com>
        <849066633.939.1524612064698.JavaMail.zimbra@efficios.com>
        <68e4c123-a223-5e26-e57a-da2515041bf3@google.com>
        <20180425001049.GX26088@linux.vnet.ibm.com>
        <20180425042056.GA21412@linux.vnet.ibm.com>
        <CAJWu+orWC=W0Jn2Jo7f+u5mbHMi+D1yuCmhD-xSgjWZ6Ynw32Q@mail.gmail.com>
        <1267842641.1791.1524692456344.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018 17:40:56 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> One problem with your approach is that you can have multiple callers
> for the same tracepoint name, where some could be non-preemptible and
> others blocking. Also, there is then no clear way for the callback
> registration API to enforce whether the callback expects the tracepoint
> to be blocking or non-preemptible. This can introduce hard to diagnose
> issues in a kernel without debug options enabled.

I agree that it should not be tied to an implementation name. But
"blocking" is confusing. I would say "can_sleep" or some such name that
states that the trace point caller is indeed something that can sleep.

> 
> Regarding the name, I'm OK with having something along the lines of
> trace_*event*_blocking or such. Please don't use "srcu" or other naming
> that is explicitly tied to the underlying mechanism used internally
> however: what we want to convey is that this specific tracepoint probe
> can be preempted and block. The underlying implementation could move to
> a different RCU flavor brand in the future, and it should not impact
> users of the tracepoint APIs.
> 
> In order to ensure that probes that may block only register themselves
> to tracepoints that allow blocking, we should introduce new tracepoint
> declaration/definition *and* registration APIs also contain the
> "BLOCKING/blocking" keywords (or such), so we can ensure that a
> tracepoint probe being registered to a "blocking" tracepoint is indeed
> allowed to block.

I'd really don't want to add more declaration/definitions, as we
already have too many as is, and with different meanings and the number
is of incarnations is n! in growth.

I'd say we just stick with a trace_<event>_can_sleep() call, and make
sure that if that is used that no trace_<event>() call is also used, and
enforce this with linker or compiler tricks.

-- Steve
