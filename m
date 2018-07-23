Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA01ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C4020647
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KZOFkwlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C4020647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbeGWJhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:37:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36824 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387972AbeGWJhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3t1ILcP0waxWz0icApDAfgvIFrJ104KU9yTd0GACuM8=; b=KZOFkwlOqaKkc56wBeb2t7eDb
        NMWOZOEQ+6SXspuzGO3JL1Q3JWgmkEJD5dNDnPpFb5ck+bynTOK2NcBoQ9jHrr46n0pwrB3+qrR4F
        jtvza+9+IRpcvvb34fmBw6dY3WsnUZhLsp8XXPglWXK8Wr9z9ocked1eyVuXvwbwW0YtgC+hTqBaO
        cZTrgcODlmEfD2J32Tc/rOm/hYPJyvUpfn8UpFmV+feHCZJSYLfi/l5NwkZIzfAImfGLyrRL3eCAS
        o60cV1Vfu9M/LTldn7HIrrvzldk63HryokiVoQY+LiMBGRYREX0lgbswLVfbnD1gO7KYa0MjOvXYG
        Hu3BgcTMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhWL3-0004rC-6y; Mon, 23 Jul 2018 08:37:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EEE620275F47; Mon, 23 Jul 2018 10:37:02 +0200 (CEST)
Date:   Mon, 23 Jul 2018 10:37:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: Re: [PATCH] sched/topology: check variable group before dereferenced
Message-ID: <20180723083702.GW2494@hirez.programming.kicks-ass.net>
References: <1532319547-33335-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532319547-33335-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 12:19:07PM +0800, Yi Wang wrote:
> The variable group in sched_domain_debug_one() is not checked
> when firstly used in cpumask_test_cpu(cpu, sched_group_span(group)),
> but it maybe NULL(checked later in the following while loop) and may
> cause NULL pointer dereference without checking. We need to check it
> before using to avoid NULL dereference.

It being NULL really is a fairly severe error in construction; but sure.
This patch won't hurt.

> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>  kernel/sched/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 5ac724b..c7cf87c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -53,7 +53,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
>  		printk(KERN_ERR "ERROR: domain->span does not contain "
>  				"CPU%d\n", cpu);
>  	}
> -	if (!cpumask_test_cpu(cpu, sched_group_span(group))) {
> +	if (group && !cpumask_test_cpu(cpu, sched_group_span(group))) {
>  		printk(KERN_ERR "ERROR: domain->groups does not contain"
>  				" CPU%d\n", cpu);
>  	}
> -- 
> 1.8.3.1
> 
