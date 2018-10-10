Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DC0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00FF214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00FF214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJJP5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:57:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:43034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbeJJP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:57:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B376AFE6;
        Wed, 10 Oct 2018 08:35:57 +0000 (UTC)
Date:   Wed, 10 Oct 2018 10:35:54 +0200 (CEST)
From:   Richard Biener <rguenther@suse.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Ingo Molnar <mingo@kernel.org>, Michael Matz <matz@suse.de>,
        gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
In-Reply-To: <20181010081906.GA5533@zn.tnic>
Message-ID: <alpine.LSU.2.20.1810101034020.16707@zhemvz.fhfr.qr>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org> <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr> <20181010072240.GB103159@gmail.com> <20181010080324.GV29268@gate.crashing.org> <20181010081906.GA5533@zn.tnic>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018, Borislav Petkov wrote:

> On Wed, Oct 10, 2018 at 03:03:25AM -0500, Segher Boessenkool wrote:
> > The code immediately after this makes it size 1, even for things like
> > asm(""), I suppose this works better for the inliner.  But that's a detail
> > (and it might change); the description says "consider this asm as minimum
> > length and cost for inlining decisions", which works for either 0 or 1.
> 
> Thanks for implementing this, much appreciated. If you need people to
> test stuff, lemme know.
> 
> > You can think of it as meaning "we want this asm inlined always", and then
> > whether that actually happens depends on if the function around it is
> > inlined or not.
> 
> My only concern is how we would catch the other extremity where the
> inline asm grows too big and we end up inlining it everywhere and thus
> getting fat. The 0day bot already builds tinyconfigs but we should be
> looking at vmlinux size growth too.

Well, it's like always-inline functions, you have to be careful
and _not_ put it everywhere...  It's also somewhat different to
always-inline functions as those lose their special-ness once
inlined (the inlined body is properly accounted for size).

Richard.
