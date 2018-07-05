Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2394C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58933240FB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58933240FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753607AbeGEQrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:47:46 -0400
Received: from foss.arm.com ([217.140.101.70]:53864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753325AbeGEQrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:47:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D90C87A9;
        Thu,  5 Jul 2018 09:47:44 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A8E4C3F5BA;
        Thu,  5 Jul 2018 09:47:44 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D79B61AE3105; Thu,  5 Jul 2018 17:48:24 +0100 (BST)
Date:   Thu, 5 Jul 2018 17:48:24 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     James Morse <james.morse@arm.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Message-ID: <20180705164824.GA7445@arm.com>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org>
 <20180704170655.GD8370@arm.com>
 <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
 <20180705094313.GL28220@linaro.org>
 <ec1a5f0f-99e3-fda1-9a64-5c2539817190@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec1a5f0f-99e3-fda1-9a64-5c2539817190@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 12:02:15PM +0100, James Morse wrote:
> On 05/07/18 10:43, AKASHI Takahiro wrote:
> > On Wed, Jul 04, 2018 at 08:49:32PM +0200, Ard Biesheuvel wrote:
> >> On 4 July 2018 at 19:06, Will Deacon <will.deacon@arm.com> wrote:
> >>> On Tue, Jun 19, 2018 at 03:44:23PM +0900, AKASHI Takahiro wrote:
> >>>> Since arm_enter_runtime_services() was modified to always create a virtual
> >>>> mapping of UEFI memory map in the previous patch, it is now renamed to
> >>>> efi_enter_virtual_mode() and called earlier before acpi_load_tables()
> >>>> in acpi_early_init().
> >>>>
> >>>> This will allow us to use UEFI memory map in acpi_os_ioremap() to create
> >>>> mappings of ACPI tables using memory attributes described in UEFI memory
> >>>> map.
> 
> >>> Hmm, this is ugly as hell. Is there nothing else we can piggy-back off?
> >>> It's also fairly jarring that, on x86, efi_enter_virtual_mode() is called
> >>> a few lines later, *after* acpi_early_init() has been called.
> 
> >> Currently, there is a gap where we have already torn down the early
> >> mapping and haven't created the definitive mapping of the UEFI memory
> >> map. There are other reasons why this is an issue, and I recently
> >> proposed [0] myself to address one of them
> 
> >> Akashi-san, could you please confirm whether the patch below would be
> >> sufficient for you? Apologies for going back and forth on this, but I
> >> agree with Will that we should try to avoid warts like the one above
> >> in generic code.
> >>
> >> [0] https://marc.info/?l=linux-efi&m=152930773507524&w=2
> > 
> > I think that this patch will also work.
> > Please drop my patch#2 and #3 if you want to pick up my patchset, Will.
> 
> Patch 2 is what changes arm_enable_runtime_services() to map the efi memory map
> before bailing out due to efi=noruntime.
> 
> Without it, 'efi=noruntime' means no-acpi-tables.

So it sounds like we want patch 2. Akashi, given that this series is only
four patches, please can you send out a v3 with the stuff that should be
reviewed and merged? Otherwise, there's a real risk we end up with breakage
that goes unnoticed initially.

Thanks,

Will
