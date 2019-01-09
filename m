Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAA7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA42206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfAIJKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:10:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:6917 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfAIJKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:10:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="132956090"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jan 2019 01:10:09 -0800
Received: from [10.125.252.236] (abudanko-mobl.ccr.corp.intel.com [10.125.252.236])
        by linux.intel.com (Postfix) with ESMTP id 0A5ED580490;
        Wed,  9 Jan 2019 01:10:06 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 1/4] perf record: allocate affinity masks
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
 <ed9acf48-def7-1539-331f-454951dad3d9@linux.intel.com>
 <20190101213924.GD13760@krava>
Organization: Intel Corp.
Message-ID: <3beb9c5d-9dc8-00ae-5413-f126d8d796e9@linux.intel.com>
Date:   Wed, 9 Jan 2019 12:10:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190101213924.GD13760@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02.01.2019 0:39, Jiri Olsa wrote:
> On Mon, Dec 24, 2018 at 03:23:13PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> @@ -2143,6 +2152,8 @@ int cmd_record(int argc, const char **argv)
>>  	if (verbose > 0)
>>  		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
>>  
>> +	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
>> +
>>  	err = __cmd_record(&record, argc, argv);
>>  out:
>>  	perf_evlist__delete(rec->evlist);
>> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
>> index 388c6dd128b8..69f54529d81f 100644
>> --- a/tools/perf/perf.h
>> +++ b/tools/perf/perf.h
>> @@ -83,6 +83,14 @@ struct record_opts {
>>  	clockid_t    clockid;
>>  	u64          clockid_res_ns;
>>  	int	     nr_cblocks;
>> +	int	     affinity;
>> +};
>> +
>> +enum perf_affinity {
>> +	PERF_AFFINITY_SYS = 0,
>> +	PERF_AFFINITY_NODE,
>> +	PERF_AFFINITY_CPU,
>> +	PERF_AFFINITY_EOF
> 
> PERF_AFFINITY_MAX might be better name

Corrected in v3.

Thanks,
Alexey

> 
> jirka
> 
