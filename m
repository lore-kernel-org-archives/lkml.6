Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9886C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3229218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfAAVjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:39:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbfAAVjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:39:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05851820E9;
        Tue,  1 Jan 2019 21:39:21 +0000 (UTC)
Received: from krava (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id EEF515D9CA;
        Tue,  1 Jan 2019 21:39:18 +0000 (UTC)
Date:   Tue, 1 Jan 2019 22:39:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] perf record: implement --affinity=node|cpu option
Message-ID: <20190101213918.GC13760@krava>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
 <b94a028a-131b-3b5c-1158-3f2d26ffb84d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94a028a-131b-3b5c-1158-3f2d26ffb84d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 01 Jan 2019 21:39:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 03:28:33PM +0300, Alexey Budankov wrote:
> 
> Implement --affinity=node|cpu option for the record mode defaulting
> to system affinity mask bouncing.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt |  5 +++++
>  tools/perf/builtin-record.c              | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index d232b13ea713..efb839784f32 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -440,6 +440,11 @@ Use <n> control blocks in asynchronous (Posix AIO) trace writing mode (default:
>  Asynchronous mode is supported only when linking Perf tool with libc library
>  providing implementation for Posix AIO API.
>  
> +--affinity=mode::
> +Set affinity mask of trace reading thread according to the policy defined by 'mode' value:
> +  node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
> +  cpu  - thread affinity mask is set to cpu of the processed mmap buffer
> +
>  --all-kernel::
>  Configure all used events to run in kernel space.
>  
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index eea96794ee45..57dc3a45d16f 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1653,6 +1653,21 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
>  	ui__warning("unknown clockid %s, check man page\n", ostr);
>  	return -1;
>  }
> +static int record__parse_affinity(const struct option *opt, const char *str, int unset)
> +{
> +	struct record_opts *opts = (struct record_opts *)opt->value;
> +
> +	if (!unset) {
> +		if (str) {
> +			if (!strcasecmp(str, "node"))
> +				opts->affinity = PERF_AFFINITY_NODE;
> +			else if (!strcasecmp(str, "cpu"))
> +				opts->affinity = PERF_AFFINITY_CPU;
> +		}
> +	}
> +
> +	return 0;
> +}
>  
>  static int record__parse_mmap_pages(const struct option *opt,
>  				    const char *str,
> @@ -1961,6 +1976,9 @@ static struct option __record_options[] = {
>  		     &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
>  		     record__aio_parse),
>  #endif
> +	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
> +		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
> +		     record__parse_affinity),

so this makes sense only when there's --aio and LIBNUMA
in place.. we should check for those and allow this only
for these

jirka
