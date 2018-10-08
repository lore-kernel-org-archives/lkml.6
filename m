Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF7BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4239920858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4239920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeJHTgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:36:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:37249 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbeJHTgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:36:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 05:24:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="263839093"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 08 Oct 2018 05:24:34 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id C2F355801E6;
        Mon,  8 Oct 2018 05:24:32 -0700 (PDT)
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <de91f032-94e5-626e-bf2c-2f3a21ab6db1@linux.intel.com>
Date:   Mon, 8 Oct 2018 15:24:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008105254.GG17270@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.10.2018 13:52, Jiri Olsa wrote:
> On Mon, Oct 08, 2018 at 09:17:11AM +0300, Alexey Budankov wrote:
<SNIP>
>> +#ifdef HAVE_AIO_SUPPORT
>> +	off = lseek(trace_fd, 0, SEEK_CUR);
>> +#endif
> 
> I'm still little puzzled why we need to do this,
> when the aio write takes the offset value, but

pwrite() syscall [1] which is the base for aio_write() doesn't 
advance file pos value so it requires to be calculated and 
updated by callers of aio_write() API.

> please provide some aio_.. function for this

Accepted.

> 
> 
>>  	for (i = 0; i < evlist->nr_mmaps; i++) {
>>  		struct perf_mmap *map = &maps[i];
>>  
>>  		if (map->base) {
>> -			if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>> -				rc = -1;
>> -				goto out;
>> +#ifdef HAVE_AIO_SUPPORT
>> +			if (!rec->opts.nr_cblocks) {
>> +#endif
>> +				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>> +					rc = -1;
>> +					goto out;
>> +				}
>> +#ifdef HAVE_AIO_SUPPORT
>> +			} else {
>> +				/*
>> +				 * Call record__aio_sync() to wait till map->data buffer
>> +				 * becomes available after previous aio write request.
>> +				 */
>> +				record__aio_sync(map);
>> +				if (perf_mmap__aio_push(map, rec, record__aio_pushfn, &off) != 0) {
>> +					lseek(trace_fd, off, SEEK_SET);
>> +					rc = -1;
>> +					goto out;
>> +				}
>>  			}
>> +#endif
>>  		}
>>  
>>  		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
>> @@ -547,7 +694,9 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  			goto out;
>>  		}
>>  	}
>> -
>> +#ifdef HAVE_AIO_SUPPORT
>> +	lseek(trace_fd, off, SEEK_SET);
>> +#endif
> 
> ditto

Accepted.

Thanks,
Alexey

> 
> thanks,
> jirka
> 

[1] http://man7.org/linux/man-pages/man2/pread.2.html


