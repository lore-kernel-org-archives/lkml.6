Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29486C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5E52098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5E52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbeJKXwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:52:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:54762 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbeJKXwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:52:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 09:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="98562887"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 11 Oct 2018 09:24:20 -0700
Received: from [10.252.28.165] (abudanko-mobl.ccr.corp.intel.com [10.252.28.165])
        by linux.intel.com (Postfix) with ESMTP id 24159580496;
        Thu, 11 Oct 2018 09:24:17 -0700 (PDT)
Subject: Re: [PATCH v12 3/3]: perf record: extend trace writing to multi AIO
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e045b4aa-bff1-4e40-4cdf-4504003ecff5@linux.intel.com>
 <39da34d3-7198-7514-b000-7bfbf382e526@linux.intel.com>
 <20181011134605.GD29634@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f2e5b55c-5dd8-84e0-dd95-cbb8e17bb888@linux.intel.com>
Date:   Thu, 11 Oct 2018 19:24:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011134605.GD29634@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2018 16:46, Jiri Olsa wrote:
> On Tue, Oct 09, 2018 at 11:59:31AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> @@ -709,12 +729,13 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  					goto out;
>>  				}
>>  			} else {
>> +				int idx;
>>  				/*
>>  				 * Call record__aio_sync() to wait till map->data buffer
>>  				 * becomes available after previous aio write request.
>>  				 */
>> -				record__aio_sync(map);
>> -				if (perf_mmap__aio_push(map, rec, record__aio_pushfn, &off) != 0) {
>> +				idx = record__aio_sync(map, false);
> 
> looks like record__aio_sync can return -1,
> how is it not breaking the perf_mmap__aio_push call below?

Currently -1 may be returned only when calling with 
sync_all==true i.e. record__aio_sync(, true).

Thanks,
Alexey

> 
>> +				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
>>  					record__aio_set_pos(trace_fd, off);
>>  					rc = -1;
>>  					goto out;
> 
> SNIP
> 
