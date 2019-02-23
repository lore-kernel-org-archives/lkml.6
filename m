Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5258C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83C9206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="osAqe5/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfBWIju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:39:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfBWIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xtvmSIA5GbdSg1LeBhZQEUzLKD0LVlVHfuS0/yyCVQc=; b=osAqe5/FaW4bURfQr3hPT8Jpe
        FdVmSZRddqnJen24pYVOA8/ztVvJHGnslt4wEQvYMKJaehGoFHPElqGyEZIHEqzqkyKfufGxZC8yg
        MoRggCXCoMRP4hLnSjdNNQ55rxwWOlqZ6U2SZwoUTarnjHFXKWzjCHobNGaxU0vf8Smo1oP7ky8rg
        wto8tQIA3URds4tRDrzC+yByOAEterXlqKTB27+yb2gG3PD7arLyTZf/y+JLJakGpbPbEAVqdR7hR
        n336N5LQ7XJB7fzjt1gR2XYuRao9ooa4rlJpAZ9siTgnS7x7hW1RjjN5pNWNEKKp1Btj8nPf1TPYw
        3DuaqqPXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxSqW-00059i-Pl; Sat, 23 Feb 2019 08:39:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0185F20259708; Sat, 23 Feb 2019 09:39:42 +0100 (CET)
Date:   Sat, 23 Feb 2019 09:39:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
Message-ID: <20190223083942.GF32477@hirez.programming.kicks-ass.net>
References: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CE650687-ECB3-4A7C-96BA-A061D54AEF40@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE650687-ECB3-4A7C-96BA-A061D54AEF40@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 03:39:48PM -0800, hpa@zytor.com wrote:
> Objtool could also detect CLAC-STAC or STAC-CLAC sequences without
> memory operations and remove them; don't know how often that happens,
> but I know it *does* happen.

Objtool doesn't know about memops; that'd be a lot of work. Also,
objtool doesn't actually rewrite the text, at best it could warn about
such occurences.
