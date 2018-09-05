Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D2C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D522075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D522075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIEWYi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:24:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:21722 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeIEWYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:24:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 10:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="83315994"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga002.fm.intel.com with ESMTP; 05 Sep 2018 10:53:23 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 5 Sep 2018 10:53:22 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.139]) with mapi id 14.03.0319.002;
 Wed, 5 Sep 2018 10:53:22 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>
Subject: RE: [PATCH V3 3/5] x86/efi: Permanently save the EFI_MEMORY_MAP
 passed by the firmware
Thread-Topic: [PATCH V3 3/5] x86/efi: Permanently save the EFI_MEMORY_MAP
 passed by the firmware
Thread-Index: AQHURJyf1WeGTnU9cEeZIow9NYkj4KTiE9aAgAAIFYCAAAH+AIAAAJ8A///NBfA=
Date:   Wed, 5 Sep 2018 17:53:22 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485B9A69@ORSMSX114.amr.corp.intel.com>
References: <1536099149-12564-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536099149-12564-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu9mfWYww49OmBETutSsaTDfE6VFJjbf+LWAoXF=mNmDBA@mail.gmail.com>
 <20180905125645.GX24082@hirez.programming.kicks-ass.net>
 <CAKv+Gu_DC=+7_YmDGGJ9fYJkGSNbUK-eXOAGMuZ2B7XXPWvZ9g@mail.gmail.com>
 <alpine.DEB.2.21.1809051505030.1416@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809051505030.1416@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDM0OTRlMTAtNWE4OC00OTljLTlhNzctMDkzNDM2NmYzNGY4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVG1idFNBVW42MEtZVWNlVnJPNk9DeEJlYUVBSlhDdzBSRWZHWmR3bW1ha3pKYkFaeDFVaktOcnpIZzhoNFVuZSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 5 Sep 2018, Ard Biesheuvel wrote:
> > On 5 September 2018 at 14:56, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Wed, Sep 05, 2018 at 02:27:49PM +0200, Ard Biesheuvel wrote:
> > >> Would we still need to preserve the old memory map in that case?
> > >
> > > I thought the reason for having this was being able to know the
> > > fault is in an EFI area. But of course, I'm not wel versed in this
> > > whole EFI crapola.
> >
> > I'm not entirely sure whether that really matters. The EFI services
> > access the stack and can access byref/pointer arguments which are not
> > covered by the EFI memory map as runtime services code/data, and so
> > they can trigger page faults by running off the vmapped stack or
> > writing to const byref arguments.
> >
> > EFI runtime services using boot services regions after they are no
> > longer available are a known source of headaches, but I don't see why
> > we should restrict ourselves to such cases if we bother to wire up
> > fault handling specifically for EFI services calls.
> >
> > So any page or permission fault occurring in the context of a EFI
> > runtime services invocation should be treated the same, I think.
> 
> I agree. Keep it simple. If the EFI crap fails, then assist with the reboot and
> otherwise just kill it.

The reasons for saving old memory map are
(in my view, these are the less important ones because they are very unlikely to happen)

1. Make sure that a memory descriptor exists for the physical address that was 
faulted on (EFI Memory Map could sometime have holes). Assuming a case that the 
physical address that caused page fault doesn't have a valid efi memory descriptor, the 
efi page fault handler shouldn't take any action because it hasn't triaged the problem yet.

2. Make sure that the faulted physical address is _not_ efi runtime service code/data region.
Efi runtime service code/data regions are always mapped by kernel in efi_pgd and accesses 
to these regions should _never_ page fault. Assuming that something like this happens, 
efi page fault handler shouldn't take any action because it's not any illegal access by firmware 
but it's a kernel bug.

Generally, the above two scenarios should never happen. I am just being paranoid and wanted 
to make sure that the efi page fault handler is fixing the right firmware bug that I came across 
and not something else. I also agree that, we could make the patch set and efi page fault handler 
much simpler by not saving old memory map. So, I am OK if we are not checking for the above 
two scenarios. If they are really needed, we could add them later.

That said, a more important reason (in my view) is to print out the memory descriptor that 
we faulted on. This is a *proof* showing that it's buggy firmware that caused page fault and 
hence is not a kernel bug. This proof is important because whenever a stack trace is printed 
with some efi function, kernel is the usual suspect and hence we need to show that it's not 
kernel fault. It could also help firmware engineers to fix the bug easily.

dmesg would show something like this when buggy efi_reset_system() accesses reserved region:

[  296.141511] efi: EFI Memory Descriptor for offending PA is:
[  296.141844] efi: [Reserved           |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007e915000-0x000000007e933fff] (0MB)
[  296.142522] efi: efi_reset_system() buggy! Reboot through BIOS

So, I would be concerned if we miss this proof.

Regards,
Sai
