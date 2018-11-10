Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425BCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA1320892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VDEJdPwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA1320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeKKI3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 03:29:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeKKI3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 03:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kWfHLnXC8cbME/mYsBEh7YwvLGQFj/efe+ilZ0JVN+Y=; b=VDEJdPwxLQpoLwDGJ8FH+xtQ1
        3sf2Uy1rYvB5oMopdUHkJXbQcJH+KOQBdGo6abr4lxIiFTTqKIsDestYhXLBhbpSXVuprTeh07u8B
        7FT+2yZJmyysm24XNMR6i3DLzfEjTuDgdOOJ+bIurZ16Sj0Z6KKNQ2S4mpKj+4BSPaaWhaxYOddDG
        ernwGtOMc7ArO3hiFbD3yGW/wbzM5x5fDqJIm5zenSuaNwPPmD/pAbKCf7Z7tRf7/ms4RtknJRhOz
        j2MHN3Nuynti3EKw/66JNh2i//6dyrtaq9soDEUyVk1zifD+ylF2/Q3u/cKM7TZG/ZLyRCwhSKUKF
        GWwmWqp5A==;
Received: from [64.114.255.114] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLbyE-0001jh-6e; Sat, 10 Nov 2018 22:43:14 +0000
Received: by worktop (Postfix, from userid 1000)
        id 2B3126E08A0; Sat, 10 Nov 2018 15:17:34 +0100 (CET)
Date:   Sat, 10 Nov 2018 15:17:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 02/12] locking/lockdep: Add a new terminal lock type
Message-ID: <20181110141734.GF3339@worktop.programming.kicks-ass.net>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
 <1541709268-3766-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541709268-3766-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:34:18PM -0500, Waiman Long wrote:
> A terminal lock is a lock where further locking or unlocking on another
> lock is not allowed. IOW, no forward dependency is permitted.
> 
> With such a restriction in place, we don't really need to do a full
> validation of the lock chain involving a terminal lock.  Instead,
> we just check if there is any further locking or unlocking on another
> lock when a terminal lock is being held.

> @@ -263,6 +270,7 @@ struct held_lock {
>  	unsigned int hardirqs_off:1;
>  	unsigned int references:12;					/* 32 bits */
>  	unsigned int pin_count;
> +	unsigned int flags;
>  };

I'm thinking we can easily steal some bits off of the pin_count field if
we have to.
