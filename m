Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB76DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECF3205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECF3205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966597AbeFSP1b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:27:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52430 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966230AbeFSP1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:27:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44C1E80D;
        Tue, 19 Jun 2018 08:27:30 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 13FF93F557;
        Tue, 19 Jun 2018 08:27:30 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B2D6E1AE3797; Tue, 19 Jun 2018 16:28:05 +0100 (BST)
Date:   Tue, 19 Jun 2018 16:28:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     YaoJun <yaojun8558363@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: mm: mark tramp_pg_dir read-only
Message-ID: <20180619152805.GN13984@arm.com>
References: <20180530044806.18449-1-yaojun8558363@gmail.com>
 <20180530091457.GB2452@arm.com>
 <CAKv+Gu8Zc7eQbG-Ww51GXUCEmhe2J03vbq5vVdyaKra-s13KrA@mail.gmail.com>
 <20180619152035.GM13984@arm.com>
 <CAKv+Gu-Mad64U63jjuKGjhg=h2wdoEKm2vywzATBYr-t_UY_bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-Mad64U63jjuKGjhg=h2wdoEKm2vywzATBYr-t_UY_bQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 05:23:41PM +0200, Ard Biesheuvel wrote:
> On 19 June 2018 at 17:20, Will Deacon <will.deacon@arm.com> wrote:
> > Hi Ard,
> >
> > Sorry, I forgot to reply to this.
> >
> > On Wed, May 30, 2018 at 11:53:20AM +0200, Ard Biesheuvel wrote:
> >> On 30 May 2018 at 11:14, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Wed, May 30, 2018 at 12:48:06PM +0800, YaoJun wrote:
> >> >> To protect against KSMA(Kernel Space Mirroring Attack), make
> >> >> tramp_pg_dir read-only. The principle of KSMA is to insert a
> >> >> carefully constructed PGD entry into the translation table.
> >> >> The type of this entry is block, which maps the kernel text
> >> >> and its access permissions bits are 01. The user process can
> >> >> then modify kernel text directly through this mapping. In this
> >> >> way, an arbitrary write can be converted to multiple arbitrary
> >> >> writes.
> >> >>
> >> >> Signed-off-by: YaoJun <yaojun8558363@gmail.com>
> >> >> ---
> >> >>  arch/arm64/mm/mmu.c | 4 ++++
> >> >>  1 file changed, 4 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >> >> index 2dbb2c9f1ec1..ac4b22c7e435 100644
> >> >> --- a/arch/arm64/mm/mmu.c
> >> >> +++ b/arch/arm64/mm/mmu.c
> >> >> @@ -551,6 +551,10 @@ static int __init map_entry_trampoline(void)
> >> >>       __create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
> >> >>                            prot, pgd_pgtable_alloc, 0);
> >> >>
> >> >> +     update_mapping_prot(__pa_symbol(tramp_pg_dir),
> >> >> +                             (unsigned long)tramp_pg_dir,
> >> >> +                             PGD_SIZE, PAGE_KERNEL_RO);
> >> >
> >> > Hmm, I like the idea but is there a risk that the page table has been mapped
> >> > as part of a block entry, which we can't safely split at this point (i.e.
> >> > we'll run into one of the BUG_ONs in the mapping code)?
> >> >
> >>
> >> We'd need to create a separate segment for it initially so the mapping
> >> is already at the right granularity.
> >
> > Why do you think that's the case? I can't see anything that guarantees this
> > for the page table itself.
> >
> 
> We'd need to pass NO_BLOCK_MAPPINGS to map_kernel_segment(),
> obviously, but that shouldn't hurt since that segment is relatively
> tiny anyway.

Ah right, with NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS, I agree that we're good.
Ideally, we'd move {idmap,swapper,tramp}_pg_dir into .rodata...

Will
