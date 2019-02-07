Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4467DC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AC020823
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g106yszJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfBGJvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:51:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfBGJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7QUMRd8sHfwEbmpKYSOP457ObAXIC60C2pWHkWhJjFE=; b=g106yszJCTkh/ZjCW2lNBoW+j
        wcQzDb+lS0LeHqYCoHsYGwKQCFuet+oEhulz+ChVAePufcaRtw1yVmxPjkN7yyQKmIBze+/3X23/F
        thZIqOsvG9fx0wtGt20BqBFc6nyrSTkSNLZzsCAVxrMEJoV/DYiXEheQIrdZ7ukIMcgVEXdePHtDX
        N3dOJI0Rc/FBeIVvFPGdHrDDIwiIVQYMPSJLzIIo+cJ0EAIxsj5phCrUGC2C7QXmsppJpoe9jcKQC
        1xqE+nD5D90MzgWu9Uok8oZAXorcsrGgC8JB4SKZ5g/gGsWMDitdUg9C/kkcWyLP1qa/hV4lqq6Vc
        e2FnyTDEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grgKg-0007HQ-Rm; Thu, 07 Feb 2019 09:50:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 113B7201A1B22; Thu,  7 Feb 2019 10:50:56 +0100 (CET)
Date:   Thu, 7 Feb 2019 10:50:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [GIT PULL] x86/mm changes for v4.21
Message-ID: <20190207095056.GA32511@hirez.programming.kicks-ass.net>
References: <20181224231106.GA27438@gmail.com>
 <20190207001737.GA32096@agluck-desk>
 <8b0b85cb-c08e-3426-fe34-0b6dfc9c0cc4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b0b85cb-c08e-3426-fe34-0b6dfc9c0cc4@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:33:54PM -0800, Dave Hansen wrote:

> I wonder if the patches that you bisected to just changed the flushing
> from being CR3-based (and not taking an address) to being INVPCID-based,
> and taking an address that is sensitive to canonicality.

That is indeed one of the things that patch series does; before this it
would always flush world for ARRAY interfaces.

I'll have a look at the code; I seem to remember there being test for
canonical addresses, maybe they're not in the right place.
