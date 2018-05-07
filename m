Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbeEGVqN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:46:13 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43717 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeEGVqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:46:12 -0400
X-Google-Smtp-Source: AB8JxZrq4BQAGzzzebUJzs0KFeosMopN74VP1kEGf+T2v8Kbu3fYf0wdl3p+GfKYTs4QjSPsXRTzng==
Date: Mon, 7 May 2018 14:46:11 -0700
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
Message-ID: <20180507214611.GB13787@joelaf.mtv.corp.google.com>
References: <20180507204143.13061-1-joelaf@google.com>
 <20180507204143.13061-5-joelaf@google.com>
 <568999860.209.1525727141943.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568999860.209.1525727141943.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 05:05:41PM -0400, Mathieu Desnoyers wrote:
> ----- On May 7, 2018, at 4:41 PM, Joel Fernandes joelaf@google.com wrote:
> [...]
> > +extern struct srcu_struct tracepoint_srcu;
> > +
> > extern int
> > tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
> > extern int
> > @@ -77,6 +80,9 @@ int unregister_tracepoint_module_notifier(struct
> > notifier_block *nb)
> >  */
> > static inline void tracepoint_synchronize_unregister(void)
> > {
> > +#ifdef CONFIG_TRACEPOINTS
> > +	synchronize_srcu(&tracepoint_srcu);
> > +#endif
> > 	synchronize_sched();
> 
> Why is this ifdef needed ?

tracepoint_srcu is defined in tracepoint.c so if we don't protect usage here, it
would cause a build error.

thanks,

- Joel
