Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B995C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D61C214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfAJJyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:54:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbfAJJyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:54:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 571CA356E7;
        Thu, 10 Jan 2019 09:54:53 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id A69455C6C1;
        Thu, 10 Jan 2019 09:54:51 +0000 (UTC)
Date:   Thu, 10 Jan 2019 10:54:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] perf record: apply affinity masks when reading
 mmap buffers
Message-ID: <20190110095450.GB25764@krava>
References: <b31ddfd5-a017-d8da-14eb-d1b48bfc255b@linux.intel.com>
 <a5081531-f89b-9d5a-df16-76a1de3c0d82@linux.intel.com>
 <20190109165330.GC19455@krava>
 <93fedb49-f4fc-8153-2920-5b6b107bbca2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93fedb49-f4fc-8153-2920-5b6b107bbca2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 10 Jan 2019 09:54:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:41:55PM +0300, Alexey Budankov wrote:
> On 09.01.2019 19:53, Jiri Olsa wrote:
> > On Wed, Jan 09, 2019 at 12:38:23PM +0300, Alexey Budankov wrote:
> > 
> > SNIP
> > 
> >> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> >> index e5220790f1fb..ee0230eed635 100644
> >> --- a/tools/perf/util/mmap.c
> >> +++ b/tools/perf/util/mmap.c
> >> @@ -377,6 +377,24 @@ void perf_mmap__munmap(struct perf_mmap *map)
> >>  	auxtrace_mmap__munmap(&map->auxtrace_mmap);
> >>  }
> >>  
> >> +static void perf_mmap__setup_affinity_mask(struct perf_mmap *map, struct mmap_params *mp)
> >> +{
> >> +	int c, cpu, nr_cpus, node;
> >> +
> >> +	CPU_ZERO(&map->affinity_mask);
> >> +	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1) {
> >> +		nr_cpus = cpu_map__nr(mp->cpu_map);
> >> +		node = cpu__get_node(map->cpu);
> >> +		for (c = 0; c < nr_cpus; c++) {
> >> +			cpu = mp->cpu_map->map[c]; /* map c index to online cpu index */
> >> +			if (cpu__get_node(cpu) == node)
> >> +				CPU_SET(cpu, &map->affinity_mask);
> > 
> > should we do that from from all possible cpus task (perf record)
> > can run on, instead of mp->cpu_map, which might be only subset
> > (-C ... option)
> 
> That is how it should be and because mp->cpu_map depends on -C option value 
> in this patch set version it requires to be corrected, possibly like this:
> 
> struct mmap_params mp = {
> 		.nr_cblocks	= nr_cblocks,
> 		.affinity	= affinity,
> 		.cpu_map	= cpu_map__new(NULL) /* builds struct cpu_map from /sys/devices/system/cpu/online */
> 	}; 
> and 
> 	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1 && mp->cpu_map)
> 
> Thanks!
> 
> > 
> > also node -> cpu_map is static configuration, we could prepare
> > this map ahead (like cpunode_map) and just assign it in here
> > based on node index
> 
> It makes sense and either way is possible. However the static configuration 
> looks a bit trickier because it incurs additional mask objects duplication 
> and conversion from struct cpu_map to cpu_set_t still remains the same.

ok, please at least put that node mask creation into separate function

thanks,
jirka
