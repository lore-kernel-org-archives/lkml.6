Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CD2C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAA8205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAA8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030722AbeFSTpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:45:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:49162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030604AbeFSTn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:43:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B5CA7ABDF;
        Tue, 19 Jun 2018 19:43:56 +0000 (UTC)
Date:   Tue, 19 Jun 2018 21:43:50 +0200
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
Message-ID: <20180619194350.GG31750@zn.tnic>
References: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com>
 <20180523144621.GB25143@pd.tnic>
 <CAFLxGvyxHU_Xahwdf=0TYx8Nems78TLioLZGGLTkxNGCgxT4Dg@mail.gmail.com>
 <4f565a11-9e99-b861-06d2-b42922e44c7a@amd.com>
 <20180619094658.GB31750@zn.tnic>
 <3953c12f-c2fe-5d1d-bee2-ac9a230300b8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3953c12f-c2fe-5d1d-bee2-ac9a230300b8@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:22:53PM -0500, Brijesh Singh wrote:
> It would be nice to have a single depends. But the main issue is, PSP
> support is provided through the ccp driver (aka CRYPTO_DEV_CCP_DD).

And this sentence states also your dependency:

KVM_AMD_SEV <- PSP driver <- CCP driver

but what you do is jump over one layer

KVM_AMD_SEV <- PSP driver
KVM_AMD_SEV <- CCP driver
PSP driver <- CCP driver

Do you see the difference and how the former is much easier to express
as a dependency vs the latter? And thus a lot more robust when it comes to
random configs.

> Hence KVM_AMD_SEV need to have some level of dependency with ccp
> driver. This is to ensure that the ccp was 'y' when kvm-amd=y for SEV
> to work.

If that is so, then your dependencies are wrong. KVM doesn't care about
CCP driver - it only cares about the PSP driver which gives the SEV API
it can call. That's it. If you have to make it depend on CCP, then the
design of what depends on what is wrong.

> I am sorry but I am not able to follow you on how creating a separate CRYPTO
> .config item will solve this problem. Creating a separate config will be
> useful if we are okay with calling 'select' from kvm (i.e if kvm-amd is 'y'
> then all the symbols from crypto will be 'y').

This is just an example of what you could do.

> I looked at other drivers where they have similar situation and it seems
> like solution is same as what I have used above.

Copying how the others do it is just not good enough - especially since
people can create broken configs currently.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
