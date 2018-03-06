Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753024AbeCFL0S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:26:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36868 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeCFL0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:26:17 -0500
Date: Tue, 6 Mar 2018 11:26:11 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee@lakrids.cambridge.arm.com, Chun-Yi <jlee@suse.com>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>, Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V2 3/3] efi: Use efi_rts_workqueue to invoke EFI Runtime
 Services
Message-ID: <20180306112610.7izxtuy33bt7ivfs@lakrids.cambridge.arm.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-4-git-send-email-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520292190-5027-4-git-send-email-sai.praneeth.prakhya@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 03:23:10PM -0800, Sai Praneeth Prakhya wrote:
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
> 
> Presently, efi_runtime_services() are executed by firmware in process
> context. To execute efi_runtime_service(), kernel switches the page
> directory from swapper_pgd to efi_pgd. However, efi_pgd doesn't have any
> user space mappings. A potential issue could be, for instance, an NMI
> interrupt (like perf) trying to profile some user data while in efi_pgd.

It might be worth pointing out that this could result in disaster (e.g.
if the frame pointer happens to point at MMIO in the EFI runtime
services mappings).

[...]

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

Can't NMIs still come in during this?

... or do we assume that since something has already gone wrong, this
doesn't matter?

Otherwise, this doesn't seem to break basic stuff on arm64 platforms. I
can boot up, read the EFI RTC, and reboot. I ahd lockdep and KASAN
enabled, I received no splats from either.

FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com [arm64]

Thanks,
Mark.
