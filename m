Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A297DC6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 08:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FA320835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 08:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FA320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJNP5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 11:57:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53651 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeJNP5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 11:57:52 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gBba5-0000FJ-No; Sun, 14 Oct 2018 10:16:57 +0200
Date:   Sun, 14 Oct 2018 10:16:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Liran Alon <liran.alon@oracle.com>
cc:     lantianyu1986@gmail.com, Lan Tianyu <Tianyu.Lan@microsoft.com>,
        christoffer.dall@arm.com, marc.zyngier@arm.com, linux@armlinux.org,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@linuxdriverproject.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper
 function
In-Reply-To: <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
Message-ID: <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com> <20181013145406.4911-3-Tianyu.Lan@microsoft.com> <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-68457485-1539505017=:1438"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-68457485-1539505017=:1438
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sun, 14 Oct 2018, Liran Alon wrote:
> > On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
> > 
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > 
> > This patch is to add wrapper functions for tlb_remote_flush_with_range
> > callback.
> > 
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> > Change sicne V3:
> >       Remove code of updating "tlbs_dirty"
> > Change since V2:
> >       Fix comment in the kvm_flush_remote_tlbs_with_range()
> > ---
> > arch/x86/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 40 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index c73d9f650de7..ff656d85903a 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -264,6 +264,46 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
> > static union kvm_mmu_page_role
> > kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
> > 
> > +
> > +static inline bool kvm_available_flush_tlb_with_range(void)
> > +{
> > +	return kvm_x86_ops->tlb_remote_flush_with_range;
> > +}
> 
> Seems that kvm_available_flush_tlb_with_range() is not used in this patch…

What's wrong with that? 

It provides the implementation and later patches make use of it. It's a
sensible way to split patches into small, self contained entities.

Thanks,

	tglx
	
--8323329-68457485-1539505017=:1438--
