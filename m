Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5DBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9BA20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AGkkCO8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfAQNJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:09:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfAQNJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F9lFvUgpC9otS0kOpoLTOT92XFf/uctbZHhmkIFvays=; b=AGkkCO8wC7fd5bZ1dJw9TbzLG
        b1Xs0DC4ml0fkIW+B6m6HhGIOOEoCky3dktXr2Ptm8Y7GjXXenNZ+wAOR04BMbReInTnOKlScUqye
        c1kTBnK6PvkWpRgbPvWdkBhEUGc4FHoO+k1ZOSkDCcGkKjOMPppD1SuXUKy3z6Q718cY7LKSTQkKa
        Q/Um92B35f8KguZ3gR6gSg7mRHqQ7Tjg20gfdH2K+eKxh3C+IT0bZRtVJpuEfGvCrW1q+qj9R7UwF
        VTprqBfse6slKD/ALK8+YcCZNg26ocEu0MgNAgY69LAiJvw6BuTHIw3i2CKij435cP4WW83YtJ+p/
        9onYOXaLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk7Qg-0006NI-FL; Thu, 17 Jan 2019 13:09:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9753202647CE; Thu, 17 Jan 2019 14:09:52 +0100 (CET)
Date:   Thu, 17 Jan 2019 14:09:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        acme@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, dsahern@gmail.com
Subject: Re: [PATCH v10 perf, bpf-next 3/9] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20190117130952.GG10486@hirez.programming.kicks-ass.net>
References: <20190116162931.1542429-1-songliubraving@fb.com>
 <20190116162931.1542429-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116162931.1542429-4-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 08:29:25AM -0800, Song Liu wrote:
> +	/*
> +	 * Record bpf events:
> +	 *  enum perf_bpf_event_type {
> +	 *	PERF_BPF_EVENT_UNKNOWN		= 0,
> +	 *	PERF_BPF_EVENT_PROG_LOAD	= 1,
> +	 *	PERF_BPF_EVENT_PROG_UNLOAD	= 2,
> +	 *  };
> +	 *
> +	 * struct {
> +	 *	struct perf_event_header	header;
> +	 *	u16				type;
> +	 *	u16				flags;
> +	 *	u32				id;
> +	 *	u8				tag[BPF_TAG_SIZE];

This does forever fix BPF_TAG_SIZE; is that intentional? We could easily
make that a variable length field like with the other event. Or is that
value already part of the eBPF ABI?

> +	 *	struct sample_id		sample_id;
> +	 * };
> +	 */
> +	PERF_RECORD_BPF_EVENT			= 18,
> @@ -7744,6 +7747,121 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
>  	WARN_ONCE(1, "%s: Invalid KSYMBOL type 0x%x\n", __func__, ksym_type);
>  }
>  
> +struct perf_bpf_event {
> +	struct bpf_prog	*prog;
> +	struct {
> +		struct perf_event_header        header;
> +		u16				type;
> +		u16				flags;
> +		u32				id;
> +		u8				tag[BPF_TAG_SIZE];
> +	} event_id;
> +};

> +static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
> +					 enum perf_bpf_event_type type)
> +{
> +	bool unregister = type == PERF_BPF_EVENT_PROG_UNLOAD;
> +	int i;
> +
> +	if (prog->aux->func_cnt == 0) {
> +		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
> +				   (u64)(unsigned long)prog->bpf_func,
> +				   prog->jited_len, unregister,
> +				   perf_event_bpf_get_name, prog);
> +	} else {
> +		for (i = 0; i < prog->aux->func_cnt; i++) {
> +			struct bpf_prog *subprog = prog->aux->func[i];
> +
> +			perf_event_ksymbol(
> +				PERF_RECORD_KSYMBOL_TYPE_BPF,
> +				(u64)(unsigned long)subprog->bpf_func,
> +				subprog->jited_len, unregister,
> +				perf_event_bpf_get_name, subprog);
> +		}
> +	}
> +}

I still think this is a weird place to do this.. :-) See them patches I
just send.

> +void perf_event_bpf_event(struct bpf_prog *prog,
> +			  enum perf_bpf_event_type type,
> +			  u16 flags)
> +{
> +	struct perf_bpf_event bpf_event;
> +
> +	if (type <= PERF_BPF_EVENT_UNKNOWN ||
> +	    type >= PERF_BPF_EVENT_MAX)
> +		return;
> +
> +	switch (type) {
> +	case PERF_BPF_EVENT_PROG_LOAD:
> +	case PERF_BPF_EVENT_PROG_UNLOAD:
> +		if (atomic_read(&nr_ksymbol_events))
> +			perf_event_bpf_emit_ksymbols(prog, type);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!atomic_read(&nr_bpf_events))
> +		return;
> +
> +	bpf_event = (struct perf_bpf_event){
> +		.prog = prog,
> +		.event_id = {
> +			.header = {
> +				.type = PERF_RECORD_BPF_EVENT,
> +				.size = sizeof(bpf_event.event_id),
> +			},
> +			.type = type,
> +			.flags = flags,
> +			.id = prog->aux->id,
> +		},
> +	};

	BUILD_BUG_ON(BPF_TAG_SIZE % sizeof(u64));

> +	memcpy(bpf_event.event_id.tag, prog->tag, BPF_TAG_SIZE);
> +	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
> +}

Anyway, small nits only:

Acked-by: Peter Zijlstra (Intel) <peterz@infradeaed.org>
