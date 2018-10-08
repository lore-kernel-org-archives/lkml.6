Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A93C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18DD2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18DD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeJHTbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:31:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:28010 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeJHTbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:31:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 05:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="79409867"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 08 Oct 2018 05:20:00 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id 15B82580487;
        Mon,  8 Oct 2018 05:19:57 -0700 (PDT)
Subject: Re: [PATCH v11 2/3]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <31b0ae5f-e1b5-4255-11af-46c8ebe8e2be@linux.intel.com>
 <20181008105107.GF17270@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <cf901e1e-781f-4e1c-439f-26d09691e0fd@linux.intel.com>
Date:   Mon, 8 Oct 2018 15:19:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008105107.GF17270@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.10.2018 13:51, Jiri Olsa wrote:
> On Mon, Oct 08, 2018 at 09:17:11AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  struct option;
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index db8f16f8a363..ecaa5b5eb3ed 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -367,6 +367,82 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>>  	return rc;
>>  }
>>  
>> +#ifdef HAVE_AIO_SUPPORT
>> +int perf_mmap__aio_push(struct perf_mmap *md, void *to,
>> +			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
>> +			off_t *off)
>> +{
> 
> seems like this could be defined static within builtin-record object,
> is there a reason why it's in here?

The reason is analogy with perf_mmap__push() above.

Thanks,
Alexey
 
> 
> thanks,
> jirka
> 
