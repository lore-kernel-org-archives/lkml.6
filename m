Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB733C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A70F24079
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bpk3/pj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A70F24079
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeGFBcE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:32:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36539 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753577AbeGFBcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:32:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id m19-v6so133233pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 18:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c66Od8CGoDB9moeh931ChC9WZuMnGl27XMLIV9GOk5g=;
        b=Bpk3/pj28oeEhV/kAkcAloH7sou/eUYkS8ip16Ter5qlvbYBr6VDaXgbXSUeatCoXN
         FlJVC8OwaTBjuNpSX6nrLovzY2BL3Tqx8m7/ush6IQN5DH0UNeg3/mjBXaabsd1wrvc5
         1DzJ5ggK1at5+m0llgS9V5Z5HNFc1GwxIRD4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=c66Od8CGoDB9moeh931ChC9WZuMnGl27XMLIV9GOk5g=;
        b=hlChonVs/IVg+OA+O0T9CTaVStq9zCyZibZ2R91GYWH9iaVhRaSlNB2mjVsgYWbNm2
         q+5fAHS9eKA1W1sGVHa2hjxvy74zfkfF0qSAcbcdntDH5+pW1j1pPmhtmIAfNeT+Hjur
         QcNFUl8IImnhpx5+gO7YD0kxMmAaO6qGL3DIfYhYWyZ0k5SHV7sc6sfll1xrV7Cd+N9W
         QeC8Px/0MRfpG14bOOlL3rzv/FdpVaICIW0+oAqNqqysXT/vFVbLpVOR2dw0oj9aJjaM
         rJ7RDxbEXPMI6as+LLFmlVHNxIbjJ1jCLYpQW+wIal9Kt6to+VYXC1UZWDvgqO1mswGY
         8LlA==
X-Gm-Message-State: APt69E3N1puqYWobUAU/IiCWJtNBjlR11Nr8Vg6644e9UW0wNCkLi8HL
        FEL188H0bQAR6CfzHyHi9TOFDw==
X-Google-Smtp-Source: AAOMgpc59pqH2nIceRKbSyJVWl+RQ/qHd5KeEz7+3D1WryXQkqHR0GRtgIlhori9n1hwVJGPWCcEQA==
X-Received: by 2002:a62:2253:: with SMTP id i80-v6mr8546339pfi.11.1530840721462;
        Thu, 05 Jul 2018 18:32:01 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id p26-v6sm15194609pfi.164.2018.07.05.18.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 18:32:00 -0700 (PDT)
Date:   Fri, 6 Jul 2018 10:33:13 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20180706013311.GP28220@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org>
 <20180704170655.GD8370@arm.com>
 <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
 <20180705094313.GL28220@linaro.org>
 <ec1a5f0f-99e3-fda1-9a64-5c2539817190@arm.com>
 <20180705164824.GA7445@arm.com>
 <CAKv+Gu-c0wcscUZzRqOTAHg-L70jFf80T=7x6pVPe7iK8-wykw@mail.gmail.com>
 <20180706004226.GO28220@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706004226.GO28220@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 09:42:28AM +0900, AKASHI Takahiro wrote:
> On Fri, Jul 06, 2018 at 12:31:49AM +0200, Ard Biesheuvel wrote:
> > On 5 July 2018 at 18:48, Will Deacon <will.deacon@arm.com> wrote:
> > > On Thu, Jul 05, 2018 at 12:02:15PM +0100, James Morse wrote:
> > >> On 05/07/18 10:43, AKASHI Takahiro wrote:
> > >> > On Wed, Jul 04, 2018 at 08:49:32PM +0200, Ard Biesheuvel wrote:
> > >> >> On 4 July 2018 at 19:06, Will Deacon <will.deacon@arm.com> wrote:
> > >> >>> On Tue, Jun 19, 2018 at 03:44:23PM +0900, AKASHI Takahiro wrote:
> > >> >>>> Since arm_enter_runtime_services() was modified to always create a virtual
> > >> >>>> mapping of UEFI memory map in the previous patch, it is now renamed to
> > >> >>>> efi_enter_virtual_mode() and called earlier before acpi_load_tables()
> > >> >>>> in acpi_early_init().
> > >> >>>>
> > >> >>>> This will allow us to use UEFI memory map in acpi_os_ioremap() to create
> > >> >>>> mappings of ACPI tables using memory attributes described in UEFI memory
> > >> >>>> map.
> > >>
> > >> >>> Hmm, this is ugly as hell. Is there nothing else we can piggy-back off?
> > >> >>> It's also fairly jarring that, on x86, efi_enter_virtual_mode() is called
> > >> >>> a few lines later, *after* acpi_early_init() has been called.
> > >>
> > >> >> Currently, there is a gap where we have already torn down the early
> > >> >> mapping and haven't created the definitive mapping of the UEFI memory
> > >> >> map. There are other reasons why this is an issue, and I recently
> > >> >> proposed [0] myself to address one of them
> > >>
> > >> >> Akashi-san, could you please confirm whether the patch below would be
> > >> >> sufficient for you? Apologies for going back and forth on this, but I
> > >> >> agree with Will that we should try to avoid warts like the one above
> > >> >> in generic code.
> > >> >>
> > >> >> [0] https://marc.info/?l=linux-efi&m=152930773507524&w=2
> > >> >
> > >> > I think that this patch will also work.
> > >> > Please drop my patch#2 and #3 if you want to pick up my patchset, Will.
> > >>
> > >> Patch 2 is what changes arm_enable_runtime_services() to map the efi memory map
> > >> before bailing out due to efi=noruntime.
> > >>
> > >> Without it, 'efi=noruntime' means no-acpi-tables.
> > >
> > > So it sounds like we want patch 2. Akashi, given that this series is only
> > > four patches, please can you send out a v3 with the stuff that should be
> > > reviewed and merged? Otherwise, there's a real risk we end up with breakage
> > > that goes unnoticed initially.
> > >
> > 
> > Yes, we want patches #1, #2 and #4, and this one can be replaced with
> > my patch above. Everything can be taken via the arm64 tree as far as I
> > am concerned.
> 
> I almost believed that my patch#2 was just a preparatory one for patch#3
> where arm_enable_runtime_services() is moved aggressively forward.
> But acpi_os_ioremap() is not a __init function and I can now agree to
> keeping patch#2.
> 
> Meanwhile, the consequent code with Ard's patch would look like:
> ---8<---
> static int __init arm_enable_runtime_services(void)
> {
>         ...
>         efi_memmap_unmap();
> 
>         mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> 
>         if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
>                 pr_err("Failed to remap EFI memory map\n");
>                 return 0;
>         }
>         ...
> }
> --->8---
> It seems to me that it makes no sense.

Oops, it does. Comments at efi_memmap_init_late() say:
---8<---
 * The reason there are two EFI memmap initialisation
 * (efi_memmap_init_early() and this late version) is because the
 * early EFI memmap should be explicitly unmapped once EFI
 * initialisation is complete as the fixmap space used to map the EFI
 * memmap (via early_memremap()) is a scarce resource.
--->8---

> Is it okay to take them out?

Never mind.
> 
> -Takahiro AKASHI
