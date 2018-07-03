Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F62CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C307D24781
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C307D24781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeGCVAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:00:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:60647 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752872AbeGCVA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:00:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 14:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,305,1526367600"; 
   d="scan'208";a="63897836"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2018 14:00:25 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1187E3013DC; Tue,  3 Jul 2018 14:00:25 -0700 (PDT)
Date:   Tue, 3 Jul 2018 14:00:25 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Gabriel C <nix.or.die@gmail.com>,
        Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180703210025.GG17013@tassilo.jf.intel.com>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
 <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180703180307.GF17013@tassilo.jf.intel.com>
 <20180703202609.k2zxwduhvlynfsbw@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703202609.k2zxwduhvlynfsbw@kshutemo-mobl1>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 11:26:09PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jul 03, 2018 at 11:03:07AM -0700, Andi Kleen wrote:
> > On Tue, Jul 03, 2018 at 05:21:50PM +0300, Kirill A. Shutemov wrote:
> > > On Tue, Jul 03, 2018 at 03:44:03PM +0300, Kirill A. Shutemov wrote:
> > > > On Tue, Jul 03, 2018 at 01:24:49PM +0200, Gabriel C wrote:
> > > > > 2018-07-01 23:32 GMT+02:00 Benjamin Gilbert <bgilbert@redhat.com>:
> > > > > > On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> > > > > >> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig,
> > > > > >> up to and including 4.17.3, fail to boot on AMD64 running in (at least)
> > > > > >> QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.
> > > > > >> Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level
> > > > > >> paging boot if kernel is above 4G") fixes it.  I've attached our kernel
> > > > > >> config for reference, and am happy to test patches, provide sample QCOW
> > > > > >> images, etc.
> > > > > >
> > > > > 
> > > > > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
> > > > > 
> > > > > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
> > > > > too with the same symptoms
> > > > 
> > > > I tracked it down to -flto in LDFLAGS. I'll look more into this.
> > > 
> > > -flto in LDFLAGS screws up this part of paging_prepare():
> > 
> > Where is that coming from? The LTO patches are not upstream.
> > 
> > And I don't see any LTO usage in the main line.
> 
> Apparently some distros try to hack it around:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=200385
> 
> I'm amazed that it kinda worked for them.

I think it only works on older gccs that don't default to 
thin LTO, but always generate a fallback non LTO object. 
The kernel directly uses ld in the link step (without my patches), so LTO
shouldn't be able to ever generate code.

The early boot code may be an exception of this, and it's likely
the only code that actually uses LTO in such a set up.

The -fPIC is actually scarier than the -flto. The generated code 
must create quite a mess and I'm not sure why you even would want that
because the kernel can be relocatable without it.

BTW I hope to eventually resend the full LTO patches.
They seem to get more and more users recently, mainly for smaller
code size.

> 
> 
> > > 	/* Copy trampoline code in place */
> > > 	memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
> > > 			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
> > 
> > 
> > > In particular, relocation for trampoline_32bit_src solved in the wrong
> > > way. Without -flto, we have rip-realtive address load:
> > > 
> > >   982d30:	48 8d 35 09 cc ff ff 	lea    -0x33f7(%rip),%rsi        # 97f940 <trampoline_32bit_src>
> > > 
> > > With -flto we have immediate load:
> > > 
> > >   982cf0:	48 c7 c6 f0 f8 97 00 	mov    $0x97f8f0,%rsi
> > 
> > Strange.
> > 
> > Can you add some RELOC_HIDE()s and see if that helps?
> 
> Nope. No difference in generated code.

Ok will need to put together some self contained test case for the compiler people.
I'll try to take a look.

-Andi
