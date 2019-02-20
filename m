Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B81221848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfBTOoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:44:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:16558 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfBTOoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:44:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 06:44:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="145041599"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2019 06:44:30 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id 3B22E58019B;
        Wed, 20 Feb 2019 06:44:28 -0800 (PST)
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
 <20190212130930.GN775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e4b6b710-f144-2da5-c92a-c78d196d8a02@linux.intel.com>
Date:   Wed, 20 Feb 2019 17:44:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130930.GN775@krava>
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
>> @@ -1932,6 +2059,38 @@ fetch_mmaped_event(struct perf_session *session,
>>  	return event;
>>  }
>>  
>> +static int __perf_session__process_decomp_events(struct perf_session *session)
>> +{
>> +	s64 skip;
>> +	u64 size, file_pos = 0;
>> +	union perf_event *event;
>> +	struct decomp *decomp = session->decomp_last;
>> +
>> +	if (!decomp)
>> +		return 0;
>> +
>> +	while (decomp->head < decomp->size && !session_done()) {
> 
> so how this actualy works? does one PERF_RECORD_COMPRESSED event carry
> complete data to unpack? or you wait to receive more PERF_RECORD_COMPRESSED
> to give you data you can unpack?

One record contains compressed data chunk that is ready for decompression.
Record header is skipped and the rest is fetched to perf_session__zstd_decompress()
also providing the buffer to decompress to, which is of the size encoded in 
the file header (comp_mmap_len). After decompression the buffer is iterated 
the same way as mmapped event records. Decompressed split event records are 
handled. Decompressed buffers are chained into the linked list so the records 
memory remains available for later references.

Thanks,
Alexey

> 
> jirka
> 
