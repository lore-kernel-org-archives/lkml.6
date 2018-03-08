Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934345AbeCHEWp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:22:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:14609 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933471AbeCHEWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:22:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,439,1515484800";
   d="scan'208";a="35526283"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Lee@vger.kernel.org" <Lee@vger.kernel.org>, Chun-Yi <jlee@suse.com>,
        Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
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
Thread-Index: AQHTtNngYFyf2e7B30yWdA6aWmV0oqPFMqUAgACLVvA=
Date: Thu, 8 Mar 2018 04:22:40 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E5817F2@ORSMSX114.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <CANiq72m6_WCXSrBPesgvO1rsF1_AT5Jod_rY-y1f4JjO-SMCDg@mail.gmail.com>
In-Reply-To: <CANiq72m6_WCXSrBPesgvO1rsF1_AT5Jod_rY-y1f4JjO-SMCDg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2Y3NGUzODctOWUzOS00ODE3LWFlYzUtYThiNmVlNDEyY2Y5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJpejJPWmJMUGM3UE81cUkzWTJpN3hMcndSTlQxUytBMWJnYStYN1BOZjk5YjRGcXQ3Z0R5M2dGcVZLWmR2ZktIIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w284MmDE028528

> > +struct workqueue_struct *efi_rts_wq;
> > +
> >  static bool disable_runtime;
> >  static int __init setup_noefi(char *arg)  { @@ -329,6 +331,19 @@
> > static int __init efisubsys_init(void)
> >                 return 0;
> >
> >         /*
> > +        * Since we process only one efi_runtime_service() at a time, an
> > +        * ordered workqueue (which creates only one execution context)
> > +        * should suffice all our needs.
> > +        */
> > +       efi_rts_wq = alloc_ordered_workqueue("efi_rts_workqueue", 0);
> 
> efi_rts_wq or efi_rts_workqueue?
> 
> > +       if (!efi_rts_wq) {
> > +               pr_err("Failed to create efi_rts_workqueue, EFI runtime services "
> 
> Same here.

Sure! I will make it consistent with "efi_rts_wq". Just tried to be more verbose
with names :)

[...]

> > +#define efi_queue_work(_rts, _arg1, _arg2, _arg3, _arg4, _arg5)                \
> > +({                                                                     \
> > +       struct efi_runtime_work efi_rts_work;                           \
> > +                                                                       \
> > +       INIT_WORK_ONSTACK(&efi_rts_work.work, efi_call_rts);            \
> > +       efi_rts_work.func = _rts;                                       \
> > +       efi_rts_work.arg1 = _arg1;                                      \
> > +       efi_rts_work.arg2 = _arg2;                                      \
> > +       efi_rts_work.arg3 = _arg3;                                      \
> > +       efi_rts_work.arg4 = _arg4;                                      \
> > +       efi_rts_work.arg5 = _arg5;                                      \
> > +       /*                                                              \
> > +        * queue_work() returns 0 if work was already on queue,         \
> > +        * _ideally_ this should never happen.                          \
> > +        */                                                             \
> > +       if (queue_work(efi_rts_wq, &efi_rts_work.work))                 \
> > +               flush_work(&efi_rts_work.work);                         \
> > +       else                                                            \
> > +               BUG();                                                  \
> 
> Thanks for the change! One remark, I would just do:

Sorry! but I am planning to remove BUG(). Looks like it could defeat the purpose
of patch. Please see Boris comments on the other thread.

[...]

> > +/*
> > + * efi_runtime_work:   Details of EFI Runtime Service work
> > + * @func:              EFI Runtime Service function identifier
> > + * @arg<1-5>:          EFI Runtime Service function arguments
> > + * @status:            Status of executing EFI Runtime Service
> > + */
> > +struct efi_runtime_work {
> > +       u8 func;
> > +       void *arg1;
> > +       void *arg2;
> > +       void *arg3;
> > +       void *arg4;
> > +       void *arg5;
> > +       efi_status_t status;
> > +       struct work_struct work;
> > +};
> 
> Why is efi_runtime_work in the .h at all?
> 

Thanks for the catch. I will move it to runtime-wrappers.c file and will make it
static too. It isn't being used in any other place.

> Please CC me for the next version! :-)

Sure! Sorry for that. I should have done in V2.

Regards,
Sai
