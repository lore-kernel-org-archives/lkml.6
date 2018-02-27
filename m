Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbeB0O24 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:28:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752573AbeB0O2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:28:54 -0500
Reply-To: jtoppins@redhat.com
Subject: Re: [PATCH] arm64/acpi: make ACPI boot preference configurable
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: prarit@redhat.com, Jon Masters <jcm@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        astone@redhat.com, James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
 <CAKv+Gu9FVD18v6WA8MMG5LFX9GPObq_79hFuYv6j+S98a5Ej6w@mail.gmail.com>
From: Jonathan Toppins <jtoppins@redhat.com>
Organization: Red Hat
Message-ID: <1454e833-e3b9-780b-c5db-a6f73e799352@redhat.com>
Date: Tue, 27 Feb 2018 09:28:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9FVD18v6WA8MMG5LFX9GPObq_79hFuYv6j+S98a5Ej6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 02:22 AM, Ard Biesheuvel wrote:
> Hi Jonathan,
> 
> On 27 February 2018 at 06:05, Jonathan Toppins <jtoppins@redhat.com> wrote:
>> This patch allows a user to configure ACPI to be preferred over
>> device-tree.
>>
> 
> This comes up once a year or so, and the consensus has been so far
> that it is not up to the kernel to reason about whether DT or ACPI
> should be preferred if both are supplied, Instead, it is up to the
> firmware to ensure that only one of those is provided, and we added a
> generic driver to EDK2 that implements this.

I am assuming EDK2 is some sort of firmware code base, not that I have
ever heard of it before. This logic compared with the implementation in
the kernel seems divergent. The kernel is clearly making a choice about
which boot table (DT vs ACPI) to configure with. So to claim it is not
the kernel's job to reason about which to use is clearly incorrect. The
only thing this patch is doing is making it easier for distributions to
configure which preference the kernel has.

> 
>> Currently for ACPI to be used a user either has to set acpi=on on the
>> kernel command line or make sure any device tree passed to the kernel
>> is empty. If the dtb passed to the kernel is non-empty then device-tree
>> will be chosen as the boot method of choice even if it is not correct.
> 
> Your firmware is terminally broken if it provides an incorrect DT, and
> we should not be fixing it in the kernel.

This logic would seem akin to me asking Bjorn to remove all PCI quirks
from the kernel, because the systems that use them are "terminally
broken" or "don't follow the standard". This doesn't seem like a valid
reason to deny a change that would allow the kernel to boot on more
hardware. Further it seems rather rigid to effectively say that we only
run on perfect firmware.

> 
>> To prevent this situation where a system is only intended to be booted
>> via ACPI a user can set this kernel configuration so it ignores
>> device-tree settings unless ACPI table checks fail.
>>
> 
> 'only intended to be booted via ACPI' is a property of the system, not
> of the OS. If you need this functionality for development, you can
> append 'acpi=on' to the kernel command line via kconfig.

This is not for development this is for production rate shipping firmware.
