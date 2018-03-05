Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeCEUVA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:21:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752719AbeCEUU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:20:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3E7206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 5 Mar 2018 17:20:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, wangnan0@huawei.com, ak@linux.intel.com
Subject: Re: [PATCH 1/7] perf mmap: Store mmap scope and type in struct
 perf_mmap
Message-ID: <20180305202054.GA10176@kernel.org>
References: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 05, 2018 at 02:10:53PM -0500, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> There are too many boilerplates for the perf_mmap__read*() interfaces.
> 
> Some of the data (e.g. 'start', 'end', 'overwrite') should be stored in
> struct perf_mmap at initialization. They will be used later.
> 
> No functional change.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/mmap.c | 11 ++++++++---
>  tools/perf/util/mmap.h |  3 +++
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 4f27c46..642b479 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -250,11 +250,14 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
>  
>  	*startp = overwrite ? head : old;
>  	*endp = overwrite ? old : head;

Why did you keep the above and haven't removed the startp/endp args? to
ease the conversion somehow? I'll look at the other patches, but I think
we should change the function signature here and in the callers all at
once.

Sometimes this is ok, and probably this is one case.

- Arnaldo

> +	md->overwrite = overwrite;
> +	md->start = overwrite ? head : old;
> +	md->end = overwrite ? old : head;
>  
> -	if (*startp == *endp)
> +	if (md->start == md->end)
>  		return -EAGAIN;
>  
> -	size = *endp - *startp;
> +	size = md->end - md->start;
>  	if (size > (unsigned long)(md->mask) + 1) {
>  		if (!overwrite) {
>  			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
> @@ -268,8 +271,10 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
>  		 * Backward ring buffer is full. We still have a chance to read
>  		 * most of data from it.
>  		 */
> -		if (overwrite_rb_find_range(data, md->mask, head, startp, endp))
> +		if (overwrite_rb_find_range(data, md->mask, head, &md->start, &md->end))
>  			return -EINVAL;
> +		*startp = md->start;
> +		*endp = md->end;
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index ec7d3a24..9359e93 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -20,6 +20,9 @@ struct perf_mmap {
>  	int		 fd;
>  	refcount_t	 refcnt;
>  	u64		 prev;
> +	u64		 start;
> +	u64		 end;
> +	bool		 overwrite;
>  	struct auxtrace_mmap auxtrace_mmap;
>  	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
>  };
> -- 
> 2.4.11
