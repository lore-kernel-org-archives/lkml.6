Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDE0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A3420672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A3420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405930AbeKWC7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:59:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbeKWC7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:59:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEE6931256C9;
        Thu, 22 Nov 2018 16:19:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.142])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3DF485C21E;
        Thu, 22 Nov 2018 16:19:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 22 Nov 2018 17:19:45 +0100 (CET)
Date:   Thu, 22 Nov 2018 17:19:42 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, stable@kernel.org
Subject: Re: [PATCH] uprobes: Fix handle_swbp() vs. unregister() + register()
 race once more
Message-ID: <20181122161942.GG28270@redhat.com>
References: <20181122161031.15179-1-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122161031.15179-1-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 22 Nov 2018 16:19:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22, Andrea Parri wrote:
>
> Commit 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() +
> register() race") added the UPROBE_COPY_INSN flag, and corresponding
> smp_wmb() and smp_rmb() memory barriers, to ensure that handle_swbp()
> uses fully-initialized uprobes only.
> 
> However, the smp_rmb() is mis-placed: this barrier should be placed
> after handle_swbp() has tested for the flag, thus guaranteeing that
> (program-order) subsequent loads from the uprobe can see the initial
> stores performed by prepare_uprobe().
> 
> Move the smp_rmb() accordingly.  Also amend the comments associated
> to the two memory barriers to indicate their actual locations.
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: stable@kernel.org
> Fixes: 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() + register() race")

Thanks,

Acked-by: Oleg Nesterov <oleg@redhat.com>



> ---
>  kernel/events/uprobes.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 96d4bee83489b..322e97bbb4370 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -829,7 +829,7 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
>  	BUG_ON((uprobe->offset & ~PAGE_MASK) +
>  			UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
>  
> -	smp_wmb(); /* pairs with rmb() in find_active_uprobe() */
> +	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
>  	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
>  
>   out:
> @@ -2178,10 +2178,18 @@ static void handle_swbp(struct pt_regs *regs)
>  	 * After we hit the bp, _unregister + _register can install the
>  	 * new and not-yet-analyzed uprobe at the same address, restart.
>  	 */
> -	smp_rmb(); /* pairs with wmb() in install_breakpoint() */
>  	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
>  		goto out;
>  
> +	/*
> +	 * Pairs with the smp_wmb() in prepare_uprobe().
> +	 *
> +	 * Guarantees that if we see the UPROBE_COPY_INSN bit set, then
> +	 * we must also see the stores to &uprobe->arch performed by the
> +	 * prepare_uprobe() call.
> +	 */
> +	smp_rmb();
> +
>  	/* Tracing handlers use ->utask to communicate with fetch methods */
>  	if (!get_utask())
>  		goto out;
> -- 
> 2.17.1
> 

