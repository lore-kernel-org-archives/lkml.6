Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeEOKtF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:49:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752403AbeEOKtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:49:03 -0400
Date: Tue, 15 May 2018 12:49:00 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH RFC 11/19] perf tools: Synthesize and process mmap events
 for x86_64 KPTI entry trampolines
Message-ID: <20180515104900.GB7425@krava>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-12-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525866228-30321-12-git-send-email-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 02:43:40PM +0300, Adrian Hunter wrote:
> Like the kernel text, the location of x86_64 KPTI entry trampolines must be
> recorded in the perf.data file. Like the kernel, synthesize a mmap event
> for that, and add processing for it.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/event.c   | 90 +++++++++++++++++++++++++++++++++++++++++++++--
>  tools/perf/util/machine.c | 28 +++++++++++++++
>  2 files changed, 115 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index aafa9878465f..d810ff8488b1 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -888,9 +888,80 @@ int kallsyms__get_function_start(const char *kallsyms_filename,
>  	return 0;
>  }
>  
> -int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
> -				       perf_event__handler_t process,
> -				       struct machine *machine)
> +#if defined(__x86_64__)

also this could go under arch/x86/

jirka

> +
> +static int perf_event__synthesize_special_kmaps(struct perf_tool *tool,
> +						perf_event__handler_t process,
> +						struct machine *machine)
> +{
> +	int rc = 0;
> +	struct map *pos;
> +	struct map_groups *kmaps = &machine->kmaps;
> +	struct maps *maps = &kmaps->maps;
> +	union perf_event *event = zalloc(sizeof(event->mmap) +
> +					 machine->id_hdr_size);
> +
> +	if (!event) {
> +		pr_debug("Not enough memory synthesizing mmap event "
> +			 "for special kernel maps\n");
> +		return -1;
> +	}
> +

SNIP
