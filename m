Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932394AbeCIRnO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932085AbeCIRnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:43:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27ECC205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 9 Mar 2018 14:42:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2] perf machine: Fix load kernel symbol with '-k' option
Message-ID: <20180309174254.GH8347@kernel.org>
References: <1520575523-3838-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520575523-3838-1-git-send-email-leo.yan@linaro.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 09, 2018 at 02:05:23PM +0800, Leo Yan escreveu:
> On Hikey arm64 octa A53 platform, when use command './perf report -v
> -k vmlinux --stdio' it outputs below error info, and it skips to load
> kernel symbol and doesn't print symbol for event:
> Failed to open [kernel.kallsyms]_text, continuing without symbols.
> 
> The regression is introduced by commit ("8c7f1bb37b29 perf machine: Move
> kernel mmap name into struct machine"), which changes the logic for

commit 8c7f1bb37b29f140e08175132f3abb4d5ad229fc
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Thu Feb 15 13:26:30 2018 +0100

    perf machine: Move kernel mmap name into struct machine

Jiri, can you please check this and Ack?

- Arnaldo

> machine mmap_name by removing function machine__mmap_name() and always
> use 'machine->mmap_name'.  Comparing difference between
> machine__mmap_name() and 'machine->mmap_name', the later one includes
> the string for specified kernel vmlinux string with option '-k' in
> command, but the old function machine__mmap_name() ignores vmlinux
> path string.  As result, event's mmap file name doesn't match with
> machine mmap file name anymore and it skips to load kernel symbol from
> vmlinux file.
> 
> To resolve this issue, this patch adds extra checking for
> 'symbol_conf.vmlinux_name', when it has been set string so we can know
> it includes vmlinux path string specified for option '-k'. For this
> case it sets 'is_kernel_mmap' to true and run into flow to load kernel
> symbol from vmlinux.
> 
> This patch has been verified with two commands: './perf report -v
> -k vmlinux --stdio' and './perf script -v -F cpu,event,ip,sym,symoff
> -k vmlinux'.
> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/machine.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 12b7427..3125871 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1299,9 +1299,18 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
>  	else
>  		kernel_type = DSO_TYPE_GUEST_KERNEL;
>  
> -	is_kernel_mmap = memcmp(event->mmap.filename,
> -				machine->mmap_name,
> -				strlen(machine->mmap_name) - 1) == 0;
> +	/*
> +	 * When symbol_conf.vmlinux_name is not NULL, it includes the specified
> +	 * kernel vmlinux path with option '-k'.  So set 'is_kernel_mmap' to
> +	 * true for creating machine symbol map.
> +	 */
> +	if (symbol_conf.vmlinux_name)
> +		is_kernel_mmap = true;
> +	else
> +		is_kernel_mmap = memcmp(event->mmap.filename,
> +					machine->mmap_name,
> +					strlen(machine->mmap_name) - 1) == 0;
> +
>  	if (event->mmap.filename[0] == '/' ||
>  	    (!is_kernel_mmap && event->mmap.filename[0] == '[')) {
>  		map = machine__findnew_module_map(machine, event->mmap.start,
> -- 
> 2.7.4
