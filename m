Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62A9FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7373420893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FUB37tPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7373420893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeG3L3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:29:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41012 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeG3L3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rYRMSz+HVK4nu0hq6MV3VwjWNnI+ajHDuoPoW28AXRo=; b=FUB37tPp56tHLNggLhGeDnm5b
        S4dP2Gk2oTB87ZThJXH4z5wovygsJFWXxkSYZRVQ+FYGnhrDy2huPPGkmdXjel5eAKZksWH/4Ruf0
        Lx1Qpy/ujs6fC5bATZtygy7vH0SuXuqTB1T1TktQW8KBeLWW1WRGSalVURwLrk8Ep/fmqt201G9KQ
        VAid49MT8jGK9LmCX4I9H1V7ULOCqsXvKK/cDR5FpX5r5NgTCmgdt3dnkX5/YBUNoqzV2fvLr9Ujy
        M3QqU1Iat7bGvcZZttrdUNfq2A1Lk78+1q3z+X7m2gk8VGHW5Cy0ZOrqudzAhM9W/3+NY9qm1kZlT
        R7IKIkCXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk4tO-0005Os-0j; Mon, 30 Jul 2018 09:55:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E338F202883BF; Mon, 30 Jul 2018 11:55:02 +0200 (CEST)
Date:   Mon, 30 Jul 2018 11:55:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
Message-ID: <20180730095502.GG2494@hirez.programming.kicks-ass.net>
References: <20180728215357.3249-1-riel@surriel.com>
 <20180728215357.3249-11-riel@surriel.com>
 <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
 <20180729155452.37eddc11@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729155452.37eddc11@imladris.surriel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 03:54:52PM -0400, Rik van Riel wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c45de46fdf10..11724c9e88b0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2691,7 +2691,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  	 */
>  	if (mm) {
>  		membarrier_mm_sync_core_before_usermode(mm);
> -		mmdrop(mm);
> +		drop_lazy_mm(mm);
>  	}
>  	if (unlikely(prev_state == TASK_DEAD)) {
>  		if (prev->sched_class->task_dead)
> @@ -2805,7 +2805,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  	 */
>  	if (!mm) {
>  		next->active_mm = oldmm;
> -		mmgrab(oldmm);
> +		grab_lazy_mm(oldmm);
>  		enter_lazy_tlb(oldmm, next);
>  	} else
>  		switch_mm_irqs_off(oldmm, mm, next);

What happened to the rework I did there? That not only avoided fiddling
with active_mm, but also avoids grab/drop cycles for the other
architectures when doing task->kthread->kthread->task things.

I agree with Andy that if you avoid the refcount fiddling, then you
should also not muck with active_mm.

That is, if you keep active_mm for now (which seems a reasonable first
step) then at least ensure you keep ->mm == ->active_mm at all times.
