Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A428DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F218208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F218208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeH0Nbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:31:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:5482 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeH0Nbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:31:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 02:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="83693112"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2018 02:45:41 -0700
Received: from [10.125.252.155] (abudanko-mobl.ccr.corp.intel.com [10.125.252.155])
        by linux.intel.com (Postfix) with ESMTP id BBCC85802AD;
        Mon, 27 Aug 2018 02:45:39 -0700 (PDT)
Subject: Re: [PATCH v2 2/2]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
 <20180827084333.GG24695@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2c525930-fbfd-2ea7-0b80-b67eff9b44cf@linux.intel.com>
Date:   Mon, 27 Aug 2018 12:45:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827084333.GG24695@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27.08.2018 11:43, Jiri Olsa wrote:
> On Thu, Aug 23, 2018 at 07:47:01PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
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
>> +	struct timespec timeoutS = { 0, 1000 * 1000  * 1 };
>> +
>> +	if (!cblocks_size)
>> +		return 0;
>> +
>> +	do {
>> +		do_suspend = 0;
>> +		nanosleep(&timeoutS, NULL);
>> +		if (aio_suspend((const struct aiocb**)cblocks, cblocks_size, &timeout0)) {
>> +			if (errno == EAGAIN || errno == EINTR) {
>> +				do_suspend = 1;
>> +				continue;
>> +			} else {
>> +				pr_err("failed to sync perf data, error: %m\n");
>> +				break;
>> +			}
>> +		}
>> +		for (i = 0; i < cblocks_size; i++) {
> 
> it looks like we could set up the async write to receive the signal
> with the user pointer (sigev_value.sival_ptr), which would allow us
> to get the finished descriptor right away and we wouldn't need
> to iterate all of them and checking on them

Yep. This mechanism is provided by AIO API, but we still need this kind of 
synchronizing barrier to avoid memory races on mmap->data buffer between 
calls of the loop in record__mmap_read_evlist().

> 
> jirka
>> +			if (cblocks[i] == NULL) {
>> +				continue;
>> +			}
>> +			aio_errno = aio_error(cblocks[i]);
>> +			if (aio_errno == EINPROGRESS) {
>> +				do_suspend = 1;
>> +				continue;
>> +			}
> 
> SNIP
> 
