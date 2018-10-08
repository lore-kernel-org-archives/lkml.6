Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B7DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F9E20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F9E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJHTSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:18:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:5245 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeJHTSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:18:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 05:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="86626843"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2018 05:03:21 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id 9543E5801E6;
        Mon,  8 Oct 2018 05:03:19 -0700 (PDT)
Subject: Re: [PATCH v11 1/3]: perf util: map data buffer for preserving
 collected data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
 <20181008105057.GD17270@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f8ac7176-26a4-7114-3807-abdaffaa897c@linux.intel.com>
Date:   Mon, 8 Oct 2018 15:03:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008105057.GD17270@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.10.2018 13:50, Jiri Olsa wrote:
> On Mon, Oct 08, 2018 at 09:14:29AM +0300, Alexey Budankov wrote:
<SNIP>
>>  
>> +#ifdef HAVE_AIO_SUPPORT
>> +static void perf_mmap__aio_munmap(struct perf_mmap *map)
>> +{
>> +	if (map->data)
>> +		zfree(&map->data);
>> +}
> 
> if we really need to keep this optional for compilation,
> please make it as single block with dummy functions
> for when it's not compiled in, like:
> 
> #ifdef 
> static void perf_mmap__aio_munmap(struct perf_mmap *map)
> {
> 	if (map->data)
> 		zfree(&map->data);
> }
> #else
> static void perf_mmap__aio_munmap(struct perf_mmap *map) { }
> #endif

Ok.

> 
> thanks,
> jirka
> 
> 
>> +#endif
>> +
>>  void perf_mmap__munmap(struct perf_mmap *map)
>>  {
>> +#ifdef HAVE_AIO_SUPPORT
>> +	perf_mmap__aio_munmap(map);
>> +#endif
>>  	if (map->base != NULL) {
>>  		munmap(map->base, perf_mmap__mmap_len(map));
>>  		map->base = NULL;
>> @@ -164,8 +175,40 @@ void perf_mmap__munmap(struct perf_mmap *map)
>>  	auxtrace_mmap__munmap(&map->auxtrace_mmap);
>>  }

Well, let's go with stub functions design as opposite to pure 
conditional compilation. However this may, probably, result in 
unintended Perf tool binary size growth, even if NO_AIO is 
defined during compilation.

Thanks,
Alexey
