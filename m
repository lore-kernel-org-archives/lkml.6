Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E698C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFC320880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTAuHPTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFC320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeIYTBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:01:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbeIYTBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YfEgqCZsL0D0MX2UFgrk0gZ2R/zh4SL983DQE0j7GFE=; b=NTAuHPTBofAjMrR1WN4NdN55e
        M4pzeMj4oDIbpsvrsrJcH4K3wVuXgN5eDInCFzwZ4j0sOXcbKOJQcNHHnReiAICb98+JOggs94/A6
        WmgUORQL+iwYxPIQ39WIw09TC/4lqqfj+2cyChwES5GxjnxFJLTkOdd9nY+GAARvHtz2DFzAWZBI5
        Qyax5D13zGJOGVZ4YE79ojWZVfKtV5PbowQJV2bQi9ZroEH06ULaU4xvRQUPcwmWanC4L5l9xjN+n
        n4ZFqlha26Fr5IQwPWhVCuTAGCQqN41cgmbPPfbhq9a8jnaDArrn8wPP7/NSnfknUazAkj94LXF0P
        26d0BhYNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4mqn-0004UF-Ii; Tue, 25 Sep 2018 12:54:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97CDE20289D10; Tue, 25 Sep 2018 14:53:59 +0200 (CEST)
Date:   Tue, 25 Sep 2018 14:53:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v5 5/5] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20180925125359.GB29985@hirez.programming.kicks-ass.net>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
 <20180903142801.20046-6-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903142801.20046-6-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 04:28:01PM +0200, Juri Lelli wrote:
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index fb7ae691cb82..08128bdf3944 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1883,8 +1883,19 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>  	for (i = 0; i < ndoms_cur; i++) {
>  		for (j = 0; j < n && !new_topology; j++) {
>  			if (cpumask_equal(doms_cur[i], doms_new[j])
> -			    && dattrs_equal(dattr_cur, i, dattr_new, j))
> +			    && dattrs_equal(dattr_cur, i, dattr_new, j)) {

While there, please also fix that wrongly placed operator.

> +				struct root_domain *rd;
> +
> +				/*
> +				 * This domain won't be destroyed and as such
> +				 * its dl_bw->total_bw needs to be cleared.  It
> +				 * will be recomputed in function
> +				 * update_tasks_root_domain().
> +				 */
> +				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
> +				dl_clear_root_domain(rd);
>  				goto match1;
> +			}
>  		}
>  		/* No match - a current sched domain not in new doms_new[] */
>  		detach_destroy_domains(doms_cur[i]);
> -- 
> 2.17.1
> 
