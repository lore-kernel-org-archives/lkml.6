Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA161C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750EA2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750EA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeK0OrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:47:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:47320 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbeK0OrZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:47:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 19:50:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,285,1539673200"; 
   d="scan'208";a="253068544"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.161.30]) ([10.239.161.30])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2018 19:50:52 -0800
Subject: Re: [PATCH 2/2] perf report: Display average IPC and IPC coverage per
 symbol
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1543225254-5858-1-git-send-email-yao.jin@linux.intel.com>
 <1543225254-5858-3-git-send-email-yao.jin@linux.intel.com>
 <20181126095203.GA18780@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <fa7b94e5-f1a9-f232-97d6-1d1aeb5f4b9b@linux.intel.com>
Date:   Tue, 27 Nov 2018 11:50:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181126095203.GA18780@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/2018 5:52 PM, Jiri Olsa wrote:
> On Mon, Nov 26, 2018 at 05:40:54PM +0800, Jin Yao wrote:
>> Support displaying the average IPC and IPC coverage for symbol
>> in perf report TUI browser. We create a new sort-key 'ipc' for
>> that.
>>
>> For example,
>>
>> $ perf record -g -b ...
>> $ perf report -s symbol,ipc or
>>    perf report -s ipc
>>
>> Overhead  Symbol                           IPC   [IPC Coverage]
>>    39.60%  [.] __random                     2.30  [ 54.8%]
>>    18.02%  [.] main                         0.43  [ 54.3%]
>>    14.21%  [.] compute_flag                 2.29  [100.0%]
>>    14.16%  [.] rand                         0.36  [100.0%]
>>     7.06%  [.] __random_r                   2.57  [ 70.5%]
>>     6.85%  [.] rand@plt                     0.00  [  0.0%]
>>
>> Note that, stdio mode doesn't support this feature.
> 
> the patch below allowed this for stdio
> please merge it in, and feel free to change it as you see fit
> 
> jirka
> 
> 

Thanks so much! I have merged following code in v2.

Thanks
Jin Yao

> ---
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 9b75e118f609..a6756dc13285 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -85,6 +85,7 @@ struct report {
>   	int			socket_filter;
>   	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
>   	struct branch_type_stat	brtype_stat;
> +	bool			symbol_ipc;
>   };
>   
>   static int report__config(const char *var, const char *value, void *cb)
> @@ -129,7 +130,7 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
>   	struct mem_info *mi;
>   	struct branch_info *bi;
>   
> -	if (!ui__has_annotation())
> +	if (!ui__has_annotation() && !rep->symbol_ipc)
>   		return 0;
>   
>   	hist__account_cycles(sample->branch_stack, al, sample,
> @@ -174,7 +175,7 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
>   	struct perf_evsel *evsel = iter->evsel;
>   	int err;
>   
> -	if (!ui__has_annotation())
> +	if (!ui__has_annotation() && !rep->symbol_ipc)
>   		return 0;
>   
>   	hist__account_cycles(sample->branch_stack, al, sample,
> @@ -954,7 +955,6 @@ int cmd_report(int argc, const char **argv)
>   	bool has_br_stack = false;
>   	int branch_mode = -1;
>   	bool branch_call_mode = false;
> -	bool symbol_ipc = false;
>   #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
>   	const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
>   					     CALLCHAIN_REPORT_HELP
> @@ -1289,7 +1289,7 @@ int cmd_report(int argc, const char **argv)
>   		strstr(sort_order, "ipc")) {
>   		if (!strstr(sort_order, "symbol"))
>   			sort_order = "symbol,ipc";
> -		symbol_ipc = true;
> +		report.symbol_ipc = true;
>   	}
>   
>   	if (setup_sorting(session->evlist) < 0) {
> @@ -1319,7 +1319,7 @@ int cmd_report(int argc, const char **argv)
>   	 * so don't allocate extra space that won't be used in the stdio
>   	 * implementation.
>   	 */
> -	if (ui__has_annotation()) {
> +	if (ui__has_annotation() || report.symbol_ipc) {
>   		ret = symbol__annotation_init();
>   		if (ret < 0)
>   			goto error;
> @@ -1339,9 +1339,6 @@ int cmd_report(int argc, const char **argv)
>   			symbol_conf.sort_by_name = true;
>   		}
>   		annotation_config__init();
> -	} else if (symbol_ipc) {
> -		pr_err("Only TUI mode supports sort-key ipc\n");
> -		goto error;
>   	}
>   
>   	if (symbol__init(&session->header.env) < 0)
> 
