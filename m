Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeEBILK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:11:10 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26703 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751317AbeEBILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:11:08 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39483815"
Subject: Re: recent patch "x86/acpi: Prevent X2APIC id 0xffffffff from being
 accounted"
To: Jan Beulich <JBeulich@suse.com>
CC: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <5AE2CF8802000078001BF017@prv1-mh.provo.novell.com>
 <12fd36d0-1678-ed57-fec3-c94b430bd23f@cn.fujitsu.com>
 <5AE3130702000078001BF180@prv1-mh.provo.novell.com>
 <769e14c9-298d-3049-4001-2a8fe903d21e@cn.fujitsu.com>
 <5AE95D2002000078001BFEC4@prv1-mh.provo.novell.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <8310e1db-b874-fef1-2068-c8f049c38135@cn.fujitsu.com>
Date: Wed, 2 May 2018 16:10:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5AE95D2002000078001BFEC4@prv1-mh.provo.novell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 500414D0EFD1.A88F4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

At 05/02/2018 02:39 PM, Jan Beulich wrote:
>>>> On 02.05.18 at 03:56, <douly.fnst@cn.fujitsu.com> wrote:
>> At 04/27/2018 08:09 PM, Jan Beulich wrote:
>>> I'm afraid I don't understand: Limiting the number of disabled CPUs is
>>> certainly desirable when those can never be used, but why would you
>>> want to do this when they might later get hotplugged? I'm not aware
>>
>> Let's see the workflow of CPU hotplug:
>>
>>     1) get the CPU device info from ACPI namespace
>>        - it contains logical processor id
>>
>>     2) through the logical processor id, get the LACPI entry in MADT.
>>
>>     3) generate the CPU for kernel(will create a CPU id, can see by lscpu)
>>
>> Normally, there are no valid CPU devices in 1) which are mapped to
>> the LACPI entries(0xff or 0xffffffff).
>>
>> The actually number of hotplugged CPUs depends on CPU devices/processors
>> in ACPI namespace. The number calculated from MADT is the maximum
>> situation which can be cut and doesn't affect CPU hotplug. Don't worry
>> about it.
>>
>> Now, in ACPI-based system, Linux gets the number of possible CPUs by
>> MADT, We are going to use the ACPI namespace to make the number
>> accurate. But it is so hard, because it's so late to initialize the ACPI
>> namespace.
> 
> So are you envisioning a model when the number of disabled CPUs can be
> increased once the ACPI interpreter has been enabled? Otherwise the

Yes, good idea, but, As Thomas said:

   It needs to run _before_ setup_percpu() is invoked to
   scale everything correctly.

> maximum recorded during early boot may be too low with the changes in
> question. (And FTR, I agree this number may also be way too large without
> them, but it being too large is a resource efficiency problem, while it being
> too low is a functionality one.)

Too large number will waste vectors, and even cause bugs.

IMO, the number will just be more accurate by excluding 0xffffffff, it
only equal to, even be larger than the real number of possible CPUs.

> 
> Also, for background, besides wanting to clarify the correctness of these
> two changes, I'm also trying to understand whether we want to mirror
> them into the Xen hypervisor, which relies on the Dom0 kernel's ACPI
> interpreter (i.e. it can and does parse MADT, but can't and doesn't parse
> the ACPI name space). Hence late adjustment of the number of
> hotpluggable CPUs would be even more problematic in that environment.
> 

I am not familiar with Xen, I will consider that.

Thanks,

	dou

> Jan
> 
> 
> 
> 
> 
