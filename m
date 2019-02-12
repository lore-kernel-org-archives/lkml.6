Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC6AC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F61214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfBLNJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:09:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbfBLNJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:09:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21A29C01DE11;
        Tue, 12 Feb 2019 13:09:28 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6FC365C26A;
        Tue, 12 Feb 2019 13:09:26 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:09:25 +0100
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
Message-ID: <20190212130925.GM775@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 12 Feb 2019 13:09:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:23:40PM +0300, Alexey Budankov wrote:

SNIP

> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 239e9a13c2b7..980784b77fe2 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -156,6 +156,86 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
>  {
>  }
>  
> +static ssize_t perf_mmap__capture(struct perf_mmap *md, int idx,
> +			perf_mmap__compress_fn_t compress, void *where)

what's the point of casting perf_session* to void* ? all the way down to
the compression, where you cast it back?

SNIP

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

in here... it could be just struct perf_session* no?

jirka
