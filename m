Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D05C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C610420664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jK+OO/NI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C610420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeJaWJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:09:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeJaWJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4l2DjgZkXSLqL1QWFrZ12/6BysXWyTCGDXE+o5HH3N0=; b=jK+OO/NIz5pIli96U9FDs7tIr
        CA9sCtJlMGNcI45TJRDAsv9qj64Rm9y+kYmunW764zXU7MdiBcoFRnpj9lsH8TrLgTR69JJNIdgV+
        WgtUVd9nTh1bKZXWuOqmN7ZulIA5OSMmuSYoACkuPD/yiFkdvQ3PBPoeyYyT3NEu6VYgVk/1kOglS
        uRHCA07ItJ3F+T4l2GXUg+KYW/5aUdMNEv/UclXCQERmFgwO+h1cYVi/TM4cqViKChmfCoUJ8ScDh
        Ok9JiKmiTttGTXvkHYK5FRW1XV0ue28XPwliWN57k+A8S1LwdPDF7gju6YlyaJdvOIw7ilBEJny9Q
        LZpuLVh1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHqHA-0003zJ-Uj; Wed, 31 Oct 2018 13:11:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B00EB20297604; Wed, 31 Oct 2018 14:11:10 +0100 (CET)
Date:   Wed, 31 Oct 2018 14:11:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
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
Message-ID: <20181031131110.GA13257@hirez.programming.kicks-ass.net>
References: <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org>
 <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
 <20181010072240.GB103159@gmail.com>
 <20181010080324.GV29268@gate.crashing.org>
 <20181010081906.GA5533@zn.tnic>
 <20181010185432.GB29268@gate.crashing.org>
 <20181010191427.GF5533@zn.tnic>
 <20181013193335.GD31650@zn.tnic>
 <20181031125526.GA13219@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031125526.GA13219@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 01:55:26PM +0100, Peter Zijlstra wrote:
> On Sat, Oct 13, 2018 at 09:33:35PM +0200, Borislav Petkov wrote:
> > Ok,
> > 
> > with Segher's help I've been playing with his patch ontop of bleeding
> > edge gcc 9 and here are my observations. Please double-check me for
> > booboos so that they can be addressed while there's time.
> > 
> > So here's what I see ontop of 4.19-rc7:
> > 
> > First marked the alternative asm() as inline and undeffed the "inline"
> > keyword. I need to do that because of the funky games we do with
> > "inline" redefinitions in include/linux/compiler_types.h.
> > 
> > And Segher hinted at either doing:
> > 
> > asm volatile inline(...
> > 
> > or
> > 
> > asm volatile __inline__(...
> > 
> > but both "inline" variants are defined as macros in that file.
> > 
> > Which means we either need to #undef inline before using it in asm() or
> > come up with something cleverer.
> 
> # git grep -e "\<__inline__\>" | wc -l
> 488
> # git grep -e "\<__inline\>" | wc -l
> 56
> # git grep -e "\<inline\>" | wc -l
> 69598
> 
> And we already have scripts/checkpatch.pl:
> 
>   # Check for __inline__ and __inline, prefer inline
> 
> Which suggests we do:
> 
> git grep -l "\<__inline\(\|__\)\>" | while read file
> do
> 	sed -i -e 's/\<__inline\(\|__\)\>/inline/g' $file
> done
> 
> and get it over with.
> 
> 
> Anyway, with the below patch, I get:
> 
>    text    data     bss     dec     hex filename
> 17385183        5064780 1953892 24403855        1745f8f defconfig-build/vmlinux
> 17385678        5064780 1953892 24404350        174617e defconfig-build/vmlinux

  17387603        5065468 1953892 24406963        1746bb3 defconfig-build/vmlinux

If I do an additional:

git grep -l "asm volatile" | while read file
do
	sed -i -e 's/asm volatile/asm_volatile/g' $file
done

on the tree...

No changes for:

-#define asm_volatile_goto(x...)        do { asm goto(x); asm (""); } while (0)
+#define asm_volatile_goto(x...)        do { asm __inline__ goto (x); asm (""); } while (0)

I suppose all our goto's are small now (my tree includes Nadav's patch
to static_cpu_has).
