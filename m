Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754830AbeCHEdH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:33:07 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42177 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754066AbeCHEdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:33:04 -0500
X-Google-Smtp-Source: AG47ELsXEa4dRp1J6t8l9nCx5qjQrco8v47MFu+fuB7eNUrhSLe926BtRRBvYtKEiUK3Tgu2h2ZppQCP3dLcTeWGu2s=
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F2E5817CE@ORSMSX114.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180306112610.7izxtuy33bt7ivfs@lakrids.cambridge.arm.com> <FFF73D592F13FD46B8700F0A279B802F2E5817CE@ORSMSX114.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 7 Mar 2018 20:33:03 -0800
Message-ID: <CAPcyv4jL-Js14GEWe26E4wQSYnQtk_oXCv_RQwr6DvC2wFVNPQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] efi: Use efi_rts_workqueue to invoke EFI Runtime Services
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 8:11 PM, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
> 05, 2018 at 03:23:10PM -0800, Sai Praneeth Prakhya wrote:
>> > From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
>> >
>> > Presently, efi_runtime_services() are executed by firmware in process
>> > context. To execute efi_runtime_service(), kernel switches the page
>> > directory from swapper_pgd to efi_pgd. However, efi_pgd doesn't have
>> > any user space mappings. A potential issue could be, for instance, an
>> > NMI interrupt (like perf) trying to profile some user data while in efi_pgd.
>>
>> It might be worth pointing out that this could result in disaster (e.g.
>> if the frame pointer happens to point at MMIO in the EFI runtime services
>> mappings).
>>
>
> Sorry! I didn't get it. I would like to add this point, so could you please
> explain it more?
>
>> [...]
>>
>> > pstore writes could potentially be invoked in interrupt context and it
>> > uses set_variable<>() and query_variable_info<>() to store logs. If we
>> > invoke efi_runtime_services() through efi_rts_wq while in atomic()
>> > kernel issues a warning ("scheduling wile in atomic") and prints stack
>> > trace. One way to overcome this is to not make the caller process wait
>> > for the worker thread to finish. This approach breaks pstore i.e. the
>> > log messages aren't written to efi variables. Hence, pstore calls
>> > efi_runtime_services() without using efi_rts_wq or in other words
>> > efi_rts_wq will be used unconditionally for all the
>> > efi_runtime_services() except set_variable<>() and
>> > query_variable_info<>()
>>
>> Can't NMIs still come in during this?
>>
>> ... or do we assume that since something has already gone wrong, this doesn't
>> matter?
>>
>
> I think they can come. AFAIK, pstore (if enabled) runs only when we crashed.
> Since, we are still executing stuff to log messages and NMI's can't be masked,
> there is still a possibility for NMI's to occur (please correct me if I am wrong).
> But, as you said earlier, I guess it doesn't matter because anyways we are going down.

The problem is that we are not always in a "already going down"
condition for typical set_variable and query_variable_info calls. So
are we actually fixing anything with this patchset? In other words if
the NMI vs EFI mapping problem requires the workqueue context then we
can't have any EFI calls outside of that context.  Am I missing how
this scheme addresses that problem?
