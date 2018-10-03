Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BEBC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEE1213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bshuiK0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEE1213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJCPQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:16:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeJCPQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Arb13BCu4zbBM0jaVVYdVsl7FbIlqiVlm3Jtq4sWiCM=; b=bshuiK0ysySobW380CeCMr1ER
        +6T7ppljlnbjb99adAGqJFGhZMcP5PTqoM9v/YlMGM9CPutUGLS0cOt3yiPkB7kPf6Ihj7O6Fmbiy
        RR05WF4Bo9XMRuVF235I/5qdvpFz/jxmIhQ7ALRXVDrY/Pi0rtk5edkXkZxnJPIDmYbLqbH58Hq9y
        qdT3coMCEQp64yvdUKJElEwvCx7FN8CBXShDD1ymAlVZiven+BgltUxhwMq3gipLqC+cr1Tk95Hru
        na8k1XGX3EAqoJlLYX/P5eyMrxneEwkN82ZUjX6tljuHzuKx/eMUyFMM3jkphpZBknbhNjzEbfvjG
        j5OsIfPHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7cWS-0003br-6u; Wed, 03 Oct 2018 08:28:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EB54202C1A1E; Wed,  3 Oct 2018 10:28:42 +0200 (CEST)
Date:   Wed, 3 Oct 2018 10:28:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, bigeasy@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        daniel.wagner@siemens.com, Will Deacon <will.deacon@arm.com>,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, boqun.feng@gmail.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [Problem] Cache line starvation
Message-ID: <20181003082842.GN26858@hirez.programming.kicks-ass.net>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
 <20180921122058.GB24124@hirez.programming.kicks-ass.net>
 <CAHkRjk4Vvv5rc+habecu2xPiFGZ37onRzy1kCnFcBH2115U8jQ@mail.gmail.com>
 <alpine.DEB.2.21.1810031005210.1435@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810031005210.1435@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 10:07:05AM +0200, Thomas Gleixner wrote:
> On Wed, 3 Oct 2018, Catalin Marinas wrote:
> 
> > On Fri, 21 Sep 2018 at 13:22, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
> > > > We reproducibly observe cache line starvation on a Core2Duo E6850 (2
> > > > cores), a i5-6400 SKL (4 cores) and on a NXP LS2044A ARM Cortex-A72 (4
> > > > cores).

> Except that the ARM64 ticket locks are not preventing the starvation
> issue. Neither do the qrlocks on ARM64 on later kernels.

That A72 is ARMv8-A afaict, that doesn't have the fancy LSE bits (which
are new in ARMv8.1) on and thus ends up using LL/SC. And LL/SC has
similar issues as cmpxchg loops.

AFAICT Cortex-A75 is the first that has LSE on (that's an ARMv8.2-A).
