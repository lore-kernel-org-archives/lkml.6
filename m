Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA04C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADF1214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EJjAgKPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfA2JiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:38:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56312 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfA2JiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/56xF6oLfxBmXgnzr3HBj0IOJtYizlwY+A20yEDsDUE=; b=EJjAgKPrd72y8UvlmQ6giHTSb
        kYP0ZJOh+i7vazGZyb9ZhXP6U447rYRkfHudIdnsVlYzA/QNYjmZ9RTXTSwfzDceBadtsySCbmGfS
        KLkm1Hd49GPBOD9LrErMxm1cjdx1OMXX7wPTDD6xMMx2HkzQpqDEgUaaJkbN1QbN0PkkHyocQxw6E
        DYWRJXPk5Vl2gaAjyYrBDolJiBVqIMtAHeWE0aPbwlCW2E/6DlpDJZXYwitiCnYqfj5dHNNYD3VOe
        omJ45qpmd2z/b45SImOi14wqNgjvIXDgFVFlRUkhIlTxAACwB10Ck0nxzz9twCgeP6RjVnWprJEUf
        37X6iCWwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goPq2-0008Lt-9F; Tue, 29 Jan 2019 09:37:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FB842042CFA9; Tue, 29 Jan 2019 10:37:48 +0100 (CET)
Date:   Tue, 29 Jan 2019 10:37:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, keescook@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 1/3] perf: convert perf_event_context.refcount to
 refcount_t
Message-ID: <20190129093748.GF28467@hirez.programming.kicks-ass.net>
References: <1548678448-24458-1-git-send-email-elena.reshetova@intel.com>
 <1548678448-24458-2-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548678448-24458-2-git-send-email-elena.reshetova@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 02:27:26PM +0200, Elena Reshetova wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3cd13a3..a1e87d2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1171,7 +1171,7 @@ static void perf_event_ctx_deactivate(struct perf_event_context *ctx)
>  
>  static void get_ctx(struct perf_event_context *ctx)
>  {
> -	WARN_ON(!atomic_inc_not_zero(&ctx->refcount));
> +	WARN_ON(!refcount_inc_not_zero(&ctx->refcount));

This could be refcount_inc(), remember how that already produces a WARN
when we try and increment 0.

