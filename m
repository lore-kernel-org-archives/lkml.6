Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02332C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B828A20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PyN5MHpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B828A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeLCRbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:31:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36838 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeLCRbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s5/fOkoTPwEm2o0Pae1jRb0P+S0mR2X8/we1WstPVsY=; b=PyN5MHpjpwlGU1FU6zDlO3I3I
        8nbhFx057TfdW0bCJG6mQIVDA6JXXF9wTETggV+iIEH9+0JGYaUF4WY8VwCXL2HVrajuaos53clqL
        rX/8aVlBVbccR2x9b5emoTnNBgCorLaK1VkmZwP/eYxb6B5BPmmqEIa8ncnR1kRb5MQdnLff9Q/Qd
        8CKpFVia1mjUV0dIC1JeKAXFijk8mOXbwy9cAFomoAu6NaBy7De7hSz6cgEYgnMQxAkbTt9goSWYt
        YYsm6pOAYRn9o4ZcgV9O8AxL5VHYaV1duRiwZgFiSXEknIsY6huoBpJ+wIagiVyd1z3tEJRrV+2fm
        PDCSdd+cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTs4D-0001OL-Is; Mon, 03 Dec 2018 17:31:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45CA62029F873; Mon,  3 Dec 2018 18:31:32 +0100 (CET)
Date:   Mon, 3 Dec 2018 18:31:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/27] locking/lockdep: Add support for dynamic keys
Message-ID: <20181203173132.GJ11614@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
 <20181128234325.110011-26-bvanassche@acm.org>
 <20181129101000.GF2131@hirez.programming.kicks-ass.net>
 <1543856820.185366.159.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543856820.185366.159.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 09:07:00AM -0800, Bart Van Assche wrote:
> How about adding this as an additional patch before patch 25/27?

Excellent, thanks!

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 9a7cca6dc3d4..ce05b9b419f4 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -725,6 +725,15 @@ static bool assign_lock_key(struct lockdep_map *lock)
>  {
>  	unsigned long can_addr, addr = (unsigned long)lock;
>  
> +	/*
> +	 * lockdep_free_key_range() assumes that struct lock_class_key
> +	 * objects do not overlap. Since we use the address of lock
> +	 * objects as class key for static objects, check whether the
> +	 * size of lock_class_key objects does not exceed the size of
> +	 * the smallest lock object.
> +	 */
> +	BUILD_BUG_ON(sizeof(struct lock_class_key) > sizeof(raw_spinlock_t));
> +
>  	if (__is_kernel_percpu_address(addr, &can_addr))
>  		lock->key = (void *)can_addr;
>  	else if (__is_module_percpu_address(addr, &can_addr))
> 
> Thanks,
> 
> Bart.
