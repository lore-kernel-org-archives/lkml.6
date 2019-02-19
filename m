Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F90C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C846C2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfBSOCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:02:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfBSOCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:02:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D55C987643;
        Tue, 19 Feb 2019 14:02:16 +0000 (UTC)
Received: from krava (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with SMTP id 37CED60149;
        Tue, 19 Feb 2019 14:02:15 +0000 (UTC)
Date:   Tue, 19 Feb 2019 15:02:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     He Kuang <hekuang@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Don't shadow inlined symbol with different
 addr range
Message-ID: <20190219140213.GC6435@krava>
References: <20190219130531.15692-1-hekuang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219130531.15692-1-hekuang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 19 Feb 2019 14:02:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:05:31PM +0800, He Kuang wrote:
> We can't assume inlined symbols with the same name are equal, because
> their address range may be different. This will cause the symbols with
> different addresses be shadowed when adding to the hist entry, and lead
> to ERANGE error when checking the symbol address during sample parse, the
> addr should be within the range of [sym.start, sym.end].
> 
> The error message is like: "0x36aea60 [0x8]: failed to process type: 68".
> 
> The second parameter of symbol__new() is the length of the fake symbol for
> the inline frame, which is the subtraction of the end and start address of
> base_sym.
> 
> Signed-off-by: He Kuang <hekuang@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/sort.c    | 10 ++++++++--
>  tools/perf/util/srcline.c |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 6c1a83768eb0..d0334c33da54 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -230,8 +230,14 @@ static int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
>  	if (sym_l == sym_r)
>  		return 0;
>  
> -	if (sym_l->inlined || sym_r->inlined)
> -		return strcmp(sym_l->name, sym_r->name);
> +	if (sym_l->inlined || sym_r->inlined) {
> +		int ret = strcmp(sym_l->name, sym_r->name);
> +
> +		if (ret)
> +			return ret;
> +		if ((sym_l->start <= sym_r->end) && (sym_l->end >= sym_r->start))
> +			return 0;
> +	}
>  
>  	if (sym_l->start != sym_r->start)
>  		return (int64_t)(sym_r->start - sym_l->start);
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index dc86597d0cc4..ccf42c4e83f0 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -104,7 +104,7 @@ static struct symbol *new_inline_sym(struct dso *dso,
>  	} else {
>  		/* create a fake symbol for the inline frame */
>  		inline_sym = symbol__new(base_sym ? base_sym->start : 0,
> -					 base_sym ? base_sym->end : 0,
> +					 base_sym ? (base_sym->end - base_sym->start) : 0,
>  					 base_sym ? base_sym->binding : 0,
>  					 base_sym ? base_sym->type : 0,
>  					 funcname);
> -- 
> 2.20.1
> 
