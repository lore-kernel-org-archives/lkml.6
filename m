Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C43C26658
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3E320880
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfATST3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:19:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfATST3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 13:19:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20B849E63F;
        Sun, 20 Jan 2019 18:19:29 +0000 (UTC)
Received: from krava (ovpn-204-22.brq.redhat.com [10.40.204.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id 55B2360BE9;
        Sun, 20 Jan 2019 18:19:25 +0000 (UTC)
Date:   Sun, 20 Jan 2019 19:19:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com,
        peterz@infradead.org, mingo@elte.hu, ak@linux.intel.com,
        kan.liang@intel.com
Subject: Re: [PATCH] perf tools: handle TOPOLOGY headers with no CPU
Message-ID: <20190120181925.GC8591@krava>
References: <1547885559-1657-1-git-send-email-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547885559-1657-1-git-send-email-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 20 Jan 2019 18:19:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 12:12:39AM -0800, Stephane Eranian wrote:
> This patch fixes an issue in cpumap.c when used with the
> TOPOLOGY header. In some configurations, some NUMA nodes may
> have no CPU (empty cpulist). Yet a cpumap map must be created
> otherwise perf abort with an error. This patch handles this
> case by creating a dummy map.
> 
> Before:
> $ perf record -o - -e cycles noploop 2 | perf script -i -
> 0x6e8 [0x6c]: failed to process type: 80
> 
> After:
> $ perf record -o - -e cycles noploop 2 | perf script -i -
> noploop for 2 seconds
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/cpumap.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 1ccbd3342069..383674f448fc 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -134,7 +134,12 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
>  	if (!cpu_list)
>  		return cpu_map__read_all_cpu_map();
>  
> -	if (!isdigit(*cpu_list))
> +	/*
> +	 * must handle the case of empty cpumap to cover
> +	 * TOPOLOGY header for NUMA nodes with no CPU
> +	 * ( e.g., because of CPU hotplug)
> +	 */
> +	if (!isdigit(*cpu_list) && *cpu_list != '\0')
>  		goto out;
>  
>  	while (isdigit(*cpu_list)) {
> @@ -181,8 +186,10 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
>  
>  	if (nr_cpus > 0)
>  		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
> -	else
> +	else if (*cpu_list != '\0')
>  		cpus = cpu_map__default_new();
> +	else
> +		cpus = cpu_map__dummy_new();
>  invalid:
>  	free(tmp_cpus);
>  out:
> -- 
> 2.7.4
> 
