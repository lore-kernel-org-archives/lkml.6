Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63645C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ECD216FA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ug98x9Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ECD216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeH0CAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:00:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbeH0CAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U1xK8R2nt5oLYf6ZDOXGtnO7yEEcsyGQ7xnTDDSx+tI=; b=Ug98x9ZkRhZg5xujjnsbiQnT8
        SV5o5I+FN1NGyRL5Lk+22gyMFgImFcyAVdSjxIpSAb8bCIGN2JEMjV4Xo/iylLwNR8kdd9vFseyfr
        uo8K5Fpe/byxvyth8KQ5G6XCeYJfLIoNehrrPLGcdreeUl2rX2r3kgCjZkj6mP5d6+wEVgZfZMDdP
        CdHkgf5G8AMLuzpWVcjquOdLdhvCnOy2jw6kETnARJ6knbE0Jbo183GzYc4h/8dMSdOZteDUHg6c5
        n1FnT4HpUBU4J1CfcKT5pM0UoJxBvlcrhs+4jAqOB/AwYgDAg5KkQohqkID3O7+Q4gP/u2ftW5srU
        A7dM3x4rA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fu3Jt-0001KP-Pg; Sun, 26 Aug 2018 22:15:41 +0000
Date:   Sun, 26 Aug 2018 15:15:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
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
Subject: Re: TLB flushes on fixmap changes
Message-ID: <20180826221541.GB30765@bombadil.infradead.org>
References: <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com>
 <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org>
 <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
 <CAGXu5j+xUbq_mu=2jvH2Vu+mviteZJqdPNTrxpaijwsuDdN-sw@mail.gmail.com>
 <952A64F0-90B3-4E2F-B410-7E20BE90D617@amacapital.net>
 <CAGXu5jKk+ELGsSXC8e3v67oo74BF9rP2HDqMHx1Sb17-0F-xZQ@mail.gmail.com>
 <DF353FDA-4A57-4F5E-A403-531DDA0DBC25@amacapital.net>
 <alpine.DEB.2.21.1808262212030.1195@nanos.tec.linutronix.de>
 <CAGXu5jJQGiGwQRBGuVrmhQqyUEfRUUSD6WYokc2xezExY9ZNUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJQGiGwQRBGuVrmhQqyUEfRUUSD6WYokc2xezExY9ZNUg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 03:03:59PM -0700, Kees Cook wrote:
> I thought the point was that the implementation I suggested was
> NMI-proof? (And in reading Documentation/preempt-locking.txt it sounds
> like disabling interrupts is redundant to preempt_disable()? But I
> don't understand how; it looks like the preempt stuff is advisory?)

Oter way round; disabling interrupts implicitly disables preemption
