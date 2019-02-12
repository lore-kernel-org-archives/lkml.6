Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F72C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC18C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfBLNJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:09:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbfBLNJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:09:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88C9BC074563;
        Tue, 12 Feb 2019 13:09:54 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id C6E4217997;
        Tue, 12 Feb 2019 13:09:52 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:09:51 +0100
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
Message-ID: <20190212130951.GR775@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 12 Feb 2019 13:09:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:23:40PM +0300, Alexey Budankov wrote:
> 
> Compression is implemented using simple Zstd API and employs AIO data
> buffer as the memory to operate on. If the API call fails for some
> reason compression falls back to memcpy().
> 
> Data chunks are split and packed into PERF_RECORD_COMPRESSED records
> by 64KB at max. mmap-flush option value can be used to avoid compression
> of every single byte of data and increase compression ratio.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v2:
> - enabled trace compression for serial trace streaming
> - moved compression/decompression code to session layer
> 
> ---
>  tools/perf/builtin-record.c |  67 +++++++++-----
>  tools/perf/util/mmap.c      | 173 +++++++++++++++++++++---------------
>  tools/perf/util/mmap.h      |  24 +++--
>  tools/perf/util/session.c   | 106 ++++++++++++++++++++++
>  tools/perf/util/session.h   |  13 +++
>  5 files changed, 280 insertions(+), 103 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 227dbbd47d3f..435ff88dfc5e 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -112,8 +112,7 @@ static bool switch_output_time(struct record *rec)
>  	       trigger_is_ready(&switch_output_trigger);
>  }
>  
> -static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
> -			 void *bf, size_t size)
> +static int record__write(struct record *rec, void *bf, size_t size)

please keep the 'struct perf_mmap *map' in, I'm using it in
the multiple file storage, where each map holds pointer to
its data file

thanks,
jirka
