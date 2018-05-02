Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeEBGjf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 02:39:35 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:55241 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeEBGjc (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:3:1>);
        Wed, 2 May 2018 02:39:32 -0400
Message-Id: <5AE95D2002000078001BFEC4@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 02 May 2018 00:39:28 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: <douly.fnst@cn.fujitsu.com>
Cc: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: Re: recent patch "x86/acpi: Prevent X2APIC id 0xffffffff from
 being accounted"
References: <5AE2CF8802000078001BF017@prv1-mh.provo.novell.com>
 <12fd36d0-1678-ed57-fec3-c94b430bd23f@cn.fujitsu.com>
 <5AE3130702000078001BF180@prv1-mh.provo.novell.com>
 <769e14c9-298d-3049-4001-2a8fe903d21e@cn.fujitsu.com>
In-Reply-To: <769e14c9-298d-3049-4001-2a8fe903d21e@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 02.05.18 at 03:56, <douly.fnst@cn.fujitsu.com> wrote:
> At 04/27/2018 08:09 PM, Jan Beulich wrote:
>> I'm afraid I don't understand: Limiting the number of disabled CPUs is
>> certainly desirable when those can never be used, but why would you
>> want to do this when they might later get hotplugged? I'm not aware
> 
> Let's see the workflow of CPU hotplug:
> 
>    1) get the CPU device info from ACPI namespace
>       - it contains logical processor id
> 
>    2) through the logical processor id, get the LACPI entry in MADT.
> 
>    3) generate the CPU for kernel(will create a CPU id, can see by lscpu)
> 
> Normally, there are no valid CPU devices in 1) which are mapped to
> the LACPI entries(0xff or 0xffffffff).
> 
> The actually number of hotplugged CPUs depends on CPU devices/processors
> in ACPI namespace. The number calculated from MADT is the maximum
> situation which can be cut and doesn't affect CPU hotplug. Don't worry
> about it.
> 
> Now, in ACPI-based system, Linux gets the number of possible CPUs by
> MADT, We are going to use the ACPI namespace to make the number
> accurate. But it is so hard, because it's so late to initialize the ACPI
> namespace.

So are you envisioning a model when the number of disabled CPUs can be
increased once the ACPI interpreter has been enabled? Otherwise the
maximum recorded during early boot may be too low with the changes in
question. (And FTR, I agree this number may also be way too large without
them, but it being too large is a resource efficiency problem, while it being
too low is a functionality one.)

Also, for background, besides wanting to clarify the correctness of these
two changes, I'm also trying to understand whether we want to mirror
them into the Xen hypervisor, which relies on the Dom0 kernel's ACPI
interpreter (i.e. it can and does parse MADT, but can't and doesn't parse
the ACPI name space). Hence late adjustment of the number of
hotpluggable CPUs would be even more problematic in that environment.

Jan
