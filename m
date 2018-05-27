Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033021AbeE0Prv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:47:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:33051 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032815AbeE0Pra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:47:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="54347861"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Will Deacon" <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Naresh Bhat" <naresh.bhat@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: RE: [PATCH V4 0/3] Use efi_rts_wq to invoke EFI Runtime Services
Thread-Topic: [PATCH V4 0/3] Use efi_rts_wq to invoke EFI Runtime Services
Thread-Index: AQHT9HR8sSnhkv5o2EW6xj6m94heQKRBeVoA//+OqnCAAPsYgIABCbbwgACmjwD//4w5QIAAuUEA//+/I0A=
Date: Sun, 27 May 2018 15:47:23 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F3954D5DF@ORSMSX114.amr.corp.intel.com>
References: <1527285903-31799-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_oNUmOwTgM9sAsfMn4WgY+grC2f12vRC4HH9CgxxkfXQ@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F39481456@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_eShqmjkDSXnFs-_Hcay67+JTMdb6TatNZpV2v5_MoaQ@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F3952F0CF@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu96gURHioy7hRLW2reyUwYMQDSLHhGE=m_TOz9CYF_Tjw@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F39539372@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu9U5Ap37J-56=oDOuUfbcMyGaMnTZh1+JKHDTPU5pteZQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9U5Ap37J-56=oDOuUfbcMyGaMnTZh1+JKHDTPU5pteZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODFiOTE1ZTAtMWY1MC00MGEzLWExZWUtNjI4MDQzZDQxYTUwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaWN3ZVlkUXlWbktuQktQU1pxWXpEK0VtMXJ0Y2lEa1JhTzhLOXdYelNURWJFNWFMWk9vbGZMSXFYQStHMHpaVSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4RFmTVn011110

> > Another follow on question is, does every firmware support both
> > blocking and non-blocking variants (specially legacy EFI firmware)? I
> > am worried about this because, presently efi_delete_dummy_variable()
> > uses set_variable() and
> > query_variable_info() but if I change efi_delete_dummy_variable() to
> > use non-blocking variants and if they aren’t supported, then, I guess,
> > efi_delete_dummy_variable() might fail :(
> >
> > So, could you please clarify on that?
> >
> 
> I don't follow. Why should it make any difference to the firmware whether the
> OS routines blocks or gives up? We always honor the mutual exclusion between
> different invocations of runtime services, and the firmware itself has no
> awareness of the kind of scheduling the OS needs to do to ensure this.

Sorry! my bad.. I thought firmware (with EFI System table revision > 2.0 ) offers two 
types of efi run time services, a blocking variant and a non-blocking variant. But, now I 
noticed in the spec that there is only set_variable() but _no_ set_variable_nonblocking(). 
Same with query_variable_info(). The same is also seen in runtime-wrappers.c file. 
Both the blocking and non-blocking variants call the same efi runtime service. I see that 
non-blocking() variants are just an additional feature (API) offered by OS.

Regards,
Sai
