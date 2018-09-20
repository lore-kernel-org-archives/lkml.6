Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA45ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D94F2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oVISmaLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D94F2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeITWGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:06:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeITWGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xJ3yBp77MqWtiwJKjICMtjEDV065Wj+aVcTDyX7S1Jw=; b=oVISmaLe+PC7Tx6igS7AEJIpQ
        EPZv249C2/S9XO2QI73yhkjLdzPylL6AfU/SaXTCm9+HtZSqQ9KZLNCj7VqmO726Mci3iFHi6hSxE
        L81aKJw/2vI9L0YrWo/WZL2TIsdeh53JIDhlWzs7zloJPl32iti/2Q2uJ9vGDAY9/L9hZaQrvSDXX
        GmNqMSlg9WoxU7SJ3ePZtej1oS1PRd23azyl6Fm6ADL4Bq+wI2xfwzGHY9lOLDsmDemP97kJv4Pny
        wxxnlDXdJVzedWcWIUiZbBsvmYmlN/3NAP2dHvNrDrQG9Ei/NamM9koO2rfhSluo1St+0ZoRT5JO4
        KSS4TtdTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g31ie-0008HS-Kz; Thu, 20 Sep 2018 16:22:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D0902024E44B; Thu, 20 Sep 2018 18:22:17 +0200 (CEST)
Date:   Thu, 20 Sep 2018 18:22:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@kernel.org,
        boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Message-ID: <20180920162216.GR24142@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180409105835.GC23134@arm.com>
 <20180409145409.GA9661@arm.com>
 <20180409155420.GB4082@hirez.programming.kicks-ass.net>
 <20180409171959.GB9661@arm.com>
 <20180920160832.GZ24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920160832.GZ24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 06:08:32PM +0200, Peter Zijlstra wrote:
> Another approach might be to use something like:
> 
> 	val = xchg_relaxed(&lock->locked_pending, _Q_PENDING_VAL | _Q_LOCKED_VAL);
> 	val |= atomic_read_acquire(&lock->val) & _Q_TAIL_MASK;
> 
> combined with something like:
> 
> 	/* 0,0,0 -> 0,1,1 - we won trylock */
> 	if (!(val & _Q_LOCKED_MASK)) {

That one doesn't actually work... let me think about this more.

> 		clear_pending(lock);
> 		return;
> 	}
> 
> 	/* 0,0,1 -> 0,1,1 - we won pending */
> 	if (!(val & ~_Q_LOCKED_MASK)) {
> 		...
> 	}
> 
> 	/* *,0,1 -> *,1,1 - we won pending, but there's queueing */
> 	if (!(val & _Q_PENDING_VAL))
> 		clear_pending(lock);
> 
> 	...
> 
> 
> Hmmm?
