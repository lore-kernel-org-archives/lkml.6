Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E27DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C7A2400A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C7A2400A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeGFNhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:37:22 -0400
Received: from foss.arm.com ([217.140.101.70]:36908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932851AbeGFNhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:37:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A455ED1;
        Fri,  6 Jul 2018 06:37:19 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DEDD83F5BA;
        Fri,  6 Jul 2018 06:37:18 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6BF101AE3105; Fri,  6 Jul 2018 14:37:59 +0100 (BST)
Date:   Fri, 6 Jul 2018 14:37:59 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
Message-ID: <20180706133758.GB11172@arm.com>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org>
 <20180704170655.GD8370@arm.com>
 <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
 <20180705094313.GL28220@linaro.org>
 <ec1a5f0f-99e3-fda1-9a64-5c2539817190@arm.com>
 <20180705164824.GA7445@arm.com>
 <CAKv+Gu-c0wcscUZzRqOTAHg-L70jFf80T=7x6pVPe7iK8-wykw@mail.gmail.com>
 <20180706004226.GO28220@linaro.org>
 <20180706013311.GP28220@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706013311.GP28220@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On Fri, Jul 06, 2018 at 10:33:13AM +0900, AKASHI Takahiro wrote:
> On Fri, Jul 06, 2018 at 09:42:28AM +0900, AKASHI Takahiro wrote:
> > I almost believed that my patch#2 was just a preparatory one for patch#3
> > where arm_enable_runtime_services() is moved aggressively forward.
> > But acpi_os_ioremap() is not a __init function and I can now agree to
> > keeping patch#2.
> > 
> > Meanwhile, the consequent code with Ard's patch would look like:
> > ---8<---
> > static int __init arm_enable_runtime_services(void)
> > {
> >         ...
> >         efi_memmap_unmap();
> > 
> >         mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> > 
> >         if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> >                 pr_err("Failed to remap EFI memory map\n");
> >                 return 0;
> >         }
> >         ...
> > }
> > --->8---
> > It seems to me that it makes no sense.
> 
> Oops, it does. Comments at efi_memmap_init_late() say:
> ---8<---
>  * The reason there are two EFI memmap initialisation
>  * (efi_memmap_init_early() and this late version) is because the
>  * early EFI memmap should be explicitly unmapped once EFI
>  * initialisation is complete as the fixmap space used to map the EFI
>  * memmap (via early_memremap()) is a scarce resource.
> --->8---
> 
> > Is it okay to take them out?
> 
> Never mind.

I'm struggling with your monologue...

Please can you send a v3 of the series, containing the patches that you
think are necessary, along with the Acks you've collected?

Thanks,

Will
