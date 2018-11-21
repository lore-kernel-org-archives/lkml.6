Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471C5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDCD21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDCD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeKUTsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:48:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:52849 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeKUTsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:48:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 01:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="110092622"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga001.jf.intel.com with ESMTP; 21 Nov 2018 01:14:58 -0800
Subject: Re: [PATCH 4/4] perf intel-pt/bts: fix potential NULL pointer
 dereference in intel_bts_process_auxtrace_info
To:     Wen Yang <wen.yang99@zte.com.cn>, peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, Julia Lawall <julia.lawall@lip6.fr>
References: <1542786220-19338-1-git-send-email-wen.yang99@zte.com.cn>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <60a8972e-037f-8d6b-ce45-76b65a841156@intel.com>
Date:   Wed, 21 Nov 2018 11:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1542786220-19338-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/18 9:43 AM, Wen Yang wrote:
> This patch fixes a possible null pointer dereference in
> intel_bts_process_auxtrace_info, detected by the semantic patch
> deref_null.cocci, with the following warning:
> 
> ./tools/perf/util/intel-bts.c:921:32-49: ERROR: session -> itrace_synth_opts is NULL but dereferenced.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  tools/perf/util/intel-bts.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 7b27d77..b0258f4 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -917,7 +917,8 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
>  	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
>  		bts->synth_opts = *session->itrace_synth_opts;
>  	} else {
> -		itrace_synth_opts__set_default(&bts->synth_opts,
> +		if (session->itrace_synth_opts)
> +			itrace_synth_opts__set_default(&bts->synth_opts,
>  				session->itrace_synth_opts->default_no_sample);
>  		if (session->itrace_synth_opts)
>  			bts->synth_opts.thread_stack =
> 

See response to patch 1.
