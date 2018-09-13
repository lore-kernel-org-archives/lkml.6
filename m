Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B77C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC9F20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UU9ADuox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC9F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeIMMPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:15:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeIMMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N/5C/eSkvq9wDSxmWyO/AV8RAlyLbGlkAF5j9oMFunI=; b=UU9ADuoxk8zQP8E4mZt7Kxul2
        llg5BJ4m9TzNJRigHc90ZVVaA80xLzxcF6mkUFSURI2hMwE2VYhyfC1Dam+/yYHXxicCHz0YV/UqN
        i1Vdxk9NPg0VsjVrHHaEofVP6dUjG8Doyf8q/eIYTmRU8L3LFQ1Tei97TnJROlooNt28v1SyQ9H9A
        H8qGfNrXYDQsutVr7HyMB7/rsADKEac/E6ng12PH9jzyIbxg64/6jXP1ZzzMzaaIeUoUz9KtrZ1Oo
        fXdN2ikXv6xnd1zIpY4hYuhxQqKrm8TUAs2gsfYT6Mz09A1MLH5PIBgQAKI5vcelnjDSo6aPr2Q44
        97T35OYCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0Lj5-0000eN-5C; Thu, 13 Sep 2018 07:07:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEED0202B2E3B; Thu, 13 Sep 2018 09:07:40 +0200 (CEST)
Date:   Thu, 13 Sep 2018 09:07:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] perf: Prevent recursion in ring buffer
Message-ID: <20180913070740.GT24124@hirez.programming.kicks-ass.net>
References: <20180912193317.10339-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912193317.10339-1-jolsa@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:33:17PM +0200, Jiri Olsa wrote:
> Some of the scheduling tracepoints allow the perf_tp_event
> code to write to ring buffer under different cpu than the
> code is running on.

ARGH.. that is indeed borken.

> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 4a9937076331..0c976ac414c5 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -101,6 +101,7 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
>  
>  out:
>  	preempt_enable();
> +	atomic_set(&rb->recursion, 0);
>  }
>  
>  static __always_inline bool
> @@ -145,6 +146,12 @@ __perf_output_begin(struct perf_output_handle *handle,
>  		goto out;
>  	}
>  
> +	if (atomic_cmpxchg(&rb->recursion, 0, 1) != 0) {
> +		if (rb->nr_pages)
> +			local_inc(&rb->lost);
> +		goto out;
> +	}
> +
>  	handle->rb    = rb;
>  	handle->event = event;
>  
> @@ -286,6 +293,7 @@ ring_buffer_init(struct ring_buffer *rb, long watermark, int flags)
>  		rb->overwrite = 1;
>  
>  	atomic_set(&rb->refcount, 1);
> +	atomic_set(&rb->recursion, 0);
>  
>  	INIT_LIST_HEAD(&rb->event_list);
>  	spin_lock_init(&rb->event_lock);

That's not a recursion count, that's a test-and-set spinlock, and you
got the memory ordering wrong for that.

Also, we tried very hard to avoid atomic ops in the ring-buffer and you
just wrecked that. Worse, you wrecked previously working interrupt
nesting output.

Let me have a look at this.

