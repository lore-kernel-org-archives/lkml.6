Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeFET3R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:29:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:9776 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbeFET3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:29:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,479,1520924400";
   d="scan'208";a="205574601"
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
Thread-Index: AQHT9vO3aszHxwLi40SgbqoO42tT1aRSh1CA//+QwMA=
Date: Tue, 5 Jun 2018 19:29:13 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F3B812DFC@ORSMSX114.amr.corp.intel.com>
References: <1527560464-19466-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1527560464-19466-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_K3HsVoH0M7kFx12d8eGzdmAe-C06TnKek1xwsSFyStA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_K3HsVoH0M7kFx12d8eGzdmAe-C06TnKek1xwsSFyStA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWQ5ZGUxZTAtMmZiYS00M2FjLTk2N2QtNDg4ODhiNDZiYjNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicjIyWFwvVHlGRzlVR0tNVVl0R0s3endIK2MyV3RLMVk4QVZSSFR4SmU2djlmVGNnQmlRYmxlUFNXRGNWb2RcL1V2In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w55JTNsq004751

> > +       case RESET_SYSTEM:
> > +               __efi_call_virt(reset_system, *(int *)arg1,
> > +                               *(efi_status_t *)arg2,
> > +                               *(unsigned long *)arg3,
> > +                               (efi_char16_t *)arg4);
> > +               break;
> 
> I noticed that -unsurprisingly- reboot no longer works with these changes.
> 
> I will fix up the patch, and revert the efi_reset_system() change, both here and
> below.

Could you please let me know what the bug is here? I am unable to see it right away :(
I have tested reboot on qemu x86_64 by passing "reboot=efi" as command line arg and 
saw that reboot is working fine.

> > @@ -340,7 +441,8 @@ static void virt_efi_reset_system(int reset_type,
> >                         "could not get exclusive access to the firmware\n");
> >                 return;
> >         }
> > -       __efi_call_virt(reset_system, reset_type, status, data_size, data);
> > +       efi_queue_work(RESET_SYSTEM, &reset_type, &status, &data_size, data,
> > +                      NULL);
> >         up(&efi_runtime_lock);
> >  }

Regards,
Sai
