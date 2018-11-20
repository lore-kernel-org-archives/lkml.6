Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2059C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690FD20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pbo9b6Ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690FD20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeKTXz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:55:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeKTXz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XSVvNPjnHJ4zUjkPzmO4/qoU7trNa/0Oc4U4PeUSd6E=; b=Pbo9b6RiAgD4CLkvvTuLfpZz3
        7iLFr3NNODYNybllozavPWOSriM+GD2TjlxOUORpV9zpxzz2UTcqhgWyy8UQuaJgV+pcZcygiBr6y
        NcEGmGrJLyDdsR/ok0viSc4ueymdajvKG9TKg5rO9vDXEt5uXU/svxiNkGv2OrL71US5asgfRE2gJ
        95bm7JavLfYHPVebR3A7qNW/Sive/jNwf07Cx1Th7Pu86o/RMazO47GsadVn/cLnJlcQbpDQbFPiM
        WZEC9AXKGa2Rj5H+DC8HCgPp00/FM9rwnUGCsS95hT8RNoHl+CwrCXGkvEfnavFlHiQzd1kDEWHLz
        CFr01RMSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP620-0007Ev-FL; Tue, 20 Nov 2018 13:25:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B37E2029F87F; Tue, 20 Nov 2018 14:25:12 +0100 (CET)
Date:   Tue, 20 Nov 2018 14:25:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 04/25] vtime: Spare a seqcount lock/unlock cycle on
 context switch
Message-ID: <20181120132512.GQ2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-5-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542163569-20047-5-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:45:48AM +0100, Frederic Weisbecker wrote:

So I definitely like avoiding that superfluous atomic op, however:

> @@ -730,19 +728,25 @@ static void vtime_account_guest(struct task_struct *tsk,
>  	}
>  }
>  
> +static void __vtime_account_kernel(struct task_struct *tsk,
> +				   struct vtime *vtime)

Your last patch removed a __function, and now you're adding one back :/

>  {
>  	/* We might have scheduled out from guest path */
>  	if (tsk->flags & PF_VCPU)
>  		vtime_account_guest(tsk, vtime);
>  	else
>  		vtime_account_system(tsk, vtime);
> +}
> +
> +void vtime_account_kernel(struct task_struct *tsk)
> +{
> +	struct vtime *vtime = &tsk->vtime;
> +
> +	if (!vtime_delta(vtime))
> +		return;
> +

See here the fast path (is it worth it?)

> +	write_seqcount_begin(&vtime->seqcount);
> +	__vtime_account_kernel(tsk, vtime);
>  	write_seqcount_end(&vtime->seqcount);
>  }

> +void vtime_task_switch_generic(struct task_struct *prev)
>  {
>  	struct vtime *vtime = &prev->vtime;

And observe a distinct lack of that same fast path..

>  
>  	write_seqcount_begin(&vtime->seqcount);
> +	if (is_idle_task(prev))
> +		vtime_account_idle(prev);
> +	else
> +		__vtime_account_kernel(prev, vtime);
>  	vtime->state = VTIME_INACTIVE;
>  	write_seqcount_end(&vtime->seqcount);
>  
> -- 
> 2.7.4
> 
