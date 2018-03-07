Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeCGKWB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:22:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751142AbeCGKWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:22:00 -0500
Date: Wed, 7 Mar 2018 11:21:57 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: acme@redhat.com, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf mmap: Discard head in overwrite_rb_find_range
Message-ID: <20180307102157.GC22848@krava>
References: <1520336663-53466-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520336663-53466-1-git-send-email-xieyisheng1@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 07:44:23PM +0800, Yisheng Xie wrote:
> In overwrite mode, start will be set to head in perf_mmap__read_init.
> Therefore, it is no need to set the start one more in
> overwrite_rb_find_range and *start can be used as head instead of
> passing head to overwrite_rb_find_range.

it conflicts a little with recent cleanup from Kan Liang,,
  https://marc.info/?t=152035082800001&r=1&w=2

otherwise it looks ok to me

jirka

> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  tools/perf/util/mmap.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 91531a7..6751ac9 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -223,19 +223,18 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
>  	return 0;
>  }
>  
> -static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64 *end)
> +static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
>  {
>  	struct perf_event_header *pheader;
> -	u64 evt_head = head;
> +	u64 evt_head = *start;
>  	int size = mask + 1;
>  
> -	pr_debug2("overwrite_rb_find_range: buf=%p, head=%"PRIx64"\n", buf, head);
> -	pheader = (struct perf_event_header *)(buf + (head & mask));
> -	*start = head;
> +	pr_debug2("%s: buf=%p, start=%"PRIx64"\n", __func__, buf, *start);
> +	pheader = (struct perf_event_header *)(buf + (*start & mask));
>  	while (true) {
> -		if (evt_head - head >= (unsigned int)size) {
> +		if (evt_head - *start >= (unsigned int)size) {
>  			pr_debug("Finished reading overwrite ring buffer: rewind\n");
> -			if (evt_head - head > (unsigned int)size)
> +			if (evt_head - *start > (unsigned int)size)
>  				evt_head -= pheader->size;
>  			*end = evt_head;
>  			return 0;
> @@ -287,7 +286,7 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
>  		 * Backward ring buffer is full. We still have a chance to read
>  		 * most of data from it.
>  		 */
> -		if (overwrite_rb_find_range(data, md->mask, head, startp, endp))
> +		if (overwrite_rb_find_range(data, md->mask, startp, endp))
>  			return -EINVAL;
>  	}
>  
> -- 
> 1.7.12.4
> 
