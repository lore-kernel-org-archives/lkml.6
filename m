Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3E4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C3A20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3luxs/c9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfB0Ra6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:30:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36994 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfB0Ra5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6+ogArHtVGPuIbgTIJjF3G9WgFr8MFiqT754au0NmR4=; b=3luxs/c9wdQ5vU3yHCdTTu4tg
        1eBLvR6O9vCm3kzDCmrKyFFOYtzuBo3FUitTxC3TJnY70vUbXwmwy5MAYcmpIUoN7M/n/X/pklLOp
        HChHBp/UjQu/Ry2NtCVmnVEVN5HGGmvZLZlcIn6ERKCy8/oBol2KyZfncnqqoZXO+2fHx9fDxiEHv
        UI2GqIO5FgbEZCzFEQ+mbVeuBm8lvhvGas26AhZJRXMDPHoUGaqGZTeAK0eQZhoxn3w9h3I1Y+JHR
        RBY7ddUmEkrXFlWxg7DyV0P+E3RdKpKZrDRZKPgRDvuE0D3dPPGTw/AcbGgfpalEysZsKPszS4VYF
        NW7hOklNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gz32d-0005xS-J6; Wed, 27 Feb 2019 17:30:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C8B128523BB2; Wed, 27 Feb 2019 18:30:46 +0100 (CET)
Date:   Wed, 27 Feb 2019 18:30:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
Message-ID: <20190227173046.GU32494@hirez.programming.kicks-ass.net>
References: <20190225124330.613028745@infradead.org>
 <20190225125232.191698923@infradead.org>
 <20190227140830.GP32494@hirez.programming.kicks-ass.net>
 <CAHk-=wg6P=hDhq+kPs0TCCvN7_q3usW5WNWzfdCBcLX_syoVxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg6P=hDhq+kPs0TCCvN7_q3usW5WNWzfdCBcLX_syoVxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:18:21AM -0800, Linus Torvalds wrote:

> So the whole "run with AC on" thing isn't a big deal, apart from the
> scheduling case.
> 
> And we know how to fix the scheduling case by just doing the
> save/restore thing..

Right, but I was hoping to avoid having to do that; and I think we can
do that if we push all of kasan_report into an exception, like that
'patch' I just posted.

If I'm not mistaken the regular kasan house-keeping crud just prods at
the shadow memory with simple code and should be perfectly safe.
