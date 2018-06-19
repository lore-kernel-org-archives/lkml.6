Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE87C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D82A2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D82A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937579AbeFSKrb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:47:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:18888 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937215AbeFSKr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:47:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 03:47:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="60405200"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by orsmga003.jf.intel.com with ESMTP; 19 Jun 2018 03:47:26 -0700
Received: from ash by um with local (Exim 4.91)
        (envelope-from <alexander.shishkin@linux.intel.com>)
        id 1fVEAX-0002rz-SI; Tue, 19 Jun 2018 13:47:25 +0300
Date:   Tue, 19 Jun 2018 13:47:25 +0300
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
Message-ID: <20180619104725.bqvs7uwzhb4ihyxy@um.fi.intel.com>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
 <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
 <20180614202022.GC12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614202022.GC12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:20:22PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 10:51:15AM +0300, Alexander Shishkin wrote:
> > +static unsigned long perf_aux_sample_size(struct perf_event *event,
> > +					  struct perf_sample_data *data,
> > +					  size_t size)
> > +{
> > +	struct perf_event *sampler = event->sample_event;
> > +	struct ring_buffer *rb;
> > +	int *disable_count;
> > +
> > +	data->aux.size = 0;
> > +
> > +	if (!sampler || READ_ONCE(sampler->state) != PERF_EVENT_STATE_ACTIVE)
> > +		goto out;
> > +
> > +	if (READ_ONCE(sampler->oncpu) != smp_processor_id())
> > +		goto out;
> 
> Should those not be WARNs ? If we allow a configuration where that is
> possible, we're doing it wrong I think.

Indeed, this shouldn't happen.

> > +	/*
> > +	 * Non-zero disable count here means that we, being the NMI
> > +	 * context, are racing with pmu::add, pmu::del or address filter
> > +	 * adjustment, which we want to avoid.
> > +	 */
> > +	disable_count = this_cpu_ptr(sampler->pmu->pmu_disable_count);
> > +	if (*disable_count)
> > +		goto out;
> > +
> > +	/* Re-enabled in perf_aux_sample_output() */
> > +	perf_pmu_disable(sampler->pmu);
> 
> This is disguisting..  and also broken I think. Imagine what happens
> when the NMI hits in middle of perf_pmu_enable(), right where count
> dropped to 0, but we've not yet done pmu->pmu_enable() yet.
> 
> Then we end up with a double disable and double enable.

True, we kind of tiptoe around that by not having ->pmu_enable() and
->pmu_disable() for PT.

> > +
> > +	rb = ring_buffer_get(sampler);
> > +	if (!rb) {
> > +		perf_pmu_enable(sampler->pmu);
> > +		goto out;
> > +	}
> > +
> > +	/* Restarted in perf_aux_sample_output() */
> > +	sampler->pmu->stop(sampler, PERF_EF_UPDATE);
> 
> More yuck...
> 
> You rreally should not be calling these pmu::methods, they're meant to
> be used from _interrupt_ not NMI context. Using them like this is asking
> for tons of trouble.

Right, the SW stuff may then race with event_function_call() stuff. Hmm.
For the HW stuff, I'm hoping that some kind of a sleight of hand may
suffice. Let me think some more.

> Why can't you just snapshot the current location and let the thing
> 'run' ?

Because the buffer will overwrite itself and the location will be useless.
We don't write the AUX data out in this 'mode' at all, only the samples,
which allows for much less data in the resulting perf.data, less work for
the consumer, less IO bandwidth etc, and as a bonus, no AUX-related
interrupts.

But actually, even to snapshot the location we need to stop the event.

> > +	data->aux.to = rb->aux_head;
> > +
> > +	size = min(size, perf_aux_size(rb));
> > +
> > +	if (data->aux.to < size)
> > +		data->aux.from = rb->aux_nr_pages * PAGE_SIZE + data->aux.to -
> > +			size;
> > +	else
> > +		data->aux.from = data->aux.to - size;
> > +	data->aux.size = ALIGN(size, sizeof(u64));
> > +	ring_buffer_put(rb);
> > +
> > +out:
> > +	return data->aux.size;
> > +}
> > +
> > +static void perf_aux_sample_output(struct perf_event *event,
> > +				   struct perf_output_handle *handle,
> > +				   struct perf_sample_data *data)
> > +{
> 
> > +	ring_buffer_put(rb);
> > +	sampler->pmu->start(sampler, 0);
> > +
> > +out_enable:
> > +	perf_pmu_enable(sampler->pmu);
> 
> More of that... really yuck stuff.
> 
> > +}
