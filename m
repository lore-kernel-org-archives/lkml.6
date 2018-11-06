Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AAFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F6F2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ogdh/hv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F6F2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbeKFUZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:25:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeKFUZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eXS+h2E3fznNmKn234lBsiJ10CGrDQApqVEsQd47ayE=; b=Ogdh/hv/KCxeYISie2mn2mMXs
        XxvAiYMTi/648DWwxwjZ+4Ko52skt6DO3/EhwaB0iSzNt8q6OUvp5+w8i8lN81M9mxuYiaHVOUGqi
        d+ZC08Ll/RxHKyedDSNLEvTvrvOniPQy3HuxIcx+devnXv42b9g98OmgQKvJT7phzXYHsELlPQuu8
        c7E4zLjkYVQGrL1CD4fzPOjK6Y+9ulu1cD8+DbA8dxPtKYrdK03HvicapHBVa3bzSjbZZ0K3AXqZ6
        sOxepbySDvfZnc4+tiRzk5q8M/caTIw/iQb7+rc4IZjXM2Y7SipCi+eYk1yA0lfqJqoBtyjYS+qzT
        ayQgdXqxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJz5z-0001hg-W6; Tue, 06 Nov 2018 11:00:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2AC62029F9FF; Tue,  6 Nov 2018 12:00:26 +0100 (CET)
Date:   Tue, 6 Nov 2018 12:00:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] bit_spinlock: introduce smp_cond_load_relaxed
Message-ID: <20181106110026.GJ22431@hirez.programming.kicks-ass.net>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181030060441.16107-1-gaoxiang25@huawei.com>
 <20181105224654.GA25864@brain-police>
 <20181106090642.GH22431@hirez.programming.kicks-ass.net>
 <5eb42b84-5195-69f2-e7a7-97568f360506@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eb42b84-5195-69f2-e7a7-97568f360506@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 06:22:31PM +0800, Gao Xiang wrote:
> Hi Peter,
> 
> On 2018/11/6 17:06, Peter Zijlstra wrote:
> > On Mon, Nov 05, 2018 at 10:49:21PM +0000, Will Deacon wrote:
> >> diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
> >> index 3ae021368f48..9de8d3544630 100644
> >> --- a/include/asm-generic/bitops/lock.h
> >> +++ b/include/asm-generic/bitops/lock.h
> >> @@ -6,6 +6,15 @@
> >>  #include <linux/compiler.h>
> >>  #include <asm/barrier.h>
> >>  
> >> +static inline void spin_until_bit_unlock(unsigned int nr,
> >> +					 volatile unsigned long *p)
> >> +{
> >> +	unsigned long mask = BIT_MASK(bitnum);
> >> +
> >> +	p += BIT_WORD(nr);
> >> +	smp_cond_load_relaxed(p, VAL & mask);
> >> +}
> >> +
> >>  /**
> >>   * test_and_set_bit_lock - Set a bit and return its old value, for lock
> >>   * @nr: Bit to set
> >> diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
> >> index bbc4730a6505..d711c62e718c 100644
> >> --- a/include/linux/bit_spinlock.h
> >> +++ b/include/linux/bit_spinlock.h
> >> @@ -26,9 +26,7 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
> >>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> >>  	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
> >>  		preempt_enable();
> >> -		do {
> >> -			cpu_relax();
> >> -		} while (test_bit(bitnum, addr));
> >> +		spin_until_bit_unlock(bitnum, addr);
> >>  		preempt_disable();
> >>  	}
> >>  #endif
> > 
> > Yes, that's much better. Ideally though, we'd get rid of bit spinlocks
> > that have significant enough contention for this to matter.
> 
> OK, I will send v3 to fix like the above.

That's not answering the full question though. What bit spinlocks did
you find where this matters? And can't we convert them to proper
spinlocks instead?
