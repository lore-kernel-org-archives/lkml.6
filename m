Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeCZOvl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:51:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:4043 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeCZOvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:51:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="31383432"
Subject: Re: [PATCH] perf mmap: Fix accessing unmapped mmap in
 perf_mmap__read_done()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com
References: <1522071729-16776-1-git-send-email-kan.liang@linux.intel.com>
 <20180326142604.GE18897@kernel.org> <20180326144127.GF18897@kernel.org>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <cf6f5ab7-5be4-19c6-318c-c665c0d888c4@linux.intel.com>
Date: Mon, 26 Mar 2018 10:51:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326144127.GF18897@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/2018 10:41 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 26, 2018 at 11:26:04AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Mar 26, 2018 at 09:42:09AM -0400, kan.liang@linux.intel.com escreveu:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> There is segmentation fault when running perf trace. For example,
>>>    [root@jouet e]# perf trace -e *chdir -o /tmp/bla perf report
>>>    --ignore-vmlinux -i ../perf.data
>>>
>>> The perf_mmap__consume() could unmap the mmap. It needs to check the
>>> refcnt in perf_mmap__read_done().
>>>
>>> Fixes: ee023de05f35 ("perf mmap: Introduce perf_mmap__read_done()")
>>> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>
>> Seems insuficient:
>>
>> [root@jouet ~]# perf trace -e *chdir -o /tmp/bla perf report --ignore-vmlinux
>> perf: Segmentation fault
>> Obtained 9 stack frames.
>> perf(sighandler_dump_stack+0x3e) [0x4fe31e]
>> /lib64/libc.so.6(+0x346df) [0x7fc0c3ced6df]
>> perf(perf_mmap__read_init+0x26) [0x4ccd06]
>> perf(cmd_trace+0x1bf6) [0x47bb76]
>> perf() [0x4a824e]
>> perf() [0x4a8550]
>> perf(main+0x331) [0x42bef1]
>> /lib64/libc.so.6(__libc_start_main+0xe9) [0x7fc0c3cd9f29]
>> perf(_start+0x29) [0x42c319]
>> Segmentation fault (core dumped)
>> [root@jouet ~]#
> 
> I'm adding this as a separate patch, with yours and this one, the
> segfault is gone.
>

Thanks. Yes, we should check the mmap before using it for all new 
interfaces.

Thanks,
Kan

> - Arnaldo
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index f6cfc52ff1fe..fc832676a798 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -234,7 +234,7 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
>   /*
>    * Report the start and end of the available data in ringbuffer
>    */
> -int perf_mmap__read_init(struct perf_mmap *md)
> +static int __perf_mmap__read_init(struct perf_mmap *md)
>   {
>   	u64 head = perf_mmap__read_head(md);
>   	u64 old = md->prev;
> @@ -268,6 +268,17 @@ int perf_mmap__read_init(struct perf_mmap *md)
>   	return 0;
>   }
>   
> +int perf_mmap__read_init(struct perf_mmap *map)
> +{
> +	/*
> +	 * Check if event was unmapped due to a POLLHUP/POLLERR.
> +	 */
> +	if (!refcount_read(&map->refcnt))
> +		return -ENOENT;
> +
> +	return __perf_mmap__read_init(map);
> +}
> +
>   int perf_mmap__push(struct perf_mmap *md, void *to,
>   		    int push(void *to, void *buf, size_t size))
>   {
> 
