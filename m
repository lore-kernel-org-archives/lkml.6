Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C18EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3717B2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfA2Nmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:42:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:9138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfA2Nmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:42:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78A39C0C7CA0;
        Tue, 29 Jan 2019 13:42:41 +0000 (UTC)
Received: from krava (ovpn-204-171.brq.redhat.com [10.40.204.171])
        by smtp.corp.redhat.com (Postfix) with SMTP id A4119226F1;
        Tue, 29 Jan 2019 13:42:37 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:42:36 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, namhyung@kernel.org, dzickus@redhat.com,
        fowles@inreach.com, jmario@redhat.com,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH v2] perf mem/c2c: Fix perf_mem_events to support powerpc
Message-ID: <20190129134236.GB30190@krava>
References: <dd6d04f3-c8aa-1d57-c466-c6b3c333db51@linux.ibm.com>
 <20190129132412.771-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129132412.771-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 29 Jan 2019 13:42:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 06:54:12PM +0530, Ravi Bangoria wrote:
> Powerpc hw does not have inbuilt latency filter (--ldlat) for mem-load
> event and, perf_mem_events by default includes ldlat=30 which is
> causing failure on powerpc. Refactor code to support perf mem/c2c on
> powerpc.
> 
> This patch depends on kernel side changes done my Madhavan:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-December/182596.html
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>  tools/perf/Documentation/perf-c2c.txt     | 16 ++++++++++++----
>  tools/perf/Documentation/perf-mem.txt     |  2 +-
>  tools/perf/arch/powerpc/util/Build        |  1 +
>  tools/perf/arch/powerpc/util/mem-events.c | 11 +++++++++++
>  tools/perf/util/mem-events.c              |  2 +-
>  5 files changed, 26 insertions(+), 6 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/util/mem-events.c
> 
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> index 095aebd..e6150f2 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -19,8 +19,11 @@ C2C stands for Cache To Cache.
>  The perf c2c tool provides means for Shared Data C2C/HITM analysis. It allows
>  you to track down the cacheline contentions.
>  
> -The tool is based on x86's load latency and precise store facility events
> -provided by Intel CPUs. These events provide:
> +On x86, the tool is based on load latency and precise store facility events
> +provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling
> +with thresholding feature.
> +
> +These events provide:
>    - memory address of the access
>    - type of the access (load and store details)
>    - latency (in cycles) of the load access
> @@ -46,7 +49,7 @@ RECORD OPTIONS
>  
>  -l::
>  --ldlat::
> -	Configure mem-loads latency.
> +	Configure mem-loads latency. (x86 only)
>  
>  -k::
>  --all-kernel::
> @@ -119,11 +122,16 @@ Following perf record options are configured by default:
>    -W,-d,--phys-data,--sample-cpu
>  
>  Unless specified otherwise with '-e' option, following events are monitored by
> -default:
> +default on x86:
>  
>    cpu/mem-loads,ldlat=30/P
>    cpu/mem-stores/P
>  
> +and following on PowerPC:
> +
> +  cpu/mem-loads/
> +  cpu/mem-stores/
> +
>  User can pass any 'perf record' option behind '--' mark, like (to enable
>  callchains and system wide monitoring):
>  
> diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
> index f8d2167..199ea0f 100644
> --- a/tools/perf/Documentation/perf-mem.txt
> +++ b/tools/perf/Documentation/perf-mem.txt
> @@ -82,7 +82,7 @@ RECORD OPTIONS
>  	Be more verbose (show counter open errors, etc)
>  
>  --ldlat <n>::
> -	Specify desired latency for loads event.
> +	Specify desired latency for loads event. (x86 only)
>  
>  In addition, for report all perf report options are valid, and for record
>  all perf record options.
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index 2e659531..ba98bd0 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -2,6 +2,7 @@ libperf-y += header.o
>  libperf-y += sym-handling.o
>  libperf-y += kvm-stat.o
>  libperf-y += perf_regs.o
> +libperf-y += mem-events.o
>  
>  libperf-$(CONFIG_DWARF) += dwarf-regs.o
>  libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
> diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
> new file mode 100644
> index 0000000..f1194fc
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/mem-events.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "mem-events.h"
> +
> +/* PowerPC does not support 'ldlat' parameter. */
> +char *perf_mem_events__name(int i)
> +{
> +	if (i == PERF_MEM_EVENTS__LOAD)
> +		return (char *) "cpu/mem-loads/";
> +
> +	return (char *) "cpu/mem-stores/";
> +}
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 93f74d8..42c3e5a 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -28,7 +28,7 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
>  static char mem_loads_name[100];
>  static bool mem_loads_name__init;
>  
> -char *perf_mem_events__name(int i)
> +char * __weak perf_mem_events__name(int i)
>  {
>  	if (i == PERF_MEM_EVENTS__LOAD) {
>  		if (!mem_loads_name__init) {
> -- 
> 1.8.3.1
> 
