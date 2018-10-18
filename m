Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08621C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91782145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBDfOMSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91782145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJRNqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:46:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35383 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeJRNqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:46:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id e187-v6so4429105wmf.0;
        Wed, 17 Oct 2018 22:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hi5S1cE1lZbguBgiKYdwGUeUdS6bx4RZBEkcJQl2eY0=;
        b=hBDfOMSUaYPQYkI0Y558EFMWzuYlNVYR42HmmIzy4eP5T3fljyjjWeQuj0GgNHfwvG
         SB5CEhn9tOHGSf/3RA0mMbn9STW5uX02rdC0br9VgfX5SkyJ8MlPuzFs5BcPF57P6SYi
         7nltwk8zuv+ewP7TUhLwHF1O7AbEmmJDOBMMArBTSk6bCemZJvbgjFw3XWU2NJNdhSgh
         WTXfDRvJ8VjSaZJRTYzETs2ySm2AYo2M77bh55F/bD/k3RG3UloXuVTUGk/ul77jV6iI
         71w8nVhFHoH+Nj2+reKL8FD9oYP89dIzLzFncS3se32W9IXbj53wK20Cbtmm7I7Fxt/5
         SK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hi5S1cE1lZbguBgiKYdwGUeUdS6bx4RZBEkcJQl2eY0=;
        b=QwbFKk7DHTPX8L/nfjetTydOHNq4uwqWX1/eUI3hio+GsXfrGBSEQ/Axs15WRZn5d5
         A+uwq3mC9t2/Ci63H/5EowuDNMdOkhgg0IIZZes10+R+mIX43lA2a38mri14sUifsx0C
         w/jcgevZJtpC3VeXJQGuo05WSLz765k2Lr3ANOsr80BUxFQU8nUeVufpyVhsmH/LBP9C
         dc10iP5U2kIipqv2LrCdWvLR5/LYsWaSy98WFJBBItmhl0LUZ244beNrAzrsrwB736pa
         h5xLPJjbX7LSUUfaxC7Js7pDOSXDDJDVkgWXr1zSlhGm/uwyaLwXudgufdAxIM/OuMbz
         mQAA==
X-Gm-Message-State: ABuFfohcOHCTEoO4fyukbrvaZM3AXet+8hXaG9nDIffqqZmsNyUgKuSE
        Q05cFsjuzaJtaRYu5WuFVXU=
X-Google-Smtp-Source: ACcGV60Sgy5wi2a0HBWF9TrxpAIPSKH+KObYvAkNCYhuxGaE8K9xBh80P+bxthpuLU/sEoshVSMF4w==
X-Received: by 2002:a1c:9d43:: with SMTP id g64-v6mr5591986wme.26.1539841641298;
        Wed, 17 Oct 2018 22:47:21 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u5-v6sm20610519wru.16.2018.10.17.22.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 22:47:20 -0700 (PDT)
Date:   Thu, 18 Oct 2018 07:47:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org,
        Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/4] Renames variable to fix shadow warning.
Message-ID: <20181018054718.GB62071@gmail.com>
References: <20181017000834.GA21330@WindFlash>
 <20181017060151.GA1105@gmail.com>
 <CADvQ+rHD5kAam7kOc2UBUd9Pw6QW3dGhUjQj=es37NfgMeLcyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvQ+rHD5kAam7kOc2UBUd9Pw6QW3dGhUjQj=es37NfgMeLcyA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Leonardo Bras <leobras.c@gmail.com> wrote:

> Thanks Ingo,
> On Wed, Oct 17, 2018 at 3:01 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Leonardo Brás <leobras.c@gmail.com> wrote:
> >
> > > Renames the char variable to avoid shadowing a variable previously
> > > declared on this function.
> > >
> > > Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> > > ---
> > >  arch/x86/entry/vdso/vdso2c.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
> > > index fa847a620f40..9466998d0f28 100644
> > > --- a/arch/x86/entry/vdso/vdso2c.h
> > > +++ b/arch/x86/entry/vdso/vdso2c.h
> > > @@ -93,11 +93,11 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
> > >               int k;
> > >               ELF(Sym) *sym = raw_addr + GET_LE(&symtab_hdr->sh_offset) +
> > >                       GET_LE(&symtab_hdr->sh_entsize) * i;
> > > -             const char *name = raw_addr + GET_LE(&strtab_hdr->sh_offset) +
> > > +             const char *name2 = raw_addr + GET_LE(&strtab_hdr->sh_offset) +
> > >                       GET_LE(&sym->st_name);
> > >
> > >               for (k = 0; k < NSYMS; k++) {
> > > -                     if (!strcmp(name, required_syms[k].name)) {
> > > +                     if (!strcmp(name2, required_syms[k].name)) {
> > >                               if (syms[k]) {
> > >                                       fail("duplicate symbol %s\n",
> > >                                            required_syms[k].name);
> >
> > NAK.
> >
> > Please read and understand the code and rename both variables to
> > meaningful names, not just a mindless name/name2 ...
> >
> 
> It's changed! This change will be available on v2.

Thanks!

	Ingo
