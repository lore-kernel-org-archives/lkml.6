Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86023C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572CC218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfAAVjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:39:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728328AbfAAVjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:39:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD52A5F;
        Tue,  1 Jan 2019 21:39:12 +0000 (UTC)
Received: from krava (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id AE2BD608D9;
        Tue,  1 Jan 2019 21:39:10 +0000 (UTC)
Date:   Tue, 1 Jan 2019 22:39:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] perf record: bind the AIO user space buffers to
 nodes
Message-ID: <20190101213909.GB13760@krava>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
 <e616e65f-bf53-e87e-b906-4fd9dce86380@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e616e65f-bf53-e87e-b906-4fd9dce86380@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 01 Jan 2019 21:39:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 03:24:36PM +0300, Alexey Budankov wrote:
> 
> Allocate and bind AIO user space buffers to the memory nodes
> that mmap kernel buffers are bound to.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v2:
> - implemented perf_mmap__aio_alloc, perf_mmap__aio_free, perf_mmap__aio_bind 
>   and put HAVE_LIBNUMA_SUPPORT #ifdefs in there
> ---
>  tools/perf/util/mmap.c | 49 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index e68ba754a8e2..742fa9a8e498 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -10,6 +10,9 @@
>  #include <sys/mman.h>
>  #include <inttypes.h>
>  #include <asm/bug.h>
> +#ifdef HAVE_LIBNUMA_SUPPORT
> +#include <numaif.h>
> +#endif
>  #include "debug.h"
>  #include "event.h"
>  #include "mmap.h"
> @@ -154,6 +157,46 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
>  }
>  
>  #ifdef HAVE_AIO_SUPPORT
> +
> +#ifdef HAVE_LIBNUMA_SUPPORT
> +static void perf_mmap__aio_alloc(void **data, size_t len)
> +{
> +	*data = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
> +}

please make perf_mmap__aio_alloc return the pointer,
I dont see a need for **data arg

also perf_mmap__ preffix indicates it's function over
'struct perf_mmap', which should be the first arg..
not sure, but perhaps that could make the code also
simpler, like:

static int perf_mmap__aio_alloc(struct perf_mmap *, int index);
static int perf_mmap__aio_bind(struct perf_mmap *, int index, int affinity);
static void perf_mmap__aio_free(struct perf_mmap *, int index);

jirka
