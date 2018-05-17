Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeEQSHi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:07:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39608 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752112AbeEQSHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:07:36 -0400
Subject: Re: [PATCH v9 04/11] arm64: kexec_file: allocate memory walking
 through memblock list
To: Baoquan He <bhe@redhat.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-5-takahiro.akashi@linaro.org>
 <648656ef-1f1e-b0ac-581c-aba1e62f4eee@arm.com>
 <20180507055906.GE11326@linaro.org> <20180517021024.GI24627@MiWiFi-R3L-srv>
 <20180517021547.GJ24627@MiWiFi-R3L-srv>
From: James Morse <james.morse@arm.com>
Message-ID: <d9b8a3ca-93bc-87f9-1316-f45c0dfe47ae@arm.com>
Date: Thu, 17 May 2018 19:04:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180517021547.GJ24627@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On 17/05/18 03:15, Baoquan He wrote:
> On 05/17/18 at 10:10am, Baoquan He wrote:
>> On 05/07/18 at 02:59pm, AKASHI Takahiro wrote:
>>> On Tue, May 01, 2018 at 06:46:09PM +0100, James Morse wrote:
>>>> On 25/04/18 07:26, AKASHI Takahiro wrote:
>>>>> We need to prevent firmware-reserved memory regions, particularly EFI
>>>>> memory map as well as ACPI tables, from being corrupted by loading
>>>>> kernel/initrd (or other kexec buffers). We also want to support memory
>>>>> allocation in top-down manner in addition to default bottom-up.
>>>>> So let's have arm64 specific arch_kexec_walk_mem() which will search
>>>>> for available memory ranges in usable memblock list,
>>>>> i.e. !NOMAP & !reserved, 
>>>>
>>>>> instead of system resource tree.
>>>>
>>>> Didn't we try to fix the system-resource-tree in order to fix regular-kexec to
>>>> be safe in the EFI-memory-map/ACPI-tables case?
>>>>
>>>> It would be good to avoid having two ways of doing this, and I would like to
>>>> avoid having extra arch code...
>>>
>>> I know what you mean.
>>> /proc/iomem or system resource is, in my opinion, not the best place to
>>> describe memory usage of kernel but rather to describe *physical* hardware
>>> layout. As we are still discussing about "reserved" memory, I don't want
>>> to depend on it.
>>> Along with memblock list, we will have more accurate control over memory
>>> usage.
>>
>> In kexec-tools, we see any usable memory as candidate which can be used
> 
> Here I said 'any', it's not accurate. Those memory which need be passed
> to 2nd kernel for use need be excluded, just as we have done in
> kexec-tools.
> 
>> to load kexec kernel image/initrd etc. However kexec loading is a
>> preparation work, it just books those position for later kexec kernel
>> jumping after "kexec -e", that is why we need kexec_buf to remember
>> them and do the real content copy of kernel/initrd.

The problem we have on arm64 is /proc/iomem is being used for two things.
1) Kexec's this is memory I can book for the new kernel.
2) Kdump's this is memory I must describe for vmcore.

We get the memory map from UEFI via the EFI stub, and leave it in
memblock_reserved() memory. A new kexec kernel needs this to boot: it mustn't
overwrite it. The same goes for the ACPI tables, they could be reclaimed and
used as memory, but the new kexec kernel needs them to boot, they are
memblock_reserved() too.

If we knock all memblock_reserved() regions out of /proc/iomem then kdump
doesn't work, because /proc/iomem is only generated once. Its a snapshot. The
initcode/data is an example of memory we release from memblock_reserve() after
this, then gets used for data we need in the vmcore.

Ideally we would describe all this in /proc/iomem with:
| 8001e80000-83ff186fff : System RAM
|   8002080000-8002feffff : [Data you really need to boot]

kexec-tools should not overwrite 'data you really need to boot' unless it knows
what it is, and that the system will never need it again. (examples: overwrite
the ACPI tables when booting a non-acpi kernel, overwrite the UEFI memory map if
the DT has been regenerated for a non-uefi kernel)

But, kexec-tools doesn't parse those second level entries properly. We have a
bug in user-space, and a bug in the kernel.

Because /proc/iomem is being used for two things, and kexec-tools only parses
one level, I don't think we can fix this in the kernel without breaking one of
the use-cases. I think Akashi's fix user-space too approach is the most
pragmatic approach.


>> Here you use
>> memblock to search available memory, isn't it deviating too far away
>> from the original design in kexec-tools. Assume kexec loading and
>> kexec_file loading should be consistent on loading even though they are
>> done in different space, kernel space and user space.

Its much easier for us to parse memblock in the kernel as the helpers step over
the regions we know we don't want. For the resource list we would need to
strcmp(), and a bunch of handling for the second level entries.


Thanks,

James
