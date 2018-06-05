Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeFEUPY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:15:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:42983 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752177AbeFEUPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:15:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,479,1520924400";
   d="scan'208";a="234922813"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: RE: [PATCH V5 3/3] efi: Use efi_rts_wq to invoke EFI Runtime
 Services
Thread-Topic: [PATCH V5 3/3] efi: Use efi_rts_wq to invoke EFI Runtime
 Services
Thread-Index: AQHT9vO3aszHxwLi40SgbqoO42tT1aRSh1CA//+QwMCAAH2gAP//jIRg
Date: Tue, 5 Jun 2018 20:15:20 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F3B818BE7@ORSMSX114.amr.corp.intel.com>
References: <1527560464-19466-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1527560464-19466-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_K3HsVoH0M7kFx12d8eGzdmAe-C06TnKek1xwsSFyStA@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F3B812DFC@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_Y3Lt1FpymS00AMD4ZJ3AFSV1m7ggxuRFCa4PROeX8XA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_Y3Lt1FpymS00AMD4ZJ3AFSV1m7ggxuRFCa4PROeX8XA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGMyNmNhMzktMjEyMS00NmRjLWEwMzUtOWY3ZGJmMDFjMDE1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVDFrWFNqcjhiVWpqbldYQUZhUkdYREVGZnVkUlVWSjVVaXcwR2FHRHpJV0g5cjlaM0FKd1VJYWxyY1loOGNqQyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w55KFUhj008484

> >> I noticed that -unsurprisingly- reboot no longer works with these changes.
> >>
> >> I will fix up the patch, and revert the efi_reset_system() change,
> >> both here and below.
> >
> > Could you please let me know what the bug is here? I am unable to see
> > it right away :( I have tested reboot on qemu x86_64 by passing
> > "reboot=efi" as command line arg and saw that reboot is working fine.
> >
> 
> My arm64 hangs at reboot or power off, unless i revert the ResetSystem() part.
>

That's interesting. Not sure how the behavior could be different between x86 and arm64.
Maybe worth debugging further?
As you said, reverting ResetSystem() part makes things work, we cannot suspect a 
buggy efi_reset_system() (I came across buggy efi_reset_system() implementations 
on some x86 systems).

> But given that it is both risky (relying on a kthread running a workqueue in the
> shutdown path) and unnecessary (ResetSystem() is not supposed to return, and is
> only called by the kernel when the whole system has already been torn down), I
> think the main reason is simply that there is no reason to add it.

Makes sense.
I think, before calling firmware ResetSystem() kernel has already shut down all other parts 
and hence as the control will not transfer back to kernel (other than ResetSystem() failure), 
we could safely assume that no kernel code would access user space while in 
efi_reset_system() and hence we don't need to take the work queue path.

Regards,
Sai
