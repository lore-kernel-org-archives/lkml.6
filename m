Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934090AbeCHEMF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:12:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:7105 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933426AbeCHEMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:12:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,439,1515484800";
   d="scan'208";a="36395054"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
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
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH V2 3/3] efi: Use efi_rts_workqueue to invoke EFI Runtime
 Services
Thread-Topic: [PATCH V2 3/3] efi: Use efi_rts_workqueue to invoke EFI
 Runtime Services
Thread-Index: AQHTtNnh5quqBSHNNUqcUMMSoRcro6PDmEOAgAIiL1A=
Date: Thu, 8 Mar 2018 04:11:59 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E5817CE@ORSMSX114.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180306112610.7izxtuy33bt7ivfs@lakrids.cambridge.arm.com>
In-Reply-To: <20180306112610.7izxtuy33bt7ivfs@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZThjZTk2MzItNjFlZi00NTBjLTk2NDEtNmE3MTZiMGE2OWMyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJTb3hPTDFTM3dWOGhSYUU2U3BLaVZFNVRpUlg4dVB4SndxN1dwWjROdjVqRGRcL0lidVJTXC9YeExwalROcFMxZEcifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05, 2018 at 03:23:10PM -0800, Sai Praneeth Prakhya wrote:
> > From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
> >
> > Presently, efi_runtime_services() are executed by firmware in process
> > context. To execute efi_runtime_service(), kernel switches the page
> > directory from swapper_pgd to efi_pgd. However, efi_pgd doesn't have
> > any user space mappings. A potential issue could be, for instance, an
> > NMI interrupt (like perf) trying to profile some user data while in efi_pgd.
> 
> It might be worth pointing out that this could result in disaster (e.g.
> if the frame pointer happens to point at MMIO in the EFI runtime services
> mappings).
> 

Sorry! I didn't get it. I would like to add this point, so could you please
explain it more?

> [...]
> 
> > pstore writes could potentially be invoked in interrupt context and it
> > uses set_variable<>() and query_variable_info<>() to store logs. If we
> > invoke efi_runtime_services() through efi_rts_wq while in atomic()
> > kernel issues a warning ("scheduling wile in atomic") and prints stack
> > trace. One way to overcome this is to not make the caller process wait
> > for the worker thread to finish. This approach breaks pstore i.e. the
> > log messages aren't written to efi variables. Hence, pstore calls
> > efi_runtime_services() without using efi_rts_wq or in other words
> > efi_rts_wq will be used unconditionally for all the
> > efi_runtime_services() except set_variable<>() and
> > query_variable_info<>()
> 
> Can't NMIs still come in during this?
> 
> ... or do we assume that since something has already gone wrong, this doesn't
> matter?
>

I think they can come. AFAIK, pstore (if enabled) runs only when we crashed.
Since, we are still executing stuff to log messages and NMI's can't be masked,
there is still a possibility for NMI's to occur (please correct me if I am wrong).
But, as you said earlier, I guess it doesn't matter because anyways we are going down.
 
> Otherwise, this doesn't seem to break basic stuff on arm64 platforms. I can boot
> up, read the EFI RTC, and reboot. I ahd lockdep and KASAN enabled, I received
> no splats from either.
> 
> FWIW:
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com [arm64]
> 
> Thanks,
> Mark.
