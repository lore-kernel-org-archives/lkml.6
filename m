Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A489C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DC42083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DC42083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030526AbeFSVdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:33:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55437 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967138AbeFSVdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:33:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2DE35AF5A;
        Tue, 19 Jun 2018 21:33:01 +0000 (UTC)
Date:   Tue, 19 Jun 2018 23:32:56 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, felix@feldspaten.org
Subject: Re: [PATCH] Use 'imply' with SEV Kconfig CRYPTO dependencies
Message-ID: <20180619213255.GH31750@zn.tnic>
References: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com>
 <20180523144621.GB25143@pd.tnic>
 <CAFLxGvyxHU_Xahwdf=0TYx8Nems78TLioLZGGLTkxNGCgxT4Dg@mail.gmail.com>
 <4f565a11-9e99-b861-06d2-b42922e44c7a@amd.com>
 <20180619094658.GB31750@zn.tnic>
 <3953c12f-c2fe-5d1d-bee2-ac9a230300b8@amd.com>
 <20180619194350.GG31750@zn.tnic>
 <15f10b01-e32f-5fc1-a2e6-3c6ab1461b30@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15f10b01-e32f-5fc1-a2e6-3c6ab1461b30@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 03:46:40PM -0500, Brijesh Singh wrote:
> In case if it was not clear, we don't have a standalone PSP driver.
> The PSP support is provided by the CCP driver. If you look at config
> changes I proposed then it says if PSP is available then we can support
> SEV. But since PSP support is provided by the CCP driver hence we
> need to have module dependency with CCP. So, we are using your former
> expression in the dependency but have to extend it a bit more.

It doesn't matter whether the driver is standalong or not as long as you
specifically have to express explicit dependency on:

depends CRYPTO_DEV_SP_PSP

Now that's the PSP component or whatever but as long as it has a
separate Kconfig symbol, it is the only thing that is important here.

Now, KVM_AMD_SEV needs the functionality behind CRYPTO_DEV_SP_PSP. So
far so good?

> We had discussion about this during our patch review process but lets
> revisit again. CCP driver manages CCP and PSP devices. Ideally the
> driver should have been called SP driver but ccp name existed well
> before we added high level SP interface. IIRC, during SP patch review it
> was recommended not to rename the driver from ccp->sp because it may
> break folks who are already using with ccp name.
> 
> Here is how the config looks:
> 
>                   +------ CRYPTO_DEV_SP_PSP
>                   |
> CRYPTO_DEV_CCP_DD *
>  (ccp.ko)         |                            +-- ccpv3
>                   +------ CRYPTO_DEV_SP_CCP  --|
>                                                +-- ccpv5
>                                                ....

Let me repeat my point more detailed again because it seems like it is
still not clear:

KVM needs SEV functionality which is behind CRYPTO_DEV_SP_PSP. Which
means, KVM_AMD_SEV should depend *only* on that. This is the symbol
which gives that functionality.

Now, you say "CCP driver manages CCP and PSP devices". So
CRYPTO_DEV_SP_PSP should select/depend on *everything* it needs in order
to function properly in order to provide that functionalty to KVM.

BUT! - and this is the key point - KVM should *not* care what PSP needs
to depend on in order to provide that functionality to KVM. PSP should
provide all that functionality itself and not rely on KVM_AMD_SEV to
select it for the PSP functionality.

IOW, you should have this:

config KVM_AMD_SEV
	bool "AMD Secure Encrypted Virtualization (SEV) support"
	depends KVM_AMD && X86_64 && CRYPTO_DEV_SP_PSP

No more symbols.

CRYPTO_DEV_SP_PSP should then do the proper selection so that
CRYPTO_DEV_CCP_DD has the proper setting wrt whether KVM is a module
or builtin. When you add CRYPTO_DEV_CCP_DD to the dependencies list,
you "fix" the design issue that ccp.ko is the driver which provides PSP
functionality.

I'm not sure if you could do something with a separate symbol as I
suggested earlier:

bool CRYPTO_PSP_FOR_KVM
	depends on CRYPTO_DEV_CCP_DD && CRYPTO_DEV_SP_PSP

or so and have KVM_AMD_SEV depend on that so that you have one
indirection more which wraps the CCP and PSP dependency.

But that seems unnecessary especially since we already have

config CRYPTO_DEV_SP_PSP
        bool "Platform Security Processor (PSP) device"
        default y
        depends on CRYPTO_DEV_CCP_DD && X86_64

so CRYPTO_DEV_SP_PSP already depends on CRYPTO_DEV_CCP_DD!

So why should KVM_AMD_SEV depend on CRYPTO_DEV_CCP_DD too?!? Do you
catch my drift?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
