Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA55C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F4C242EB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WQ3DrqjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F4C242EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeGBPrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:47:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48046 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeGBPrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BzFfbEMn8OWf/4jxRFqZIJRUfdxPz/cpk4a9QwtqOAo=; b=WQ3DrqjEJqbhwmAJsGPXRPTAP
        V36f7IWti7I59q8JMFSNLNOg2jGnV3M7wIGLXPYVRJgkZ1J+PkFIkZwbVbsOy5Rzk+Tnhxa/XARxd
        EQh9qJsWwyZSn8hwuqo5EqAF6KUuDcLq1tYTYvK3uEOH1j64/8fmvbLNKpJmXss3VRdOetsCW6d/y
        x4mhCGkbbD1GdKzoQfNTaGihPpfQmNJVEVOA4ocrNF7YIDTcxceCwms+831/qAhj32SzmSK2XpZPX
        QDziGvOxQbA6gyVq1cJnWFEDqgBpb3A2gthU4A1n2aR3Ebc5IHY8xVis+km1mwjzcx+NhwXyinS3J
        zFlqWUL8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa12W-0000nh-MJ; Mon, 02 Jul 2018 15:46:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EEB52029F1DB; Mon,  2 Jul 2018 17:46:55 +0200 (CEST)
Date:   Mon, 2 Jul 2018 17:46:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>, boris.ostrovsky@oracle.com
Subject: Re: [RFC PATCH] perf/core: don't sample kernel regs upon skid
Message-ID: <20180702154655.GR2494@hirez.programming.kicks-ass.net>
References: <20180702151250.14536-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702151250.14536-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 04:12:50PM +0100, Mark Rutland wrote:
> Users can request that general purpose registers, instruction pointer,
> etc, are sampled when a perf event counter overflows. To try to avoid
> this resulting in kernel state being leaked, unprivileged users are
> usually forbidden from opening events which count while the kernel is
> running.
> 
> Unfortunately, this is not sufficient to avoid leading kernel state.

'leaking' surely.

> 
> For various reasons, there can be a delay between the overflow occurring
> and the resulting overflow exception (e.g. an NMI) being taken. During
> this window, other instructions may be executed, resulting in skid.
> 
> This skid means that a userspace-only event overflowing may result in an
> exception being taken *after* entry to the kernel, allowing kernel
> registers to be sampled. Depending on the amount of skid, this may only
> leak the PC (breaking KASLR), or it may leak secrets which are currently
> live in GPRs.
> 
> Let's avoid this by only sampling from the user registers when an event
> is supposed to exclude the kernel, providing the illusion that the
> overflow exception is taken from userspace.
> 
> We also have similar cases when sampling a guest, where we get the host
> regs in some cases. It's not entirely clear to me how we should handle
> these.

Would not a similar:

	if ((event->attr.exclude_hv || event->attr.exclude_host) /* WTF both !? */ &&
	    perf_guest_cbs && !perf_guest_cbs->is_in_guest())
		return perf_guest_cbs->guest_pt_regs();

work there? Of course, perf_guest_info_callbacks is currently lacking
that guest_pt_regs() thingy..

> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/events/core.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8f0434a9951a..2ab2548b2e66 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6361,6 +6361,32 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  	return callchain ?: &__empty_callchain;
>  }
>  
> +static struct pt_regs *perf_get_sample_regs(struct perf_event *event,
> +					    struct pt_regs *regs)
> +{
> +	/*
> +	 * Due to interrupt latency (AKA "skid"), we may enter the kernel
> +	 * before taking an overflow, even if the PMU is only counting user
> +	 * events.
> +	 *
> +	 * If we're not counting kernel events, always use the user regs when
> +	 * sampling.
> +	 *
> +	 * TODO: what do we do about sampling a guest's registers? The IP is
> +	 * special-cased, but for the rest of the regs they'll get the
> +	 * user/kernel regs depending on whether exclude_kernel is set, which
> +	 * is nonsensical.
> +	 *
> +	 * We can't get at the full set of regs in all cases (e.g. Xen's PV PMU
> +	 * can't provide the GPRs), so should we just zero the GPRs when in a
> +	 * guest? Or skip outputting the regs in perf_output_sample?

Seems daft Xen cannot provide registers; why is that? Boris?

> +	 */
> +	if (event->attr.exclude_kernel && !user_mode(regs))
> +		return task_pt_regs(current);
> +
> +	return regs;
> +}
> +
>  void perf_prepare_sample(struct perf_event_header *header,
>  			 struct perf_sample_data *data,
>  			 struct perf_event *event,
> @@ -6368,6 +6394,8 @@ void perf_prepare_sample(struct perf_event_header *header,
>  {
>  	u64 sample_type = event->attr.sample_type;
>  
> +	regs = perf_get_sample_regs(event, regs);
> +
>  	header->type = PERF_RECORD_SAMPLE;
>  	header->size = sizeof(*header) + event->header_size;

In any case ACK for this thing.
