Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B4ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DD92084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZE+QnLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DD92084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJZR0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:26:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJZRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JhkYmCqLNjLyUBVGgzczZMognjW37CKwTgg0gHjV/qw=; b=JZE+QnLCIqO5+nQyTu73wSFd2
        3wUa2uwJLSknqJQZPF5CdO98gjVFFgCF0Jv86Xlv71BorcJHGjZsYDuks0e9AKuIpwtkM1TfaDQnh
        2dMhGWaBgO/Gvg/bGbDmld5c+m8/Wh0X8Ybw1Mir79nWT+nhUVxqeje2HMf0KJmLaozRNffqcBeZG
        NCwInrzs4fX66DK3j+xSQkmjvo8VJMuf1QFRfOe87WP/GIwgDVXsGa1W74G3eR+lhzVUpufwEV1+/
        cXu8LU6m9f12Z/20L/sbsqu/WXIdfAhNgdJEaPeu3fT4cj58cwlAPC9UJGxN93amhPAmRvvhmhV4H
        twEHb6Y+g==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFxoO-0002FF-HM; Fri, 26 Oct 2018 08:49:44 +0000
Received: by worktop (Postfix, from userid 1000)
        id B9FD66E07BE; Fri, 26 Oct 2018 10:32:35 +0200 (CEST)
Date:   Fri, 26 Oct 2018 10:32:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 1/3] sched/core: Warn if cpumask has a mix of isolcpus
 and housekeeping CPUs
Message-ID: <20181026083235.GW3109@worktop.c.hoisthospitality.com>
References: <1540492943-17147-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1540492943-17147-2-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540492943-17147-2-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 12:12:21AM +0530, Srikar Dronamraju wrote:
> @@ -4778,6 +4779,16 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>  
>  	cpuset_cpus_allowed(p, cpus_allowed);
>  	cpumask_and(new_mask, in_mask, cpus_allowed);
> +	hk_mask = housekeeping_cpumask(HK_FLAG_DOMAIN);
> +
> +	/*
> +	 * Warn if the cpumask provided has CPUs that are part of isolated and
> +	 * housekeeping_cpumask
> +	 */
> +	if (!cpumask_subset(new_mask, hk_mask) &&
> +			cpumask_intersects(new_mask, hk_mask))
> +		pr_warn("pid %d: Mix of isolcpus and non-isolcpus provided\n",
> +			p->pid);
>  
>  	/*
>  	 * Since bandwidth control happens on root_domain basis,

That is horribly coding style, and completely pointless. Also user
trigerable printl like that should be rate limited at the very least.
