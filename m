Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3026C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B5920833
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uFa8k/Zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B5920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeKAUSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:18:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeKAUSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gWqOTYZkHgjjHyE9vSrkJN0G7zLuwwNT6oQ9KO2L7ag=; b=uFa8k/Zd3Vzx87d6FpfON25l6
        zjexHnR5O/wM8N69BYmbQtfbC++QKvzEnFq9xpKudVtL0SUrPSfs0sVuqXk5p3sGyU1VrKz1AwHfw
        xNqKmabxJlyBJqqX+szytNO+eRhS6KauPRhTGYQxFuUhnRR66tprTc08w2yPPMEeYxS37p9w7kmJJ
        facNjJGZGvqSFdxWjlilUTI7LitTsuvZW3ejiBK2QqjDWz4Mp16zuQP6asd8GJFiF+owJ7Wrqxb4T
        tzdpRnffLnb2PnSc+W5rDGYbvGItnBCEVAktNXjbqw8OfVqv6R/+gRhlg3AMipirbbvoh5rhDqx7B
        Y3SIl/iWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIAxB-0007bN-80; Thu, 01 Nov 2018 11:15:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4321520296EF3; Thu,  1 Nov 2018 12:15:54 +0100 (CET)
Date:   Thu, 1 Nov 2018 12:15:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Biener <rguenther@suse.de>,
        Michael Matz <matz@suse.de>, gcc@gcc.gnu.org,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Message-ID: <20181101111554.GC3178@hirez.programming.kicks-ass.net>
References: <20181010072240.GB103159@gmail.com>
 <20181010080324.GV29268@gate.crashing.org>
 <20181010081906.GA5533@zn.tnic>
 <20181010185432.GB29268@gate.crashing.org>
 <20181010191427.GF5533@zn.tnic>
 <20181013193335.GD31650@zn.tnic>
 <20181031125526.GA13219@hirez.programming.kicks-ass.net>
 <5f987ecbb4962b4796615928d9d71f2cf9b21a3b.camel@perches.com>
 <20181101090114.GE3159@hirez.programming.kicks-ass.net>
 <02085d90af8a81b69cb38e0fdd6a018f151a58d8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02085d90af8a81b69cb38e0fdd6a018f151a58d8.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 02:20:40AM -0700, Joe Perches wrote:
> On Thu, 2018-11-01 at 10:01 +0100, Peter Zijlstra wrote:
> > On Wed, Oct 31, 2018 at 10:20:00PM -0700, Joe Perches wrote:
> > > On Wed, 2018-10-31 at 13:55 +0100, Peter Zijlstra wrote:
> > > > Anyway, with the below patch, I get:
> > > > 
> > > >    text    data     bss     dec     hex filename
> > > > 17385183        5064780 1953892 24403855        1745f8f defconfig-build/vmlinux
> > > > 17385678        5064780 1953892 24404350        174617e defconfig-build/vmlinux
> > > > 
> > > > Which shows we inline more (look for asm_volatile for the actual
> > > > changes).
> > > []
> > > >  scripts/checkpatch.pl                              |  8 ++---
> > > >  scripts/genksyms/keywords.c                        |  4 +--
> > > >  scripts/kernel-doc                                 |  4 +--
> > > 
> > > I believe these should be excluded from the conversions.
> > 
> > Probably, yes. It compiled, which was all I cared about :-)
> > 
> > BTW, if we do that conversion, we should upgrade the checkpatch warn to
> > an error I suppose.
> 
> More like remove altogether as __inline and __inline__
> will no longer be #defined

That's the point, therefore checkpatch should error when it sees them.
Otherwise we'll grow new instances, because it will compile just file.
