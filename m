Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFBFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A0B20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfAWIdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:33:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfAWIdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:33:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1D8B89ACB;
        Wed, 23 Jan 2019 08:33:42 +0000 (UTC)
Received: from krava (unknown [10.40.205.71])
        by smtp.corp.redhat.com (Postfix) with SMTP id D2697104C53E;
        Wed, 23 Jan 2019 08:33:39 +0000 (UTC)
Date:   Wed, 23 Jan 2019 09:33:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests: evsel-tp-sched: Fix bitwise operator
Message-ID: <20190123083338.GK27625@krava>
References: <20190122233439.GA5868@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122233439.GA5868@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 23 Jan 2019 08:33:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 05:34:39PM -0600, Gustavo A. R. Silva wrote:
> Notice that the use of the bitwise OR operator '|' always leads to
> true in this particular case, which seems a bit suspicious due to
> the context in which this expression is being used.
> 
> Fix this by using bitwise AND operator '&' instead.
> 
> This bug was detected with the help of Coccinelle.
> 
> Fixes: 6a6cd11d4e57 ("perf test: Add test for the sched tracepoint format fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

nice catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
> 
> NOTE: Notice that this code has been there since 2012. So, it would
>       be helpful if someone can double-check this. Thanks.
> 
>  tools/perf/tests/evsel-tp-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
> index 5f8501c68da4..5cbba70bcdd0 100644
> --- a/tools/perf/tests/evsel-tp-sched.c
> +++ b/tools/perf/tests/evsel-tp-sched.c
> @@ -17,7 +17,7 @@ static int perf_evsel__test_field(struct perf_evsel *evsel, const char *name,
>  		return -1;
>  	}
>  
> -	is_signed = !!(field->flags | TEP_FIELD_IS_SIGNED);
> +	is_signed = !!(field->flags & TEP_FIELD_IS_SIGNED);
>  	if (should_be_signed && !is_signed) {
>  		pr_debug("%s: \"%s\" signedness(%d) is wrong, should be %d\n",
>  			 evsel->name, name, is_signed, should_be_signed);
> -- 
> 2.20.1
> 
