Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E911C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CEF2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbfBMNtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:49:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:58180 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfBMNtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:49:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 05:49:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="299421505"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
  by orsmga005.jf.intel.com with ESMTP; 13 Feb 2019 05:49:06 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mgorman@techsingularity.net
Subject: Re: [PATCH v0 1/2] perf: Add an option to ask for high order allocations for AUX buffers
In-Reply-To: <20190213130755.GQ32494@hirez.programming.kicks-ass.net>
References: <20190213114716.63972-1-alexander.shishkin@linux.intel.com> <20190213114716.63972-2-alexander.shishkin@linux.intel.com> <20190213130755.GQ32494@hirez.programming.kicks-ass.net>
Date:   Wed, 13 Feb 2019 15:49:06 +0200
Message-ID: <87a7izer3h.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Feb 13, 2019 at 01:47:15PM +0200, Alexander Shishkin wrote:
>> Currently, the AUX buffer allocator will use high-order allocations
>> for PMUs that don't support hardware scatter-gather chaining to ensure
>> large contiguous blocks of pages, and always use an array of single
>> pages otherwise.
>> 
>> There is, however, a tangible performance benefit in using larger chunks
>> of contiguous memory even in the latter case, that comes from not having
>> to fetch the next page's address at every page boundary. In particular,
>> a task running under Intel PT on an Atom CPU shows 1.5%-2% less runtime
>> penalty with a single multi-page output region in snapshot mode (no PMI)
>> than with multiple single-page output regions, from ~6% down to ~4%. For
>> the snapshot mode it does make a difference as it is intended to run over
>> long periods of time.
>> 
>> Following the above justification, add an attribute bit to ask for a
>> high-order AUX allocation. To prevent an unprivileged user from using up
>> the higher orders of the page allocator, require CAP_SYS_ADMIN for this
>> option.
>
> Why do we need a knob for that? Last time I checked unpriv users could
> fragment the page allocator just fine. What is there to protect?
>
> Also, since we return all pages upon buffer free, the page allocator
> should in fact re-construct the high order stuff.
>
> So a buffer alloc + free, using high order pages, should be an effective
> nop on high order availability.
>
> Unlike spraying dentries or whatever works these days around the
> machine.

Good point. My worry is that since it's 'snapshot' mode, the buffer(s)
will be around potentially for a long time. Otherwise, I'd also prefer
to drop the capability wall.

Thanks,
--
Alex
