Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839D5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC70208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC70208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeH0OLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:11:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:17021 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeH0OLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:11:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 03:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="75890976"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Aug 2018 03:25:38 -0700
Received: from [10.125.252.155] (abudanko-mobl.ccr.corp.intel.com [10.125.252.155])
        by linux.intel.com (Postfix) with ESMTP id 6DAEE5803DA;
        Mon, 27 Aug 2018 03:25:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/2]: perf record: enable asynchronous trace writing
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-team@lge.com
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
 <20180827083852.GF24695@krava>
 <a34aa784-e36c-02fd-3e9d-7df4bc61ffe2@linux.intel.com>
 <20180827100536.GA8065@sejong>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3c0a8ecc-a68e-7e19-066c-096f7e318e1f@linux.intel.com>
Date:   Mon, 27 Aug 2018 13:25:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827100536.GA8065@sejong>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On 27.08.2018 13:05, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Aug 27, 2018 at 12:33:07PM +0300, Alexey Budankov wrote:
>> Hi,
>>
>> On 27.08.2018 11:38, Jiri Olsa wrote:
>>> On Thu, Aug 23, 2018 at 07:47:01PM +0300, Alexey Budankov wrote:
>>>
>>> SNIP
>>>
>>>>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
>>>>  				    bool overwrite)
>>>>  {
>>>>  	u64 bytes_written = rec->bytes_written;
>>>> -	int i;
>>>> -	int rc = 0;
>>>> +	int i, rc = 0;
>>>>  	struct perf_mmap *maps;
>>>> +	int trace_fd = rec->session->data->file.fd;
>>>> +	struct aiocb **mmap_aio = rec->evlist->mmap_aio;
>>>> +	int mmap_aio_size = 0;
>>>> +	off_t off;
>>>>  
>>>>  	if (!evlist)
>>>>  		return 0;
>>>> @@ -546,14 +620,17 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>>>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
>>>>  		return 0;
>>>>  
>>>> +	off = lseek(trace_fd, 0, SEEK_CUR);
>>>> +
>>>
>>> with async write, do we need to query/set the offset like this
>>> all the time?
>>
>> It looks like we need it this way. Internally glibc AIO implements writes 
>> using pwrite64 syscall in our case. The sycall requires offset as a parameter 
>> and doesn't update file position on the completion.
>>
>>>
>>> could we just keep/update the offset value in the 'struct perf_data_file'
>>> and skip both lseek calls?
>>
>> Don't see how it is possible. offset is different for every enqeued write 
>> operation and write areas don't intersect for the whole writing loop. 
>> To know the final file position it is required to iterate thru 
>> the loop.
> 
> But as far as I can see the offset is linearly updated in
> perf_mmap__push() and I guess those two lseek() calls will return
> a same value as the last updated offset, no?

Yes, offset is linearly calculated by perf_mmap__push() code for 
the next possible write operation, but file position is update by 
the kernel only in the second lseek() syscall after the loop. 
The first lseek() syscall reads that file position for 
the next loop iterations.

Regards,
Alexey

> 
> Thanks,
> Namhyung
> 
