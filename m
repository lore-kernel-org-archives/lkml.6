Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8BBC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E42E20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yaHaiFBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E42E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeLDTrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbeLDTrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:47:00 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 554E3208E7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543952818;
        bh=GdIT3mrXur7/u6TLriNhD21+/ytaHGodUcV1/TXX2w0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yaHaiFBFwW2K1suVAfvSKAmZRBwU4cL/NyCKd0k2S2+AkwHjiBbmGFGyw72cuhAzv
         sWL7lYHeKfjUx+QxgeZ4X1yPq7OdoEopqMhDYL4VjAVD1iOoW2+XnkqQ/toFk/iZbw
         L5IHByOtX5+qvoSm5kgHF3aQIvdfGhYu+iMKEKbw=
Received: by mail-wr1-f53.google.com with SMTP id t27so17246424wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:46:58 -0800 (PST)
X-Gm-Message-State: AA+aEWayt8jTY61AFnPTHM2Rw2Yhv654aSOa4uH3fAs/wa6GpuXYgnNw
        eDqJaC2ksbfQDs0tBzP3N4zlyWpsHEZHIl2D8132iQ==
X-Google-Smtp-Source: AFSGD/VDgUH8J5GNCTYFyNrRV9D2XN3HVbDurIyJnihZrPJwNt0y3QJU0YRVapiSXNvZnUSsrcPebZHFMxj02nucYow=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr18242564wri.199.1543952816753;
 Tue, 04 Dec 2018 11:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20181204161741.12292-1-sean.j.christopherson@intel.com>
 <20181204161741.12292-2-sean.j.christopherson@intel.com> <20181204182239.GA17374@linux.intel.com>
 <20181204182932.GB17374@linux.intel.com> <CALCETrWHhdMBxejzgTtykFUgifkNYj5zDfp04tn7JdftiSzFLw@mail.gmail.com>
 <20181204192849.GC17374@linux.intel.com>
In-Reply-To: <20181204192849.GC17374@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 11:46:44 -0800
X-Gmail-Original-Message-ID: <CALCETrXbQD3c6zTxXJxKxLEuD75nYErHxLyPupdQWHQXGGCeMQ@mail.gmail.com>
Message-ID: <CALCETrXbQD3c6zTxXJxKxLEuD75nYErHxLyPupdQWHQXGGCeMQ@mail.gmail.com>
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

On Tue, Dec 4, 2018 at 11:28 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Dec 04, 2018 at 10:58:51AM -0800, Andy Lutomirski wrote:
> > On Tue, Dec 4, 2018 at 10:29 AM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > On Tue, Dec 04, 2018 at 10:22:39AM -0800, Sean Christopherson wrote:
> > > > On Tue, Dec 04, 2018 at 08:17:40AM -0800, Sean Christopherson wrote:
> > > > > At one point the vDSO image was manually stripped down by vdso2c in an
> > > > > attempt to minimize the size of the image mapped into userspace.  Part
> > > > > of that stripping process involved building a fake section table so as
> > > > > not to break userspace processes that parse the section table.  Memory
> > > > > for the fake section table was reserved in the .rodata section so that
> > > > > vdso2c could simply copy the entire PT_LOAD segment into the userspace
> > > > > image after building the fake table.
> > > > >
> > > > > Eventually, the entire fake section table approach was dropped in favor
> > > > > of stripping the vdso "the old fashioned way", i.e. via objdump -S.
> > > > > But, the reservation in .rodata for the fake table was left behind.
> > > > > Remove the reserveration along with a few other related defines and
> > > > > section entries.
> > > > >
> > > > > Removing the fake section table placeholder zaps a whopping 0x340 bytes
> > > > > from the 64-bit vDSO image, which drops the current image's size to
> > > > > under 4k, i.e. reduces the effective size of the userspace vDSO mapping
> > > > > by a full page.
> > > > >
> > > > > Fixes: da861e18eccc ("x86, vdso: Get rid of the fake section mechanism")
> > > > > Cc: Andy Lutomirski <luto@amacapital.net>
> > > > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > > > > ---
> > > > > diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
> > > > > index 4674f58581a1..2479a454b15c 100644
> > > > > --- a/arch/x86/entry/vdso/vdso2c.c
> > > > > +++ b/arch/x86/entry/vdso/vdso2c.c
> > > > > @@ -98,12 +98,6 @@ struct vdso_sym required_syms[] = {
> > > > >     [sym_hpet_page] = {"hpet_page", true},
> > > > >     [sym_pvclock_page] = {"pvclock_page", true},
> > > > >     [sym_hvclock_page] = {"hvclock_page", true},
> > > > > -   [sym_VDSO_FAKE_SECTION_TABLE_START] = {
> > > > > -           "VDSO_FAKE_SECTION_TABLE_START", false
> > > > > -   },
> > > > > -   [sym_VDSO_FAKE_SECTION_TABLE_END] = {
> > > > > -           "VDSO_FAKE_SECTION_TABLE_END", false
> > > > > -   },
> > > >
> > > > Doh, I missed removing the definitions for sym_VDSO_FAKE_SECTION_TABLE_*.
> > >
> > > And with sym_VDSO_FAKE_SECTION_TABLE_* gone all symbols are exported,
> > > meaning required_syms can be a char* array and struct vdso_sym can be
> > > removed.
> >
> > I bet that we'll want that field to parse out the extable entries once
> > all the dust settles, though.
>
> Hmm, the extable stuff will be sections, a la .altinstructions, I don't
> think we'll need separate symbols.

In my mind, the easiest nice implementation is to have a section that
gets thrown away by objcopy --remove-section, and to have the actual
table in that section be bracketed by a pair of symbols, since vdso2c
already parses that.  But vdso2c could certainly also just find the
section direclty.  Then vdso2c could expose an list of extable entries
in the vdso_image, and that would be that.  Does that seem reasonable?

>
> What if I send out a RFC for the extable stuff in parallel to this series
> and to the SGX series?  It'd also be nice to iterate on that code without
> having to spin a full SGX series.

Sounds great!
