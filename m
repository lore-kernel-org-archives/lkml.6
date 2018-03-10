Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933896AbeCJAdk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 19:33:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:27284 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeCJAdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 19:33:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,448,1515484800";
   d="scan'208";a="181460767"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>, "Luck, Tony" <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Zijlstra, Peter" <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH V2 2/3] efi: Introduce efi_rts_workqueue and some
 infrastructure to invoke all efi_runtime_services()
Thread-Topic: [PATCH V2 2/3] efi: Introduce efi_rts_workqueue and some
 infrastructure to invoke all efi_runtime_services()
Thread-Index: AQHTtNngYFyf2e7B30yWdA6aWmV0oqPFNzYAgACKE+CAASj/gIAAOHqggAEohoCAAEk+AA==
Date: Sat, 10 Mar 2018 00:33:35 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E5821F9@ORSMSX114.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180307121047.GG23662@pd.tnic>
 <FFF73D592F13FD46B8700F0A279B802F2E5818E4@ORSMSX114.amr.corp.intel.com>
 <20180308140830.GE21166@pd.tnic>
 <FFF73D592F13FD46B8700F0A279B802F2E581D28@ORSMSX114.amr.corp.intel.com>
 <20180309111157.GC10753@pd.tnic>
In-Reply-To: <20180309111157.GC10753@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzliN2JlYjAtZWQ1NC00Y2IxLWEwZDktZmE5ZWQxNzc3MmJjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJQdGNIQ05JNjRib1ZMOFMySjNsYmxnOVd0bHl4cURTRkRrXC9BNmVxNmxvdVhGVlJVVFppKzBUYjhWcEwraURnRCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2A0XjmK007848

> > That's true! AFAIK, we don't have any issues handling NMI while in efi_pgd.
> > We might have issues only when, we are already in efi_pgd, NMI comes
> > along
> 
> Can you trigger this? Or is it something hypothetical?
> 

AFAIK, it's hypothetical. I did try to trigger the issue, but failed [1].
Maybe, I need to have some more constraints [2].

[1] https://lkml.org/lkml/2017/8/23/715
[2] https://lkml.org/lkml/2017/8/25/469

> > and NMI handler tries to touch the regions that are not mapped in
> > efi_pgd
> 
> If it is not hypothetical, the NMI handler should learn to look at CR3 first and
> return if CR3 has the efi pgd.

This solution and it's variants were discussed here [1], [2] and for varied reasons 
the community had decided to go with "Everything EFI as kthread" approach [3] [4].

Although the discussions were off my understanding, the present issue I see is, 
(and also the motivation for me to do the patch is)
when a thread tries to execute any  efi_runtime_service() we switch to efi_pgd 
(which doesn't have user space mappings) and all other subsystems in kernel 
aren't aware of this switch. This looks like a perfect case for kthread.

Kthread by definition doesn’t have user space mappings and if we run efi_runtime_services()
in a kthread context and if any other subsystem tries to access user space mappings 
while in efi_kthread, it's terminally broken [5].

There were several issues Andy, Peter and Mark raised.
One such (hypothetical) case is accessing user space from the back of an interrupt (NMI).
Others include
1. Issue specific to ARM because it runs efi_runtime_services() with interrupts enabled [6]
2. Interrupt taken while mmap_sem() is held for write that tries to access user memory [7]
3. If EFI were to have IO memory mapped at a "user" address, perf could end up reading it [8]

[1] https://lkml.org/lkml/2017/8/15/757
[2] https://lkml.org/lkml/2017/8/16/487
[3] https://lkml.org/lkml/2017/8/21/573
[4] https://lkml.org/lkml/2017/8/16/540

[5] https://lkml.org/lkml/2017/8/17/667
[6] https://lkml.org/lkml/2017/8/16/176
[7] https://lkml.org/lkml/2017/8/17/667
[8] https://lkml.org/lkml/2017/8/21/427

Regards,
Sai
