Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C97C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D01721712
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iBdyqmMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D01721712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeHXMfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:35:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeHXMfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6+OUCC7RnGRXvLq3d7cG1dIVzq3dw6UiWQI3xhlpWNc=; b=iBdyqmMUhjco1hqMTPRgavbaJ
        RKQtL2QJj9Wj0KgLbYfXqMd305qvgUNemHiBYzHQ2pujrVPMdLKYHx1wtLKIdJOmAjswce6pmlWiH
        RQtAgMq/vy5pgEWzP8z2Sqw31Xoq4SY/neKMAWoyxixkTblZplpt5gktUrBR21qPSS9rE5r+tB+Hr
        AZTZWi2Zr4InXd7zeThdReyC1h2q0UvBv7CeC5Er625noyGRSiHWHTS4Z7vJ3pqmECnzwr6mTV1/H
        UrzvOETSFz/5/MNV9PpZMqfJEoQv5SY3t3bQtV1ld5OCcfEzlJwGjG2fOXbKT2nnRKcnPSEl+1p4e
        zanzcUMIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ft7t3-0004mM-B2; Fri, 24 Aug 2018 08:57:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D30D202E65E0; Fri, 24 Aug 2018 10:56:01 +0200 (CEST)
Date:   Fri, 24 Aug 2018 10:56:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yabin Cui <yabinc@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Force USER_DS when recording user stack data.
Message-ID: <20180824085601.GM24124@hirez.programming.kicks-ass.net>
References: <20180823225935.27035-1-yabinc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823225935.27035-1-yabinc@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 03:59:35PM -0700, Yabin Cui wrote:
> Perf can record user stack data in response to a synchronous request, such
> as a tracepoint firing. If this happens under set_fs(KERNEL_DS), then we
> end up reading user stack data using __copy_from_user_inatomic() under
> set_fs(KERNEL_DS). I think this conflicts with the intention of using
> set_fs(KERNEL_DS). And it is explicitly forbidden by hardware on ARM64
> when both CONFIG_ARM64_UAO and CONFIG_ARM64_PAN are used.
> 
> So fix this by forcing USER_DS when recording user stack data.
> 
> Signed-off-by: Yabin Cui <yabinc@google.com>

Ingo, I think this wants a stable tag too; seems to be a corrolary of:

  88b0193d9418 ("perf/callchain: Force USER_DS when invoking perf_callchain_user()")

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/events/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2a62b96600ad..9bc047421e75 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5948,6 +5948,7 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
>  		unsigned long sp;
>  		unsigned int rem;
>  		u64 dyn_size;
> +		mm_segment_t fs;
>  
>  		/*
>  		 * We dump:
> @@ -5965,7 +5966,10 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
>  
>  		/* Data. */
>  		sp = perf_user_stack_pointer(regs);
> +		fs = get_fs();
> +		set_fs(USER_DS);
>  		rem = __output_copy_user(handle, (void *) sp, dump_size);
> +		set_fs(fs);
>  		dyn_size = dump_size - rem;
>  
>  		perf_output_skip(handle, rem);
> -- 
> 2.19.0.rc0.228.g281dcd1b4d0-goog
> 
