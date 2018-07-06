Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652E2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251B523E92
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251B523E92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932816AbeGFLoi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:44:38 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56843 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932348AbeGFLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:44:36 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0747115|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03295;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CN48llI_1530877443;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CN48llI_1530877443)
          by smtp.aliyun-inc.com(10.147.41.187);
          Fri, 06 Jul 2018 19:44:03 +0800
Date:   Fri, 6 Jul 2018 19:44:03 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706114402.GB27148@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175902.GF2530@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705175902.GF2530@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 07:59:02PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:
> 
> > +static inline void arch_spin_lock(arch_spinlock_t *lock)
> > +{
> > +	unsigned int *p = &lock->lock;
> > +	unsigned int tmp;
> > +
> > +	asm volatile (
> > +		"1:	ldex.w		%0, (%1) \n"
> > +		"	bnez		%0, 1b   \n"
> > +		"	movi		%0, 1    \n"
> > +		"	stex.w		%0, (%1) \n"
> > +		"	bez		%0, 1b   \n"
> > +		: "=&r" (tmp)
> > +		: "r"(p)
> > +		: "memory");
> > +	smp_mb();
> > +}
> 
> Test-and-set with MB acting as ACQUIRE, ok.
Em ... Ok, I'll try to use test-and-set function instead of it.

> > +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> > +{
> > +	unsigned int *p = &lock->lock;
> > +	unsigned int tmp;
> > +
> > +	smp_mb();
> > +	asm volatile (
> > +		"1:	ldex.w		%0, (%1) \n"
> > +		"	movi		%0, 0    \n"
> > +		"	stex.w		%0, (%1) \n"
> > +		"	bez		%0, 1b   \n"
> > +		: "=&r" (tmp)
> > +		: "r"(p)
> > +		: "memory");
> > +}
> 
> MB acting for RELEASE, but _why_ are you using a LDEX/STEX to clear the
> lock word? Would not a normal store work?
Normal store is enough, I'll fixup it in next version patch.
 
> Also, the fact that you need MB for release implies your LDEX does not
> in fact imply anything and your xchg/cmpxchg implementation is broken.
xchg/cmxchg broken without 1th smp_mb()? Why we need protect the
instructions flow before the ldex.w?

> > +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> > +{
> > +	unsigned int *p = &lock->lock;
> > +	unsigned int tmp;
> > +
> > +	asm volatile (
> > +		"1:	ldex.w		%0, (%1) \n"
> > +		"	bnez		%0, 2f   \n"
> > +		"	movi		%0, 1    \n"
> > +		"	stex.w		%0, (%1) \n"
> > +		"	bez		%0, 1b   \n"
> > +		"	movi		%0, 0    \n"
> > +		"2:				 \n"
> > +		: "=&r" (tmp)
> > +		: "r"(p)
> > +		: "memory");
> > +	smp_mb();
> > +
> > +	return !tmp;
> > +}
> 
> Strictly speaking you can avoid the MB on failure. You only need to
> provide ACQUIRE semantics on success.
> 
> That said, I would really suggest you implement a ticket lock instead of
> a test-and-set lock. They're not really all that complicated and do
> provide better worst case behaviour.
Ok, I'll try to implement ticket lock in next version patch.

> 
> 
> > +/****** read lock/unlock/trylock ******/
> 
> Please have a look at using qrwlock -- esp. if you implement a ticket
> lock, then the rwlock comes for 'free'.
Ok, I'll try it.

 Guo Ren
