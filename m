Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556B4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAB9206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfBLNIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:08:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBLNIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:08:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACC8B89AC7;
        Tue, 12 Feb 2019 13:08:53 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 05FEA17CE4;
        Tue, 12 Feb 2019 13:08:51 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:08:50 +0100
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
Message-ID: <20190212130850.GG775@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <4f45c930-cf39-76b0-5c56-ee4fb0705fa3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f45c930-cf39-76b0-5c56-ee4fb0705fa3@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 12 Feb 2019 13:08:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:25:00PM +0300, Alexey Budankov wrote:

SNIP

>  size_t perf_session__zstd_copy(void *to __maybe_unused,
> @@ -533,6 +646,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
>  		tool->time_conv = process_event_op2_stub;
>  	if (tool->feature == NULL)
>  		tool->feature = process_event_op2_stub;
> +	if (tool->compressed == NULL)
> +		tool->compressed = perf_session__process_compressed_event;
>  }
>  
>  static void swap_sample_id_all(union perf_event *event, void *data)
> @@ -1469,7 +1584,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>  	int fd = perf_data__fd(session->data);
>  	int err;
>  
> -	dump_event(session->evlist, event, file_offset, &sample);
> +	if (event->header.type != PERF_RECORD_COMPRESSED)
> +		dump_event(session->evlist, event, file_offset, &sample);
>  
>  	/* These events are processed right away */
>  	switch (event->header.type) {
> @@ -1522,6 +1638,11 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>  		return tool->time_conv(session, event);
>  	case PERF_RECORD_HEADER_FEATURE:
>  		return tool->feature(session, event);
> +	case PERF_RECORD_COMPRESSED:
> +		err = tool->compressed(session, event, file_offset);
> +		if (err)
> +			dump_event(session->evlist, event, file_offset, &sample);

I'm not sure about having compressed callback at all, but maybe
it could be usefull for inject, to get the compressed data..?

I assume inject is working now and it will get you the uncompressed
perf.data?

jirka
