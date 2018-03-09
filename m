Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbeCICiI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:38:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:8135 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750996AbeCICiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:38:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="23072150"
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
Thread-Index: AQHTtNngYFyf2e7B30yWdA6aWmV0oqPFNzYAgACKE+CAASj/gIAAOHqg
Date: Fri, 9 Mar 2018 02:37:59 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E581D28@ORSMSX114.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180307121047.GG23662@pd.tnic>
 <FFF73D592F13FD46B8700F0A279B802F2E5818E4@ORSMSX114.amr.corp.intel.com>
 <20180308140830.GE21166@pd.tnic>
In-Reply-To: <20180308140830.GE21166@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTg0YjNmZDQtZjlmYi00MmVlLTg4MDctODA5ZTA4OGJiOGM0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJcL3o4dGh5ZUtmXC9qMXE0YjlXRDF3UE1zajVkS0FMQzhzSlJmYmNvU2ZnZjJITmFQXC9ZdlpaRTVJaDhIdWNPU3JLIn0=
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w292cEku020960

> > Another warning by checkpatch is "use of in_atomic() in drivers code"
> 
> I'm assuming it warns because you're touching files in drivers/ but the efi fun is
> not really a driver...

True! That makes sense :)

> 
> But looking at patch 3, that thing looks like a real mess. Some of the things -
> pstore, it seems - do stuff in atomic context and yet you want to do efi stuff in a
> workqueue which doesn't stomach atomic context to begin with.
> 
> So if you wanna do workqueue, you should make sure all efi stuff gets delayed
> to process context and queued properly. For example, we log MCEs from atomic
> context by putting them on a lockless buffer and then kicking irq_work to queue
> the work when we return to process context.
> Can you do something like that?
> 

I think we can do this, it's is a good idea. I looked at this approach and saw that
in oops_end() function, part of arch/x86/kernel/dumpstack, between oops_exit()
and panic() (here we are not in atomic context, so, I think we can use work queues)
we could have something like efi_flush_buffer() which will flush the buffer and
queue the work to efi_rts_wq.

But, I guess, we have some downsides with this design:
1. We are doing this to have "no exceptions to use efi_rts_wq", but we will be making
the common case complicated. i.e. When a user requests to write some efi variable,
we will first write it to a buffer and then flush the buffer using efi_rts_wq. Instead, we
could have written the variable directly.
Maybe, you meant, we should use this buffer only while pstore and not during normal
case (which sounds reasonably OK).
2. It doesn't look rational that, when we are already going down, we schedule (because
we will be invoking efi_runtime_services() through work queue) to log some stuff.
Not, sure if that's happening in other parts of kernel or if it's OK to do that.

I will try the suggested approach and will keep this thread posted.

> "Hence, pstore calls efi_runtime_services() without using efi_rts_wq" - that
> doesn't sound like optimal design to me. I would try to shove them all through
> the workqueue - not have exceptions.
> 

Alternatively, instead of playing around with in_atomic(), we could have wrapper
functions like efi_write_var_non_wq() which will only be used by pstore. This function
will not use efi_rts_wq and directly invoke efi_runtime_service. Just an attempt to
make the code not look messy.

> Then this:
> 
> > A potential issue could be, for instance, an NMI interrupt (like perf)
> > trying to profile some user data while in efi_pgd.
> 
> I can't understand.
> 
> How did we handle this until now and why is it a problem all of a sudden?
> 
> Because I don't recall being unable to run perf while efi runtime services are
> happening.
> 

That's true! AFAIK, we don't have any issues handling NMI while in efi_pgd.
We might have issues only when, we are already in efi_pgd, NMI comes along
and NMI handler tries to touch the regions that are not mapped in efi_pgd
(Eg: User space part of process address space) and using kthread inherently
means that we will not have any user space.

Regards,
Sai
