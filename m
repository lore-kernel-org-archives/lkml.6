Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25FEC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EB520878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD9iwxWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EB520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeLDS7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:59:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeLDS7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:59:06 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51B1920879
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543949944;
        bh=BhVDt/3cNqBIf39ulqamI6y4o2AnmljccOWNLBiclOg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dD9iwxWpf4jkCrDxpH7xwwTcyIBqdG5dXIt6gZZYJO1bL+ScREtMTihLKAPkeeICX
         54JufPbD+0sGZbLuqPSDzF1CsS4wsv74T6TO/2FUkioa12nKhbfkmVzlYJOn+p5eYT
         bnln+5AGdgqnn7GDiMponJ6hST9ycNiloH4iCi70=
Received: by mail-wr1-f44.google.com with SMTP id p4so17099792wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:59:04 -0800 (PST)
X-Gm-Message-State: AA+aEWbrlVHJx5kI0r/kr3lDoxWpv1wDKRNshpSWgGG+URvvLtQUfZ9l
        d2MpzstT7QbNNXqtFgNg6J52fEwQzpkY9M6XogkorQ==
X-Google-Smtp-Source: AFSGD/Uaee6HgGyFYlKlcsojOpCpYAvW978UEF8A/Lo64WZ5nZy5pbkITar7ozdTQboTUdqiXPGIaURZO3wAGPbqGe4=
X-Received: by 2002:adf:8323:: with SMTP id 32mr18387439wrd.176.1543949942753;
 Tue, 04 Dec 2018 10:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20181204161741.12292-1-sean.j.christopherson@intel.com>
 <20181204161741.12292-2-sean.j.christopherson@intel.com> <20181204182239.GA17374@linux.intel.com>
 <20181204182932.GB17374@linux.intel.com>
In-Reply-To: <20181204182932.GB17374@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 10:58:51 -0800
X-Gmail-Original-Message-ID: <CALCETrWHhdMBxejzgTtykFUgifkNYj5zDfp04tn7JdftiSzFLw@mail.gmail.com>
Message-ID: <CALCETrWHhdMBxejzgTtykFUgifkNYj5zDfp04tn7JdftiSzFLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/vdso: Remove obsolete "fake section table" reservation
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 10:29 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Dec 04, 2018 at 10:22:39AM -0800, Sean Christopherson wrote:
> > On Tue, Dec 04, 2018 at 08:17:40AM -0800, Sean Christopherson wrote:
> > > At one point the vDSO image was manually stripped down by vdso2c in an
> > > attempt to minimize the size of the image mapped into userspace.  Part
> > > of that stripping process involved building a fake section table so as
> > > not to break userspace processes that parse the section table.  Memory
> > > for the fake section table was reserved in the .rodata section so that
> > > vdso2c could simply copy the entire PT_LOAD segment into the userspace
> > > image after building the fake table.
> > >
> > > Eventually, the entire fake section table approach was dropped in favor
> > > of stripping the vdso "the old fashioned way", i.e. via objdump -S.
> > > But, the reservation in .rodata for the fake table was left behind.
> > > Remove the reserveration along with a few other related defines and
> > > section entries.
> > >
> > > Removing the fake section table placeholder zaps a whopping 0x340 bytes
> > > from the 64-bit vDSO image, which drops the current image's size to
> > > under 4k, i.e. reduces the effective size of the userspace vDSO mapping
> > > by a full page.
> > >
> > > Fixes: da861e18eccc ("x86, vdso: Get rid of the fake section mechanism")
> > > Cc: Andy Lutomirski <luto@amacapital.net>
> > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > > ---
> > > diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
> > > index 4674f58581a1..2479a454b15c 100644
> > > --- a/arch/x86/entry/vdso/vdso2c.c
> > > +++ b/arch/x86/entry/vdso/vdso2c.c
> > > @@ -98,12 +98,6 @@ struct vdso_sym required_syms[] = {
> > >     [sym_hpet_page] = {"hpet_page", true},
> > >     [sym_pvclock_page] = {"pvclock_page", true},
> > >     [sym_hvclock_page] = {"hvclock_page", true},
> > > -   [sym_VDSO_FAKE_SECTION_TABLE_START] = {
> > > -           "VDSO_FAKE_SECTION_TABLE_START", false
> > > -   },
> > > -   [sym_VDSO_FAKE_SECTION_TABLE_END] = {
> > > -           "VDSO_FAKE_SECTION_TABLE_END", false
> > > -   },
> >
> > Doh, I missed removing the definitions for sym_VDSO_FAKE_SECTION_TABLE_*.
>
> And with sym_VDSO_FAKE_SECTION_TABLE_* gone all symbols are exported,
> meaning required_syms can be a char* array and struct vdso_sym can be
> removed.

I bet that we'll want that field to parse out the extable entries once
all the dust settles, though.

--Andy
