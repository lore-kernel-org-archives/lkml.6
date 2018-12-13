Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DBC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1718B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1718B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeLMG0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:26:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:4667 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeLMG0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:26:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 22:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; 
   d="scan'208";a="301779111"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 12 Dec 2018 22:26:50 -0800
Received: from [10.125.251.221] (abudanko-mobl.ccr.corp.intel.com [10.125.251.221])
        by linux.intel.com (Postfix) with ESMTP id 4D74058079C;
        Wed, 12 Dec 2018 22:26:48 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v1 2/3] perf record: apply affinity masks when reading
 mmap buffers
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
 <6e5df6f0-5dfa-265e-73cd-803de96ac9b2@linux.intel.com>
 <20181212121538.GE25240@krava>
Organization: Intel Corp.
Message-ID: <42d1f52c-e140-5d8b-9c18-41b5b9e12292@linux.intel.com>
Date:   Thu, 13 Dec 2018 09:26:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181212121538.GE25240@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 12.12.2018 15:15, Jiri Olsa wrote:
> On Wed, Dec 12, 2018 at 10:40:22AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
>>  {
>> +	int c, nr_cpus, node;
>>  	/*
>>  	 * The last one will be done at perf_mmap__consume(), so that we
>>  	 * make sure we don't prevent tools from consuming every last event in
>> @@ -344,6 +369,17 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
>>  	map->cpu = cpu;
>>  
>>  	CPU_ZERO(&map->affinity_mask);
>> +	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1) {
>> +		nr_cpus = cpu_map__nr(mp->cpu_map);
>> +		node = cpu__get_node(map->cpu);
>> +		for (c = 0; c < nr_cpus; c++) {
>> +			if (cpu__get_node(c) == node) {
>> +				CPU_SET(c, &map->affinity_mask);
>> +			}
>> +		}
>> +	} else if (mp->affinity == PERF_AFFINITY_CPU) {
>> +		CPU_SET(map->cpu, &map->affinity_mask);
>> +	}
> 
> won't both of this end up in same mask?

For tested dual socket 44 core broadwell:

		node 0		node 1
cpu mask	0-21,44-65  	22-43,66-87

For affinity=node map->affinity_mask is either [0-21,44-65] or [22-43,66-87].
For affinity=cpu  map->affinity_mask is [0] or [1] or [2] and so on.

Without affinity option set map->affinity_mask and record->affinity_mask are [].

Thanks,
Alexey

> 
> jirka
> 
