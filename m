Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E50AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B952146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="c3nP1Ld7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B952146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeK3UOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:14:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45516 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbeK3UOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:14:44 -0500
Received: from [10.206.160.32] (x2f7f020.dyn.telefonica.de [2.247.240.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 473B61EC0229;
        Fri, 30 Nov 2018 10:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543568764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXyub/bQNo+twzgkBA6uGv+W4gRUJq5dMFkmkzgCG54=;
        b=c3nP1Ld7sLsCExu5lrCfgV/yK4wXs5v7wJW9U0JdzrIkjUSl1jl8BeR4n8JS8s2ZEyY0ma
        vEbzecFYVu39xrPRPIkqte2s5EPYQ6k9DhjiJCJ1l4/IryeaFrdQtBNuf+74Z8fvMBCWc0
        hczL4IogqAN8sv3VgoHN1Pwd0li/NfQ=
Date:   Fri, 30 Nov 2018 10:06:02 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20181129122500.GX23873@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr> <20181009145330.GT29268@gate.crashing.org> <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com> <20181129122500.GX23873@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
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
From:   Boris Petkov <bp@alien8.de>
Message-ID: <CF26ACBE-500C-47E8-B79D-E1ABE938031D@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 29, 2018 1:25:02 PM GMT+01:00, Segher Boessenkool <segher@kerne=
l=2Ecrashing=2Eorg> wrote:
>This will only be fixed from GCC 9 on, if the compiler adopts it=2E  The
>kernel wants to support ancient GCC, so it will need to have a
>workaround
>for older GCC versions anyway=2E

What about backporting it, like Richard says?


--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
