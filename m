Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758522AbeD0QNf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758236AbeD0QNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:13:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1397921893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 27 Apr 2018 12:13:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks
 executing with preempt on
Message-ID: <20180427121330.40b7ef15@gandalf.local.home>
In-Reply-To: <20180427155701.GL26088@linux.vnet.ibm.com>
References: <20180427042656.190746-1-joelaf@google.com>
        <20180427155701.GL26088@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018 08:57:01 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > +		if (preempt_on) {					\
> > +			WARN_ON_ONCE(in_nmi()); /* no srcu from nmi */	\  
> 
> Very good on this check, thank you!

I think you need to return and not call the read lock.

			if (WARN_ON_ONCE(in_nmi()))
				return;

> 
> > +			idx = srcu_read_lock(&tracepoint_srcu);         \  
> 
> Hmmm...  Do I need to create a _notrace variant of srcu_read_lock()
> and srcu_read_unlock()?

I think so.

-- Steve

> 
> > +			it_func_ptr = srcu_dereference((tp)->funcs,	\
> > +						&tracepoint_srcu);	\
> > +		} else {						\
> > +			rcu_read_lock_sched_notrace();			\
> > +			it_func_ptr =					\
> > +				rcu_dereference_sched((tp)->funcs);	\
> > +		}							\
> > +									\
