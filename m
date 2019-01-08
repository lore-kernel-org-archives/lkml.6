Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83F9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9699206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o9QtRb9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfAHSlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:41:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHSlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k3q5e+E94nl+9Epjzj2dLoN5vF7c1pT+UyEjHMtEg1c=; b=o9QtRb9TzNzRBp2YEnjkrlSGS
        lcRjB/tqOuUZsOZUL7q82G7xCsxPukyzD7OoMme0i9GXQ5n7b9DEZ+yMi7PD/2LLxanfS3ZUoNtTq
        geS4gfI9v5UoqWTSgCXqDJjFYL+d8MePYDXKX1odQZKjW3A7+T7Ff6vH0esYJdBT44j/UIEBKzFsW
        vyCLXtu/9QyTQEFYr/rI/oByEcPg/jF77U9CdJGfo/ESkhpWFRtcKaOpBLDQzxhaIU5MX3AJUGddH
        2urlwrxozCwbxokc7bvKXfAg6buEf6kxrbdFXvqJfTjSZzsBzNjH8zmgw6EtMj/D5wpLkgo/QUISX
        vvtFxlkEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggwJS-0005fZ-5L; Tue, 08 Jan 2019 18:41:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3B12202943F4; Tue,  8 Jan 2019 19:41:16 +0100 (CET)
Date:   Tue, 8 Jan 2019 19:41:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        acme@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20190108184116.GC30894@hirez.programming.kicks-ass.net>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220182904.4193196-4-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:29:00AM -0800, Song Liu wrote:
> @@ -986,9 +987,35 @@ enum perf_event_type {
>  	 */
>  	PERF_RECORD_KSYMBOL			= 17,
>  
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
> +	 *	struct sample_id		sample_id;
> +	 * };
> +	 */
> +	PERF_RECORD_BPF_EVENT			= 18,
> +

Elsewhere today, I raised the point that by the time (however short
interval) userspace gets around to reading this event, the actual
program could be gone again.

In this case the program has been with us for a very short period
indeed; but it could still have generated some samples or otherwise
generated trace data.

It was suggested to allow pinning modules/programs to avoid this
situation, but that of course has other undesirable effects, such as a
trivial DoS.

A truly horrible hack would be to include an open filedesc in the event
that needs closing to release the resource, but I'm sorry for even
suggesting that **shudder**.

Do we have any sane ideas?
