Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF92C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA17920652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA17920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeJKVNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:13:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeJKVNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:13:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D00CD792B8;
        Thu, 11 Oct 2018 13:46:01 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2402374A2E;
        Thu, 11 Oct 2018 13:45:59 +0000 (UTC)
Date:   Thu, 11 Oct 2018 15:45:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 3/3]: perf record: extend trace writing to multi AIO
Message-ID: <20181011134559.GC29634@krava>
References: <e045b4aa-bff1-4e40-4cdf-4504003ecff5@linux.intel.com>
 <39da34d3-7198-7514-b000-7bfbf382e526@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39da34d3-7198-7514-b000-7bfbf382e526@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 11 Oct 2018 13:46:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 11:59:31AM +0300, Alexey Budankov wrote:

SNIP

> @@ -1568,15 +1596,18 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
>  
>  #ifdef HAVE_AIO_SUPPORT
>  static int record__aio_parse(const struct option *opt,
> -			     const char *str __maybe_unused,
> +			     const char *str,
>  			     int unset)
>  {
>  	struct record_opts *opts = (struct record_opts *)opt->value;
>  
> -	if (unset)
> +	if (unset) {
>  		opts->nr_cblocks = 0;
> -	else
> -		opts->nr_cblocks = 1;
> +	} else {
> +		opts->nr_cblocks = strtol(str, NULL, 0);
> +		if (!opts->nr_cblocks)
> +			opts->nr_cblocks = 1;
> +	}
>  
>  	return 0;
>  }
> @@ -1886,8 +1917,8 @@ static struct option __record_options[] = {
>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>  		    "Parse options then exit"),
>  #ifdef HAVE_AIO_SUPPORT
> -	OPT_CALLBACK_NOOPT(0, "aio", &record.opts,
> -		     NULL, "Enable asynchronous trace writing mode",

hum, why removing --aio option? I though we will have:

  perf record --aio ....           # enables aio with default settings
  perf record --aio-cblocks=3 ...  # enabled aio with aio-cblocks=3


jirka

> +	OPT_CALLBACK(0, "aio-cblocks", &record.opts,
> +		     "n", "Use <n> control blocks in asynchronous trace writing mode (max: 4)",
>  		     record__aio_parse),

SNIP
