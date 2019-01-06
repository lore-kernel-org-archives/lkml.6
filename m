Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C8CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883D7218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfAGOYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:24:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:27628 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbfAGOYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:24:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 06:24:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="133635435"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.13.104])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jan 2019 06:24:09 -0800
Date:   Mon, 7 Jan 2019 05:17:59 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v1 5/8] kvm:x86 Enable MSR_IA32_XSS bit 11 and 12 for CET
 xsaves/xrstors.
Message-ID: <20190106211759.GA19372@local-michael-cet-test.sh.intel.com>
References: <20181226081532.30698-1-weijiang.yang@intel.com>
 <20181226081532.30698-6-weijiang.yang@intel.com>
 <20190102182446.GC7460@linux.intel.com>
 <CALMp9eS3F5siy-VhKwEiP+J3m3AeQ3WjvEkVPvvWZ-WMrqQYsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eS3F5siy-VhKwEiP+J3m3AeQ3WjvEkVPvvWZ-WMrqQYsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 11:19:34AM -0800, Jim Mattson wrote:
Thanks Sean and Jim for your valuable comments, I'll consolidate them in
next release!

> On Wed, Jan 2, 2019 at 10:24 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > On Wed, Dec 26, 2018 at 04:15:29PM +0800, Yang Weijiang wrote:
> > > For kvm Guest OS, right now, only bit 11(user mode CET) and bit 12
> > > (supervisor CET) are supported in XSS MSR, if other bits are being set,
> > > the write to XSS will be skipped.
> > >
> > > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > ---
> > >  arch/x86/kvm/vmx.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > > index fa2db6248404..5739ab393b90 100644
> > > --- a/arch/x86/kvm/vmx.c
> > > +++ b/arch/x86/kvm/vmx.c
> > > @@ -47,6 +47,7 @@
> > >  #include <asm/virtext.h>
> > >  #include <asm/mce.h>
> > >  #include <asm/fpu/internal.h>
> > > +#include <asm/fpu/types.h>
> > >  #include <asm/perf_event.h>
> > >  #include <asm/debugreg.h>
> > >  #include <asm/kexec.h>
> > > @@ -4323,12 +4324,16 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> > >       case MSR_IA32_XSS:
> > >               if (!vmx_xsaves_supported())
> > >                       return 1;
> > > +
> > >               /*
> > > -              * The only supported bit as of Skylake is bit 8, but
> > > -              * it is not supported on KVM.
> > > +              * Right now, only support XSS_CET_U[bit 11] and
> > > +              * XSS_CET_S[bit 12] in MSR_IA32_XSS.
> > >                */
> > > -             if (data != 0)
> > > +
> > > +             if (data & ~(XFEATURE_MASK_SHSTK_USER
> > > +                          | XFEATURE_MASK_SHSTK_KERNEL))
> >
> > New lines are usually after the operator, e.g.:
> >
> >         if (data & ~(XFEATURE_MASK_SHSTK_USER |
> >                      XFEATURE_MASK_SHSTK_KERNEL))
> >
> > And doesn't this flow need to check that the bits are actually supported?
> Supported on the host and in the guest.
