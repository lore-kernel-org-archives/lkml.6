Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C73C65C1D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87DB20882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87DB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeJGVVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 17:21:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35372 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbeJGVVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 17:21:24 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XsiTcyLhSPP1; Sun,  7 Oct 2018 16:14:01 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E22AB1EC01F6;
        Sun,  7 Oct 2018 16:14:00 +0200 (CEST)
Date:   Sun, 7 Oct 2018 16:13:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>,
        Michael Matz <matz@suse.de>, Nadav Amit <namit@vmware.com>,
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
        linux-xtensa@linux-xtensa.org
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Message-ID: <20181007141349.GD30687@zn.tnic>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
 <20181007132228.GJ29268@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181007132228.GJ29268@gate.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 08:22:28AM -0500, Segher Boessenkool wrote:
> GCC already estimates the *size* of inline asm, and this is required
> *for correctness*.

I didn't say it didn't - but the heuristic could use improving.

> So I guess the real issue is that the inline asm size estimate for x86
> isn't very good (since it has to be pessimistic, and x86 insns can be
> huge)?

Well, the size thing could be just a "parameter" or "hint" of sorts, to
tell gcc to inline the function X which is inlining the asm statement
into the function Y which is calling function X. If you look at the
patchset, it is moving everything to asm macros where gcc is apparently
able to do better inlining.

> >  3) asm ("...") __attribute__((asm_size(<size-expr>)));
> 
> Eww.

Why?

> More precise *size* estimates, yes.  And if the user lies he should not
> be surprised to get assembler errors, etc.

Yes.

Another option would be if gcc parses the inline asm directly and
does a more precise size estimation. Which is a lot more involved and
complicated solution so I guess we wanna look at the simpler ones first.

:-)

> I don't like 2) either.  But 1) looks interesting, depends what its
> semantics would be?  "Don't count this insn's size for inlining decisions",
> maybe?

Or simply "this asm statement has a size of 1" to mean, inline it
everywhere. Which has the same caveats as above.

> Another option is to just force inlining for those few functions where
> GCC currently makes an inlining decision you don't like.  Or are there
> more than a few?

I'm afraid they're more than a few and this should work automatically,
if possible.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
