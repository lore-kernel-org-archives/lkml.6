Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeCPOQ6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:16:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:65129 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbeCPOQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:16:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,316,1517904000";
   d="scan'208";a="208821594"
Subject: Re: [PATCH v2 -perf/core 1/2] perf mmap: Discard head in
 overwrite_rb_find_range
To: Yisheng Xie <xieyisheng1@huawei.com>, acme@redhat.com
Cc: mingo@redhat.com, peterz@infradead.org, namhyung@kernel.org,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <1520944274-37001-1-git-send-email-xieyisheng1@huawei.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f06f2f8b-cb99-af45-8cff-5826b46a8ff7@linux.intel.com>
Date: Fri, 16 Mar 2018 10:16:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520944274-37001-1-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/2018 8:31 AM, Yisheng Xie wrote:
> In overwrite mode, start will be set to head in perf_mmap__read_init.
> Therefore, it is no need to set the start one more in
> overwrite_rb_find_range and *start can be used as head instead of
> passing head to overwrite_rb_find_range.
>

Looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
> v2:
>   - rebase to perf/core
> 
>   tools/perf/util/mmap.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 074c4fd..38ca3ff 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -199,19 +199,18 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
>   	return 0;
>   }
>   
> -static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64 *end)
> +static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
>   {
>   	struct perf_event_header *pheader;
> -	u64 evt_head = head;
> +	u64 evt_head = *start;
>   	int size = mask + 1;
>   
> -	pr_debug2("overwrite_rb_find_range: buf=%p, head=%"PRIx64"\n", buf, head);
> -	pheader = (struct perf_event_header *)(buf + (head & mask));
> -	*start = head;
> +	pr_debug2("%s: buf=%p, start=%"PRIx64"\n", __func__, buf, *start);
> +	pheader = (struct perf_event_header *)(buf + (*start & mask));
>   	while (true) {
> -		if (evt_head - head >= (unsigned int)size) {
> +		if (evt_head - *start >= (unsigned int)size) {
>   			pr_debug("Finished reading overwrite ring buffer: rewind\n");
> -			if (evt_head - head > (unsigned int)size)
> +			if (evt_head - *start > (unsigned int)size)
>   				evt_head -= pheader->size;
>   			*end = evt_head;
>   			return 0;
> @@ -262,7 +261,7 @@ int perf_mmap__read_init(struct perf_mmap *md)
>   		 * Backward ring buffer is full. We still have a chance to read
>   		 * most of data from it.
>   		 */
> -		if (overwrite_rb_find_range(data, md->mask, head, &md->start, &md->end))
> +		if (overwrite_rb_find_range(data, md->mask, &md->start, &md->end))
>   			return -EINVAL;
>   	}
>   
> 
