Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A023C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEB120870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEB120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJ2XWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:22:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:60947 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbeJ2XWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:22:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 07:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,440,1534834800"; 
   d="scan'208";a="82434865"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 29 Oct 2018 07:33:09 -0700
Received: from [10.251.20.185] (kliang2-mobl1.ccr.corp.intel.com [10.251.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3CF1B58037D;
        Mon, 29 Oct 2018 07:33:08 -0700 (PDT)
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20181026.104513.2239058788450235574.davem@davemloft.net>
 <20181026183805.GD3353@kernel.org> <20181026184255.GE3353@kernel.org>
 <20181026190211.GF3353@kernel.org>
 <3b81c999-9039-94e9-7a74-cdbd48fca08b@linux.intel.com>
 <20181026191231.GG3353@kernel.org>
 <65cbd052-15d9-f3fb-4a8f-781c3ce7a297@linux.intel.com>
 <20181026192424.GH3353@kernel.org>
 <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
 <20181029130331.GC21857@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
Date:   Mon, 29 Oct 2018 10:33:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029130331.GC21857@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2018 9:03 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 26, 2018 at 04:11:51PM -0400, Liang, Kan escreveu:
>> On 10/26/2018 3:24 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Fri, Oct 26, 2018 at 03:16:29PM -0400, Liang, Kan escreveu:
>>>> On 10/26/2018 3:12 PM, Arnaldo Carvalho de Melo wrote:
>>>>> Em Fri, Oct 26, 2018 at 03:07:40PM -0400, Liang, Kan escreveu:
>>>>>> On 10/26/2018 3:02 PM, Arnaldo Carvalho de Melo wrote:
>>>>> I checked and both have the same result. But I still think there is
>>>>> value in having the shorter form, ok?
> 
>>>> Sure.
> 
>>> Ok.
> 
>>> I think that we should default back to --no-overwrite till we get this
>>> sorted out, as the effect is easily noticeable, as David reported and I
>>> reproduced, when doing kernel builds.
>   
>> It is mainly for performance reason to switch to overwrite mode. The impact
>> was very small when I did my test. But now the effect is easily noticeable
>> in other tests. Yes, I agree. We may change it back to non-overwrite mode
>> until the issue is addressed.
> 
> So, I have these two patches in my perf/core branch, with Fixes tags
> that will make them get to the stable kernels, ok?

I just realized that the problem in KNL will be back if we switch back 
to non-overwrite mode.
The problem is that users have to wait tens of minutes to see perf top 
results on the screen in KNL. Before that, there is nothing but a black 
screen.

Sorry I didn't notice it last Friday. Because I thought the ui_warning 
in perf_top__mmap_read() can give user a hint. So the user can switch to 
overwrite mode manually.
But unfortunately, the ui_warning doesn't work. Because it is called 
after perf_top__mmap_read(). The processing time of 
perf_top__mmap_read() could be tens of minutes.

Thanks,
Kan

> 
> 
>  From f54ef0e7342efb77205b2faaacbcb81cdd31f064 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Fri, 26 Oct 2018 15:55:23 -0300
> Subject: [PATCH 1/2] perf top: Allow disabling the overwrite mode
> 
> In ebebbf082357 ("perf top: Switch default mode to overwrite mode") we
> forgot to leave a way to disable that new default, add a --overwrite
> option that can be disabled using --no-overwrite, since the code already
> in such a way that we can readily disable this mode.
> 
> This is useful when investigating bugs with this mode like the recent
> report from David Miller where lots of unknown symbols appear due to
> disabling the events while processing them which disables all record
> types, not just PERF_RECORD_SAMPLE, which makes it impossible to resolve
> maps when we lose PERF_RECORD_MMAP records.
> 
> This can be easily seen while building a kernel, when there are lots of
> short lived processes.
> 
> Reported-by: David Miller <davem@davemloft.net>
> Acked-by: Kan Liang <kan.liang@intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Fixes: ebebbf082357 ("perf top: Switch default mode to overwrite mode")
> Link: https://lkml.kernel.org/n/tip-oqgsz2bq4kgrnnajrafcdhie@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/perf/Documentation/perf-top.txt | 5 +++++
>   tools/perf/builtin-top.c              | 2 ++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index 114fda12aa49..d4be6061fe1c 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -242,6 +242,11 @@ Default is to monitor all CPUS.
>   --hierarchy::
>   	Enable hierarchy output.
>   
> +--overwrite::
> +	This is the default, but for investigating problems with it or any other strange
> +	behaviour like lots of unknown samples, we may want to disable this mode by using
> +	--no-overwrite.
> +
>   --force::
>   	Don't do ownership validation.
>   
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index d21d8751e749..214fad747b04 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1372,6 +1372,8 @@ int cmd_top(int argc, const char **argv)
>   		    "Show raw trace event output (do not use print fmt or plugins)"),
>   	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
>   		    "Show entries in a hierarchy"),
> +	OPT_BOOLEAN(0, "overwrite", &top.record_opts.overwrite,
> +		    "Use a backward ring buffer, default: yes"),
>   	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
>   	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
>   			"number of thread to run event synthesize"),
> 
