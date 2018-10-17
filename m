Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED78ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6DC21528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dk+LmyWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6DC21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJRATf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:19:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54766 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeJRATf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tRiMvX9h1hxuLnPQzyDFXL/24OFKNWflxpFPK0mMNU0=; b=Dk+LmyWmK7pPw1IikspwxK0Eb
        s5y0+IyrHy/8vJwqHsHJPkSK1nbt9F1ppCh7LwyeA0U37IYlov+1JXz5c8yfST0ALnnVcMX26fkN9
        jZagMhgqaqd+ZL/NcX7L41z2U2qeq3CLvyxCZ/oVbzJA98t8BplD+igpQpSHC2nl1j/YWYMDM1bYs
        L66wLuovY8xBu0jtAp5o2R9spZyZy6a9Qvy4o98C0yNVPIdZoPUd8MTJ47b+5XV0Q2D/PcmBtw8XY
        WDmgBRKPIqzB0ZJbT6flla5eSy9kTHyKi20Nko3MDr3kv/Eu2mNoVdBsJrK/+LKCTnwpNTZMMoJrx
        KDCfLwzFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCob1-0002pn-NX; Wed, 17 Oct 2018 16:22:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E215620298568; Wed, 17 Oct 2018 18:22:53 +0200 (CEST)
Date:   Wed, 17 Oct 2018 18:22:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Message-ID: <20181017162253.GO3121@hirez.programming.kicks-ass.net>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
 <20181016202525.29437-2-bigeasy@linutronix.de>
 <acaca255a70b411488b889db9d1c31e4@AcuMS.aculab.com>
 <20181017111145.GJ3121@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1810171315250.6000@nanos.tec.linutronix.de>
 <20181017154707.GL3121@hirez.programming.kicks-ass.net>
 <20181017160050.rw6tl2dzqiozbq3m@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017160050.rw6tl2dzqiozbq3m@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 06:00:51PM +0200, 'Sebastian Andrzej Siewior' wrote:
> On 2018-10-17 17:47:07 [+0200], Peter Zijlstra wrote:
> > > > Ideally we'd never ever merge anything that only does local invalidates,
> > > > on a global address space, that's just broken.
> > > 
> > > A little bit late to lament about that.
> > 
> > For this, yes :/ But for future stuff we should really not allow such
> > things anymore.
> 
> so we stay as is?

Well, we can do that preempt kludge you propose to shut up the warning I
suppose.

But a kludge it is. That code really wants a global invalidate, but we
cannot (not without massive surgery in any case).
