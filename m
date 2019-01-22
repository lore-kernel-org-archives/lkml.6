Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2641DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8A820855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfAVMzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:55:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:6779 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbfAVMzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:55:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 04:55:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,506,1539673200"; 
   d="scan'208";a="137721309"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jan 2019 04:55:37 -0800
Received: from [10.252.24.137] (abudanko-mobl.ccr.corp.intel.com [10.252.24.137])
        by linux.intel.com (Postfix) with ESMTP id 97EA3580434;
        Tue, 22 Jan 2019 04:55:35 -0800 (PST)
Subject: Re: [PATCH v4 3/4] perf record: apply affinity masks when reading
 mmap buffers
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <77852017-b6ee-4fe1-4f3d-63827d78078f@linux.intel.com>
 <ba339341-d73e-e341-5881-a9ec0eb852a5@linux.intel.com>
 <20190121115428.GA3852@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b07a5a09-f301-c761-4c63-6eb9cc59ac33@linux.intel.com>
Date:   Tue, 22 Jan 2019 15:55:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190121115428.GA3852@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 21.01.2019 14:54, Jiri Olsa wrote:
> On Wed, Jan 16, 2019 at 12:23:05PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
>>  				    bool overwrite)
>>  {
>> @@ -755,6 +768,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  		struct perf_mmap *map = &maps[i];
>>  
>>  		if (map->base) {
>> +			record__adjust_affinity(rec, map);
>>  			if (!record__aio_enabled(rec)) {
>>  				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>>  					rc = -1;
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 08cedb643ea6..178d3280ba62 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -1032,7 +1032,11 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
>>  	 * Its value is decided by evsel's write_backward.
>>  	 * So &mp should not be passed through const pointer.
>>  	 */
>> -	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
>> +	struct mmap_params mp = {
>> +		.nr_cblocks	= nr_cblocks,
>> +		.affinity	= affinity,
>> +		.cpu_map	= cpu_map__new(NULL) /* from /sys/devices/system/cpu/online */
>> +	};
> 
> cpu_map won't get released.. if there's no better solution,
> at least we could have it as static in build_node_mask..
> this way it will be created only once

nice catch, thanks!! moved the static into a separate cpu_map__online() 
in cpumap.c and that simplified the changes a bit.

Alexey

> 
> jirka
> 
