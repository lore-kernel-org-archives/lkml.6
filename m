Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D84C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7396B2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbfBMBkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:40:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:17068 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfBMBkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:40:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 17:40:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,364,1544515200"; 
   d="scan'208";a="124043653"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.159.76]) ([10.239.159.76])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2019 17:40:06 -0800
Subject: Re: [PATCH] perf/core: don't WARN for impossible rb sizes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        julien.thierry@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Jin, Yao" <yao.jin@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20190110142745.25495-1-mark.rutland@arm.com>
 <1f71da66-4783-0108-668c-cdffca499719@linux.intel.com>
 <20190212130756.GH32494@hirez.programming.kicks-ass.net>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <023208e9-4aec-3401-8ec1-6368a01df8f7@linux.intel.com>
Date:   Wed, 13 Feb 2019 09:40:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130756.GH32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/2019 9:07 PM, Peter Zijlstra wrote:
> On Tue, Feb 12, 2019 at 10:42:38AM +0800, Jin, Yao wrote:
>>> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
>>> index 4a9937076331..309ef5a64af5 100644
>>> --- a/kernel/events/ring_buffer.c
>>> +++ b/kernel/events/ring_buffer.c
>>> @@ -734,6 +734,9 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>>>    	size = sizeof(struct ring_buffer);
>>>    	size += nr_pages * sizeof(void *);
>>> +	if (order_base_2(size) >= MAX_ORDER)
>>> +		goto fail;
>>> +
>>>    	rb = kzalloc(size, GFP_KERNEL);
> 
> Yes, Boris also send the entire morning bisecting this.
> 
> The problem is that @size is in bytes and MAX_ORDER is in pages.
> 
> That should be:
> 
>    if (order_base_2(size) >= PAGE_SHIFT+MAX_ORDER)
> 
> 

Thanks Peter! This fix works!

Thanks
Jin Yao
