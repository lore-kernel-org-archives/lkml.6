Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B19C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811F220862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811F220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbeHAVrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:47:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeHAVrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:47:07 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkxHX-0001RN-6B; Wed, 01 Aug 2018 21:59:39 +0200
Date:   Wed, 1 Aug 2018 21:59:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Erica Bugden <erica.bugden@linutronix.de>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        anna-maria@linutronix.de, bigeasy@linutronix.de
Subject: Re: [PATCH] ftrace: Add missing check for existing hwlat thread
In-Reply-To: <20180801154006.580806cc@gandalf.local.home>
Message-ID: <alpine.DEB.2.21.1808012151360.1835@nanos.tec.linutronix.de>
References: <1533120354-22923-1-git-send-email-erica.bugden@linutronix.de> <20180801154006.580806cc@gandalf.local.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Steven Rostedt wrote:

> On Wed,  1 Aug 2018 12:45:54 +0200
> Erica Bugden <erica.bugden@linutronix.de> wrote:
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
> > Signed-off-by: Erica Bugden <erica.bugden@linutronix.de>
> > ---
> >  kernel/trace/trace_hwlat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> > index d7c8e4e..2d9d36d 100644
> > --- a/kernel/trace/trace_hwlat.c
> > +++ b/kernel/trace/trace_hwlat.c
> > @@ -354,6 +354,9 @@ static int start_kthread(struct trace_array *tr)
> >  	struct task_struct *kthread;
> >  	int next_cpu;
> >  
> > +	if (hwlat_kthread)
> > +		return 0;
> > +
> 
> This looks like it is treating the symptom and not the disease.

My bad. We looked at the other instances of tracers and they all have
protection against this kind of call sequence ...


> >  	/* Just pick the first CPU on first iteration */
> >  	current_mask = &save_cpumask;
> >  	get_online_cpus();
> 
> Can you try this patch?
> 
> -- Steve
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 823687997b01..15862044db05 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7628,7 +7628,9 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
>  
>  	if (buffer) {
>  		mutex_lock(&trace_types_lock);
> -		if (val) {
> +		if (!!val == tracer_tracing_is_on(tr)) {
> +			val = 0; /* do nothing */
> +		} else if (val) {
>  			tracer_tracing_on(tr);
>  			if (tr->current_trace->start)
>  				tr->current_trace->start(tr);
> 
