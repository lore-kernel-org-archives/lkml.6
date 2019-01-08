Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF5CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A6B2063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iwdJtN8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbfAHTn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:43:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56218 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731966AbfAHTn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AUOfq+X9RJimQkb3B3mEHNGAavaLitn3Hl8uHiWIqCc=; b=iwdJtN8lmLFDvwKdHO8r4GiGb
        fgAolE2IgxlTVTE+Rd2Trs0thFfChaK+U+a7PHrbKyhxphfWuDoRPabef2F4f4BIokXB/kajx22g3
        eEXhl2mv34FzZ77oHG/KtQ1dS718Yy6DnwUN1bUkDGvvXPgPj9OMBIUk3TNNSNWjSIdn+/JS8W7zD
        w7SoZFiws0XwH5pYlCj8oOd6G85Fz26YrVW/uvQvky7uMZ8kfN3fiVhwXeeFIFb3cbetwySyp+FD5
        zUktCBUEsdpfPq2NoHVQEiRl/xKrD1747/u7FCUZvk4WSceEKvblUwf4wpIvVLae43+mfCtJ/vgUm
        pS7XcN15A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggxHL-0003mI-V5; Tue, 08 Jan 2019 19:43:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69A3520280192; Tue,  8 Jan 2019 20:43:10 +0100 (CET)
Date:   Tue, 8 Jan 2019 20:43:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20190108194310.GD1900@hirez.programming.kicks-ass.net>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108184116.GC30894@hirez.programming.kicks-ass.net>
 <77A478D9-F36F-443A-BBFD-F0C1FFE0DD90@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77A478D9-F36F-443A-BBFD-F0C1FFE0DD90@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 07:10:20PM +0000, Song Liu wrote:
> > On Jan 8, 2019, at 10:41 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Dec 20, 2018 at 10:29:00AM -0800, Song Liu wrote:
> >> @@ -986,9 +987,35 @@ enum perf_event_type {
> >> 	 */
> >> 	PERF_RECORD_KSYMBOL			= 17,
> >> 
> >> +	/*
> >> +	 * Record bpf events:
> >> +	 *  enum perf_bpf_event_type {
> >> +	 *	PERF_BPF_EVENT_UNKNOWN		= 0,
> >> +	 *	PERF_BPF_EVENT_PROG_LOAD	= 1,
> >> +	 *	PERF_BPF_EVENT_PROG_UNLOAD	= 2,
> >> +	 *  };
> >> +	 *
> >> +	 * struct {
> >> +	 *	struct perf_event_header	header;
> >> +	 *	u16				type;
> >> +	 *	u16				flags;
> >> +	 *	u32				id;
> >> +	 *	u8				tag[BPF_TAG_SIZE];
> >> +	 *	struct sample_id		sample_id;
> >> +	 * };
> >> +	 */
> >> +	PERF_RECORD_BPF_EVENT			= 18,
> >> +
> > 
> > Elsewhere today, I raised the point that by the time (however short
> > interval) userspace gets around to reading this event, the actual
> > program could be gone again.
> > 
> > In this case the program has been with us for a very short period
> > indeed; but it could still have generated some samples or otherwise
> > generated trace data.
> 
> Since we already have the separate KSYMBOL events, BPF_EVENT is only 
> required for advanced use cases, like annotation. So I guess missing 
> it for very-short-living programs should not be a huge problem?
> 
> > It was suggested to allow pinning modules/programs to avoid this
> > situation, but that of course has other undesirable effects, such as a
> > trivial DoS.
> > 
> > A truly horrible hack would be to include an open filedesc in the event
> > that needs closing to release the resource, but I'm sorry for even
> > suggesting that **shudder**.
> > 
> > Do we have any sane ideas?
> 
> How about we gate the open filedesc solution with an option, and limit
> that option for root only? If this still sounds hacky, maybe we should
> just ignore when short-living programs are missed?

I'm afraid we might also 'need' this for the kallsym thing.

The problem is that things like Intel PT (ARM Coresight too IIRC) encode
a bitstream of branch-taken decisions. The only way to decode that and
reconstruct the actual code-flow is with an exact matching text image.

In order to have this matching text we need to be able to copy out every
piece of dynamic text (from kcore) that has ever executed before it
dissapears.

Elsewhere (*), Andi suggests to have a kind of text-free fence
interface, where userspace can call a complete. And I suppose as long we
know there is a consumer, we also know we'll not be blocked
indefinitely. So it would have to be slightly more complicated than
suggested, but I think that is something we could work with.

It would also not complicate these events.



[*] https://lkml.kernel.org/r/20190108172721.GN6118@tassilo.jf.intel.com
