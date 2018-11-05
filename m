Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB53C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4362081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4362081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeKEJsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 04:48:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:8503 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeKEJsz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 04:48:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 16:32:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,465,1534834800"; 
   d="scan'208";a="93649013"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.161.30]) ([10.239.161.30])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2018 16:32:00 -0800
Subject: Re: [PATCH] perf top: Display the LBR stats in callchain entry
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1540983995-20462-1-git-send-email-yao.jin@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <cb124f2d-a7b6-689e-c41d-0dec33a8cf0f@linux.intel.com>
Date:   Mon, 5 Nov 2018 08:31:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540983995-20462-1-git-send-email-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any comments for this patch?

Thanks
Jin Yao

On 10/31/2018 7:06 PM, Jin Yao wrote:
> Perf report has supported the displaying of LBR stats
> (such as cycles, predicted%) in callchain entry.
> 
> For example,
> perf report --branch-history --stdio
> 
> --1.01%--intel_idle mwait.h:29
>            intel_idle cpufeature.h:164 (cycles:5)
>            intel_idle cpufeature.h:164 (predicted:76.4%)
>            intel_idle mwait.h:102 (cycles:41)
>            intel_idle current.h:15
> 
> While perf top has not supported that.
> 
> For example,
> perf top -a -b --call-graph branch
> 
> -   13.86%     0.23%  [kernel]		[k] __x86_indirect_thunk_rax
>     - 13.65% __x86_indirect_thunk_rax
>        + 1.69% do_syscall_64
>        + 1.68% do_select
>        + 1.41% ktime_get
>        + 0.70% __schedule
>        + 0.62% do_sys_poll
>          0.58% __x86_indirect_thunk_rax
> 
> Actually it's very easy to enable this feature in perf top.
> 
> With this patch, the result is:
> 
> perf top -a -b --call-graph branch
> 
> -   13.58%     0.00%  [kernel]		[k] __x86_indirect_thunk_rax
>     - 13.57% __x86_indirect_thunk_rax (predicted:93.9%)
>        + 1.78% do_select (cycles:2)
>        + 1.68% perf_pmu_disable.part.99 (cycles:1)
>        + 1.45% ___sys_recvmsg (cycles:25)
>        + 0.81% unix_stream_sendmsg (cycles:18)
>        + 0.80% ktime_get (cycles:400)
>          0.58% pick_next_task_fair (cycles:47)
>        + 0.56% i915_request_retire (cycles:2)
>        + 0.52% do_sys_poll (cycles:4)
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>   tools/perf/builtin-top.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index d21d875..7691b21 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1420,6 +1420,9 @@ int cmd_top(int argc, const char **argv)
>   		}
>   	}
>   
> +	if (opts->branch_stack && callchain_param.enabled)
> +		symbol_conf.show_branchflag_count = true;
> +
>   	sort__mode = SORT_MODE__TOP;
>   	/* display thread wants entries to be collapsed in a different tree */
>   	perf_hpp_list.need_collapse = 1;
> 
