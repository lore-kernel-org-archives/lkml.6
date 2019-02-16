Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47A7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754DC222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="phZcaNBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfBPKcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 05:32:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfBPKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 05:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3EcQWiX/CRLDgctPl+JlYpV6742xtIDMvMxTk2IX8YU=; b=phZcaNBP+lNGP120uZQzYpq3t
        QlsGJOtUGAMpvpbCbGBLvTWZoXwuWL9Cs7lqF1H8+SvX5vs9aPjN7u7KgxCl/TjsIYLsbEGgd2Usn
        ciWi31zzjpjCyYNqmxTkqT8o/xNswqFQxrfaT+uzKt4vLdA3VNo/FA713SJpfp3sV1hjMv4iMbyUH
        v7TCr/xc0+kGYNZT9vSRC7fGJ/hBkeVDZM8WYa9oz+ii3oEgtrv65Ed3Gfy97dU7kqu1VkOIFT86G
        LT7zuKqel3s9uxsu3L1kLg4VqmcZBjZlef8qMspV812Jdi/f4S/XhZnTVT4h4Q/IcbC4zdZESbLSY
        EtxB2Dqnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guxH5-0004Gk-RH; Sat, 16 Feb 2019 10:32:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28F3C201A4021; Sat, 16 Feb 2019 11:32:46 +0100 (CET)
Date:   Sat, 16 Feb 2019 11:32:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, valentin.schneider@arm.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190216103246.GS32494@hirez.programming.kicks-ass.net>
References: <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
 <20190214193432.GR32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
 <20190215174034.GP32494@hirez.programming.kicks-ass.net>
 <20190215233414.GS32534@hirez.programming.kicks-ass.net>
 <CAHk-=wh5sTSF0X7qp80Ls5QZ2AgAm3yk3Ow9qOuNKB6O_zGVKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5sTSF0X7qp80Ls5QZ2AgAm3yk3Ow9qOuNKB6O_zGVKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 04:21:46PM -0800, Linus Torvalds wrote:
> Even just a comment about it would be fine. But it might also be good
> to show that it's an explicit eflags value and just use
> X86_EFLAGS_FIXED as the initializer.

That is in fact what I have now; I'll repost on Monday or so.
