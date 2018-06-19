Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F6EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C922083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C922083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937621AbeFSKwO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:52:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:20669 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936108AbeFSKwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:52:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 03:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="58905467"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2018 03:51:53 -0700
Received: from ash by um with local (Exim 4.91)
        (envelope-from <alexander.shishkin@linux.intel.com>)
        id 1fVEEp-00033J-LE; Tue, 19 Jun 2018 13:51:51 +0300
Date:   Tue, 19 Jun 2018 13:51:51 +0300
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
Message-ID: <20180619105151.w3hoymzmme57chzv@um.fi.intel.com>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
 <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
 <20180614192513.GX12217@hirez.programming.kicks-ass.net>
 <20180614193917.GJ12235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614193917.GJ12235@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 09:39:17PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 14, 2018 at 09:25:13PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 12, 2018 at 10:51:15AM +0300, Alexander Shishkin wrote:
> > > @@ -882,6 +890,7 @@ struct perf_sample_data {
> > >  	 */
> > >  	u64				addr;
> > >  	struct perf_raw_record		*raw;
> > > +	struct perf_aux_record		aux;
> > >  	struct perf_branch_stack	*br_stack;
> > >  	u64				period;
> > >  	u64				weight;
> > > @@ -933,6 +942,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
> > >  	/* remaining struct members initialized in perf_prepare_sample() */
> > >  	data->addr = addr;
> > >  	data->raw  = NULL;
> > > +	data->aux.from = data->aux.to = data->aux.size = 0;
> > >  	data->br_stack = NULL;
> > >  	data->period = period;
> > >  	data->weight = 0;
> > 
> > You just blew that cacheline...
> 
> And since the whole aux_sample thing seems to be purely prepare/output
> driven, I really don't see the need why this needs to be here. AFAICT it
> should just work fine in the other part of this structure.

Yes, this wasn't intentional. Will fix in the next round.

Regards,
--
Alex
