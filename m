Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF596ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7580920693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UqiHFvEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7580920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeGRI4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:56:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeGRI4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oWybjPG8JArHBKVsTpY+gkdehyEb0Pp9XhIyVkt73R8=; b=UqiHFvEgrUnLY1iuL4O/Mn1Vy
        QtQoaf567Ljor1EQWRzHytgf/M6KvpUuMC5UVES+XQlYSAQff4pnV0Y5WDCJpl928h+x6BWCtbGw0
        A3JK+yTHJ9iDIU6cwidZH0/qTtLgCzOfQoKvEXHhzZvIKDZh90I99Lu+IMhUKf1b12NbgxU4PcM/f
        7xbcQSJZgplZ/L/ZCKqzQDZARsBP1dh03JVDNTi6/LFYTWO3h3X/8YmXtShS3wi9++/7P+3Uz1mWl
        i0zLHXgaNKYYoDM1H581udk/gy1xaxGtCaeY7D3QoTwtQvbKKn3C5T0MprD5bPo3W+eIKZjDYJDXM
        Z/mnzbyEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffhg9-0000rx-0X; Wed, 18 Jul 2018 08:19:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6873420289330; Wed, 18 Jul 2018 10:19:18 +0200 (CEST)
Date:   Wed, 18 Jul 2018 10:19:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Will Deacon <will.deacon@arm.com>,
        Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] x86/pvqspinlock: Use LOCK_PREFIX in
 __pv_queued_spin_unlock assembly code
Message-ID: <20180718081918.GO2494@hirez.programming.kicks-ass.net>
References: <1531858560-21547-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531858560-21547-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:16:00PM -0400, Waiman Long wrote:
> The LOCK_PREFIX macro should be used in the assembly
> __raw_callee_save___pv_queued_spin_unlock code so that the lock prefix
> can be patched out on UP systems.

True; but does paravirt locking realy make sense on UP guests?

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/x86/include/asm/qspinlock_paravirt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
> index 9ef5ee0..159622e 100644
> --- a/arch/x86/include/asm/qspinlock_paravirt.h
> +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> @@ -43,7 +43,7 @@
>  	"push  %rdx;"
>  	"mov   $0x1,%eax;"
>  	"xor   %edx,%edx;"
> -	"lock cmpxchg %dl,(%rdi);"
> +	LOCK_PREFIX "cmpxchg %dl,(%rdi);"
>  	"cmp   $0x1,%al;"
>  	"jne   .slowpath;"
>  	"pop   %rdx;"
> -- 
> 1.8.3.1
> 
