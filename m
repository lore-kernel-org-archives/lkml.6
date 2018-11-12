Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A550C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22986224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftujaPWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22986224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeKMCey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeKMCey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:34:54 -0500
Received: from jouet.infradead.org (d66-183-243-195.bchsia.telus.net [66.183.243.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6A492241E;
        Mon, 12 Nov 2018 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542040853;
        bh=opE0t8+K0Fkm2x3TwXwZnE6kfbux/t4qSkmgTYLIkLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftujaPWAcgik4oPEXiW7RY/a8ujtTglHDyVX0yzQioZ24HqHozV3bdOaJKVK/TdTr
         7k8nMh/eoYiYO7KaQ9s2fLUOwvNi4qUYOjwefeUdlSIeqUOwKsbeXKJvO6LK2kkFFa
         oYiLHZ5rvyhMYQHAcz2NbRkEOZoIhw5eHPRaYaJc=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id ACD2F1443D0; Mon, 12 Nov 2018 08:40:53 -0800 (PST)
Date:   Mon, 12 Nov 2018 08:40:53 -0800
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Adam Lee <leeadamrobert@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH perf/urgent] perf tools: Fix crash on synthesizing the
 unit
Message-ID: <20181112164053.GF1111@kernel.org>
References: <20181112130012.5424-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112130012.5424-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 12, 2018 at 02:00:12PM +0100, Jiri Olsa escreveu:
> Adam reported a record command crash for simple session like:
>   $ perf record -e cpu-clock ls

Thanks, tested, confirmed it fixes the problem, applied.

- Arnaldo
 
> with following backtrace:
> 
>   Program received signal SIGSEGV, Segmentation fault.
>   3543            ev = event_update_event__new(size + 1, PERF_EVENT_UPDATE__UNIT, evsel->id[0]);
>   (gdb) bt
>   #0  perf_event__synthesize_event_update_unit
>   #1  0x000000000051e469 in perf_event__synthesize_extra_attr
>   #2  0x00000000004445cb in record__synthesize
>   #3  0x0000000000444bc5 in __cmd_record
>   ...
> 
> We synthesize an update event that needs to touch the evsel id array, which is
> not defined at that time. Fixing this by forcing the id allocation for events
> with their unit defined.
> 
> Reflecting possible read_format ID bit in the attr tests.
> 
> Cc: Adam Lee <leeadamrobert@gmail.com>
> Reported-by: Yongxin Liu <yongxin.liu@outlook.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201477
> Fixes: bfd8f72c2778 ("perf record: Synthesize unit/scale/... in event update")
> Link: http://lkml.kernel.org/n/tip-hmt7oavo3w97btxl8sfq8n0i@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/attr/base-record | 2 +-
>  tools/perf/util/evsel.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
> index 37940665f736..efd0157b9d22 100644
> --- a/tools/perf/tests/attr/base-record
> +++ b/tools/perf/tests/attr/base-record
> @@ -9,7 +9,7 @@ size=112
>  config=0
>  sample_period=*
>  sample_type=263
> -read_format=0
> +read_format=0|4
>  disabled=1
>  inherit=1
>  pinned=0
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d37bb1566cd9..dbc0466db368 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1092,7 +1092,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
>  		attr->exclude_user   = 1;
>  	}
>  
> -	if (evsel->own_cpus)
> +	if (evsel->own_cpus || evsel->unit)
>  		evsel->attr.read_format |= PERF_FORMAT_ID;
>  
>  	/*
> -- 
> 2.17.2
