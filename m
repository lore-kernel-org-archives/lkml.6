Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F31BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E515218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfADV1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:27:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:5543 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfADV1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:27:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 13:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="307580654"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 13:27:02 -0800
Date:   Fri, 4 Jan 2019 13:27:02 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     lantianyu1986@gmail.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: Re: [PATCH 7/11] KVM: Remove redundant check in the
 kvm_get_dirty_log_protect()
Message-ID: <20190104212702.GD11288@linux.intel.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-8-Tianyu.Lan@microsoft.com>
 <20190104155036.GA11288@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104155036.GA11288@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 07:50:36AM -0800, Sean Christopherson wrote:
> On Fri, Jan 04, 2019 at 04:54:01PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > 
> > The dirty bits have already been checked in the previous check of
> > "dirty_bitmap" and mask must be non-zero value at this point.
> > 
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >  virt/kvm/kvm_main.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index cf7cc0554094..e75dbb15fd09 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -1206,11 +1206,9 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
> >  			mask = xchg(&dirty_bitmap[i], 0);
> >  			dirty_bitmap_buffer[i] = mask;
> >  
> > -			if (mask) {
> > -				offset = i * BITS_PER_LONG;
> > -				kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
> > -									offset, mask);
> > -			}
> > +			offset = i * BITS_PER_LONG;
> > +			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
> > +								offset, mask);
> 
> Hmm, the check against mask was explicitly added by commit 58d2930f4ee3
> ("KVM: Eliminate extra function calls in kvm_get_dirty_log_protect()").
> AFAIK KVM only *sets* bits in dirty_bitmap without holding slots_lock
> and/or mmu_lock, so I agree that checking mask is redundant, but it'd be
> nice to elaborate a bit more in the changelog.
> 
> At the very least this needs a Fixes tag for the aforementioned commit.

Actually, this can be a straight revert of 58d2930f4ee3.
