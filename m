Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F065C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2B5205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EG5gUh1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2B5205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeK3AMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:12:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43702 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeK3AMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:12:45 -0500
Received: from nazgul.tnic (x59cc8ba7.dyn.telefonica.de [89.204.139.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D17F11EC078A;
        Thu, 29 Nov 2018 14:07:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543496845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mrr4udWC5AWSesai7D93uCElVvO536RVjWPQpvZg0D4=;
        b=EG5gUh1HPTQKiPHnAXUHn9ywHZeT+Kgww7jo1Pj+xQma4WoBhrnmSiOLOztGY6i16sNkwy
        E9DgO3KHPTuCUTWfEgiDVyxlimUefXOwarwypdLcBnOOJtp0BmPGbQJ+EvXuVT/sJ/zDEY
        Aynna9TkvrLvzVKjb3orCFCp75tZ9kk=
Date:   Thu, 29 Nov 2018 14:07:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, rguenther@suse.de, matz@suse.de,
        gcc@gcc.gnu.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Message-ID: <20181129130718.GA3070@nazgul.tnic>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
 <20181007132228.GJ29268@gate.crashing.org>
 <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
 <20181008073128.GL29268@gate.crashing.org>
 <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org>
 <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 08:46:34PM +0900, Masahiro Yamada wrote:
> But, I'd like to ask if x86 people want to keep this macros.s approach.
> Revert 77b0bf55bc675 right now
> assuming the compiler will eventually solve the issue?

Yap, considering how elegant the compiler solution is and how much
problems this macros-in-asm thing causes, I think we should patch
out the latter and wait for gcc9. I mean, the savings are not so
mind-blowing to have to deal with the fallout.

But this is just my opinion.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
