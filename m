Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9043AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFA92147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p13VSK58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfBYKwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 05:52:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38674 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfBYKwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 05:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dyMB1UGRka+d+pOPsE0a1FpRZDbWxoc9RebN6Ikwq0k=; b=p13VSK58r+U7IlWf7HmUUJzpp
        9JS30ZytBbyct/D2QAWAw1o2xaKxz5eZfNboBLLyWPjhyhMp8pxTg5OUKrIw3s8XfivWgcmfqTthK
        I7nXd3atLJOjRvC488Yz5RrrLZ+vW+/jMWiYLixs643wOd8z0KnYElxS681LFNMU+Vl/P3+RSC4Ga
        gOJDCAgikEs7bhrsmJTu1q4jg25XRH+zhof/6+vv/v5BDBpecjYa/ZthDg26e/Qwwp054wtZnpqJL
        aDvcR9nmP/oYE2JAPuc11p6ldq86x8zJGS/1Xq2qjabt4+uI5na/YvfcYv/8tXhKWc5mWFU6H+QFz
        TXOA0Nw/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyDrP-0005rV-Ij; Mon, 25 Feb 2019 10:51:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAB6E2030E115; Mon, 25 Feb 2019 11:51:44 +0100 (CET)
Date:   Mon, 25 Feb 2019 11:51:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
Message-ID: <20190225105144.GJ32477@hirez.programming.kicks-ass.net>
References: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 03:55:25PM -0800, Andy Lutomirski wrote:
> I'm wondering if we can just change the code that does getreg() and
> load_gs_index() so it doesn't do it with AC set.  Also, what about
> paravirt kernels?  They'll call into PV code for load_gs_index() with
> AC set.

Paravirt can go bugger off. There's no sane way to fix that.

Luckily the load_gs_index() thing is part of the paravirt me harder crap
and so nobody sane should ever hit that.

I don't fully understand that code at all; I also have no clue why GS
has paravirt bits on but the other segments do not. But it looks like we
want to do that RELOAD_SEG() crap under SMAP because of the GET_SEG() ->
get_user_ex() thing.

Anyway, I only see 3 options here:

 1) live with the paravirt me harder builds complaining
 2) exclude the AC validation from the paravirt me harder builds
 3) rewrite this code to no need that stupid call in the first place


2 seems like an exceptionally bad ideal, 3 would need someone that
understands this, so for now I'll pick 1 :-)


*thought*... we could delay the actual set_user_seg() thing until after
the get_user_catch(), would that work?


