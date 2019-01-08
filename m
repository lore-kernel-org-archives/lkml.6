Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3325FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0704420660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m1g8T/hU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfAHSbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:31:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfAHSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UUOYjxSe1goPIEiXn1EOgrZmjCE8fiHJVtC1q2z0pSY=; b=m1g8T/hUZ9alnmvH/6/uhv098
        sxPGI2ne6ecZwcfl+Uj6+GHZ4u4UYlJ38kpbn0exf0SYR6p0wfD26BWd/AwVDeqROyTD44YbnKeO7
        fSwCRXFCliyCN24bSH3IBTkeYPUEEuIvpWKy4aVvvpfNxpW/SiS8ICOTS4jLLCJ5oa4YiBcjEZPJW
        sf7tFQn2aLoDbWsCZ+Mho1rsLxkdsMdUoC1rJGLEfZ9eoZi81k+eQ0Vdgg/y3NWXAOznYDoalsGKC
        AIuwZAxMJuhGEJb9dvXo5LTIs8r23WH+mQBbGGqffZBmjrWbuOUz/oQbOIJF/m5rH0aOwIX41rfR9
        25LrD1QVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggw9y-0001ZF-Iv; Tue, 08 Jan 2019 18:31:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB382202943F4; Tue,  8 Jan 2019 19:31:27 +0100 (CET)
Date:   Tue, 8 Jan 2019 19:31:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        acme@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v5 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Message-ID: <20190108183127.GB30894@hirez.programming.kicks-ass.net>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220182904.4193196-2-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:28:58AM -0800, Song Liu wrote:

> @@ -648,11 +649,18 @@ struct perf_event_mmap_page {
>   *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
>   *   PERF_RECORD_MISC_FORK_EXEC  - PERF_RECORD_FORK event (perf internal)
>   *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
> + *   PERF_RECORD_MISC_KSYMBOL_*  - PERF_RECORD_KSYMBOL event
>   */
>  #define PERF_RECORD_MISC_MMAP_DATA		(1 << 13)
>  #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
>  #define PERF_RECORD_MISC_FORK_EXEC		(1 << 13)
>  #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
> +
> +#define PERF_RECORD_MISC_KSYMBOL_UNREGISTER	(1 << 3)
> +#define PERF_RECORD_MISC_KSYMBOL_TYPE_MASK	(7 << 4)
> +#define PERF_RECORD_MISC_KSYMBOL_TYPE_UNKNOWN	(0 << 4)
> +#define PERF_RECORD_MISC_KSYMBOL_TYPE_BPF	(1 << 4)

So this gives us 8 possible types, of which 2 are claimed.

I suppose we already know of FTRACE_TRAMPOLINE and MODULE, which
accounts for half the space.

> +
>  /*
>   * These PERF_RECORD_MISC_* flags below are safely reused
>   * for the following events:
> @@ -965,6 +973,19 @@ enum perf_event_type {
>  	 */
>  	PERF_RECORD_NAMESPACES			= 16,
>  
> +	/*
> +	 * Record ksymbol register/unregister events:
> +	 *
> +	 * struct {
> +	 *	struct perf_event_header	header;
> +	 *	u64				addr;
> +	 *	u64				len;
> +	 *	char				name[];
> +	 *	struct sample_id		sample_id;
> +	 * };
> +	 */
> +	PERF_RECORD_KSYMBOL			= 17,

Do we really need u64 length? That is, are we willing to consider
symbols larger than 4G ?

Could we not reclaim the top 32 or 16 bits thereof for that type thing
instead of using a few misc bits?
