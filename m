Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeCFAFg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:05:36 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45875 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbeCFAFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:05:34 -0500
X-Google-Smtp-Source: AG47ELtsY7xo/6HW7/C836WIlUd1a8gkJLA3s5kH60mj6L4GG54YkBV1HLaJR1hY91PVBTzYj+JisRXJ8Oe5B+pMlew=
MIME-Version: 1.0
In-Reply-To: <1520292190-5027-4-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com> <1520292190-5027-4-git-send-email-sai.praneeth.prakhya@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 5 Mar 2018 16:05:33 -0800
Message-ID: <CAPcyv4ihj+5z8GS13MsRDOKiwhBDqA=YW3MiTh+OXS4x3Kf38Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] efi: Use efi_rts_workqueue to invoke EFI Runtime Services
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 3:23 PM, Sai Praneeth Prakhya
<sai.praneeth.prakhya@intel.com> wrote:
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
>
> Presently, efi_runtime_services() are executed by firmware in process
> context. To execute efi_runtime_service(), kernel switches the page
> directory from swapper_pgd to efi_pgd. However, efi_pgd doesn't have any
> user space mappings. A potential issue could be, for instance, an NMI
> interrupt (like perf) trying to profile some user data while in efi_pgd.
>
> A solution for this issue could be to use kthread to run
> efi_runtime_service(). When a user/kernel thread requests to execute
> efi_runtime_service(), kernel off-loads this work to kthread which in
> turn uses efi_pgd. Anything that tries to touch user space addresses
> while in kthread is terminally broken. This patch adds support to efi
> subsystem to handle all calls to efi_runtime_services() using a work
> queue (which in turn uses kthread).
>
> Implementation summary:
> -----------------------
> 1. When user/kernel thread requests to execute efi_runtime_service(),
> enqueue work to efi_rts_workqueue.
> 2. Caller thread waits until the work is finished because it's dependent
> on the return status of efi_runtime_service().
>
> Semantics to pack arguments in efi_runtime_work (has void pointers):
> 1. If argument is a pointer (of any type), pass it as is.
> 2. If argument is a value (of any type), address of the value is
> passed.
>
> Introduce a handler function (called efi_call_rts()) that
>         a. understands efi_runtime_work and
>         b. invokes the appropriate efi_runtime_service() with the
>         appropriate arguments
>
> Semantics followed by efi_call_rts() to understand efi_runtime_work:
> 1. If argument was a pointer, recast it from void pointer to original
> pointer type.
> 2. If argument was a value, recast it from void pointer to original
> pointer type and dereference it.
>
> pstore writes could potentially be invoked in interrupt context and it
> uses set_variable<>() and query_variable_info<>() to store logs. If we
> invoke efi_runtime_services() through efi_rts_wq while in atomic()
> kernel issues a warning ("scheduling wile in atomic") and prints stack
> trace. One way to overcome this is to not make the caller process wait
> for the worker thread to finish. This approach breaks pstore i.e. the
> log messages aren't written to efi variables. Hence, pstore calls
> efi_runtime_services() without using efi_rts_wq or in other words
> efi_rts_wq will be used unconditionally for all the
> efi_runtime_services() except set_variable<>() and
> query_variable_info<>()


Is there a place in the system reboot path where we can try to flush
these asynchronous pstore writes from interrupt context? It seems
unfortunate that we need to have this wide exception for all
set_variable() calls. Either that or switch to an explicit "emergency
mode" where we stop caring about protecting the system from EFI
runtime code because we're already crashing.
