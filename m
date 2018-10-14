Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E85DC6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A456920843
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ezwJBKCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A456920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeJNRIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 13:08:22 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51730 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeJNRIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 13:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9BeZhDmSMoCu6k+LTV4eF1j3MKa7nlSxYTpxMcoQHUc=; b=ezwJBKCA+fxdCeGpk3RHz0N0A
        IBjBU1Tkw2qpx9a2QDzbZ2LEdCvpy/JYtLPTYK6Kg6CuGWNZrQ/FYbyfis4HHDqqYTHqWc/yfy9Pt
        UWcI/ga9mdQH4KZ8Jk5LseVig3NetK8Y22QW6Nyt6VNlOGXxYwPi9DfBBbouS5SgGnjYM=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:51327)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gBcgY-0002xf-4V; Sun, 14 Oct 2018 10:27:42 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gBcgS-0002k8-RV; Sun, 14 Oct 2018 10:27:37 +0100
Date:   Sun, 14 Oct 2018 10:27:34 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Liran Alon <liran.alon@oracle.com>, linux-mips@linux-mips.org,
        linux@armlinux.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, paulus@ozlabs.org, hpa@zytor.com,
        kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
        lantianyu1986@gmail.com, sthemmin@microsoft.com,
        mpe@ellerman.id.au, x86@kernel.org, michael.h.kelley@microsoft.com,
        mingo@redhat.com, benh@kernel.crashing.org, jhogan@kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
        haiyangz@microsoft.com, kvm-ppc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-arm-kernel@lists.infradead.org,
        christoffer.dall@arm.com, ralf@linux-mips.org,
        paul.burton@mips.com, pbonzini@redhat.com, vkuznets@redhat.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
Message-ID: <20181014092734.GV30658@n2100.armlinux.org.uk>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 10:16:56AM +0200, Thomas Gleixner wrote:
> On Sun, 14 Oct 2018, Liran Alon wrote:
> > > On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
> > > 
> > > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > > 
> > > This patch is to add wrapper functions for tlb_remote_flush_with_range
> > > callback.
> > > 
> > > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > > ---
> > > Change sicne V3:
> > >       Remove code of updating "tlbs_dirty"
> > > Change since V2:
> > >       Fix comment in the kvm_flush_remote_tlbs_with_range()
> > > ---
> > > arch/x86/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
> > > 1 file changed, 40 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > > index c73d9f650de7..ff656d85903a 100644
> > > --- a/arch/x86/kvm/mmu.c
> > > +++ b/arch/x86/kvm/mmu.c
> > > @@ -264,6 +264,46 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
> > > static union kvm_mmu_page_role
> > > kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
> > > 
> > > +
> > > +static inline bool kvm_available_flush_tlb_with_range(void)
> > > +{
> > > +	return kvm_x86_ops->tlb_remote_flush_with_range;
> > > +}
> > 
> > Seems that kvm_available_flush_tlb_with_range() is not used in this patch…
> 
> What's wrong with that? 
> 
> It provides the implementation and later patches make use of it. It's a
> sensible way to split patches into small, self contained entities.

From what I can see of the patches that follow _this_ patch in the
series, this function remains unused.  So, not only is it not used
in this patch, it's not used in this series.

I think the real question that needs asking is - what is the plan
for this function, and when will it be used?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
