Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F745C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 19:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59A624CD8
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 19:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59A624CD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lebenslange-mailadresse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeFWTSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 15:18:34 -0400
Received: from mx01.toppoint.de ([217.70.197.24]:42886 "EHLO mx01.toppoint.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeFWTSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 15:18:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mx01.toppoint.de (Postfix) with ESMTP id 54DD480339;
        Sat, 23 Jun 2018 21:18:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx01.toppoint.de 54DD480339
X-Virus-Scanned: Debian amavisd-new at mx01.toppoint.de
Received: from mx01.toppoint.de ([127.0.0.1])
        by localhost (mx01.toppoint.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4U7sEzE-E8Rd; Sat, 23 Jun 2018 21:18:29 +0200 (CEST)
Received: from chaos.in-kiel.de (chaos.in-kiel.de [217.70.197.123])
        by mx01.toppoint.de (Postfix) with ESMTPS;
        Sat, 23 Jun 2018 21:18:29 +0200 (CEST)
Received: from w by chaos.in-kiel.de with local (Exim 4.91)
        (envelope-from <w@chaos.in-kiel.de>)
        id 1fWo3J-0004HF-2b; Sat, 23 Jun 2018 21:18:29 +0200
Date:   Sat, 23 Jun 2018 21:18:28 +0200
From:   Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] make radeon driver find ATOM BIOS again on 64-bit EFI
 systems
Message-ID: <20180623191828.i7hrhgebiwcn6nh7@chaos.in-kiel.de>
References: <20180623174258.GA15904@chaos.in-kiel.de>
 <CAKv+Gu8yA1L6P=W70gm1u_uuF9xJ+XVWeWB0MxC3Fur=_DeVmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8yA1L6P=W70gm1u_uuF9xJ+XVWeWB0MxC3Fur=_DeVmw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-message-flag: Get yourself a real email client. http://www.mutt.org/
X-Hai:  ___|\___\o/___
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sat, Jun 23, 2018 at 08:09:19PM +0200 schrieb Ard Biesheuvel:
> (+ Hans, who may be able to test this on 32-bit h/w)
> 
> On 23 June 2018 at 19:43, Wilfried Klaebe
> <linux-kernel@lebenslange-mailadresse.de> wrote:
> > make radeon driver find ATOM BIOS again on 64-bit EFI systems
> >
> > Commit 2c3625cb9fa2c477d5877a1819e29d6a902e5fef ("efi/x86: Fold
> > __setup_efi_pci32() and __setup_efi_pci64() into one function")
> > broke finding radeon's BIOS ROM on Apple MacBook Pro 8,2. Fix.
> >
> >
> > On my Apple MacBook Pro 8,2, Linux 4.18-rc1 was unable to locate a BIOS
> > ROM for the radeon GPU. Comparing Linux 4.17 and 4.18-rc1 dmesg:
> >
> >  radeon 0000:01:00.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x0000
> >  radeon 0000:01:00.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x0000
> > -ATOM BIOS: Apple
> > +[drm:radeon_get_bios [radeon]] *ERROR* Unable to locate a BIOS ROM
> >
> > Bisecting found 2c3625cb9fa2c477d5877a1819e29d6a902e5fef.
> >
> > Comparing the old __setup_efi_pci32 and __setup_efi_pci64, and looking
> > at what the new __setup_efi_pci does, I noticed that the first does
> >
> >         status = efi_early->call(pci->attributes, pci,
> >                                  EfiPciIoAttributeOperationGet, 0, 0,
> >                                  &attributes);
> >
> > while the second does
> >
> >         status = efi_early->call(pci->attributes, pci,
> >                                  EfiPciIoAttributeOperationGet, 0,
> >                                  &attributes);
> >
> > (note the difference of one "0, "), while the third has two occurences
> > of "0, " too in it's EfiPciIoAttributeOperationGet call construct.
> >
> > Testing confirmed my machine works as expected with the variant with
> > just one "0, "; I cannot test if this is true for other 64-bit EFI
> > machines or maybe even 32-bit EFI machines.
> >
> >
> > Signed-off-by: Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
> > Fixes: 2c3625cb9fa2 ("efi/x86: Fold __setup_efi_pci32() and __setup_efi_pci64() into one function")
> >
> 
> Hello Wilfried,
> 
> Thanks for tracking down this issue.
> 
> It seems the two 0s in the 32-bit version are there because the type
> of the argument is UINT64. So instead, I'd like to apply this change:
> 
> >         void *romimage;
> >
> >         status = efi_call_proto(efi_pci_io_protocol, attributes, pci,
> > -                               EfiPciIoAttributeOperationGet, 0, 0,
> > +                               EfiPciIoAttributeOperationGet, 0ULL,
> >                                 &attributes);
> >         if (status != EFI_SUCCESS)
> >
> 
> unless anyone objects?

Just compiled and booted that: works too. I therefore won't object.

Tested-by: Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>

Regards,
Wilfried
