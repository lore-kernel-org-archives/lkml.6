Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07504C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CAB214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfAJKUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:20:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:12047 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbfAJKUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:20:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 02:20:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,460,1539673200"; 
   d="scan'208";a="133338060"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jan 2019 02:20:02 -0800
Received: from [10.125.252.115] (abudanko-mobl.ccr.corp.intel.com [10.125.252.115])
        by linux.intel.com (Postfix) with ESMTP id 5705958050C;
        Thu, 10 Jan 2019 02:20:00 -0800 (PST)
Subject: Re: [PATCH v3 3/4] perf record: apply affinity masks when reading
 mmap buffers
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <b31ddfd5-a017-d8da-14eb-d1b48bfc255b@linux.intel.com>
 <a5081531-f89b-9d5a-df16-76a1de3c0d82@linux.intel.com>
 <20190109165330.GC19455@krava>
 <93fedb49-f4fc-8153-2920-5b6b107bbca2@linux.intel.com>
 <20190110095450.GB25764@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f179e86a-d9ca-1e3a-aa34-e255c6547982@linux.intel.com>
Date:   Thu, 10 Jan 2019 13:19:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190110095450.GB25764@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.2019 12:54, Jiri Olsa wrote:
> On Thu, Jan 10, 2019 at 12:41:55PM +0300, Alexey Budankov wrote:
>> On 09.01.2019 19:53, Jiri Olsa wrote:
>>> On Wed, Jan 09, 2019 at 12:38:23PM +0300, Alexey Budankov wrote:
>>>
>>> SNIP
>>>
>>>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>>>> index e5220790f1fb..ee0230eed635 100644
>>>> --- a/tools/perf/util/mmap.c
>>>> +++ b/tools/perf/util/mmap.c
>>>> @@ -377,6 +377,24 @@ void perf_mmap__munmap(struct perf_mmap *map)
>>>>  	auxtrace_mmap__munmap(&map->auxtrace_mmap);
>>>>  }
>>>>  
>>>> +static void perf_mmap__setup_affinity_mask(struct perf_mmap *map, struct mmap_params *mp)
>>>> +{
>>>> +	int c, cpu, nr_cpus, node;
>>>> +
>>>> +	CPU_ZERO(&map->affinity_mask);
>>>> +	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1) {
>>>> +		nr_cpus = cpu_map__nr(mp->cpu_map);
>>>> +		node = cpu__get_node(map->cpu);
>>>> +		for (c = 0; c < nr_cpus; c++) {
>>>> +			cpu = mp->cpu_map->map[c]; /* map c index to online cpu index */
>>>> +			if (cpu__get_node(cpu) == node)
>>>> +				CPU_SET(cpu, &map->affinity_mask);
>>>
>>> should we do that from from all possible cpus task (perf record)
>>> can run on, instead of mp->cpu_map, which might be only subset
>>> (-C ... option)
>>
>> That is how it should be and because mp->cpu_map depends on -C option value 
>> in this patch set version it requires to be corrected, possibly like this:
>>
>> struct mmap_params mp = {
>> 		.nr_cblocks	= nr_cblocks,
>> 		.affinity	= affinity,
>> 		.cpu_map	= cpu_map__new(NULL) /* builds struct cpu_map from /sys/devices/system/cpu/online */
>> 	}; 
>> and 
>> 	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1 && mp->cpu_map)
>>
>> Thanks!
>>
>>>
>>> also node -> cpu_map is static configuration, we could prepare
>>> this map ahead (like cpunode_map) and just assign it in here
>>> based on node index
>>
>> It makes sense and either way is possible. However the static configuration 
>> looks a bit trickier because it incurs additional mask objects duplication 
>> and conversion from struct cpu_map to cpu_set_t still remains the same.
> 
> ok, please at least put that node mask creation into separate function

Will do like this:

static void build_node_mask(const struct cpu_map *cpumap, int node, cpu_set_t *mask)

Thanks,
Alexey

> 
> thanks,
> jirka
> 
