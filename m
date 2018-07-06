Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94091C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBCE23E92
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBCE23E92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932524AbeGFLs1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:48:27 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58220 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753630AbeGFLs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:48:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1393301|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03298;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CN4Sj.d_1530877692;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CN4Sj.d_1530877692)
          by smtp.aliyun-inc.com(10.147.44.129);
          Fri, 06 Jul 2018 19:48:12 +0800
Date:   Fri, 6 Jul 2018 19:48:12 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706114812.GC27148@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705180008.GG2530@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705180008.GG2530@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 08:00:08PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:
> > +#ifdef CONFIG_CPU_HAS_LDSTEX
> > +ENTRY(csky_cmpxchg)
> > +	USPTOKSP
> > +	mfcr	a3, epc
> > +	INCTRAP	a3
> > +
> > +	subi    sp, 8
> > +	stw     a3, (sp, 0)
> > +	mfcr    a3, epsr
> > +	stw     a3, (sp, 4)
> > +
> > +	psrset	ee
> > +1:
> > +	ldex	a3, (a2)
> > +	cmpne	a0, a3
> > +	bt16	2f
> > +	mov	a3, a1
> > +	stex	a3, (a2)
> > +	bez	a3, 1b
> > +2:
> > +	sync.is
> > +	mvc	a0
> > +	ldw	a3, (sp, 0)
> > +	mtcr	a3, epc
> > +	ldw     a3, (sp, 4)
> > +	mtcr	a3, epsr
> > +	addi	sp, 8
> > +	KSPTOUSP
> > +	rte
> > +END(csky_cmpxchg)
> > +#else
> 
> Please explain... if the CPU has LDEX/STEX, then _why_ do you need this?
Our libc use csky_cmpxchg and we want it compatible. Of course, we'll
also implement the ldex/stex atomic operations in libs in future.

 Guo Ren

