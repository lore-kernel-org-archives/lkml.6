Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E97ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76373214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tMO7pAn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76373214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeIRTLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:11:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbeIRTLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VMfiXEWTYF3RsxNG4UrwIUiJgIWVdrHK2LA3xVZtbAg=; b=tMO7pAn5V5s4l2HVPw5gz97i8
        KSHEQ97CcvyBtRz+uXmP3GdQrzWwOv6P9RKL41Pdxd4LvWWMdQRgSbsMI9NCvM298G74wnEof2I3M
        jyjqIlrw/vWV6a0b19OqUfSRAL99Bo8Y8a73AS34vdSA3Dkc8YJCUPKr0cRPTu7DL4BhjnbW2Zod8
        RHHI2yBvDV5d8hEyAbnXHehxFTxEfjFb997npKLcLEJvT4NIzh01hYl0vNmMVRlG9Vbq3vvIOxvQ+
        H8nyohYY5kY2gryN8rmiJN1pnrNoir3q5sQ+NSjRCNU1WuDDN9kGFag8TcfzIDMIkQgeAJMkcXVYQ
        6UUoRKvNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2GDO-000171-5x; Tue, 18 Sep 2018 13:38:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15A75202C1A38; Tue, 18 Sep 2018 15:38:52 +0200 (CEST)
Date:   Tue, 18 Sep 2018 15:38:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Message-ID: <20180918133852.GO24106@hirez.programming.kicks-ass.net>
References: <20180914125118.909646643@linutronix.de>
 <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
 <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
 <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
 <20180918083055.GJ24106@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809181050020.4167@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809181204460.4167@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809181237140.4167@nanos.tec.linutronix.de>
 <20180918124800.GL24106@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809181515170.6950@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809181515170.6950@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 03:23:08PM +0200, Thomas Gleixner wrote:
> On Tue, 18 Sep 2018, Peter Zijlstra wrote:
> > On Tue, Sep 18, 2018 at 12:41:57PM +0200, Thomas Gleixner wrote:
> > > I still have one of the machines which is affected by this.
> > 
> > Are we sure this isn't a load vs rdtsc reorder? Because if I look at the
> > current code:
> 
> The load order of last vs. rdtsc does not matter at all.
> 
> CPU0					CPU1
> 
> ....
> now0 = rdtsc_ordered();
> ...
> tk->cycle_last = now0;
> 
> gtod->seq++;
> gtod->cycle_last = tk->cycle_last;
> ...
> gtod->seq++;
> 					seq_begin(gtod->seq);
> 					now1 = rdtsc_ordered();
> 
> So if the TSC on CPU1 is slightly behind the TSC on CPU0 then now1 can be
> smaller than cycle_last. The TSC sync stuff does not catch the small delta
> for unknown raisins. I'll go and find that machine and test that again.

Yeah, somehow I forgot about rseq.. maybe I should go sleep or
something.
