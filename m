Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E47C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7FC2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ChhAEsB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7FC2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeH3Npn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:45:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeH3Npn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0qYfyTotDh3T+tCc1aE9mSqKSDE/DOCfRx8e60MhO/k=; b=ChhAEsB0IcEZ7ThlRXtmVPyaL
        d1UXYPDqIgazGmQ6DWwjKuCLvIKxetEI/8MUQ5jKnPCvqOuzhtOlPaEvEFubqwFtSdzaZOg7Rio1I
        Dh/XCoE0w/HcgIaf6aHaJHh5b3zUuLWT+MNniGS5cUkMvnPtys738Uv0tqiQc2T+bhcooXuiiS3/t
        rMn40UxU6lPC4cLlI0aJDdjrnDYTR4UxGuuDjdSgLgdf6baf2XrX71hoMWPiK8EAmR2l/WWe+wBwa
        E1D7w7ykGeE13cIdAi5NDwgWAuOodFKcZ2f7iWvQPKqkRMCVGxNX5fmEbO/LEDsl9kIJtmr3YMyYd
        sSB2EDg6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvJUs-0007s3-Do; Thu, 30 Aug 2018 09:44:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 035FD2024EB1E; Thu, 30 Aug 2018 11:44:11 +0200 (CEST)
Date:   Thu, 30 Aug 2018 11:44:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <20180830094411.GX24124@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 09:16:43PM +0000, Vineet Gupta wrote:
> On 08/29/2018 11:33 AM, Eugeniy Paltsev wrote:
> > Hi Guys,
> > Since v4.19-rc1 we are getting a serious regression on platforms with ARC architecture.
> > The kernel have become unstable and spontaneously crashes on LTP tests execution / IO tests or
> > even on boot.
> >
> > I don't know exactly what breaks but bisect clearly assign the blame to this commit:
> > 84c6591103db ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")
> > https://github.com/torvalds/linux/commit/84c6591103dbeaf393a092a3fc7b09510825f6b9
> >
> > Reverting the commit solves this problem.
> >
> > I tested v4.19-rc1 on ARM (wandboard, i.mx6, 32bit, quard core, ARMv7) which uses same
> > generic bitops implementation and it works fine.
> >
> > Do you have any ideas what went wrong?
> 
> Back in 2016, Peter had fixed this file due to a problem I reported on ARC. See
> commit f75d48644c56a ("bitops: Do not default to __clear_bit() for
> __clear_bit_unlock()")
> That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic
> __clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unlock() same.
> 
> This patch undoes that which could explain the issues you see. @Peter, @Will ?

Right, so the thinking is that on platforms that suffer that issue,
atomic_set*() should DTRT. And if you look at your spinlock based atomic
implementation, you'll note that atomic_set() does indeed do the right
thing.

arch/arc/include/asm/atomic.h:108




