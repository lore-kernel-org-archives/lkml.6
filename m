Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E3AC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBD727163
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qJeCeDP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBD727163
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935101AbeF1J2a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:28:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933194AbeF1J23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hYYDbc+R/nlM7I17YKyvqtFKsVgFSEudSqAqJlnY2uU=; b=qJeCeDP5a+y7p4GEUxiAXIW1Y
        z6Dda/XYV+Hp4qp5rEGshI9MPzZ2eFigfx0OBM22dFIYBH3o6GKzF/075nHPYNG3eIrLuVVJCCnJ9
        zs0vsNlSIf0j42etYL2dZM4OsreKJ3I4MjS1jb9tv0EvBRpyGMogSR+q4WUqm2oGCfjGmxghLWq2T
        f0Up4y/eaLHnkNqGDF7h6rQQkBPkOGCDsVcbqvUG9d+C6Gxx6+bDCRtkREE86G6mcZlVThdPPr6gh
        NayuQ+12xvy2f//xP26QG+cEmiKjOT79+GnUsh7cWd8N0Us4744UzYPNw4wojOM9Bj7RPYHgTWv1l
        UNSg9RONA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYTDt-0007Jw-FY; Thu, 28 Jun 2018 09:28:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBEE52029764D; Thu, 28 Jun 2018 11:28:15 +0200 (CEST)
Date:   Thu, 28 Jun 2018 11:28:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>, namit@vmware.com
Subject: Re: [PATCH 5/5] x86/kernel: jump_table: use relative references
Message-ID: <20180628092815.GD2494@hirez.programming.kicks-ass.net>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-6-ard.biesheuvel@linaro.org>
 <20180628083107.GY2494@hirez.programming.kicks-ass.net>
 <CAKv+Gu9oxJCvpxRKpkndci1RGuewBsAPQW9W1=uXU1boGTSRrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9oxJCvpxRKpkndci1RGuewBsAPQW9W1=uXU1boGTSRrQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:34:54AM +0200, Ard Biesheuvel wrote:
> On 28 June 2018 at 10:31, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Jun 27, 2018 at 06:06:04PM +0200, Ard Biesheuvel wrote:
> >> Similar to the arm64 case, 64-bit x86 can benefit from using 32-bit
> >> relative references rather than 64-bit absolute ones when emitting
> >> struct jump_entry instances. Not only does this reduce the memory
> >> footprint of the entries themselves by 50%, it also removes the need
> >> for carrying relocation metadata on relocatable builds (i.e., for KASLR)
> >> which saves a fair chunk of .init space as well (although the savings
> >> are not as dramatic as on arm64)
> >
> > This will conflict with:
> >
> >   https://lkml.kernel.org/r/20180622172212.199633-10-namit@vmware.com
> 
> Thanks for the head's up. Fortunately, it does not conflict
> fundamentally, so it should be a straight-forward rebase after that
> code is merged.

Yeah, shouldn't be hard to cure.

There's another patch set that might have a little conflict, but that's
not near ready I think, so that'll have to just cope with things
shifting underneath (and there too, the fixup shouldn't be hard).

> Do you think this is likely to get merged for v4.19?

I'm thinking it is near ready so it might, but I'm not in charge of
those bits :-)
