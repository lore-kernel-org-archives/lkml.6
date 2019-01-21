Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0E0C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2568D21019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfAULyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:54:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbfAULyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:54:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 369ED58E23;
        Mon, 21 Jan 2019 11:54:33 +0000 (UTC)
Received: from krava (unknown [10.40.205.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4AC676013C;
        Mon, 21 Jan 2019 11:54:29 +0000 (UTC)
Date:   Mon, 21 Jan 2019 12:54:28 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] perf record: apply affinity masks when reading
 mmap buffers
Message-ID: <20190121115428.GA3852@krava>
References: <77852017-b6ee-4fe1-4f3d-63827d78078f@linux.intel.com>
 <ba339341-d73e-e341-5881-a9ec0eb852a5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba339341-d73e-e341-5881-a9ec0eb852a5@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 21 Jan 2019 11:54:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:23:05PM +0300, Alexey Budankov wrote:

SNIP

>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
>  				    bool overwrite)
>  {
> @@ -755,6 +768,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  		struct perf_mmap *map = &maps[i];
>  
>  		if (map->base) {
> +			record__adjust_affinity(rec, map);
>  			if (!record__aio_enabled(rec)) {
>  				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>  					rc = -1;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 08cedb643ea6..178d3280ba62 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1032,7 +1032,11 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
>  	 * Its value is decided by evsel's write_backward.
>  	 * So &mp should not be passed through const pointer.
>  	 */
> -	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
> +	struct mmap_params mp = {
> +		.nr_cblocks	= nr_cblocks,
> +		.affinity	= affinity,
> +		.cpu_map	= cpu_map__new(NULL) /* from /sys/devices/system/cpu/online */
> +	};

cpu_map won't get released.. if there's no better solution,
at least we could have it as static in build_node_mask..
this way it will be created only once

jirka
