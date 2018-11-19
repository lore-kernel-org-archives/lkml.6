Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA75C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D302089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IGpQKqMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D302089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbeKSXVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:21:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbeKSXVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5ODMqUXIxXlq8NQaGVEI5LGykRgTtYVNr5q1ok1UGiQ=; b=IGpQKqMkciwDKHo7ruv/LuIQU
        R43GWF+/4wGRLhswNCXDNsb3Qq4Z+SGGAZbaoSBN3AdPkwxiGGyK/PlFQRE3H2biKgaXMQlDZgjQs
        EP11ipfPrnYPDrDKXDQ5yEL/xft9VcnlD/nHtLo1GE9XEbZdstxoGlz5gluhVwKiFIqSpNJOfvLdt
        Lp2Vi6i2RqvfmeFcu2PTKPRMO0UMNOOGietR5lSuAQ5vZNIXiNFOd77P7WfenX1VImWCYu+ZGksE5
        gCdtS5v41FnhSPyUb2ClKsyDz58UeTI0+YTdQk0zdgtSc/fMBfX5nnRJSqaAyd8/+reROxKtQfHbU
        YbPQedCoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOj7w-0001gt-Nj; Mon, 19 Nov 2018 12:58:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41F0020298BFC; Mon, 19 Nov 2018 13:58:07 +0100 (CET)
Date:   Mon, 19 Nov 2018 13:58:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] perf/core: Add macro to test for event exclusion
 flags
Message-ID: <20181119125807.GD9761@hirez.programming.kicks-ass.net>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-2-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542363853-13849-2-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 10:24:04AM +0000, Andrew Murray wrote:
> Add a macro that tests if any of the perf event exclusion flags
> are set on a given event.

It is in fact an inline function, not a CPP macro.

> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  include/linux/perf_event.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f..89ee7fa 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1004,6 +1004,15 @@ perf_event__output_id_sample(struct perf_event *event,
>  extern void
>  perf_log_lost_samples(struct perf_event *event, u64 lost);
>  
> +static inline bool event_has_exclude_flags(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +
> +	return attr->exclude_idle || attr->exclude_user ||
> +	       attr->exclude_kernel || attr->exclude_hv ||
> +	       attr->exclude_guest || attr->exclude_host;
> +}
> +
>  static inline bool is_sampling_event(struct perf_event *event)
>  {
>  	return event->attr.sample_period != 0;
> -- 
> 2.7.4
> 
