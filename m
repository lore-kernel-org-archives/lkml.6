Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D72C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945352146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfBTOqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:46:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:43160 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTOq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:46:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 06:46:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="119419824"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 20 Feb 2019 06:46:28 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id 31C7E58019B;
        Wed, 20 Feb 2019 06:46:25 -0800 (PST)
Subject: Re: [PATCH v2 4/4] perf report: support record trace file
 decompression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <4f45c930-cf39-76b0-5c56-ee4fb0705fa3@linux.intel.com>
 <20190212130920.GL775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9ce9d437-eda5-ac82-7109-dd64d17b4e7f@linux.intel.com>
Date:   Wed, 20 Feb 2019 17:46:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130920.GL775@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 16:09, Jiri Olsa wrote:
> On Mon, Feb 11, 2019 at 11:25:00PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> +static int perf_session__process_compressed_event(struct perf_session *session,
>> +					union perf_event *event, u64 file_offset)
>> +{
>> +	void *src;
>> +	size_t decomp_size, src_size;
>> +	u64 decomp_last_rem = 0;
>> +	size_t decomp_len = session->header.env.comp_mmap_len;
>> +	struct decomp *decomp, *decomp_last = session->decomp_last;
>> +
>> +	decomp = mmap(NULL, sizeof(struct decomp) + decomp_len, PROT_READ|PROT_WRITE,
>> +		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
>> +	if (decomp == MAP_FAILED) {
>> +		pr_err("Couldn't allocate memory for decompression\n");
>> +		return -1;
>> +	}
>> +
>> +	decomp->file_pos = file_offset;
>> +	decomp->head = 0;
>> +
>> +	if (decomp_last) {
>> +		decomp_last_rem = decomp_last->size - decomp_last->head;
>> +		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
>> +		decomp->size = decomp_last_rem;
>> +	}
>> +
>> +	src = (void *)event + sizeof(struct compressed_event);
>> +	src_size = event->pack.header.size - sizeof(struct compressed_event);
>> +
>> +	decomp_size = perf_session__zstd_decompress(session, src, src_size,
>> +				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
>> +	if (!decomp_size) {
>> +		munmap(decomp, sizeof(struct decomp) + decomp_len);
>> +		pr_err("Couldn't decompress data\n");
>> +		return -1;
>> +	}
>> +
>> +	decomp->size += decomp_size;
>> +
>> +	if (session->decomp == NULL) {
>> +		session->decomp = decomp;
>> +		session->decomp_last = decomp;
>> +	} else {
>> +		session->decomp_last->next = decomp;
>> +		session->decomp_last = decomp;
>> +	}
> 
> can this happen? can you process more compressed events
> before you deliver them in __perf_session__process_decomp_events?
> 
> I think I asked similar question in my other email..

Answered to that mail.

Thanks,
Alexey

> 
> thanks,
> jirka
> 
