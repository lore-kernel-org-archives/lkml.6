Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A053CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7132220652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7132220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJHWvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:51:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:35133 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJHWvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:51:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 08:39:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="76345616"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 08 Oct 2018 08:39:26 -0700
Received: from [10.252.30.144] (abudanko-mobl.ccr.corp.intel.com [10.252.30.144])
        by linux.intel.com (Postfix) with ESMTP id B9D8F580145;
        Mon,  8 Oct 2018 08:39:23 -0700 (PDT)
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
 <20181008105254.GG17270@krava>
 <de91f032-94e5-626e-bf2c-2f3a21ab6db1@linux.intel.com>
 <20181008125310.GF18757@krava>
 <c6331666-e4af-f1b5-99a5-abf0fdd54a63@linux.intel.com>
 <20181008151108.GH18757@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1548bd97-4d8f-f0b6-3a37-b3f2e464ff7d@linux.intel.com>
Date:   Mon, 8 Oct 2018 18:39:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008151108.GH18757@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 08.10.2018 18:11, Jiri Olsa wrote:
> On Mon, Oct 08, 2018 at 05:42:18PM +0300, Alexey Budankov wrote:
>> Hi,
>> On 08.10.2018 15:53, Jiri Olsa wrote:
>>> On Mon, Oct 08, 2018 at 03:24:31PM +0300, Alexey Budankov wrote:
>>>> Hi,
>>>>
>>>> On 08.10.2018 13:52, Jiri Olsa wrote:
>>>>> On Mon, Oct 08, 2018 at 09:17:11AM +0300, Alexey Budankov wrote:
>>>> <SNIP>
>>>>>> +#ifdef HAVE_AIO_SUPPORT
>>>>>> +	off = lseek(trace_fd, 0, SEEK_CUR);
>>>>>> +#endif
>>>>>
>>>>> I'm still little puzzled why we need to do this,
>>>>> when the aio write takes the offset value, but
>>>>
>>>> pwrite() syscall [1] which is the base for aio_write() doesn't 
>>>> advance file pos value so it requires to be calculated and 
>>>> updated by callers of aio_write() API.
>>>
>>> ok, so aio_write does not need the offset to be updated,
>>> who needs it then?
>>
>> aio_write() needs this offset as an input parameter.
>> aio_write() gets offset as a part of cblock object.
> 
> yes, it's an 'arg' to aio_write syscall
> 
>> Adjacent aio_write() records should not overlap in the trace file so
>> off value is incremented by size in every loop iteration after 
>> successful aio_write() call.
> 
> but does the aio_write need the lseek 'set' call? if not, we could

Yes, lseek(,, SEEK_SET) is still required after the loop, so the next 
synchronous records would go after AIO written parts that might be
still *in-flight* by that time.

Thanks,
Alexey

> keep the 'offset' value within perf (like in the struct perf_data_file
> or struct record) without any need to call lseek
> 
> jirka
> 
