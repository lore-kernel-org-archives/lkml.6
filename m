Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF318C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9301E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9301E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937645AbeFSLAu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:00:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:34279 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937542AbeFSLAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:00:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 04:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="65365341"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2018 04:00:47 -0700
Received: from ash by um with local (Exim 4.91)
        (envelope-from <alexander.shishkin@linux.intel.com>)
        id 1fVENR-0004TQ-F0; Tue, 19 Jun 2018 14:00:45 +0300
Date:   Tue, 19 Jun 2018 14:00:44 +0300
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
Message-ID: <20180619110044.qid7jdgmgicvhn4u@um.fi.intel.com>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
 <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
 <20180614194720.GA12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614194720.GA12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 09:47:20PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 10:51:15AM +0300, Alexander Shishkin wrote:
> > @@ -6112,6 +6219,32 @@ void perf_prepare_sample(struct perf_event_header *header,
> >  
> >  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
> >  		data->phys_addr = perf_virt_to_phys(data->addr);
> > +
> > +	if (sample_type & PERF_SAMPLE_AUX) {
> > +		u64 size;
> > +
> > +		header->size += sizeof(u64); /* size */
> > +
> > +		/*
> > +		 * Given the 16bit nature of header::size, an AUX sample can
> > +		 * easily overflow it, what with all the preceding sample bits.
> > +		 * Make sure this doesn't happen by using up to U16_MAX bytes
> > +		 * per sample in total (rounded down to 8 byte boundary).
> > +		 */
> > +		size = min_t(size_t, U16_MAX - header->size,
> > +			     event->attr.aux_sample_size);
> > +		size = rounddown(size, 8);
> > +		size = perf_aux_sample_size(event, data, size);
> > +
> > +		WARN_ON_ONCE(size + header->size > U16_MAX);
> > +		header->size += size;
> > +	}
> > +	/*
> > +	 * If you're adding more sample types here, you likely need to do
> > +	 * something about the overflowing header::size, like repurpose the
> > +	 * lowest 3 bits of size, which should be always zero at the moment.
> > +	 */
> 
> Bugger yes.. I fairly quickly (but still too late) realized we should've
> used that u16 in u64 increments to allow up to 512K instead of 64K
> events.
>
> Still, even 64K samples are pretty terrifyingly huge. They'll be
> _sloowww_.
> 
> In any case, I suppose we can grab one of the attribute bits to rev. the
> output format -- a la sample_id_all. Do we really want to do that? 512K
> samples.... *shudder*.

Well, as far as PT goes, even a 4K sample carries a thousands of branches,
I can't imagine ever needing more than 64K, but I didn't really want to make
the call. Same goes for the width of aux_sample_size, which should match what
we can theoretically output.

Also as a thought, we could use the perf_adjust_period() to also reduce the
sample size dynamically if it takes too long to copy.

Regards,
--
Alex
