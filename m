Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966561AbeCHF3c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 00:29:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:54731 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935560AbeCHFG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,439,1515484800";
   d="scan'208";a="26189232"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
CC: Mark Rutland <mark.rutland@arm.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lee@lakrids.cambridge.arm.com" <Lee@lakrids.cambridge.arm.com>,
        Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Zijlstra, Peter" <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V2 3/3] efi: Use efi_rts_workqueue to invoke EFI Runtime
 Services
Thread-Topic: [PATCH V2 3/3] efi: Use efi_rts_workqueue to invoke EFI
 Runtime Services
Thread-Index: AQHTtNnh5quqBSHNNUqcUMMSoRcro6PDmEOAgAIiL1CAAI8OgP//eyXg
Date: Thu, 8 Mar 2018 05:06:54 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E581824@ORSMSX114.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180306112610.7izxtuy33bt7ivfs@lakrids.cambridge.arm.com>
 <FFF73D592F13FD46B8700F0A279B802F2E5817CE@ORSMSX114.amr.corp.intel.com>
 <CAPcyv4jL-Js14GEWe26E4wQSYnQtk_oXCv_RQwr6DvC2wFVNPQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jL-Js14GEWe26E4wQSYnQtk_oXCv_RQwr6DvC2wFVNPQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDJkOTY2NzItNDQ5OS00NDk3LThmODgtNzFjY2FlZTNkNmVkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJ5NlZ4d3FmUVFueDB1XC9lamVOYVgrR1dBOTFDQU5RZCtmNjNoWE1yVWljWHdxVjh2VGp3K1huOUFDTFh1RXRGdCJ9
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w285Tpn7013098

> >> > pstore writes could potentially be invoked in interrupt context and
> >> > it uses set_variable<>() and query_variable_info<>() to store logs.
> >> > If we invoke efi_runtime_services() through efi_rts_wq while in
> >> > atomic() kernel issues a warning ("scheduling wile in atomic") and
> >> > prints stack trace. One way to overcome this is to not make the
> >> > caller process wait for the worker thread to finish. This approach
> >> > breaks pstore i.e. the log messages aren't written to efi
> >> > variables. Hence, pstore calls
> >> > efi_runtime_services() without using efi_rts_wq or in other words
> >> > efi_rts_wq will be used unconditionally for all the
> >> > efi_runtime_services() except set_variable<>() and
> >> > query_variable_info<>()
> >>
> >> Can't NMIs still come in during this?
> >>
> >> ... or do we assume that since something has already gone wrong, this
> >> doesn't matter?
> >>
> >
> > I think they can come. AFAIK, pstore (if enabled) runs only when we crashed.
> > Since, we are still executing stuff to log messages and NMI's can't be
> > masked, there is still a possibility for NMI's to occur (please correct me if I am
> wrong).
> > But, as you said earlier, I guess it doesn't matter because anyways we are
> going down.
> 
> The problem is that we are not always in a "already going down"
> condition for typical set_variable and query_variable_info calls.

That's correct.

> So are we actually fixing anything with this patchset?

When we are _not_ in interrupt context (eg: process context)
we still use efi_rts_wq to invoke *all* efi_runtime_services().
This solves *someone trying to access user space* while in EFI runtime services
mapping problem. A instance could be, some user space process requests us to
execute efi_runtime_service(), so, kernel switches to efi_pgd (which doesn’t have
user space part of process address space) and while executing efi_runtime_service()
perf NMI comes along to profile user data.

> In other words if the NMI vs EFI
> mapping problem requires the workqueue context then we can't have any EFI
> calls outside of that context.  Am I missing how this scheme addresses that
> problem?

I think so, because, we are not trying to solve NMI vs EFI Runtime Service mappings.
AFAIK, they both work together (for x86_64). The problem is, as stated above,
"someone trying to access user space while executing EFI runtime services".
The problem exists because EFI runtime services mappings don’t have user space
part of process address space.

I think the problem still persists when we are already in interrupt context and then
we were requested to execute some efi_runtime_service() and then NMI happens
and that NMI handler touches user space.

Please let me know if my explanation didn’t make sense or if I misunderstood
your question.

Ard and Matt, please correct me if I stated something that is incorrect.
