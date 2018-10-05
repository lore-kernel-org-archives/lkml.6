Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D17C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DD0208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DD0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeJEQhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:37:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:39981 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbeJEQhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:37:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 02:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,343,1534834800"; 
   d="scan'208";a="268692163"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2018 02:39:14 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id CB8B95801E6;
        Fri,  5 Oct 2018 02:39:11 -0700 (PDT)
Subject: Re: [PATCH v9 2/3]: perf record: enable asynchronous trace writing
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@lge.com
References: <ded47c34-9e92-6bd2-9522-a927a7237011@linux.intel.com>
 <5ed78452-ff2b-dfe5-ec29-888971cb4b55@linux.intel.com>
 <20181005071615.GC3768@sejong>
 <dc944fcf-cbb6-9b88-bc1c-606eb027a6ac@linux.intel.com>
 <20181005084854.GE3768@sejong>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <4ee1c347-674b-ac61-65cf-55fb71a7cc2b@linux.intel.com>
Date:   Fri, 5 Oct 2018 12:39:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005084854.GE3768@sejong>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05.10.2018 11:48, Namhyung Kim wrote:
> On Fri, Oct 05, 2018 at 11:31:11AM +0300, Alexey Budankov wrote:
<SNIP>
>>
>> Well, this could be implemented like this avoiding lseek() in else branch:
>>
>> 	off = lseek(trace_fd, 0, SEEK_CUR);
>> 	ret = record__aio_write(cblock, trace_fd, bf, size, off);
>> 	if (!ret) {
>> 		lseek(trace_fd, off + size, SEEK_SET);
>> 		rec->bytes_written += size;
>>
>> 		if (switch_output_size(rec))
>> 			trigger_hit(&switch_output_trigger);
>> 	}
> 
> Oh I meant the both like:
> 
> 	off = rec->bytes_written;
>  	ret = record__aio_write(cblock, trace_fd, bf, size, off);
>  	if (!ret) {
>  		rec->bytes_written += size;
> 
> 		...
> 

It still have to adjust the file pos thru lseek() prior leaving 
record__aio_pushfn() so space in trace file would be pre-allocated for 
enqueued record and file pos be moved beyond the record data, 
possibly for the next record.

> 
<SNIP>
> 
> Why not exposing opts.nr_cblocks regardless of the #ifdef?  It'll have
> 0 when it's not compiled in.  Then it could be like below (assuming
> you have all the dummy aio funcitons):
> 
> 
>>
>> 		if (map->base) {
>> 			if (!rec->opts.nr_cblocks) {
>> 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>> 					rc = -1;
>> 					goto out;
>> 				}
>> 			} else {
>> 				int idx;
>> 				/*
>> 				 * Call record__aio_sync() to wait till map->data buffer
>> 				 * becomes available after previous aio write request.
>> 				 */
>> 				idx = record__aio_sync(map, false);
>> 				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn) != 0) {
>> 					rc = -1;
>> 					goto out;
>> 				}
>> 			}
>> 		}
>>

Well, if it has AIO symbols + opts.nr_cblocks exposed unconditionally of 
HAVE_AIO_SUPPORT, but keeps the symbols implementation under the define, then
as far aio-cblocks option is not exposed thru command line, we end up in
whole bunch of symbols referenced under the else branch that, after all, 
can cause Perf binary size increase, which is, probably, worth avoiding.

Thanks,
Alexey
