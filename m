Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBC0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE852075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE852075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757091AbeFSJrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:47:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:45592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756535AbeFSJrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:47:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 99AFDAEE6;
        Tue, 19 Jun 2018 09:47:03 +0000 (UTC)
Date:   Tue, 19 Jun 2018 11:46:58 +0200
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
Message-ID: <20180619094658.GB31750@zn.tnic>
References: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com>
 <20180523144621.GB25143@pd.tnic>
 <CAFLxGvyxHU_Xahwdf=0TYx8Nems78TLioLZGGLTkxNGCgxT4Dg@mail.gmail.com>
 <4f565a11-9e99-b861-06d2-b42922e44c7a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f565a11-9e99-b861-06d2-b42922e44c7a@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 07:08:26AM -0500, Brijesh Singh wrote:
> I think depends should look like this:
> 
> config KVM_AMD_SEV
>     def_bool y
>     bool "AMD Secure Encrypted Virtualization (SEV) support"
>     depends KVM_AMD && X86_64
>     depends CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)

CRYPTO_DEV_CCP_DD - this still doesn't belong here. KVM_AMD_SEV doesn't
care about what kind of functionality the PSP needs to function and
select it - it should only depend on a single symbol.

Now, you can add a separate CRYPTO .config item which collects all
required functionality for SEV guests and have KVM_AMD_SEV depend
on that. Or a similar solution. But not have KVM_AMD_SEV poke into
CRYPTO...PSP dependencies because it doesn't need to know about it.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
