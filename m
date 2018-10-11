Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D991C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A8820652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A8820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeJKVNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:13:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeJKVNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:13:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E5193001A5A;
        Thu, 11 Oct 2018 13:46:15 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id B1B066012E;
        Thu, 11 Oct 2018 13:46:13 +0000 (UTC)
Date:   Thu, 11 Oct 2018 15:46:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 2/3]: perf record: enable asynchronous trace writing
Message-ID: <20181011134612.GE29634@krava>
References: <e045b4aa-bff1-4e40-4cdf-4504003ecff5@linux.intel.com>
 <50fed9ff-adc4-d9d6-36bc-b6b27bf58c17@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50fed9ff-adc4-d9d6-36bc-b6b27bf58c17@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 11 Oct 2018 13:46:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 11:58:53AM +0300, Alexey Budankov wrote:

SNIP

> +#ifdef HAVE_AIO_SUPPORT
> +int perf_mmap__aio_push(struct perf_mmap *md, void *to,
> +			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
> +			off_t *off)
> +{
> +	u64 head = perf_mmap__read_head(md);
> +	unsigned char *data = md->base + page_size;
> +	unsigned long size, size0 = 0;
> +	void *buf;
> +	int rc = 0;
> +
> +	rc = perf_mmap__read_init(md);
> +	if (rc < 0)
> +		return (rc == -EAGAIN) ? 0 : -1;
> +
> +	/*
> +	 * md->base data is copied into md->data buffer to
> +	 * release space in the kernel buffer as fast as possible,
> +	 * thru perf_mmap__consume() below.
> +	 *
> +	 * That lets the kernel to proceed with storing more
> +	 * profiling data into the kernel buffer earlier than other
> +	 * per-cpu kernel buffers are handled.
> +	 *
> +	 * Coping can be done in two steps in case the chunk of
> +	 * profiling data crosses the upper bound of the kernel buffer.
> +	 * In this case we first move part of data from md->start
> +	 * till the upper bound and then the reminder from the
> +	 * beginning of the kernel buffer till the end of
> +	 * the data chunk.
> +	 */
> +
> +	size = md->end - md->start;
> +
> +	if ((md->start & md->mask) + size != (md->end & md->mask)) {
> +		buf = &data[md->start & md->mask];
> +		size = md->mask + 1 - (md->start & md->mask);
> +		md->start += size;
> +		memcpy(md->aio.data, buf, size);
> +		size0 = size;
> +	}
> +
> +	buf = &data[md->start & md->mask];
> +	size = md->end - md->start;
> +	md->start += size;
> +	memcpy(md->aio.data + size0, buf, size);
> +
> +	/*
> +	 * Increment md->refcount to guard md->data buffer
> +	 * from premature deallocation because md object can be
> +	 * released earlier than aio write request started
> +	 * on mmap->data is complete.
> +	 *
> +	 * perf_mmap__put() is done at record__aio_complete()
> +	 * after started request completion.
> +	 */
> +	perf_mmap__get(md);
> +
> +	md->prev = head;
> +	perf_mmap__consume(md);
> +
> +	rc = push(to, &(md->aio.cblock), md->aio.data, size0 + size, *off);
> +	if (!rc) {
> +		*off += size0 + size;
> +	} else {
> +		/*
> +		 * Decrement md->refcount back if aio write
> +		 * operation failed to start.
> +		 */
> +		perf_mmap__put(md);
> +	}
> +
> +	return rc;
> +}
> +#else
> +int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused,
> +	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
> +	off_t *off __maybe_unused)
> +{
> +	return 0;
> +}

I think you need to put this one in the header as static inline
otherwise it'd still appear in the NO_AIO=1 build, like:
  [jolsa@krava perf]$ make NO_AIO=1
  ...
  [jolsa@krava perf]$ nm -D perf | grep perf_mmap__aio_push
  00000000004c2be0 T perf_mmap__aio_push

change below makes it disappear completely

jirka


---
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index b176d88b3fcb..8c7516696891 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -445,13 +445,6 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to,
 
 	return rc;
 }
-#else
-int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused,
-	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
-	off_t *off __maybe_unused)
-{
-	return 0;
-}
 #endif
 
 /*
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 04ff4d2ffdbe..3ccf8c925002 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -105,10 +105,21 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
 		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
+
+#ifdef HAVE_AIO_SUPPORT
 int perf_mmap__aio_push(struct perf_mmap *md, void *to,
 			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
 			off_t *off);
 
+#else
+static inline int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused,
+	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
+	off_t *off __maybe_unused)
+{
+	return 0;
+}
+#endif
+
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
 int perf_mmap__read_init(struct perf_mmap *md);
