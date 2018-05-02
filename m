Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751084AbeEBB44 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:56:56 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1817 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750823AbeEBB4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:56:54 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39469978"
Subject: Re: recent patch "x86/acpi: Prevent X2APIC id 0xffffffff from being
 accounted"
To: Jan Beulich <JBeulich@suse.com>
CC: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <5AE2CF8802000078001BF017@prv1-mh.provo.novell.com>
 <12fd36d0-1678-ed57-fec3-c94b430bd23f@cn.fujitsu.com>
 <5AE3130702000078001BF180@prv1-mh.provo.novell.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <769e14c9-298d-3049-4001-2a8fe903d21e@cn.fujitsu.com>
Date: Wed, 2 May 2018 09:56:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5AE3130702000078001BF180@prv1-mh.provo.novell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 1D5D64B34D23.A8837
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



At 04/27/2018 08:09 PM, Jan Beulich wrote:
>>>> On 27.04.18 at 10:32, <douly.fnst@cn.fujitsu.com> wrote:
>> At 04/27/2018 03:21 PM, Jan Beulich wrote:
>>> I've just stumbled across this commit, and I'm wondering if that's actually
>>> correct (I too have at least one system where such IDs are reported in
>>> MADT): For offline/absent CPUs, the firmware may not know the APIC IDs
>>
>> The MADT table is not reasonable, the Local APIC entries(xAPIC/x2APIC)
>> in MADT is not always correct as OS want. So, we should do this sanity
>> check.
> 
> Of course, sanity checking is necessary.
> 
>>> at the point MADT is built, so I think it is quite reasonable to put ~0 in
>>> there. The ACPID spec specifically calls out that the IDs must not change
>>> across sleep states, which implies to me that they may change across an
>>> offline period of a CPU. IOW I think such entries still need to contribute to
>>> the count of disabled CPUs.
>>
>> Aha, there are no CPU devices which will map it's physical ID to the
>> illegal number 0xffffffff, So it will never be used.
> 
> The ID will never be used, yes, but the CPU may be (after firmware has
> assigned it a valid ID).
> 
>> BTW, Limiting the number of the disabled CPUs is also a goal.
> 
> I'm afraid I don't understand: Limiting the number of disabled CPUs is
> certainly desirable when those can never be used, but why would you
> want to do this when they might later get hotplugged? I'm not aware

Let's see the workflow of CPU hotplug:

   1) get the CPU device info from ACPI namespace
      - it contains logical processor id

   2) through the logical processor id, get the LACPI entry in MADT.

   3) generate the CPU for kernel(will create a CPU id, can see by lscpu)

Normally, there are no valid CPU devices in 1) which are mapped to
the LACPI entries(0xff or 0xffffffff).

The actually number of hotplugged CPUs depends on CPU devices/processors
in ACPI namespace. The number calculated from MADT is the maximum
situation which can be cut and doesn't affect CPU hotplug. Don't worry
about it.

Now, in ACPI-based system, Linux gets the number of possible CPUs by
MADT, We are going to use the ACPI namespace to make the number
accurate. But it is so hard, because it's so late to initialize the ACPI
namespace.

Thanks,
	dou

> of a way to tell, by just looking at the MADT, which of the two cases
> apply.
>




> Jan
> 
> 
> 
> 
> 
