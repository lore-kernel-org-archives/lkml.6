Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeCFA4c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:56:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:41559 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCFA4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:56:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,429,1515484800";
   d="scan'208";a="31623467"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
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
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V2 3/3] efi: Use efi_rts_workqueue to invoke EFI Runtime
 Services
Thread-Topic: [PATCH V2 3/3] efi: Use efi_rts_workqueue to invoke EFI
 Runtime Services
Thread-Index: AQHTtNnh5quqBSHNNUqcUMMSoRcro6PC2hmA//9/D8A=
Date: Tue, 6 Mar 2018 00:56:27 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E580926@ORSMSX114.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAPcyv4ihj+5z8GS13MsRDOKiwhBDqA=YW3MiTh+OXS4x3Kf38Q@mail.gmail.com>
In-Reply-To: <CAPcyv4ihj+5z8GS13MsRDOKiwhBDqA=YW3MiTh+OXS4x3Kf38Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDk1M2E4NDEtODg1OS00OGEyLWFjZmYtYzg0ZDY1OWU4N2FkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJpSWVzSStpVFRsZnpJclh6MUhWZVdhbVNZN0UrTEtWdk5wcm15SXRXNlUwSGRIQlhBbVZnQ0xpQisxV3p6M2pXIn0=
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w260uaQ2028234

> > Presently, efi_runtime_services() are executed by firmware in process
> > context. To execute efi_runtime_service(), kernel switches the page
> > directory from swapper_pgd to efi_pgd. However, efi_pgd doesn't have
> > any user space mappings. A potential issue could be, for instance, an
> > NMI interrupt (like perf) trying to profile some user data while in efi_pgd.
> >
> > A solution for this issue could be to use kthread to run
> > efi_runtime_service(). When a user/kernel thread requests to execute
> > efi_runtime_service(), kernel off-loads this work to kthread which in
> > turn uses efi_pgd. Anything that tries to touch user space addresses
> > while in kthread is terminally broken. This patch adds support to efi
> > subsystem to handle all calls to efi_runtime_services() using a work
> > queue (which in turn uses kthread).
> >
> > Implementation summary:
> > -----------------------
> > 1. When user/kernel thread requests to execute efi_runtime_service(),
> > enqueue work to efi_rts_workqueue.
> > 2. Caller thread waits until the work is finished because it's
> > dependent on the return status of efi_runtime_service().
> >
> > Semantics to pack arguments in efi_runtime_work (has void pointers):
> > 1. If argument is a pointer (of any type), pass it as is.
> > 2. If argument is a value (of any type), address of the value is
> > passed.
> >
> > Introduce a handler function (called efi_call_rts()) that
> >         a. understands efi_runtime_work and
> >         b. invokes the appropriate efi_runtime_service() with the
> >         appropriate arguments
> >
> > Semantics followed by efi_call_rts() to understand efi_runtime_work:
> > 1. If argument was a pointer, recast it from void pointer to original
> > pointer type.
> > 2. If argument was a value, recast it from void pointer to original
> > pointer type and dereference it.
> >
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
> 
> Is there a place in the system reboot path where we can try to flush these
> asynchronous pstore writes from interrupt context?

I don't think so because, the issue is not with the pstore writes but with pstore
using efi as backing store. Anything could register as pstore backend, eg: RAM,
ACPI-ERST etc.. and AFAIK, they don’t use work queues to store logs. Now that
efi_runtime_services() uses work queues, we unfortunately have to have this hack.

> It seems unfortunate that
> we need to have this wide exception for all
> set_variable() calls.

True, basically any efi_runtime_service() that might get called in interrupt context.
I am not very happy to have the hack too, but didn’t find other way.

Either that or switch to an explicit "emergency mode" where
> we stop caring about protecting the system from EFI runtime code because
> we're already crashing.

Should we care about extra warning (scheduling while in atomic) when we are already
crashing? This sounds kind of debatable. I will wait for feedback from community it they
think it's OK or maybe a better solution.

Regards,
Sai
