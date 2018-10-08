Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39643C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3102064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3102064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJHSB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbeJHSB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:01:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 277CA12F908;
        Mon,  8 Oct 2018 10:50:52 +0000 (UTC)
Received: from krava (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 75A3744FAC;
        Mon,  8 Oct 2018 10:50:50 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:50:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/3]: perf util: map data buffer for preserving
 collected data
Message-ID: <20181008105049.GC17270@krava>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 08 Oct 2018 10:50:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:14:29AM +0300, Alexey Budankov wrote:
> 
> The map->data buffer is used to preserve map->base profiling data 
> for writing to disk. AIO map->cblock is used to queue corresponding 
> map->data buffer for asynchronous writing.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v10:
>  - moved specific code to perf_mmap__aio_mmap(), perf_mmap__aio_munmap()
>  - adjusted error reporting by using %m
> Changes in v9:
>   - implemented NO_AIO and HAVE_AIO_SUPPORT defines to cover cases of 
>     libc implementations without Posix AIO API support
> Changes in v7:
>   - implemented handling record.aio setting from perfconfig file
>  Changes in v6:
>   - adjusted setting of priorities for cblocks;
>  Changes in v5:
>   - reshaped layout of data structures;
>   - implemented --aio option;
>  Changes in v4:
>   - converted mmap()/munmap() to malloc()/free() for mmap->data buffer management 
>  Changes in v2:
>   - converted zalloc() to calloc() for allocation of mmap_aio array,
>   - cleared typo and adjusted fallback branch code;
> ---
>  tools/perf/Makefile.config |  5 +++++
>  tools/perf/Makefile.perf   |  7 ++++++-
>  tools/perf/util/evlist.c   |  4 +++-
>  tools/perf/util/mmap.c     | 48 +++++++++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/mmap.h     | 11 +++++++++++
>  5 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index f6d1a03c7523..2e90f4ce9214 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -355,6 +355,11 @@ endif # NO_LIBELF
>  
>  ifeq ($(feature-glibc), 1)
>    CFLAGS += -DHAVE_GLIBC_SUPPORT
> +  ifndef NO_AIO

hum, do we need NO_AIO? we have the --aio option to enable that right?
I guess BIONIC does not support aio, but but will it fail when it's
compiled in there?

jirka

> +    ifndef BIONIC
> +        CFLAGS += -DHAVE_AIO_SUPPORT
> +    endif
> +  endif
>  endif

SNIP
