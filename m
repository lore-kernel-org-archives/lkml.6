Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E685C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EEE24728
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EEE24728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934095AbeFVSYZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:24:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60094 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933691AbeFVSYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:24:24 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JvFXaafhXKlL; Fri, 22 Jun 2018 20:24:22 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9AC61EC038F;
        Fri, 22 Jun 2018 20:24:22 +0200 (CEST)
Date:   Fri, 22 Jun 2018 20:24:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86/kvm: Handle all MCA banks
Message-ID: <20180622182419.GE1882@zn.tnic>
References: <20180622095101.32587-1-bp@alien8.de>
 <20180622095101.32587-4-bp@alien8.de>
 <20180622181603.GB5549@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180622181603.GB5549@flask>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 08:16:04PM +0200, Radim Krčmář wrote:
> 2018-06-22 11:51+0200, Borislav Petkov:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Extend the range of MCA banks which get passed to set/get_msr_mce() to
> > include all the MSRs of the last bank too.
> > 
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > ---
> >  arch/x86/kvm/x86.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 80452b0f0e8c..a7d344823356 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -2466,7 +2466,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >  
> >  	case MSR_IA32_MCG_CTL:
> >  	case MSR_IA32_MCG_STATUS:
> > -	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
> > +	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_MISC(KVM_MAX_MCE_BANKS) - 1:
> 
> It was correct before.  We have 32 banks (KVM_MAX_MCE_BANKS), so the
> last useable has index 31 and the "- 1" is going to roll over from first
> MSR of bank 32 to the last MSR of the last bank.
> 
> Another way of writing it would be:
> 
>  case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_MISC(KVM_MAX_MCE_BANKS - 1):

Huh?

This is what I did:

+   case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_MISC(KVM_MAX_MCE_BANKS) - 1:

It needs to be MISC because it is the last MSR in the MCA bank and thus
the highest.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
