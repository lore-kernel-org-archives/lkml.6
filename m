Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F5ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC282082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpRYscHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC282082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeJZR0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:26:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60426 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeJZRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AG4c6emYVFszQujiFn5ZxbPGoBBI/9qTM8hR48sNFxo=; b=gpRYscHa7eQ+0eNAPZvJg+GPu
        b1mhB0sgS8wklgjgQq6dg0auJpWFt5rF9Reth3cQ5HOuZmpm5BDXTcT6GXr4tIufPO8QVfMWPNZ2W
        740KtwgjHSVbDY0+sEjMsYCGtQHjAs6hDCxxRVprwjFlUM0ztma1fbMiNGm3LQq6FAUVtKQohGJy7
        JIedf5MrcbIAmKpH8/oPMIChIrvxO42u7Z869GZ+DuRiZaBM/IGX5tvoP0Qb+u1mOBun4VoRbQD1g
        1gwnatTla/z8XHQVuCasnhPAqzb+mpD3/MckE5P7skhHLOfXkvMYrQzTXvuiBRa/cvz2iokAjXnYh
        DxGmfVc+A==;
Received: from [167.98.65.38] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFxoN-0000yq-UB; Fri, 26 Oct 2018 08:49:44 +0000
Received: by worktop (Postfix, from userid 1000)
        id 07DD96E07CA; Fri, 26 Oct 2018 10:33:04 +0200 (CEST)
Date:   Fri, 26 Oct 2018 10:33:03 +0200
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
Subject: Re: [PATCH v3 2/3] sched/core: Don't mix isolcpus and housekeeping
 CPUs
Message-ID: <20181026083303.GX3109@worktop.c.hoisthospitality.com>
References: <1540492943-17147-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1540492943-17147-3-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540492943-17147-3-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 12:12:22AM +0530, Srikar Dronamraju wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3064e0f..37e62b8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1003,7 +1003,19 @@ static int migration_cpu_stop(void *data)
>   */
>  void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
>  {
> -	cpumask_copy(&p->cpus_allowed, new_mask);
> +	const struct cpumask *hk_mask = housekeeping_cpumask(HK_FLAG_DOMAIN);
> +
> +	/*
> +	 * If the cpumask provided has CPUs that are part of isolated and
> +	 * housekeeping_cpumask, then restrict it to just the CPUs that
> +	 * are part of the housekeeping_cpumask.
> +	 */
> +	if (!cpumask_subset(new_mask, hk_mask) &&
> +			cpumask_intersects(new_mask, hk_mask))
> +		cpumask_and(&p->cpus_allowed, new_mask, hk_mask);
> +	else
> +		cpumask_copy(&p->cpus_allowed, new_mask);
> +
>  	p->nr_cpus_allowed = cpumask_weight(new_mask);

NAK, I already explained that.
