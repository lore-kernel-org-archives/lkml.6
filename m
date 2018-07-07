Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0A4C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2329C21766
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2329C21766
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753765AbeGGHm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:42:26 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39589 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750861AbeGGHmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:42:25 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08227099|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03271;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.CNNgBZy_1530949330;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CNNgBZy_1530949330)
          by smtp.aliyun-inc.com(10.147.41.178);
          Sat, 07 Jul 2018 15:42:11 +0800
Date:   Sat, 7 Jul 2018 15:42:10 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180707074209.GA32147@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706115614.GV2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 01:56:14PM +0200, Peter Zijlstra wrote:
> That's how LL/SC works. What I was asking is if they have any effect on
> memory ordering. Some architectures have LL/SC imply memory ordering,
> most do not.
> 
> Going by your spinlock implementation they don't imply any memory
> ordering.
ldex/stex don't imply any memory ordering.

> 
> > > The mandated semantics for xchg() / cmpxchg() is an effective smp_mb()
> > > before _and_ after.
> > 
> > 	switch (size) {						\
> > 	case 4:							\
> > 		smp_mb();					\
> > 		asm volatile (					\
> > 		"1:	ldex.w		%0, (%3) \n"		\
> > 		"	mov		%1, %2   \n"		\
> > 		"	stex.w		%1, (%3) \n"		\
> > 		"	bez		%1, 1b   \n"		\
> > 			: "=&r" (__ret), "=&r" (tmp)		\
> > 			: "r" (__new), "r"(__ptr)		\
> > 			: "memory");				\
> > 		smp_mb();					\
> > 		break;						\
> > Hmm?
> > But I couldn't undertand what's wrong without the 1th smp_mb()?
> > 1th smp_mb will make all ld/st finish before ldex.w. Is it necessary?
> 
> Yes.
> 
> 	CPU0			CPU1
> 
> 	r1 = READ_ONCE(x);	WRITE_ONCE(y, 1);
> 	r2 = xchg(&y, 2);	smp_store_release(&x, 1);
> 
> must not allow: r1==1 && r2==0
CPU1 smp_store_release could be finished before WRITE_ONCE, so r1=1 &&
r2=0?
 
> > > The above implementation suggests LDEX implies a SYNC.IS, is this
> > > correct?
> > No, ldex doesn't imply a sync.is.
> 
> Right, as per the spinlock emails, then your proposed primitives are
> incorrect.
Yes, approve.

 Guo Ren
