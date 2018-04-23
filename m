Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932429AbeDWVWx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932191AbeDWVWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:22:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6625321782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 23 Apr 2018 17:22:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joelaf@google.com>, Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <20180423172244.694dbc9d@gandalf.local.home>
In-Reply-To: <1212130312.14753.1524503541789.JavaMail.zimbra@efficios.com>
References: <20180417040748.212236-1-joelaf@google.com>
        <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com>
        <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com>
        <20180423031926.GF26088@linux.vnet.ibm.com>
        <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com>
        <20180423105325.7d5d245b@gandalf.local.home>
        <1045420715.14686.1524495583859.JavaMail.zimbra@efficios.com>
        <20180423121800.47b173af@gandalf.local.home>
        <1212130312.14753.1524503541789.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 13:12:21 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

 
> I'm inclined to explicitly declare the tracepoints with their given
> synchronization method. Tracepoint probe callback functions for currently
> existing tracepoints expect to have preemption disabled when invoked.
> This assumption will not be true anymore for srcu-tracepoints.

Actually, why not have a flag attached to the tracepoint_func that
states if it expects preemption to be enabled or not? If a
trace_##event##_srcu() is called, then simply disable preemption before
calling the callbacks for it. That way if a callback is fine for use
with srcu, then it would require calling

	register_trace_##event##_may_sleep();

Then if someone uses this on a tracepoint where preemption is disabled,
we simply do not call it.

-- Steve
