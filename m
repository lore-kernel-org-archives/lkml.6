Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3050C2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rYZfyXYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3050C2157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeHXMQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:16:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38098 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeHXMQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TbhKW5bVlTF/yJ3eGP0p1VX8OoN4gWr5H+K8J3b5di0=; b=rYZfyXYJrAeVbcYg7GsuD0Ld5
        hISCp+D1BzYFz8oMjufOaZajJ90xgaSJLqNGv+MyTOzI35wQ4KkiCqwE7ki5n5jUddXRm/WkAI2jW
        tadqgCK4XOUlsgRRk0qnVylxMBvPbk4ENugj440adg7mkF1xBn7KuQEh92DRj+qoRgX2xw/y8bypl
        D90eaSaVgN5u31DTQZsIqw2aWAUidxexfm+k7RKvCVShIV8Hbq/jhrAS1Hoe9PH1xTLg+FUsxuKnf
        CzLJCJu3PNBbdTRDYs7FUCABaEIAjVTUHGwmkul3EPHnYlK2C6c2lt2al5Ttw/5WdP4aTP9fAO2NC
        Se88OnU/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ft7gK-0007Ih-F1; Fri, 24 Aug 2018 08:43:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43847202E65E0; Fri, 24 Aug 2018 10:42:59 +0200 (CEST)
Date:   Fri, 24 Aug 2018 10:42:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Piggin <npiggin@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/4] mm/tlb: Remove tlb_remove_table() non-concurrent
 condition
Message-ID: <20180824084259.GJ24124@hirez.programming.kicks-ass.net>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.772017055@infradead.org>
 <20180823133103.30d6a16b@roar.ozlabs.ibm.com>
 <CA+55aFyY4fG8Hhds4ykSm5vUMdxbLdB7mYmC2pOPk8UKBXtpjA@mail.gmail.com>
 <20180823141642.38b53175@roar.ozlabs.ibm.com>
 <CA+55aFzfnWv3JoB0mR7iCX322KsiE+uRq3HcmOpciEAiTw-oLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzfnWv3JoB0mR7iCX322KsiE+uRq3HcmOpciEAiTw-oLw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 09:54:48PM -0700, Linus Torvalds wrote:

> It honored it for the *normal* case, which is why it took so long to
> notice that the TLB shootdown had been broken on x86 when it moved to
> the "generic" code. The *normal* case does this all right, and batches
> things up, and then when the batch fills up it does a
> tlb_table_flush() which does the TLB flush and schedules the actual
> freeing.
> 
> But there were two cases that *didn't* do that. The special "I'm the
> only thread" fast case, and the "oops I ran out of memory, so now I'll
> fake it, and just synchronize with page twalkers manually, and then do
> that special direct remove without flushing the tlb".

The actual RCU batching case was also busted; there was no guarantee
that by the time we run the RCU callbacks the invalidate would've
happened. Exceedingly unlikely, but no guarantee.

So really, all 3 cases in tlb_remove_table() were busted in this
respect.
