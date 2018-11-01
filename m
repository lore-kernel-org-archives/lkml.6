Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E01C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5AF20830
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbbLmY2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5AF20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeKARIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbeKARIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:08:04 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA97A20657;
        Thu,  1 Nov 2018 08:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541059567;
        bh=37AC+1QUQ+1GXAGsSdLB6oBTJsZ9erE1m1OcpnzizpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sbbLmY2kujPWvipmCr0E8/qIXtCmjBN4wQTfsAjEgQs7nSCFkSsYxnt6iDLGBZp8q
         LtYvDX4gziuYt3TgoiBKzNIcwyri9dwWYzQ/yMf04E2TyMCesnHJpA5TElcJSi7uPi
         6h9gVa0UF2uuXi1xFphoS61VvogXBpeRMRbMzzaA=
Date:   Thu, 1 Nov 2018 17:06:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kretprobe: produce sane stack traces
Message-Id: <20181101170602.76ec2b8735192226df154638@kernel.org>
In-Reply-To: <20181030031953.5petvkbt45adewdt@yavin>
References: <20181026132210.12569-1-cyphar@cyphar.com>
        <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
        <20181030031953.5petvkbt45adewdt@yavin>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 14:19:53 +1100
Aleksa Sarai <cyphar@cyphar.com> wrote:

> On 2018-10-30, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > Historically, kretprobe has always produced unusable stack traces
> > > (kretprobe_trampoline is the only entry in most cases, because of the
> > > funky stack pointer overwriting). This has caused quite a few annoyances
> > > when using tracing to debug problems[1] -- since return values are only
> > > available with kretprobes but stack traces were only usable for kprobes,
> > > users had to probe both and then manually associate them.
> > 
> > Yes, this unfortunately still happens. I once tried to fix it by
> > replacing current "kretprobe instance" with graph-tracer's per-thread
> > return stack. (https://lkml.org/lkml/2017/8/21/553)
> 
> I played with graph-tracer a while ago and it didn't appear to have
> associated return values? Is this hidden somewhere or did I just miss
> it?

Graph tracer just doesn't trace it. We still can access it.

> 
> > I still believe that direction is the best solution to solve this kind
> > of issues, otherwise, we have to have 2 different stack fixups for
> > kretprobe and ftrace graph tracer. (I will have a talk with Steve at
> > plumbers next month)
> 
> I'm definitely :+1: on removing the duplication of the stack fixups, my
> first instinct was to try to refactor all of the stack_trace code so
> that we didn't have multiple arch-specific "get the stack trace" paths
> (and so we could generically add current_kretprobe_instance() to one
> codepath). But after looking into it, I was convinced this would be more
> than a little ugly to do.

Yes, it would take a time to fix it up all, but should be done.

> > > With the advent of bpf_trace, users would have been able to do this
> > > association in bpf, but this was less than ideal (because
> > > bpf_get_stackid would still produce rubbish and programs that didn't
> > > know better would get silly results). The main usecase for stack traces
> > > (at least with bpf_trace) is for DTrace-style aggregation on stack
> > > traces (both entry and exit). Therefore we cannot simply correct the
> > > stack trace on exit -- we must stash away the stack trace and return the
> > > entry stack trace when it is requested.
> > > 
> > > In theory, patches like commit 76094a2cf46e ("ftrace: distinguish
> > > kretprobe'd functions in trace logs") are no longer necessary *for
> > > tracing* because now all kretprobe traces should produce sane stack
> > > traces. However it's not clear whether removing them completely is
> > > reasonable.
> > 
> > Then, let's try to revert it :)
> 
> Sure. :P
> 
> > BTW, could you also add a test case for ftrace too?
> > also, I have some comments below.
> 
> Yup, will do.
> 
> > > +#define KRETPROBE_TRACE_SIZE 1024
> > > +struct kretprobe_trace {
> > > +	int nr_entries;
> > > +	unsigned long entries[KRETPROBE_TRACE_SIZE];
> > > +};
> > 
> > Hmm, do we really need all entries? It takes 8KB for each instances.
> > Note that the number of instances can be big if the system core number
> > is larger.
> 
> Yeah, you're right this is too large for a default.
> 
> But the problem is that we need it to be large enough for any of the
> tracers to be happy -- otherwise we'd have to dynamically allocate it
> and I had a feeling this would be seen as a Bad Idea™ in the kprobe
> paths.

Note that we can skip if it is not enough with just nmissed+1

> 
>   * ftrace uses PAGE_SIZE/sizeof(u64) == 512 (on x86_64).
>   * perf_events (and thus BPF) uses 127 as the default but can be
>     configured via sysctl -- and thus can be unbounded.
>   * show_stack(...) doesn't appear to have a limit, but I might just be
>     misreading the x86-specific code.
> 
> As mentioned above, the lack of consensus on a single structure for
> storing stack traces also means that there is a lack of consensus on
> what the largest reasonable stack is.
> 
> But maybe just doing 127 would be "reasonable"?

Yeah, I think that is reasonable size.

> 
> (Athough, dynamically allocating would allow us to just use 'struct
> stack_trace' directly without needing to embed a different structure.)
> 
> > > +	hlist_for_each_entry_safe(iter, next, head, hlist) {
> > 
> > Why would you use "_safe" variant here? if you don't modify the hlist,
> > you don't need to use it.
> 
> Yup, my mistake.
> 
> > > +void kretprobe_save_stack_trace(struct kretprobe_instance *ri,
> > > +				struct stack_trace *trace)
> > > +{
> > > +	int i;
> > > +	struct kretprobe_trace *krt = &ri->entry;
> > > +
> > > +	for (i = trace->skip; i < krt->nr_entries; i++) {
> > > +		if (trace->nr_entries >= trace->max_entries)
> > > +			break;
> > > +		trace->entries[trace->nr_entries++] = krt->entries[i];
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL_GPL(kretprobe_save_stack_trace);
> > > +
> > > +void kretprobe_perf_callchain_kernel(struct kretprobe_instance *ri,
> > > +				     struct perf_callchain_entry_ctx *ctx)
> > > +{
> > > +	int i;
> > > +	struct kretprobe_trace *krt = &ri->entry;
> > > +
> > > +	for (i = 0; i < krt->nr_entries; i++) {
> > > +		if (krt->entries[i] == ULONG_MAX)
> > > +			break;
> > > +		perf_callchain_store(ctx, (u64) krt->entries[i]);
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL_GPL(kretprobe_perf_callchain_kernel);
> > 
> > 
> > Why do we need to export these functions?
> 
> That's a good question -- I must've just banged out the EXPORT
> statements without thinking. I'll remove them in v2.

OK.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
