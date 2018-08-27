Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A641021746
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s35vu3DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A641021746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeH0MGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:06:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeH0MGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=08NhBsgssFggdaqXAqAU6I7UbTl+bbSlkb8y+DaTiKs=; b=s35vu3DGy7/U6OMwVZSY0VMqQ
        UJbL/XoJGDU/QdpFHb3RJ80UNnPyjQFSIjQ6KNKMa5Q9X9B/Bn5PX1GFmEaNmwBDKzRSlDtkhkVSW
        HVj3aNYFN/ovG1cpzYKef5JDMDz46tLbu5k6fSHdkdI7JUkGJTs10MwDTwHF8Cl4hf8Y4zz8m/iUS
        qzgt5NdsPBIOKvelPzo5biVEkkCuzbUHYIoXtHl6TyeIE6Ehj2IiYol28GlojT+Rt2famyByaReHm
        3Z6qs+foYH/7XZK0wE8jhYg3d6M6ssRCbTYudhhpzZfZnVJRGFf9GXZ2CnSxZ9WM4XeCSeg528sle
        BCjIM3cwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuClS-0007R1-Ok; Mon, 27 Aug 2018 08:20:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 287E12029B105; Mon, 27 Aug 2018 10:20:45 +0200 (CEST)
Date:   Mon, 27 Aug 2018 10:20:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180827082045.GA24124@hirez.programming.kicks-ass.net>
References: <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <20180824113214.GK24142@hirez.programming.kicks-ass.net>
 <20180824113953.GL24142@hirez.programming.kicks-ass.net>
 <20180827150008.13bce08f@roar.ozlabs.ibm.com>
 <20180827074701.GW24124@hirez.programming.kicks-ass.net>
 <20180827180458.4af9b2ac@roar.ozlabs.ibm.com>
 <4ef8a2aa44db971340b0bcc4f73d639455dd4282.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef8a2aa44db971340b0bcc4f73d639455dd4282.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 06:09:50PM +1000, Benjamin Herrenschmidt wrote:

> Sadly our architecture requires a precise match between the page size
> specified in the tlbie instruction and the entry in the TLB or it won't
> be flushed.

Argh.. OK I see. That is rather unfortunate and does seem to require
something along the lines of tlb_remove_check_page_size_change().
