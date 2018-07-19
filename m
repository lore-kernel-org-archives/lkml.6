Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150F6C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C5B20858
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eYVjzJWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C5B20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbeGSOaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:30:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbeGSOaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0JQaYzz+DtpWDwPQ2DQgpVr0Gb0MOJuAxIwwOEZ/HU8=; b=eYVjzJWULEnJ1u8LKH2Ia64hH
        F7vsMaCM5CQt/Nw1pC1G4d4tdG9X/SUdY9/17ravMUHKGXeXCNqqdjqVb3Sdp+Vu00F+oKB0iZ2ja
        vsFUaVuYMXNJZ9By+xMYljg1G/SS+v+jgrG1oJwIbfg2pYBDV6JT50rpr2bsz9nhHs/rLJySHryUX
        WCOcl15YdC/cjwtoGaFuPdVLlaNiS7wJU0sGC5GANzc9z6tRsM1f1h1vjVXn53X9e+gOehFpn+gQU
        cF/dI72xcqWAGQDvVx+r7sAhCdjIgFytBFXGMdD3YdDWMH4Ibm1Poi3PIImiNPayh9MI5eVsGDnNl
        c1lASlbHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg9Gh-0002b8-5v; Thu, 19 Jul 2018 13:46:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7746020275F3A; Thu, 19 Jul 2018 15:46:53 +0200 (CEST)
Date:   Thu, 19 Jul 2018 15:46:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/debug: Use terse backtrace for idly sleeping
 threads.
Message-ID: <20180719134653.GH2476@hirez.programming.kicks-ass.net>
References: <1532007443-3538-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532007443-3538-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:37:23PM +0900, Tetsuo Handa wrote:
> This patch can be applied before proposing abovementioned changes.
> Since there are many kernel threads whose backtrace is boring due to idly
> waiting for an event inside the main loop, this patch introduces a kernel
> config option (which allows SysRq-t to use one-liner backtrace for threads
> idly waiting for an event) and simple helpers (which allow current thread
> to declare that current thread is about to start/end idly waiting).

> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index f776807..6b8c8bd 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -406,7 +406,9 @@ static int devtmpfsd(void *p)
>  		}
>  		__set_current_state(TASK_INTERRUPTIBLE);
>  		spin_unlock(&req_lock);
> +		start_idle_sleeping();
>  		schedule();
> +		end_idle_sleeping();
>  	}
>  	return 0;
>  out:

So I _really_ hate the idea of sprinking that all around the kernel like
this.
