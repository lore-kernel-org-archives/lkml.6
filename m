Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D75C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E1D2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfBTOPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:15:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:27621 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfBTOPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:15:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 06:15:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="145813486"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2019 06:15:16 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id 584CB58019B;
        Wed, 20 Feb 2019 06:15:14 -0800 (PST)
Subject: Re: [PATCH v2 2/4] perf record: implement -z=<level> and
 --mmap-flush=<thres> options
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
 <20190212130828.GD775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <39a1cf8d-2496-72f6-c3a4-a4abb8008689@linux.intel.com>
Date:   Wed, 20 Feb 2019 17:15:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130828.GD775@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 16:08, Jiri Olsa wrote:
> On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> -	if (rec->opts.nr_cblocks > nr_cblocks_max)
>> -		rec->opts.nr_cblocks = nr_cblocks_max;
>> -	if (verbose > 0)
>> -		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
>> +	if (rec->opts.comp_level > 22)
>> +		rec->opts.comp_level = 0;
>> +	if (record__comp_enabled(rec) && !rec->opts.nr_cblocks) {
>> +		 /*
>> +		  * Allocate aio.data[0] buffer for compression.
>> +		  */
>> +		rec->opts.nr_cblocks = -1;
>> +	}
> 
> I assume you're using aio.data[0] as a buffer for non-aio case
> as compression buffer.. if that's the case, please dont do that
> and use separate buffer for that

Do you want it to be one more field in the mmap struct or 
aio related fields still could be reworked?

Thanks,
Alexey

> 
> jirka
> 
