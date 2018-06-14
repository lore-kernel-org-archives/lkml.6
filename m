Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2CCCBC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C9E208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PXPyDfVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C9E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755444AbeFNUUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:20:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755445AbeFNUU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BKs/pfWgY7S2iC3E/B9MiX8IAm9Frpv56L6xt7IKEzY=; b=PXPyDfVU62VGVOCNzFnrEt/jv
        ptmNwRVxE1sUaFqDy0b1aQPjrOZCaeaJ25eAPeaj4eLVT3h3tNvqoIUSColLqsxn4S4gcr7Y+makz
        enGMtSwGx8+rwn0ErXVgkZUac6KJHQ0mtaGLZ/jII3a34Z7asJj9iGec7fFRR8aXep2Jker3Caen1
        h//MngEyRogw1BABZNtPknaeysaUBND1GbzhHL2sHYWbQLy+lvGwggOtNCXR3TFPAUam7/aGhxWEj
        Dz2Lv7Lwi2Sy7ag/RbnggCuzCu8uMkiPOP+pCPtuxYMWmLd2r0bg0makT43aBMSt2Xis8r60pYIS9
        jomccptdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTYjJ-0002u9-0O; Thu, 14 Jun 2018 20:20:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF8DA201EA7C9; Thu, 14 Jun 2018 22:20:22 +0200 (CEST)
Date:   Thu, 14 Jun 2018 22:20:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
Message-ID: <20180614202022.GC12217@hirez.programming.kicks-ass.net>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
 <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:51:15AM +0300, Alexander Shishkin wrote:
> +static unsigned long perf_aux_sample_size(struct perf_event *event,
> +					  struct perf_sample_data *data,
> +					  size_t size)
> +{
> +	struct perf_event *sampler = event->sample_event;
> +	struct ring_buffer *rb;
> +	int *disable_count;
> +
> +	data->aux.size = 0;
> +
> +	if (!sampler || READ_ONCE(sampler->state) != PERF_EVENT_STATE_ACTIVE)
> +		goto out;
> +
> +	if (READ_ONCE(sampler->oncpu) != smp_processor_id())
> +		goto out;

Should those not be WARNs ? If we allow a configuration where that is
possible, we're doing it wrong I think.

> +	/*
> +	 * Non-zero disable count here means that we, being the NMI
> +	 * context, are racing with pmu::add, pmu::del or address filter
> +	 * adjustment, which we want to avoid.
> +	 */
> +	disable_count = this_cpu_ptr(sampler->pmu->pmu_disable_count);
> +	if (*disable_count)
> +		goto out;
> +
> +	/* Re-enabled in perf_aux_sample_output() */
> +	perf_pmu_disable(sampler->pmu);

This is disguisting..  and also broken I think. Imagine what happens
when the NMI hits in middle of perf_pmu_enable(), right where count
dropped to 0, but we've not yet done pmu->pmu_enable() yet.

Then we end up with a double disable and double enable.

> +
> +	rb = ring_buffer_get(sampler);
> +	if (!rb) {
> +		perf_pmu_enable(sampler->pmu);
> +		goto out;
> +	}
> +
> +	/* Restarted in perf_aux_sample_output() */
> +	sampler->pmu->stop(sampler, PERF_EF_UPDATE);

More yuck...

You rreally should not be calling these pmu::methods, they're meant to
be used from _interrupt_ not NMI context. Using them like this is asking
for tons of trouble.

Why can't you just snapshot the current location and let the thing
'run' ?

> +	data->aux.to = rb->aux_head;
> +
> +	size = min(size, perf_aux_size(rb));
> +
> +	if (data->aux.to < size)
> +		data->aux.from = rb->aux_nr_pages * PAGE_SIZE + data->aux.to -
> +			size;
> +	else
> +		data->aux.from = data->aux.to - size;
> +	data->aux.size = ALIGN(size, sizeof(u64));
> +	ring_buffer_put(rb);
> +
> +out:
> +	return data->aux.size;
> +}
> +
> +static void perf_aux_sample_output(struct perf_event *event,
> +				   struct perf_output_handle *handle,
> +				   struct perf_sample_data *data)
> +{

> +	ring_buffer_put(rb);
> +	sampler->pmu->start(sampler, 0);
> +
> +out_enable:
> +	perf_pmu_enable(sampler->pmu);

More of that... really yuck stuff.

> +}
