Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98949C4151A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6020B21920
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3mJF1Fut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfBGOBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:01:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42238 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfBGOBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AewIT6yEpMwwuUCQuV/zuqKv5UYFpbkS2e0N8nJZ44s=; b=3mJF1FutYd9OY/Ml674OVBDOq
        E6FItD0VTbHjEqBsNg9qDvAcRpR0Rray5Mjzdt77eevfqCOrbjGu2R26Y54p1DlMWHGEK/SBCP5Er
        EWoB4wNO20WSw9ZrdOUbGZqUgNb90SqwsaEjsSvXG3I2xTVSkvB2Xh43ZzRfskZc4a/K2F8ZUgCl0
        4MBRLnw86cdxahKO9E7CI22CAHfADNMjYQoR7rlw2YBBheOpwq3g/esmfuEEktkn7X7EYj2FcAycO
        CDP/GXZyoRC3TtVTXg8Zhl0Ip2r6XteQg3ucVoyQRkqZC58Txys1XUGWnj8LxN/WGbbM42IlziYEv
        2/NAxhZGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grkFA-00050O-W6; Thu, 07 Feb 2019 14:01:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF944201A1B24; Thu,  7 Feb 2019 15:01:31 +0100 (CET)
Date:   Thu, 7 Feb 2019 15:01:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [GIT PULL] x86/mm changes for v4.21
Message-ID: <20190207140131.GB32477@hirez.programming.kicks-ass.net>
References: <20181224231106.GA27438@gmail.com>
 <20190207001737.GA32096@agluck-desk>
 <20190207101846.GB32511@hirez.programming.kicks-ass.net>
 <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 11:50:52AM +0000, Linus Torvalds wrote:
> If you re-generate the canonical address in __cpa_addr(), now we'll
> actually have the real virtual address around for a lot of code-paths
> (pte lookup etc), which was what people wanted to avoid in the first
> place.

Note that it's an 'unsigned long' address, not an actual pointer, and
(afaict) non of the code paths use it as a pointer. This _should_ avoid
the CPU from following said pointer and doing a deref on it.

But yes, I didn't go all the way down, maybe I missed some.
