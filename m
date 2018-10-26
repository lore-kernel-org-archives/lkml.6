Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D07BECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B892054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B892054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJ0Dp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:45:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:44850 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbeJ0Dp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:45:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 12:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,429,1534834800"; 
   d="scan'208";a="84759486"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2018 12:07:44 -0700
Received: from [10.252.142.77] (kliang2-mobl1.ccr.corp.intel.com [10.252.142.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4B431580496;
        Fri, 26 Oct 2018 12:07:43 -0700 (PDT)
Subject: Re: A concern about overflow ring buffer mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Wang Nan <wangnan0@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20181026.104513.2239058788450235574.davem@davemloft.net>
 <20181026183805.GD3353@kernel.org> <20181026184255.GE3353@kernel.org>
 <20181026190211.GF3353@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3b81c999-9039-94e9-7a74-cdbd48fca08b@linux.intel.com>
Date:   Fri, 26 Oct 2018 15:07:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026190211.GF3353@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2018 3:02 PM, Arnaldo Carvalho de Melo wrote:
> So, I'm adding the following to my tree to help in diagnosing problems
> with this overwrite mode:
>

Actually, you can use per-event overwrite term to disable overwrite mode 
for perf top.

/*
  * Check per-event overwrite term.
  * perf top should support consistent term for all events.
  * - All events don't have per-event term
  *   E.g. "cpu/cpu-cycles/,cpu/instructions/"
  *   Nothing change, return 0.
  * - All events have same per-event term
  *   E.g. "cpu/cpu-cycles,no-overwrite/,cpu/instructions,no-overwrite/
  *   Using the per-event setting to replace the opts->overwrite if
  *   they are different, then return 0.
  * - Events have different per-event term
  *   E.g. "cpu/cpu-cycles,overwrite/,cpu/instructions,no-overwrite/"
  *   Return -1
  * - Some of the event set per-event term, but some not.
  *   E.g. "cpu/cpu-cycles/,cpu/instructions,no-overwrite/"
  *   Return -1
  */
static int perf_top__overwrite_check(struct perf_top *top)
{

Thanks,
Kan

> 
>  From 40feb09001c7cc2ba8aeaa0a8f03b6d28fa4ca95 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Fri, 26 Oct 2018 15:55:23 -0300
> Subject: [PATCH 1/1] perf top: Allow disabling the overwrite mode
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
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wang Nan <wangnan0@huawei.com>
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
