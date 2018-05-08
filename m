Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755900AbeEHVLA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:11:00 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33031 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755342AbeEHVK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:10:59 -0400
X-Google-Smtp-Source: AB8JxZoXgRh+5Sel+bYyVEo6wHOStFBCIfvP3J6R5kv5bl3CMrH/fPSBdZX7sHvwWrum7vGQb7l9wg==
Date: Tue, 8 May 2018 14:10:57 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH RFC v6 4/5] tracepoint: Make rcuidle tracepoint callers
 use SRCU
Message-ID: <20180508211057.GA77668@joelaf.mtv.corp.google.com>
References: <20180507204143.13061-1-joelaf@google.com>
 <20180507204143.13061-5-joelaf@google.com>
 <568999860.209.1525727141943.JavaMail.zimbra@efficios.com>
 <20180507214611.GB13787@joelaf.mtv.corp.google.com>
 <581097661.279.1525739874243.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581097661.279.1525739874243.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 08:37:54PM -0400, Mathieu Desnoyers wrote:
> ----- On May 7, 2018, at 5:46 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:
> 
> > On Mon, May 07, 2018 at 05:05:41PM -0400, Mathieu Desnoyers wrote:
> >> ----- On May 7, 2018, at 4:41 PM, Joel Fernandes joelaf@google.com wrote:
> >> [...]
> >> > +extern struct srcu_struct tracepoint_srcu;
> >> > +
> >> > extern int
> >> > tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
> >> > extern int
> >> > @@ -77,6 +80,9 @@ int unregister_tracepoint_module_notifier(struct
> >> > notifier_block *nb)
> >> >  */
> >> > static inline void tracepoint_synchronize_unregister(void)
> >> > {
> >> > +#ifdef CONFIG_TRACEPOINTS
> >> > +	synchronize_srcu(&tracepoint_srcu);
> >> > +#endif
> >> > 	synchronize_sched();
> >> 
> >> Why is this ifdef needed ?
> > 
> > tracepoint_srcu is defined in tracepoint.c so if we don't protect usage here, it
> > would cause a build error.
> 
> Then we should ifdef the entire implementation of tracepoint_synchronize_unregister().
> There is no point in issuing synchronize_sched() when code invokes that
> function on a CONFIG_TRACEPOINTS=n config.

Ok I'll do it this way in the next rev. Could you also share any thoughts on
patch 6/6 if you had some time? Development of it has also been complete for
some time.

thanks,

- Joel
