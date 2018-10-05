Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92173C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532CB206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532CB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeJESsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:48:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:53979 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbeJESsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:48:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 04:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="78970411"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 05 Oct 2018 04:50:06 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id D1B55580332;
        Fri,  5 Oct 2018 04:50:03 -0700 (PDT)
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
 <4ee1c347-674b-ac61-65cf-55fb71a7cc2b@linux.intel.com>
 <20181005105557.GF3768@sejong>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <c5129bc1-1e69-0fcc-c552-9bda51886bcf@linux.intel.com>
Date:   Fri, 5 Oct 2018 14:50:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005105557.GF3768@sejong>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05.10.2018 13:55, Namhyung Kim wrote:
<SNIP>
> On Fri, Oct 05, 2018 at 12:39:10PM +0300, Alexey Budankov wrote:
<SNIP>
>>
>> It still have to adjust the file pos thru lseek() prior leaving 
>> record__aio_pushfn() so space in trace file would be pre-allocated for 
>> enqueued record and file pos be moved beyond the record data, 
>> possibly for the next record.
> 
> For that purpose, isn't it better calling ftruncate() with a
> reasonable batch size to reduce number of syscalls?
> 

According to docs [1] ftruncate() does not advance file pos 
which is essential here.

> 
<SNIP>
>> Well, if it has AIO symbols + opts.nr_cblocks exposed unconditionally of 
>> HAVE_AIO_SUPPORT, but keeps the symbols implementation under the define, then
>> as far aio-cblocks option is not exposed thru command line, we end up in
>> whole bunch of symbols referenced under the else branch that, after all, 
>> can cause Perf binary size increase, which is, probably, worth avoiding.
> 
> I think it's ok as long as they're empty.

Well, the both designs are possible and acceptable.
The only thing that matters here is contradictive requests from other reviewing folks. 
Let me share the version without dummy functions so 
we could jointly decide how to proceed from there. 
Ok?

Thanks,
Alexey

[1] http://man7.org/linux/man-pages/man2/ftruncate.2.html
