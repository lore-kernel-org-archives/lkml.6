Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8312CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475F02145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EOZUqv+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475F02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeKUU1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:27:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUU1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bq5T1IB5o8dPizGl0BWe401hM4aviIDqLChSRIhJGJw=; b=EOZUqv+SP2m2Le0B/9nCEqHmV
        TcohAvYp0N8ZVqyLSWNHdUR74YLwvuoJc7kB3DkMAE+3qUEnz0e4BRFJltWy3woxwaje2fDsEzDX8
        ZttwX4Xt3e43mN1wabyTVPB8LzGx0fgiq2OxRiPex7DnzbpLdNSwtomHyFqJldyJdJddfjbPP6t0b
        +5DTeYPwbaWwIdUOLDvz0i2GvoYBb34sUfmUJeNUnqfyeYK34eW1WfjjjkCGqmR7rxKcbKByPBR9k
        ntnFBSRifGQxCqBFXjGW0ejs6W1g+rIOyfODGwI5ossA1bmXFuNCBmBeklRhmeX4yrPPdhTt0Kn31
        vGPP6M8uA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPPCj-0003x7-Dx; Wed, 21 Nov 2018 09:53:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C66012029F87F; Wed, 21 Nov 2018 10:53:50 +0100 (CET)
Date:   Wed, 21 Nov 2018 10:53:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] proc: add /proc/<pid>/arch_state
Message-ID: <20181121095350.GC2149@hirez.programming.kicks-ass.net>
References: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
 <1542236407-4323-2-git-send-email-aubrey.li@intel.com>
 <20181119173904.GC2131@hirez.programming.kicks-ass.net>
 <c62acf67-2529-15b1-5325-e0265b0f613d@linux.intel.com>
 <20181121081936.GH2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121081936.GH2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:19:36AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 21, 2018 at 09:39:00AM +0800, Li, Aubrey wrote:
> > > Also; you were going to shop around with the other architectures to see
> > > what they want/need for this interface. I see nothing on that.
> > > 
> > I'm open for your suggestion, :)
> 
> Well, we have linux-arch and the various maintainers are also listed in
> MAINTAINERS. Go forth and ask..

Ok, so I googled a wee bit (you could have too).

There's not that many architectures that build big hot chips
(powerpc,x86,arm64,s390) (mips, sparc64 and ia64 are pretty dead I
think, although the Fujitsu Sparc M10 X+/X SIMD looked like it could be
'fun').

Of those, powerpc altivec doesn't seem to be very wide, but you'd have
to ask the power folks. Same for s390 z13.

The Fujitsu/ARM64-SVE stuff looks like it can be big and hot.

And RISC-V has was vector extention, but I don't think anybody is
actually building big hot versions of that just yet.
