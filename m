Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E59C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B5420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfAIJNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:13:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:35449 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfAIJNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:13:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:13:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="108470244"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 09 Jan 2019 01:13:53 -0800
Received: from [10.125.252.236] (abudanko-mobl.ccr.corp.intel.com [10.125.252.236])
        by linux.intel.com (Postfix) with ESMTP id CF2C158056F;
        Wed,  9 Jan 2019 01:13:50 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 3/4] perf record: apply affinity masks when reading
 mmap buffers
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
 <4b7b902b-01b7-7a3f-eee2-e7fc8433322c@linux.intel.com>
 <20190101213932.GE13760@krava>
Organization: Intel Corp.
Message-ID: <94e6b67e-441c-89cb-eb10-1c8d135d8840@linux.intel.com>
Date:   Wed, 9 Jan 2019 12:13:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190101213932.GE13760@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02.01.2019 0:39, Jiri Olsa wrote:
> On Mon, Dec 24, 2018 at 03:27:17PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index 742fa9a8e498..a2095e4eda4b 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -361,6 +361,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
>>  
>>  int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
>>  {
>> +	int c, nr_cpus, node;
>>  	/*
>>  	 * The last one will be done at perf_mmap__consume(), so that we
>>  	 * make sure we don't prevent tools from consuming every last event in
>> @@ -389,6 +390,17 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
>>  	map->cpu = cpu;
>>  
>>  	CPU_ZERO(&map->affinity_mask);
>> +	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1) {
>> +		nr_cpus = cpu_map__nr(mp->cpu_map);
>> +		node = cpu__get_node(map->cpu);
>> +		for (c = 0; c < nr_cpus; c++) {
>> +			if (cpu__get_node(c) == node) {
> 
> the 'c' is just an index here, I think you need to
> use the real cpu value from the mp->cpu_map->map[c]

Well, yes, mapping c index to online cpu index is more generic. 
Corrected in v3. Thanks!

Alexey

> 
> jirka
> 
>> +				CPU_SET(c, &map->affinity_mask);
>> +			}
>> +		}
>> +	} else if (mp->affinity == PERF_AFFINITY_CPU) {
>> +		CPU_SET(map->cpu, &map->affinity_mask);
>> +	}
>>  
>>  	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
>>  				&mp->auxtrace_mp, map->base, fd))
>> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
>> index e566c19b242b..b3f724fad22e 100644
>> --- a/tools/perf/util/mmap.h
>> +++ b/tools/perf/util/mmap.h
>> @@ -72,6 +72,7 @@ enum bkw_mmap_state {
>>  struct mmap_params {
>>  	int			    prot, mask, nr_cblocks, affinity;
>>  	struct auxtrace_mmap_params auxtrace_mp;
>> +	const struct cpu_map	    *cpu_map;
>>  };
>>  
>>  int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu);
> 
