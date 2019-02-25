Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A88C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1375420684
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YMM5Cz7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfBYQlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:41:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41706 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfBYQlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hWLsJ4IGYPewpa4W7Wh7ZvdcZCL9hRkXDdDcmuLpTeg=; b=YMM5Cz7juP3UIVt1eDb1XGxOm
        Q9ExEL+kfvxXttD07k1hrBbJHKHtwSMe6z7ttC6/7tE2ai+NJGk4DxuEu6dljaJv4+wU2dSndBnds
        vWG4m24g9vfhX7t9ZQZH+ulmdsJ5tZvJquScpLQvKAqUZKsPAMtydVgAk8lUxkJCjyhhZ15/37Wbw
        Z9+AVik7WOT5gweun5POAtq15EEqznVoUmypgnNkYlZvev1LMvTrXEEhfxXrMb+YSp1h7tEiQ3h4P
        TUMAL16tPEeK52XekBHsmOpDTzZrDfEDhjrmxgYK5+uxlFaVWFEOoofr3vZGNQgz7fisdx4ybTWdx
        RGIOmMuTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyJK4-0007b9-H6; Mon, 25 Feb 2019 16:41:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D36F2105B471; Mon, 25 Feb 2019 17:41:43 +0100 (CET)
Date:   Mon, 25 Feb 2019 17:41:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] x86/ia32: Fix ia32_restore_sigcontext AC leak
Message-ID: <20190225164143.GC32534@hirez.programming.kicks-ass.net>
References: <20190225124330.613028745@infradead.org>
 <20190225125231.936952143@infradead.org>
 <CALCETrW-p4iF-RMecyNt1JDwKh74c_tw67FCW7Yr_Fd3adtGUw@mail.gmail.com>
 <20190225161003.GL32477@hirez.programming.kicks-ass.net>
 <3F83AE74-3F9E-42BB-8F9C-3033F72B3EF5@amacapital.net>
 <20190225163745.GF32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225163745.GF32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 05:37:45PM +0100, Peter Zijlstra wrote:
> +	RELOAD_SEG(gs);
> +	RELOAD_SEG(fs);
> +	RELOAD_SEG(ds);
> +	RELOAD_SEG(es);

Also; is that the canonical order ? It bugs the hell out of me to not
have that alphabetically correct. Shall I correct that?
