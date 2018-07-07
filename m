Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9552C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E6C213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E6C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeGGIJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:09:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38648 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751693AbeGGII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:08:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09957097|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03298;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.CNO7aKH_1530950927;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CNO7aKH_1530950927)
          by smtp.aliyun-inc.com(10.147.43.230);
          Sat, 07 Jul 2018 16:08:47 +0800
Date:   Sat, 7 Jul 2018 16:08:47 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180707080845.GA346@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
 <20180706121716.GO2512@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706121716.GO2512@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:17:16PM +0200, Peter Zijlstra wrote:
> > 
> > 	CPU0			CPU1
> > 
> > 	r1 = READ_ONCE(x);	WRITE_ONCE(y, 1);
> > 	r2 = xchg(&y, 2);	smp_store_release(&x, 1);
> > 
> > must not allow: r1==1 && r2==0
> 
> Also, since you said "SYNC.IS" is a pipeline flush, those
> instruction-sync primitives normally do not imply a store-buffer flush,
> does yours? If not it is not a valid smp_mb() implementation.
Sync.is will flush pipeline and store-buffer.

"sync"	means completion memory barrier.
"i"	means flush cpu pipeline.
"s"	means sharable to other cpus.

> 
> Notably:
> 
> 	CPU0				CPU1
> 
> 	WRITE_ONCE(x, 1);		WRITE_ONCE(y, 1);
> 	smp_mb();			smp_mb();
> 	r0 = READ_ONCE(y);		r1 = READ_ONCE(x);
> 
> must not allow: r0==0 && r1==0
> 
> Which would be possible with a regular instruction-sync barrier, but
> must absolutely not be true with a full memory barrier.
> 
> (and you can replace the smp_mb(); r = READ_ONCE(); with r = xchg() to
> again see why you need that first smp_mb()).

	CPU0			CPU1

	WRITE_ONCE(x, 1)	WRITE_ONCE(y, 1)
	r0 = xchg(&y, 2)	r1 = xchg(&x, 2)

must not allow: r0==0 && r1==0
So we must add a smp_mb between WRITE_ONCE() and xchg(), right?

 Guo Ren

