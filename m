Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD43C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0602073D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pcx+6gkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfBENZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:25:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBENZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+l45x5l0P651QToTgntqm4C4rBuYwaWF/YbxeJcL2io=; b=Pcx+6gkPLdBa1ieyYGSrBM86W
        cluGsoVQzC2hMkhbRbBbvcd309s1CoJjgS8x3tyXcriGoNdWG4+Z1ApqrCrmflsbikjhAWgYdXLIm
        5VtZ84kTOXNSEEJCU2oPV7toJzb9bsmDs5sAWjqM/9HoDb8jZiKaeLe6fglkiNHCyBuxWFeOkbK3A
        MqMnbfWYhbM5bmqVdTmFDnW738MZR1o1akvR+72MWee5cFKjAdchbhuCAolzuUKVnpFfQ+4oEhHue
        DEEMlRNJwbJ2KT75VJf/XcinLApF6zKOOhzZLVaeryeSMnWmHf5w99bCrg1Auwa3uPU0l+nf3hNIW
        LIaeKvqPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gr0ir-0006Jc-5O; Tue, 05 Feb 2019 13:25:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EB66202A2A0F; Tue,  5 Feb 2019 14:25:07 +0100 (CET)
Date:   Tue, 5 Feb 2019 14:25:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 06/20] x86/alternative: use temporary mm for text
 poking
Message-ID: <20190205132507.GS17528@hirez.programming.kicks-ass.net>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-7-rick.p.edgecombe@intel.com>
 <20190205095853.GJ21801@zn.tnic>
 <20190205113146.GP17528@hirez.programming.kicks-ass.net>
 <20190205123533.GN21801@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205123533.GN21801@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 01:35:33PM +0100, Borislav Petkov wrote:
> On Tue, Feb 05, 2019 at 12:31:46PM +0100, Peter Zijlstra wrote:
> > ...
> >
> > So while in general I agree with BUG_ON() being undesirable, I think
> > liberal sprinking in text_poke() is fine; you really _REALLY_ want this
> > to work or fail loudly. Text corruption is just painful.
> 
> Ok. It would be good to have the gist of this sentiment in a comment
> above it so that it is absolutely clear why we're doing it.
> 
> And since text_poke() can't fail, then it doesn't need a retval too.
> AFAICT, nothing is actually using it.

See patch 12, that removes the return value (after fixing the few users
that currently 'rely' on it).
