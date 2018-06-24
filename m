Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF7BC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A50424E97
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="Mx7FDs+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A50424E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeFXKrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 06:47:10 -0400
Received: from mail-1857040136.protonmail.ch ([185.70.40.136]:50285 "EHLO
        mail-1857040136.protonmail.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751721AbeFXKrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 06:47:09 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jun 2018 06:47:08 EDT
Date:   Sun, 24 Jun 2018 06:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1529836741;
        bh=54cHe5gj4iLsK6HrIwQNr6+oH61gbWpE+5ktwJp+VmI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=Mx7FDs+zVVpdNf3IN8s8CPXP2932Trg0Bvj061awv0PiL9U7BqtxVwYJA9Ut94tZl
         PMZwJb3N8Tr7tdF4qt1BwW8rPLrMAN4cEcxDTWQimmX0KO4D1xZzrtdiOIzxVFsLLd
         GWdWDXSFGugBtuSKwEbSHvgLgMlP5KWp7VbgQO84=
To:     Ingo Molnar <mingo@kernel.org>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Brad Spengler <spender@grsecurity.net>,
        Tycho Andersen <tycho@tycho.ws>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH v13 0/6] Introduce the STACKLEAK feature and a test for it
Message-ID: <rlJicRc5iVlRxMPSYI3Y9Ow3cZimuIY4gAVTbm4wtlt2JVFIX9VR3rKdNIWS0-uYYi40epQlb-lwLC4Hc9HjmIB8PLGcX3s8CNcPl9BhGzo=@protonmail.ch>
In-Reply-To: <20180624071817.GA32154@gmail.com>
References: <1527365430-8303-1-git-send-email-alex.popov@linux.com>
 <CAGXu5jJ9F-eZW5qVGebsv=wUh0kSm+edAecpztgvMC3fGeYXXA@mail.gmail.com>
 <CAGXu5jLU4En5Cf6KGf0Adpky-TF7aa=d9MTDqDKwxQuxZSLNEg@mail.gmail.com>
 <20180622013339.GA10129@gmail.com>
 <CAGXu5jJgmvqWzJ1kbq-zTsmwkcc9FPXgBdT9qf+Hc4tLcLh87w@mail.gmail.com>
 <CAGXu5j+bUEPZp1LAc82RDmvCXc=YnsOVP3FdzCX_4WsZTXcCBA@mail.gmail.com>
 <20180622031645.GA26826@gmail.com>
 <feb24168-9528-dfd0-be05-daea3e0b19b9@linux.com>
 <20180624071817.GA32154@gmail.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 24, 2018 9:18 AM, Ingo Molnar <mingo@kernel.org> wrote:

> -   Alexander Popov alex.popov@linux.com wrote:
>=20
> > On 22.06.2018 06:16, Ingo Molnar wrote:
> >=20
> > > -   Kees Cook keescook@chromium.org wrote:
> > >=20
> > > > On Thu, Jun 21, 2018 at 7:07 PM, Kees Cook keescook@chromium.org wr=
ote:
> > > >=20
> > > > > It needs rebasing to -rc1 (which I've done already, but I'm still
> > > > >=20
> > > > > doing build tests on it).
> > > >=20
> > > > It's passed basic allmodconfig builds:
> > > >=20
> > > > tree: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.gi=
t
> > > >=20
> > > > branch: for-next/stackleak
> > >=20
> > > Ok, that's 6 patches - please send the latest for review as emails to=
 lkml the
> > >=20
> > > usual. Thanks!
> >=20
> > I'll resend the rebased v13 shortly.
>=20
> Well, I assume there were v12->v13 changes, correct?
>=20
> If yes, and if it's on a different base krnel, then why did you call it a
>=20
> 'resend'? That will only get fewer people to review it ... Please don't d=
o that
>=20
> for future iterations.
>=20
> Thanks,
>=20
> Ingo

v13 was sent for the first time a month ago and you were on the list of rec=
ipients:
http://www.openwall.com/lists/kernel-hardening/2018/05/26/6

Jordan
