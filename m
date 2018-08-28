Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7942088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7942088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeH1Q3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:29:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:25032 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeH1Q3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:29:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 05:37:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,299,1531810800"; 
   d="scan'208";a="87004472"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 28 Aug 2018 05:37:48 -0700
Received: from [10.125.252.157] (abudanko-mobl.ccr.corp.intel.com [10.125.252.157])
        by linux.intel.com (Postfix) with ESMTP id 37E835802AD;
        Tue, 28 Aug 2018 05:37:45 -0700 (PDT)
Subject: Re: [PATCH v3 2/2]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <bdd669cd-a6dc-d592-4655-33b7bfc46cbb@linux.intel.com>
 <6f83f9cd-263e-b073-487f-4c7570105a7d@linux.intel.com>
 <20180828090145.GI23727@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2ed75413-4a8a-ee0c-be27-b3fbbfa000c6@linux.intel.com>
Date:   Tue, 28 Aug 2018 15:37:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828090145.GI23727@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28.08.2018 12:01, Jiri Olsa wrote:
> On Mon, Aug 27, 2018 at 09:16:55PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> +static int record__mmap_read_sync(int trace_fd, struct aiocb **cblocks,
>> +		int cblocks_size, struct record *rec)
>> +{
>> +	size_t rem;
>> +	ssize_t size;
>> +	off_t rem_off;
>> +	int i, aio_ret, aio_errno, do_suspend;
>> +	struct perf_mmap *md;
>> +	struct timespec timeout0 = { 0, 0 };
>> +	struct timespec timeoutS = { 0, 1000 * 500  * 1 }; // 0.5ms
>> +
>> +	if (!cblocks_size)
>> +		return 0;
>> +
>> +	do {
>> +		do_suspend = 0;
>> +		/* aio_suspend() implementation inside glibc (as of v2.27) is
>> +		 * intrusive and not just blocks waiting io requests completion
>> +		 * but polls requests queue inducing context switches in perf
>> +		 * tool process. When profiling in system wide mode with tracing
>> +		 * context switches the trace may be polluted by context switches
>> +		 * from the perf process and the trace size becomes about 3-5
>> +		 * times bigger than that of when writing the trace serially.
>> +		 * To limit the volume of context switches from perf tool
>> +		 * process nanosleep() call below is added prior aio_suspend()
>> +		 * calling till every half of the kernel timer tick which is
>> +		 * usually 1ms (depends on CONFIG_HZ value).
> 
> nice, any idea this is intentional for some reason?
> 
> was there some impact on the overall performance or
> this is purely for the sanity of the trace size?

Initially we noticed the trace size increase only. However if you look at 
the data using perf report you see that Perf tool process gets considerable 
volume of new context switches and that is what caused by switching 
to AIO streaming, specifically frequent calls of aio_suspend().

> 
> thanks,
> jirka
> 
