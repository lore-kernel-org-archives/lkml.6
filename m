Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712C6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D29D206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfAIQ6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:58:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:55579 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbfAIQ6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:58:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 08:58:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="133082793"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jan 2019 08:58:18 -0800
Received: from [10.252.18.78] (abudanko-mobl.ccr.corp.intel.com [10.252.18.78])
        by linux.intel.com (Postfix) with ESMTP id 20AD35802E1;
        Wed,  9 Jan 2019 08:58:15 -0800 (PST)
Subject: Re: [PATCH v3 2/4] perf record: bind the AIO user space buffers to
 nodes
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <b31ddfd5-a017-d8da-14eb-d1b48bfc255b@linux.intel.com>
 <848d3b31-7efb-880b-3e82-87ba6748104c@linux.intel.com>
 <20190109155853.GA19455@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <75316888-2c63-bbe4-7b2d-2e87ea5102c6@linux.intel.com>
Date:   Wed, 9 Jan 2019 19:58:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109155853.GA19455@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 09.01.2019 18:58, Jiri Olsa wrote:
> On Wed, Jan 09, 2019 at 12:37:17PM +0300, Alexey Budankov wrote:
>>
>> Allocate and bind AIO user space buffers to the memory nodes
>> that mmap kernel buffers are bound to.
<SNIP>
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
<SNIP>
>> +static void perf_mmap__aio_bind(struct perf_mmap *map, int index, int cpu, int affinity)
>> +{
>> +	void *data;
>> +	size_t mmap_len;
>> +	unsigned long node_mask;
>> +
>> +	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
>> +		data = map->aio.data[index];
>> +		mmap_len = perf_mmap__mmap_len(map);
>> +		node_mask = 1UL << cpu__get_node(cpu);
>> +		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
>> +			pr_warn("failed to bind [%p-%p] to node %d\n",
>> +				data, data + mmap_len, cpu__get_node(cpu));
>> +		}
> 
> getting compilation fail in here:
> 
>   CC       util/mmap.o
> util/mmap.c: In function ‘perf_mmap__aio_bind’:
> util/mmap.c:193:4: error: implicit declaration of function ‘pr_warn’; did you mean ‘pr_warning’? [-Werror=implicit-function-declaration]
>     pr_warn("failed to bind [%p-%p] to node %d\n",
>     ^~~~~~~
>     pr_warning
> util/mmap.c:193:4: error: nested extern declaration of ‘pr_warn’ [-Werror=nested-externs]
> cc1: all warnings being treated as errors

Yes, it should be pr_warning().
This hunk missed when I was preparing the patches - sorry.
It will be included into v4.

Thanks!
Alexey

> 
> 
> jirka
> 
