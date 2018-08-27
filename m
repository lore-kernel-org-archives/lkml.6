Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89CB208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89CB208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeH0NGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:06:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:57710 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeH0NGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:06:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 02:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="83688255"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2018 02:20:53 -0700
Received: from [10.125.252.155] (abudanko-mobl.ccr.corp.intel.com [10.125.252.155])
        by linux.intel.com (Postfix) with ESMTP id 25D555803DA;
        Mon, 27 Aug 2018 02:20:50 -0700 (PDT)
Subject: Re: [PATCH v1 2/2]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <dcd3ee88-57d6-8704-f5e1-7a3c75a17d8d@linux.intel.com>
 <2db359cc-dc5d-c00e-a42a-12a2e9da80b7@linux.intel.com>
 <20180826214856.GA24518@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3a8286ff-124f-fb56-1d1c-5d5e1f3b8512@linux.intel.com>
Date:   Mon, 27 Aug 2018 12:20:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180826214856.GA24518@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27.08.2018 0:48, Jiri Olsa wrote:
> On Tue, Aug 21, 2018 at 11:27:03AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> -static int record__pushfn(void *to, void *bf, size_t size)
>> +static int record__pushfn(void *to, void *bf, size_t size, off_t off)
>>  {
>>  	struct record *rec = to;
>> +	struct perf_mmap *map = bf;
>>  
>>  	rec->samples++;
>> -	return record__write(rec, bf, size);
>> +	return record__aio_write(rec->session->data->file.fd, &map->cblock,
>> +			map->data, size, off);
>>  }
>>  
>>  static volatile int done;
>> @@ -528,13 +530,85 @@ static struct perf_event_header finished_round_event = {
>>  	.type = PERF_RECORD_FINISHED_ROUND,
>>  };
>>  
>> +static int record__mmap_read_sync(int trace_fd, struct aiocb **cblocks,
>> +		int cblocks_size, struct record *rec)
>> +{
>> +	size_t rem;
>> +	ssize_t size;
>> +	off_t rem_off;
>> +	int i, aio_ret, aio_errno, do_suspend;
>> +	struct perf_mmap *md;
>> +	struct timespec timeout0 = { 0, 0 };
>> +	struct timespec timeoutS = { 0, 1000 * 500  * 1 };
>> +
>> +	if (!cblocks_size)
>> +		return 0;
>> +
>> +	do {
>> +		do_suspend = 0;
>> +		nanosleep(&timeoutS, NULL);
> 
> why the extra sleep in here and not sleeping through aio_suspend call?

Yep. Good question. That requires explicit explanation:

+               /* aio_suspend() implementation inside glibc (as of v2.27) is
+                * intrusive and not just blocks waiting io requests completion
+                * but polls requests queue inducing context switches in perf
+                * tool process. When profiling in system wide mode with tracing
+                * context switches the trace may be polluted by context switches
+                * from the perf process and the trace size becomes about 3-5
+                * times bigger than that of when writing the trace serially.
+                * To limit the volume of context switches from perf tool
+                * process nonsleep() call limits aio_suspend()
+                * polling till every half of the kernel timer tick which is
+                * usually 1ms (depends on CONFIG_HZ value).
+                */

> 
> jirka
> 
>> +		if (aio_suspend((const struct aiocb**)cblocks, cblocks_size, &timeout0)) {
>> +			if (errno == EAGAIN || errno == EINTR) {
>> +				do_suspend = 1;
>> +				continue;
>> +			} else {
>> +				pr_err("failed to sync perf data, error: %m\n");
> 
> SNIP
> 
