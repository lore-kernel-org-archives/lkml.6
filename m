Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA4FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5352086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5352086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeLLMPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:15:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbeLLMPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:15:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8D5930917A1;
        Wed, 12 Dec 2018 12:15:33 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 388325D70A;
        Wed, 12 Dec 2018 12:15:32 +0000 (UTC)
Date:   Wed, 12 Dec 2018 13:15:31 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] perf record: apply affinity masks when reading
 mmap buffers
Message-ID: <20181212121531.GD25240@krava>
References: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
 <6e5df6f0-5dfa-265e-73cd-803de96ac9b2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5df6f0-5dfa-265e-73cd-803de96ac9b2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 12 Dec 2018 12:15:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:40:22AM +0300, Alexey Budankov wrote:
> 
> Build node cpu masks for mmap data buffers. Bind AIO data buffers
> to nodes according to kernel data buffers location. Apply node cpu
> masks to trace reading thread every time it references memory cross
> node or cross cpu.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c |  9 +++++++++
>  tools/perf/util/evlist.c    |  6 +++++-
>  tools/perf/util/mmap.c      | 38 ++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/mmap.h      |  1 +
>  4 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4979719e54ae..1a1438c73f96 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -532,6 +532,9 @@ static int record__mmap_evlist(struct record *rec,
>  	struct record_opts *opts = &rec->opts;
>  	char msg[512];
>  
> +	if (opts->affinity != PERF_AFFINITY_SYS)
> +		cpu__setup_cpunode_map();
> +
>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>  				 opts->auxtrace_mmap_pages,
>  				 opts->auxtrace_snapshot_mode,
> @@ -751,6 +754,12 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  		struct perf_mmap *map = &maps[i];
>  
>  		if (map->base) {
> +			if (rec->opts.affinity != PERF_AFFINITY_SYS &&
> +			    !CPU_EQUAL(&rec->affinity_mask, &map->affinity_mask)) {
> +				CPU_ZERO(&rec->affinity_mask);
> +				CPU_OR(&rec->affinity_mask, &rec->affinity_mask, &map->affinity_mask);
> +				sched_setaffinity(0, sizeof(rec->affinity_mask), &rec->affinity_mask);
> +			}

hum, so you change affinity every time you read different map?
I'm surprised this is actualy faster..

anyway this patch is doing 2 things.. binding the memory allocation
to nodes and setting the process affinity, please seprate those and
explain the logic behind

thanks,
jirka
