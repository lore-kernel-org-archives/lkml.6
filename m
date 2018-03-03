Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeCCMZu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 07:25:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbeCCMZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 07:25:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944A221782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 3 Mar 2018 21:25:45 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Yang Bo <yangbo@deepin.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH -tip] x86: kprobes: Cleanup preempt disabling and
 enabling
Message-Id: <20180303212545.8aa1ddb856975ffcac4672b5@kernel.org>
In-Reply-To: <20180303095823.phaoeuvcjhoirwg3@gmail.com>
References: <152004878307.12012.17534094592580782444.stgit@devbox>
        <20180303095823.phaoeuvcjhoirwg3@gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2018 10:58:23 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > +/*
> > + * Interrupts are disabled on entry as trap3 is an interrupt gate and they
> > + * remain disabled throughout this function.
> > + */
> > +int kprobe_int3_handler(struct pt_regs *regs)
> > +{
> > +	struct kprobe_ctlblk *kcb;
> > +	int ret;
> > +
> > +	if (user_mode(regs))
> > +		return 0;
> > +
> > +	/*
> > +	 * We don't want to be preempted for the entire
> > +	 * duration of kprobe processing.
> > +	 */
> > +	preempt_disable();
> > +
> > +	kcb = get_kprobe_ctlblk();
> > +	ret = kprobe_int3_dispatcher(regs, kcb);
> > +
> > +	if (!kprobe_ready_for_singlestep(regs))
> > +		preempt_enable_no_resched();
> > +
> > +	return ret;
> 
> What's the point of disabling preemption, if IRQs are disabled already?
> 
> There's no preemption when IRQs are off...

Ahh, right! Whole the kprobe singlestepping, IRQs are off (kprobes drops
IF from regs->flags for single stepping) so we don't need to care about
preempt count anymore...

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
