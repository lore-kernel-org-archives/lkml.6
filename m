Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7090C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3DB2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3DB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbeJLAGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:06:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:10782 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbeJLAGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:06:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 09:38:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="96679901"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 11 Oct 2018 09:29:49 -0700
Received: from [10.252.28.165] (abudanko-mobl.ccr.corp.intel.com [10.252.28.165])
        by linux.intel.com (Postfix) with ESMTP id 8182958015C;
        Thu, 11 Oct 2018 09:29:46 -0700 (PDT)
Subject: Re: [PATCH v12 2/3]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e045b4aa-bff1-4e40-4cdf-4504003ecff5@linux.intel.com>
 <50fed9ff-adc4-d9d6-36bc-b6b27bf58c17@linux.intel.com>
 <20181011134612.GE29634@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e28e7cf7-db1b-c77e-71cd-6eaefc3d3a5b@linux.intel.com>
Date:   Thu, 11 Oct 2018 19:29:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011134612.GE29634@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2018 16:46, Jiri Olsa wrote:
> On Tue, Oct 09, 2018 at 11:58:53AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> +#ifdef HAVE_AIO_SUPPORT
>> +int perf_mmap__aio_push(struct perf_mmap *md, void *to,
>> +			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
>> +			off_t *off)
>> +{
>> +	u64 head = perf_mmap__read_head(md);
>> +	unsigned char *data = md->base + page_size;
>> +	unsigned long size, size0 = 0;
>> +	void *buf;
>> +	int rc = 0;
>> +
>> +	rc = perf_mmap__read_init(md);
>> +	if (rc < 0)
>> +		return (rc == -EAGAIN) ? 0 : -1;
>> +
>> +	/*
>> +	 * md->base data is copied into md->data buffer to
>> +	 * release space in the kernel buffer as fast as possible,
>> +	 * thru perf_mmap__consume() below.
>> +	 *
>> +	 * That lets the kernel to proceed with storing more
>> +	 * profiling data into the kernel buffer earlier than other
>> +	 * per-cpu kernel buffers are handled.
>> +	 *
>> +	 * Coping can be done in two steps in case the chunk of
>> +	 * profiling data crosses the upper bound of the kernel buffer.
>> +	 * In this case we first move part of data from md->start
>> +	 * till the upper bound and then the reminder from the
>> +	 * beginning of the kernel buffer till the end of
>> +	 * the data chunk.
>> +	 */
>> +
>> +	size = md->end - md->start;
>> +
>> +	if ((md->start & md->mask) + size != (md->end & md->mask)) {
>> +		buf = &data[md->start & md->mask];
>> +		size = md->mask + 1 - (md->start & md->mask);
>> +		md->start += size;
>> +		memcpy(md->aio.data, buf, size);
>> +		size0 = size;
>> +	}
>> +
>> +	buf = &data[md->start & md->mask];
>> +	size = md->end - md->start;
>> +	md->start += size;
>> +	memcpy(md->aio.data + size0, buf, size);
>> +
>> +	/*
>> +	 * Increment md->refcount to guard md->data buffer
>> +	 * from premature deallocation because md object can be
>> +	 * released earlier than aio write request started
>> +	 * on mmap->data is complete.
>> +	 *
>> +	 * perf_mmap__put() is done at record__aio_complete()
>> +	 * after started request completion.
>> +	 */
>> +	perf_mmap__get(md);
>> +
>> +	md->prev = head;
>> +	perf_mmap__consume(md);
>> +
>> +	rc = push(to, &(md->aio.cblock), md->aio.data, size0 + size, *off);
>> +	if (!rc) {
>> +		*off += size0 + size;
>> +	} else {
>> +		/*
>> +		 * Decrement md->refcount back if aio write
>> +		 * operation failed to start.
>> +		 */
>> +		perf_mmap__put(md);
>> +	}
>> +
>> +	return rc;
>> +}
>> +#else
>> +int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused,
>> +	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
>> +	off_t *off __maybe_unused)
>> +{
>> +	return 0;
>> +}
> 
> I think you need to put this one in the header as static inline
> otherwise it'd still appear in the NO_AIO=1 build, like:
>   [jolsa@krava perf]$ make NO_AIO=1
>   ...
>   [jolsa@krava perf]$ nm -D perf | grep perf_mmap__aio_push
>   00000000004c2be0 T perf_mmap__aio_push
> 
> change below makes it disappear completely> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index b176d88b3fcb..8c7516696891 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -445,13 +445,6 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to,
>  
>  	return rc;
>  }
> -#else
> -int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused,
> -	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
> -	off_t *off __maybe_unused)
> -{
> -	return 0;
> -}
>  #endif
>  
>  /*
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index 04ff4d2ffdbe..3ccf8c925002 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -105,10 +105,21 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map);
>  
>  int perf_mmap__push(struct perf_mmap *md, void *to,
>  		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
> +
> +#ifdef HAVE_AIO_SUPPORT
>  int perf_mmap__aio_push(struct perf_mmap *md, void *to,
>  			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
>  			off_t *off);
>  
> +#else
> +static inline int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused,
> +	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
> +	off_t *off __maybe_unused)
> +{
> +	return 0;
> +}
> +#endif
> +
>  size_t perf_mmap__mmap_len(struct perf_mmap *map);
>  
>  int perf_mmap__read_init(struct perf_mmap *md);
> 

Accepted.

Thanks,
Alexey
