Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D63BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EB521902
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfBTPDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:03:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:13740 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfBTPDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:03:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 07:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="145824190"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2019 07:03:48 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id 87C5258028E;
        Wed, 20 Feb 2019 07:03:45 -0800 (PST)
Subject: Re: [PATCH v2 3/4] perf record: enable runtime trace compression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
 <20190212130925.GM775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d2a33fb7-2b7e-9f4c-eb32-f91a34ce0305@linux.intel.com>
Date:   Wed, 20 Feb 2019 18:03:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130925.GM775@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 16:09, Jiri Olsa wrote:
> On Mon, Feb 11, 2019 at 11:23:40PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index 239e9a13c2b7..980784b77fe2 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -156,6 +156,86 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
>>  {
>>  }
>>  
>> +static ssize_t perf_mmap__capture(struct perf_mmap *md, int idx,
>> +			perf_mmap__compress_fn_t compress, void *where)
> 
> what's the point of casting perf_session* to void* ? all the way down to
> the compression, where you cast it back?
> 
> SNIP
> 
>> +int perf_session__zstd_fini(struct perf_session *session)
>> +{
>> +	if (session->zstd_cstream) {
>> +		ZSTD_freeCStream(session->zstd_cstream);
>> +		session->zstd_cstream = NULL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +size_t perf_session__zstd_compress(void *to,  void *dst, size_t dst_size,
>> +				   void *src, size_t src_size)
>> +{
>> +	struct perf_session *session = to;
> 
> in here... it could be just struct perf_session* no?

As far as it is a pointer. Casting a pointer to void* 
and back is harmless. Well, let's clean that up.

Thanks,
Alexey

> 
> jirka
> 
