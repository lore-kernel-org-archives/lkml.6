Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECC9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 18:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D8A2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 18:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfAAS2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 13:28:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfAAS2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 13:28:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71AF92D7E9;
        Tue,  1 Jan 2019 18:28:54 +0000 (UTC)
Received: from krava (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 67D4F101963D;
        Tue,  1 Jan 2019 18:28:53 +0000 (UTC)
Date:   Tue, 1 Jan 2019 19:28:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] perf thread-stack: Allocate an array of thread stacks
Message-ID: <20190101182852.GA13760@krava>
References: <20181221120620.9659-1-adrian.hunter@intel.com>
 <20181221120620.9659-7-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221120620.9659-7-adrian.hunter@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 01 Jan 2019 18:28:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 02:06:18PM +0200, Adrian Hunter wrote:
> In preparation for fixing thread stack processing for the idle task,
> allocate an array of thread stacks.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/thread-stack.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index 4340381d54c2..a896d89fe5f7 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -114,20 +114,26 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
>  static struct thread_stack *thread_stack__new(struct thread *thread,
>  					      struct call_return_processor *crp)
>  {
> -	struct thread_stack *ts;
> -
> -	ts = zalloc(sizeof(struct thread_stack));
> -	if (!ts)
> -		return NULL;
> -
> -	ts->arr_sz = 1;
> -
> -	if (thread_stack__init(ts, thread, crp)) {
> -		free(ts);
> -		return NULL;
> +	struct thread_stack *ts = thread->ts, *new_ts;
> +	unsigned int old_sz = ts ? ts->arr_sz : 0;
> +	unsigned int new_sz = 1;
> +
> +	if (!ts || new_sz > old_sz) {
> +		new_ts = calloc(new_sz, sizeof(*ts));
> +		if (!new_ts)
> +			return NULL;
> +		if (ts)
> +			memcpy(new_ts, ts, old_sz * sizeof(*ts));
> +		new_ts->arr_sz = new_sz;
> +		if (thread->ts)
> +			zfree(&thread->ts);

you don't need to check for thread->ts,
anyway it looks all good, for the patchset:

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> +		thread->ts = new_ts;
> +		ts = new_ts;
>  	}
>  
> -	thread->ts = ts;
> +	if (!ts->stack &&
> +	    thread_stack__init(ts, thread, crp))
> +		return NULL;
>  
>  	return ts;
>  }
> -- 
> 2.17.1
> 
