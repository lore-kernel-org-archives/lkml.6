Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CACC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFADA24001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JVlqyxbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFADA24001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeGFMRr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:17:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43948 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeGFMRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XRJlrDqObBe2aPw6BTdVXU724T4m8PKuo0iFGPdRo1c=; b=JVlqyxbfHouwOgTC0/q9wndfn
        UQLBt9Lyey3VY33fDFQQbVGrirVBmdl8VTg/jbqA5dj0utBz2NACojSc37ZdiKPUg1IqsgdKkQ71o
        MxBhFN1fGysTxqdwL4XlK39yyFl/4krms6uPqsLS/bxKUpNtwhL2u9fa1HydX8FvsX7DZR77Pr1WA
        K93JHtz+KrOaRePoAw23uL8SjeMEBE466Dr5xQh/K794OqNaj3xylZwHknUctGtJxTzpC3i9hawSQ
        flBL0KAHz8/OtxJPlZ/EhxBEF3PFYc1+Z5djtqa/l5z41nAfafjF0/ptYq3pTlMT8TAdwXBI40sX/
        +kiF3pDSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbPfq-0000ns-D8; Fri, 06 Jul 2018 12:17:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C464920291063; Fri,  6 Jul 2018 14:17:16 +0200 (CEST)
Date:   Fri, 6 Jul 2018 14:17:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706121716.GO2512@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706115614.GV2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 01:56:14PM +0200, Peter Zijlstra wrote:

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

Also, since you said "SYNC.IS" is a pipeline flush, those
instruction-sync primitives normally do not imply a store-buffer flush,
does yours? If not it is not a valid smp_mb() implementation.

Notably:

	CPU0				CPU1

	WRITE_ONCE(x, 1);		WRITE_ONCE(y, 1);
	smp_mb();			smp_mb();
	r0 = READ_ONCE(y);		r1 = READ_ONCE(x);

must not allow: r0==0 && r1==0

Which would be possible with a regular instruction-sync barrier, but
must absolutely not be true with a full memory barrier.

(and you can replace the smp_mb(); r = READ_ONCE(); with r = xchg() to
again see why you need that first smp_mb()).
