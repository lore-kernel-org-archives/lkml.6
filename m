Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7CCC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E2120644
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E2120644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeJNFJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 01:09:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38640 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbeJNFJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 01:09:11 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CMjTikMlhzp0; Sat, 13 Oct 2018 23:30:35 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDC0500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FCD51EC0293;
        Sat, 13 Oct 2018 23:30:35 +0200 (CEST)
Date:   Sat, 13 Oct 2018 23:30:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexander Monakov <amonakov@ispras.ru>
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
Message-ID: <20181013213015.GG31650@zn.tnic>
References: <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org>
 <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
 <20181010072240.GB103159@gmail.com>
 <20181010080324.GV29268@gate.crashing.org>
 <20181010081906.GA5533@zn.tnic>
 <20181010185432.GB29268@gate.crashing.org>
 <20181010191427.GF5533@zn.tnic>
 <20181013193335.GD31650@zn.tnic>
 <alpine.LNX.2.20.13.1810132355180.13914@monopod.intra.ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.20.13.1810132355180.13914@monopod.intra.ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 12:14:02AM +0300, Alexander Monakov wrote:
> I apologize for coming in late here with an alternative proposal, but would
> you be happy if GCC gave you a way to designate a portion of the asm template
> string that shouldn't be counted as its cost because it doesn't go into the
> .text section? This wouldn't interact with your redefinitions of the inline
> keyword, and you could do something like (assuming we go with %` ... %`
> delimiters)

I don't mind it but I see you guys are still discussing what would be
the better solution here, on the gcc ML. And we, as one user, are a
happy camper as long as it does what it is meant to do. But how the
feature looks like syntactically is something for gcc folk to decide as
they're going to support it for the foreseeable future and I'm very well
aware of how important it is for a supportable feature to be designed
properly.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
