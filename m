Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936184AbeCHSGt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:06:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:45654 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932177AbeCHSGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:06:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="scan'208";a="22974177"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Will Deacon" <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Zijlstra, Peter" <peter.zijlstra@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH V2 1/3] x86/efi: Call efi_delete_dummy_variable() during
 efi subsystem initialization
Thread-Topic: [PATCH V2 1/3] x86/efi: Call efi_delete_dummy_variable()
 during efi subsystem initialization
Thread-Index: AQHTtNnft9Mxi3CHBU2aHJMBOcVcFKPGfq2A//+IQGA=
Date: Thu, 8 Mar 2018 18:06:45 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E581AD0@ORSMSX114.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-2-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_ZYGwgORet4ruL8=GUy75LMAuLeYD987FA3UVYuw8GMg@mail.gmail.com>
In-Reply-To: <CAKv+Gu_ZYGwgORet4ruL8=GUy75LMAuLeYD987FA3UVYuw8GMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTk3OGEwYTUtMGJkNC00OGM4LWE4YWItNzMxMTFjOGMwZjJjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJhK2tQd2Q2OHFUTXZ5QVNkMVlwenV5RzRMMUFpU2ZLSWt3eFJPaG1BWk1ZTDFKTEpSTzVSQ25RMTQ3a1RBc0dIIn0=
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28I6vW2032442

> >  void __init efi_enter_virtual_mode(void) diff --git
> > a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c index
> > cd42f66a7c85..838b8efe639c 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -328,6 +328,12 @@ static int __init efisubsys_init(void)
> >         if (!efi_enabled(EFI_BOOT))
> >                 return 0;
> >
> > +       /*
> > +        * Clean DUMMY object calls EFI Runtime Service, set_variable(), so
> > +        * it should be invoked only after efi_rts_workqueue is ready.
> > +        */
> > +       efi_delete_dummy_variable();
> > +
> 
> Is there any way to keep this local to arch/x86?
>

I think, we can definitely do that. I will retake a look at the possibilities
and will update this thread.

> >         /* We register the efi directory at /sys/firmware/efi */
> >         efi_kobj = kobject_create_and_add("efi", firmware_kobj);
> >         if (!efi_kobj) {
> > diff --git a/include/linux/efi.h b/include/linux/efi.h index
> > f5083aa72eae..c4efb3ef0dfa 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -992,6 +992,7 @@ extern efi_status_t efi_query_variable_store(u32
