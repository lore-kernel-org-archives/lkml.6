Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FC7206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FC7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbeLDT2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:28:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:8914 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbeLDT2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:28:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 11:28:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="301000979"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga005.fm.intel.com with ESMTP; 04 Dec 2018 11:28:49 -0800
Date:   Tue, 4 Dec 2018 11:28:49 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/vdso: Remove obsolete "fake section table"
 reservation
Message-ID: <20181204192849.GC17374@linux.intel.com>
References: <20181204161741.12292-1-sean.j.christopherson@intel.com>
 <20181204161741.12292-2-sean.j.christopherson@intel.com>
 <20181204182239.GA17374@linux.intel.com>
 <20181204182932.GB17374@linux.intel.com>
 <CALCETrWHhdMBxejzgTtykFUgifkNYj5zDfp04tn7JdftiSzFLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWHhdMBxejzgTtykFUgifkNYj5zDfp04tn7JdftiSzFLw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 10:58:51AM -0800, Andy Lutomirski wrote:
> On Tue, Dec 4, 2018 at 10:29 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > On Tue, Dec 04, 2018 at 10:22:39AM -0800, Sean Christopherson wrote:
> > > On Tue, Dec 04, 2018 at 08:17:40AM -0800, Sean Christopherson wrote:
> > > > At one point the vDSO image was manually stripped down by vdso2c in an
> > > > attempt to minimize the size of the image mapped into userspace.  Part
> > > > of that stripping process involved building a fake section table so as
> > > > not to break userspace processes that parse the section table.  Memory
> > > > for the fake section table was reserved in the .rodata section so that
> > > > vdso2c could simply copy the entire PT_LOAD segment into the userspace
> > > > image after building the fake table.
> > > >
> > > > Eventually, the entire fake section table approach was dropped in favor
> > > > of stripping the vdso "the old fashioned way", i.e. via objdump -S.
> > > > But, the reservation in .rodata for the fake table was left behind.
> > > > Remove the reserveration along with a few other related defines and
> > > > section entries.
> > > >
> > > > Removing the fake section table placeholder zaps a whopping 0x340 bytes
> > > > from the 64-bit vDSO image, which drops the current image's size to
> > > > under 4k, i.e. reduces the effective size of the userspace vDSO mapping
> > > > by a full page.
> > > >
> > > > Fixes: da861e18eccc ("x86, vdso: Get rid of the fake section mechanism")
> > > > Cc: Andy Lutomirski <luto@amacapital.net>
> > > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > > > ---
> > > > diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
> > > > index 4674f58581a1..2479a454b15c 100644
> > > > --- a/arch/x86/entry/vdso/vdso2c.c
> > > > +++ b/arch/x86/entry/vdso/vdso2c.c
> > > > @@ -98,12 +98,6 @@ struct vdso_sym required_syms[] = {
> > > >     [sym_hpet_page] = {"hpet_page", true},
> > > >     [sym_pvclock_page] = {"pvclock_page", true},
> > > >     [sym_hvclock_page] = {"hvclock_page", true},
> > > > -   [sym_VDSO_FAKE_SECTION_TABLE_START] = {
> > > > -           "VDSO_FAKE_SECTION_TABLE_START", false
> > > > -   },
> > > > -   [sym_VDSO_FAKE_SECTION_TABLE_END] = {
> > > > -           "VDSO_FAKE_SECTION_TABLE_END", false
> > > > -   },
> > >
> > > Doh, I missed removing the definitions for sym_VDSO_FAKE_SECTION_TABLE_*.
> >
> > And with sym_VDSO_FAKE_SECTION_TABLE_* gone all symbols are exported,
> > meaning required_syms can be a char* array and struct vdso_sym can be
> > removed.
> 
> I bet that we'll want that field to parse out the extable entries once
> all the dust settles, though.

Hmm, the extable stuff will be sections, a la .altinstructions, I don't
think we'll need separate symbols.

What if I send out a RFC for the extable stuff in parallel to this series
and to the SGX series?  It'd also be nice to iterate on that code without
having to spin a full SGX series.
