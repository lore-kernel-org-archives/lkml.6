Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57313C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3088B2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfARJtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:49:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfARJtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:49:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E124786675;
        Fri, 18 Jan 2019 09:49:21 +0000 (UTC)
Received: from krava (unknown [10.40.205.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id 631E55D964;
        Fri, 18 Jan 2019 09:49:20 +0000 (UTC)
Date:   Fri, 18 Jan 2019 10:49:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf, script: Fix crash with printing mixed trace point
 and other events
Message-ID: <20190118094919.GA28346@krava>
References: <20190117194834.21940-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117194834.21940-1-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 18 Jan 2019 09:49:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:48:34AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> perf script crashes currently when printing mixed trace points and other
> events because the trace format does not handle events without trace
> meta data. Add a simple check to avoid that.
> 
> % cat > test.c
> main()
> {
>     printf("Hello world\n");
> }
> ^D
> % gcc -g -o test test.c
> % sudo perf probe -x test 'test.c:3'
> % perf record -e '{cpu/cpu-cycles,period=10000/,probe_test:main}:S' ./test
> % perf script
> <segfault>
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 3728b50e52e2..ea2396b33a57 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1779,7 +1779,7 @@ static void process_event(struct perf_script *script,
>  		return;
>  	}
>  
> -	if (PRINT_FIELD(TRACE)) {
> +	if (PRINT_FIELD(TRACE) && sample->raw_data) {
>  		event_format__fprintf(evsel->tp_format, sample->cpu,
>  				      sample->raw_data, sample->raw_size, fp);
>  	}
> -- 
> 2.17.2
> 
