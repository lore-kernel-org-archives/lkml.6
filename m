Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053B2C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE86820883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="shs+AXGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE86820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeGZUtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730392AbeGZUtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:49:06 -0400
Received: from jouet.infradead.org (unknown [177.79.82.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81ECB20671;
        Thu, 26 Jul 2018 19:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532633449;
        bh=cAHEEkXqAwrur6Nkn8V/ML8TtGCXWsqV05bmYz2ybGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=shs+AXGhJGV6d391wJsgvifuByjX3u0mquOlY+S8pH96RqTaAfAIrIeMcurwlmlTu
         Rs9SbRxCIilfJJ5kQL3Ge+0J6FA7fT3bbQ/bArpiWgj3UAs9AXBvi9/Xd1IqjFsrXc
         abdRYHguD3185exnN5ivmkdKSTQn1BZdDcavBOvw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 300DC1403B8; Thu, 26 Jul 2018 16:30:46 -0300 (-03)
Date:   Thu, 26 Jul 2018 16:30:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, rodia@autistici.org
Subject: Re: [PATCH] perf c2c report: Fix crash for empty browser
Message-ID: <20180726193046.GC20438@kernel.org>
References: <20180724062008.26126-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724062008.26126-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 24, 2018 at 08:20:08AM +0200, Jiri Olsa escreveu:
> Do not try to display entry details if there's
> not any. Currently this ends up in crash:
>   $ perf c2c report
>   perf: Segmentation fault

How to replicate this?

I tried:

$ perf record sleep 1
$ perf c2c report

But it didn't segfault

 
> Reported-by: rodia@autistici.org
> Link: http://lkml.kernel.org/n/tip-3d7qjz9x49ay9ncerfordcv3@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-c2c.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index f2ea85ee573f..f3aa9d02a5ab 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2349,6 +2349,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>  	" s             Toggle full length of symbol and source line columns \n"
>  	" q             Return back to cacheline list \n";
>  
> +	if (!he)
> +		return 0;
> +
>  	/* Display compact version first. */
>  	c2c.symbol_full = false;
>  
> -- 
> 2.17.1
