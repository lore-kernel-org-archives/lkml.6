Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16136C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BFC218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfBLNJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:09:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfBLNJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:09:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C84AFC059B6D;
        Tue, 12 Feb 2019 13:09:22 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2BB1F5C236;
        Tue, 12 Feb 2019 13:09:21 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:09:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] perf report: support record trace file
 decompression
Message-ID: <20190212130920.GL775@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <4f45c930-cf39-76b0-5c56-ee4fb0705fa3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f45c930-cf39-76b0-5c56-ee4fb0705fa3@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 12 Feb 2019 13:09:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:25:00PM +0300, Alexey Budankov wrote:

SNIP

> +static int perf_session__process_compressed_event(struct perf_session *session,
> +					union perf_event *event, u64 file_offset)
> +{
> +	void *src;
> +	size_t decomp_size, src_size;
> +	u64 decomp_last_rem = 0;
> +	size_t decomp_len = session->header.env.comp_mmap_len;
> +	struct decomp *decomp, *decomp_last = session->decomp_last;
> +
> +	decomp = mmap(NULL, sizeof(struct decomp) + decomp_len, PROT_READ|PROT_WRITE,
> +		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +	if (decomp == MAP_FAILED) {
> +		pr_err("Couldn't allocate memory for decompression\n");
> +		return -1;
> +	}
> +
> +	decomp->file_pos = file_offset;
> +	decomp->head = 0;
> +
> +	if (decomp_last) {
> +		decomp_last_rem = decomp_last->size - decomp_last->head;
> +		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
> +		decomp->size = decomp_last_rem;
> +	}
> +
> +	src = (void *)event + sizeof(struct compressed_event);
> +	src_size = event->pack.header.size - sizeof(struct compressed_event);
> +
> +	decomp_size = perf_session__zstd_decompress(session, src, src_size,
> +				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
> +	if (!decomp_size) {
> +		munmap(decomp, sizeof(struct decomp) + decomp_len);
> +		pr_err("Couldn't decompress data\n");
> +		return -1;
> +	}
> +
> +	decomp->size += decomp_size;
> +
> +	if (session->decomp == NULL) {
> +		session->decomp = decomp;
> +		session->decomp_last = decomp;
> +	} else {
> +		session->decomp_last->next = decomp;
> +		session->decomp_last = decomp;
> +	}

can this happen? can you process more compressed events
before you deliver them in __perf_session__process_decomp_events?

I think I asked similar question in my other email..

thanks,
jirka
