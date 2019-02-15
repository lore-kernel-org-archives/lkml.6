Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F872082F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbfBOSKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:10:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387853AbfBOSKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:10:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7F76C3A93;
        Fri, 15 Feb 2019 18:10:42 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-20.phx2.redhat.com [10.3.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28C0F19C65;
        Fri, 15 Feb 2019 18:10:42 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 1868655D3; Fri, 15 Feb 2019 16:10:38 -0200 (BRST)
Date:   Fri, 15 Feb 2019 16:10:38 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, Mansour Alharthi <malharthi9@gatech.edu>,
        acme@kernel.org
Subject: Re: [PATCH v0 1/2] perf: Copy parent's address filter offsets on
 clone
Message-ID: <20190215181038.GK5784@redhat.com>
References: <20190215115655.63469-1-alexander.shishkin@linux.intel.com>
 <20190215115655.63469-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215115655.63469-2-alexander.shishkin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 15 Feb 2019 18:10:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 15, 2019 at 01:56:54PM +0200, Alexander Shishkin escreveu:
> When a child event is allocated in the inherit_event() path, the VMA
> based filter offsets are not copied from the parent, even though the
> address space mapping of the new task remains the same, which leads
> to no trace for the new task until exec.

Peter, I'm processing this one, ok? Ack?

- Arnaldo
 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
> Reported-by: Mansour Alharthi <malharthi9@gatech.edu>
> ---
>  kernel/events/core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5aeb4c74fb99..2d89efc0a3e0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1255,6 +1255,7 @@ static void put_ctx(struct perf_event_context *ctx)
>   *	      perf_event_context::lock
>   *	    perf_event::mmap_mutex
>   *	    mmap_sem
> + *	      perf_addr_filters_head::lock
>   *
>   *    cpu_hotplug_lock
>   *      pmus_lock
> @@ -10312,6 +10313,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  			goto err_per_task;
>  		}
>  
> +		/*
> +		 * Clone the parent's vma offsets: they are valid until exec()
> +		 * even if the mm is not shared with the parent.
> +		 */
> +		if (event->parent) {
> +			struct perf_addr_filters_head *ifh = perf_event_addr_filters(event);
> +
> +			raw_spin_lock_irq(&ifh->lock);
> +			memcpy(event->addr_filters_offs,
> +			       event->parent->addr_filters_offs,
> +			       pmu->nr_addr_filters * sizeof(unsigned long));
> +			raw_spin_unlock_irq(&ifh->lock);
> +		}
> +
>  		/* force hw sync on the address filters */
>  		event->addr_filters_gen = 1;
>  	}
> -- 
> 2.20.1
