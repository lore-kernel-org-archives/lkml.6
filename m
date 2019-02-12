Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC02AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8385E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfBLNIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:08:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBLNIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:08:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F5B98E584;
        Tue, 12 Feb 2019 13:08:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id CC3E55C23F;
        Tue, 12 Feb 2019 13:08:45 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:08:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] perf record: enable runtime trace compression
Message-ID: <20190212130844.GF775@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 12 Feb 2019 13:08:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:23:40PM +0300, Alexey Budankov wrote:

SNIP

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 18fb9c8cbf9c..5d406eebd058 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -29,6 +29,112 @@
>  #include "stat.h"
>  #include "arch/common.h"
>  

I think this should not be in session.c but separated in new object

> +#ifdef HAVE_ZSTD_SUPPORT
> +int perf_session__zstd_init(struct perf_session *session, int level)
> +{
> +	size_t ret;
> +
> +	session->header.env.comp_type  = PERF_COMP_NONE;
> +	session->header.env.comp_level = 0;
> +
> +	session->zstd_cstream = ZSTD_createCStream();
> +	if (session->zstd_cstream == NULL) {
> +		pr_err("Couldn't create compression stream.\n");
> +		return -1;
> +	}
> +
> +	ret = ZSTD_initCStream(session->zstd_cstream, level);
> +	if (ZSTD_isError(ret)) {
> +		pr_err("Failed to initialize compression stream: %s\n", ZSTD_getErrorName(ret));
> +		return -1;
> +	}
> +
> +	session->header.env.comp_type  = PERF_COMP_ZSTD;
> +	session->header.env.comp_level = level;
> +
> +	return 0;
> +}
> +
> +int perf_session__zstd_fini(struct perf_session *session)
> +{
> +	if (session->zstd_cstream) {
> +		ZSTD_freeCStream(session->zstd_cstream);
> +		session->zstd_cstream = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +size_t perf_session__zstd_compress(void *to,  void *dst, size_t dst_size,
> +				   void *src, size_t src_size)
> +{
> +	struct perf_session *session = to;
> +	size_t ret, size, compressed = 0;
> +	struct compressed_event *event = NULL;
> +	/* maximum size of record data size (2^16 - 1 - header) */
> +	const size_t max_data_size = (1 << 8 * sizeof(event->header.size)) -
> +				      1 - sizeof(struct compressed_event);
> +	ZSTD_inBuffer input = { src, src_size, 0 };
> +	ZSTD_outBuffer output;
> +
> +	while (input.pos < input.size) {
> +		event = dst;
> +
> +		event->header.type = PERF_RECORD_COMPRESSED;
> +		event->header.size = size = sizeof(struct compressed_event);
> +		compressed += size;
> +		dst += size;
> +		dst_size -= size;
> +
> +		output = (ZSTD_outBuffer){ dst, (dst_size > max_data_size) ?
> +						max_data_size : dst_size, 0 };
> +		ret = ZSTD_compressStream(session->zstd_cstream, &output, &input);
> +		ZSTD_flushStream(session->zstd_cstream, &output);
> +		if (ZSTD_isError(ret)) {
> +			pr_err("failed to compress %ld bytes: %s\n",
> +				(long)src_size, ZSTD_getErrorName(ret));
> +			return perf_session__zstd_copy(session, dst, dst_size, src, src_size);
> +		}
> +		size = output.pos;
> +
> +		event->header.size += size;
> +		compressed += size;
> +		dst += size;
> +		dst_size -= size;
> +	}
> +
> +	session->bytes_transferred += src_size;
> +	session->bytes_compressed  += compressed;
> +
> +	return compressed;
> +}
> +#else /* !HAVE_ZSTD_SUPPORT */
> +int perf_session__zstd_init(struct perf_session *session __maybe_unused, int level __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +int perf_session__zstd_fini(struct perf_session *session __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +size_t perf_session__zstd_compress(void *to __maybe_unused,
> +				void *dst __maybe_unused, size_t dst_size __maybe_unused,
> +				void *src __maybe_unused, size_t src_size __maybe_unused)
> +{
> +	return 0;
> +}
> +#endif
> +
> +size_t perf_session__zstd_copy(void *to __maybe_unused,
> +			void *dst, size_t dst_size __maybe_unused,
> +			void *src, size_t src_size)
> +{
> +	memcpy(dst, src, src_size);
> +	return src_size;
> +}
> +

SNIP
