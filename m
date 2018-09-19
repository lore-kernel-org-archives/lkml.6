Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FAAECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5D7214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DjMviy+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5D7214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeISRg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:36:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbeISRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g8nSW7uKeh4rScHAO2VCw3O28QCvcFkDVft/Cyxqxyk=; b=DjMviy+hY87nyyLZd+LvFY8S/
        pSWcKX6ytZyBC4+ecJdagyqZstoL/sZMDhKTfswqyRplI/7M66ubGqcCgF+5GqeUOK4XBhOVWaPca
        HDzuLqROIuJbJKsofGipd5mMrfkkoUpk7c0Nnmd1ty/o5ch2cEvcDRg0gVvHna+QszeXRsFL/jZ4b
        fiJBZDeFE2p+W36AOEKKTntcEIg8UTUFDfJgyuPGzylA73uZkI6tMQwdKwB780TN17GHV6vfpSvRP
        aH2MGys67Cn3c1rCY1CfkzSMQtKs5c7rv8ck/+uqK5uIIAyMsFgHvLO/Pp33SVEqXdiF3YGGd8m/v
        jOMwn7zKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2b7u-0002CX-W1; Wed, 19 Sep 2018 11:58:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E92D7202C1A3F; Wed, 19 Sep 2018 13:58:36 +0200 (CEST)
Date:   Wed, 19 Sep 2018 13:58:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>, segher@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] sched: move stack_canary field at the top of
 task_struct
Message-ID: <20180919115836.GE24124@hirez.programming.kicks-ass.net>
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:14:43AM +0000, Christophe Leroy wrote:
> In order to allow the use of non global stack protector canary,
> the stack canary needs to be located at a know offset defined
> in Makefile via -mstack-protector-guard-offset.
> 
> On powerpc/32, register r2 points to current task_struct at
> all time, the stack_canary located inside task_struct can be
> used directly if it is located in a known place.
> 
> In order to allow that, this patch moves the stack_canary field
> out of the randomized area of task_struct.

And you cannot use something like asm-offsets to extract this?

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  include/linux/sched.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 977cb57d7bc9..1d977b8a4bac 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -601,6 +601,10 @@ struct task_struct {
>  	/* -1 unrunnable, 0 runnable, >0 stopped: */
>  	volatile long			state;
>  
> +#ifdef CONFIG_STACKPROTECTOR
> +	/* Canary value for the -fstack-protector GCC feature: */
> +	unsigned long			stack_canary;
> +#endif
>  	/*
>  	 * This begins the randomizable portion of task_struct. Only
>  	 * scheduling-critical items should be added above here.

Might as well put it before state, right after the task_info thing.
