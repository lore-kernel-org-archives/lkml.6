Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C97C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B5A20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hVY7YNen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B5A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH3VSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:18:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeH3VSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ibAuDr8ktP8kc2VavoK2sMX9glq0IfQtKZyoqsVAfGU=; b=hVY7YNenpj9YIoAl+jQarf0BF
        gfsl4Kh2FmDudNsRZ0pXAdA7D2PbluQ5/n0/Jg//5PeISvwzBBGMCcu2CPD01Yoxj8LiRiBESYHK7
        7J7P86530k2gz4zAq3lNsK0ZHiK5eM+EkZAESdFe07+xbBQlFGrHvF97hHFhA/AlO4axLF1jFYipw
        f698IvlIIWLPglyrSxbROMC1gXViIx9n7X/AJks/q4QVbfyYQqDJQXr64kXUaZPylRqknt7n/tJLm
        VkyLUNXsiysL4fTxnolApzf7Gk2zy5kAqSHxpaQPVHVQmRLPA/xg9ufFK1KcFTP9M0VSU1uzKnO7C
        pOs/+XyRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvQXJ-0002FA-1T; Thu, 30 Aug 2018 17:15:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A1B92024D73F; Thu, 30 Aug 2018 19:15:10 +0200 (CEST)
Date:   Thu, 30 Aug 2018 19:15:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <20180830171510.GQ24082@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <1535640375.4465.68.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535640375.4465.68.camel@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 02:46:16PM +0000, Eugeniy Paltsev wrote:
> On Thu, 2018-08-30 at 16:17 +0200, Peter Zijlstra wrote:
> > On Thu, Aug 30, 2018 at 11:53:17AM +0000, Eugeniy Paltsev wrote:
> > > I can see crashes with LLSC enabled in both SMP running on 4 cores
> > > and SMP running on 1 core.
> > 
> > So you're running on LL/SC enabled hardware; that would make Will's
> > patch irrelevant (although still a good idea for the hardware that does
> > care about that spinlocked atomic crud).
> > 
> > Does something like the below cure things? That would confirm the
> > suggestion that the change to __clear_bit_unlock() is the curprit.
> 
> I tested it - this doesn't change anything, the problem still reproduces.

OK, 'good' :-)

> I'll test it with last Will fix.

Yes, that missing "bnz 1b" is very very suspect.
