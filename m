Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36500C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FED20845
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FED20845
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeHXUVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:21:00 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:41996 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:21:00 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1ftFDE-0005e5-0J; Fri, 24 Aug 2018 17:45:28 +0100
Message-ID: <1535129126.2902.36.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Roland Dreier <roland@purestorage.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        matt@codeblueprint.co.uk, bp@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, luto@kernel.org,
        ard.biesheuvel@linaro.org, bp@alien8.de, brgerst@gmail.com,
        davej@codemonkey.org.uk, dvlasenk@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        sai.praneeth.prakhya@intel.com, sds@tycho.nsa.gov,
        Thomas Gleixner <tglx@linutronix.de>, toshi.kani@hp.com,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Yazen.Ghannam@amd.com
Date:   Fri, 24 Aug 2018 17:45:26 +0100
In-Reply-To: <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
References: <20171215092305.994559179@linuxfoundation.org>
         <20171215092311.347628971@linuxfoundation.org>
         <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 17:48 -0700, Roland Dreier wrote:
> On Fri, Dec 15, 2017 at 2:20 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > This reverts commit 87e2bd898d3a79a8c609f183180adac47879a2a4 which is
> > commit edc3b9129cecd0f0857112136f5b8b1bc1d45918 upstream.
> > 
> > Turns there was too many other issues with this patch to make it viable
> > for the stable tree.
> 
> This was sort of a long time ago, but does anyone remember why this
> needed to be reverted from 4.4?

See
<https://lore.kernel.org/lkml/1512686629.18523.217.camel@codethink.co.uk/T/#u>.

Ben.

> The reason I ask is that without this, commit 02ff2769edbc /
> "x86/mm/pat: Make set_memory_np() L1TF safe" in 4.4.148 is broken.
> That patch has
> 
> -               set_pud(pud, __pud(cpa->pfn | _PAGE_PSE |
> -                                  massage_pgprot(pud_pgprot)));
> +               set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
> +                                  canon_pgprot(pud_pgprot))));
> 
> (and similarly for pmds) but pfn_pud() is operating on page frame
> numbers and __pud(cpa->pfn... in the old code is operating on physical
> addresses.
> 
> This is bad enough that 4.4.148 and all newer 4.4.y crash early in
> boot on some EFI systems that I have.
> 
> For now I am re-applying the "ensure cpa->pfn only contains page frame
> numbers" patch, ported on top of 4.4.151.
> 
>  - R.
> 
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
