Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210A1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92482173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92482173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbeHCKlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:41:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39199 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeHCKlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:41:52 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=[10.100.21.79])
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <erica.bugden@linutronix.de>)
        id 1flVjD-0004OP-TL; Fri, 03 Aug 2018 10:46:32 +0200
Message-ID: <1533285974.2179.6.camel@linutronix.de>
Subject: Re: [PATCH] ftrace: Add missing check for existing hwlat thread
From:   Erica Bugden <erica.bugden@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, anna-maria@linutronix.de, bigeasy@linutronix.de
Date:   Fri, 03 Aug 2018 10:46:14 +0200
In-Reply-To: <20180801154006.580806cc@gandalf.local.home>
References: <1533120354-22923-1-git-send-email-erica.bugden@linutronix.de>
         <20180801154006.580806cc@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 15:40 -0400, Steven Rostedt wrote:
> On Wed,  1 Aug 2018 12:45:54 +0200
> > Erica Bugden <erica.bugden@linutronix.de> wrote:
> 
> > The hwlat tracer uses a kernel thread to measure latencies. The function
> > that creates this kernel thread, start_kthread(), can be called when the
> > tracer is initialized and when the tracer is explicitly enabled.
> > start_kthread() does not check if there is an existing hwlat kernel
> > thread and will create a new one each time it is called.
> > 
> > This causes the reference to the previous thread to be lost. Without the
> > thread reference, the old kernel thread becomes unstoppable and
> > continues to use CPU time even after the hwlat tracer has been disabled.
> > This problem can be observed when a system is booted with tracing
> > enabled and the hwlat tracer is configured like this:
> > 
> > 	echo hwlat > current_tracer; echo 1 > tracing_on
> > 
> > Add the missing check for an existing kernel thread in start_kthread()
> > to prevent this problem. This function and the rest of the hwlat kernel
> > thread setup and teardown are already serialized because they are called
> > through the tracer core code with trace_type_lock held.
> > 
> > > > Signed-off-by: Erica Bugden <erica.bugden@linutronix.de>
> > ---
> >  kernel/trace/trace_hwlat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> > index d7c8e4e..2d9d36d 100644
> > --- a/kernel/trace/trace_hwlat.c
> > +++ b/kernel/trace/trace_hwlat.c
> > @@ -354,6 +354,9 @@ static int start_kthread(struct trace_array *tr)
> > > >  	struct task_struct *kthread;
> > > >  	int next_cpu;
> >  
> > > > +	if (hwlat_kthread)
> > > > +		return 0;
> > +
> 
> This looks like it is treating the symptom and not the disease.
> 
> > > >  	/* Just pick the first CPU on first iteration */
> > > >  	current_mask = &save_cpumask;
> > > >  	get_online_cpus();
> 
> Can you try this patch?

I tested the patch below and it also fixes the problem.

> 
> -- Steve
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 823687997b01..15862044db05 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7628,7 +7628,9 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
>  
>  	if (buffer) {
>  		mutex_lock(&trace_types_lock);
> -		if (val) {
> +		if (!!val == tracer_tracing_is_on(tr)) {
> +			val = 0; /* do nothing */
> +		} else if (val) {
>  			tracer_tracing_on(tr);
>  			if (tr->current_trace->start)
>  				tr->current_trace->start(tr);
