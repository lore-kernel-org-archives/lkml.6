Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932092AbeEOQVE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:21:04 -0400
Received: from foss.arm.com ([217.140.101.70]:35156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753700AbeEOQUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:20:50 -0400
Subject: Re: [PATCH v9 04/11] arm64: kexec_file: allocate memory walking
 through memblock list
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-5-takahiro.akashi@linaro.org>
 <648656ef-1f1e-b0ac-581c-aba1e62f4eee@arm.com>
 <20180507055906.GE11326@linaro.org> <20180515043538.GB2737@linaro.org>
From: James Morse <james.morse@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <84d5da84-81c4-d311-10e9-ba6afaf72a8e@arm.com>
Date: Tue, 15 May 2018 17:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180515043538.GB2737@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 15/05/18 05:35, AKASHI Takahiro wrote:
> On Mon, May 07, 2018 at 02:59:07PM +0900, AKASHI Takahiro wrote:
>> On Tue, May 01, 2018 at 06:46:09PM +0100, James Morse wrote:
>>> On 25/04/18 07:26, AKASHI Takahiro wrote:
>>>> We need to prevent firmware-reserved memory regions, particularly EFI
>>>> memory map as well as ACPI tables, from being corrupted by loading
>>>> kernel/initrd (or other kexec buffers). We also want to support memory
>>>> allocation in top-down manner in addition to default bottom-up.
>>>> So let's have arm64 specific arch_kexec_walk_mem() which will search
>>>> for available memory ranges in usable memblock list,
>>>> i.e. !NOMAP & !reserved, 
>>>
>>>> instead of system resource tree.
>>>
>>> Didn't we try to fix the system-resource-tree in order to fix regular-kexec to
>>> be safe in the EFI-memory-map/ACPI-tables case?
>>>
>>> It would be good to avoid having two ways of doing this, and I would like to
>>> avoid having extra arch code...
>>
>> I know what you mean.
>> /proc/iomem or system resource is, in my opinion, not the best place to
>> describe memory usage of kernel but rather to describe *physical* hardware
>> layout. As we are still discussing about "reserved" memory, I don't want
>> to depend on it.

I agree. We have funny stuff that isn't hardware-layout, but is important for
the next boot. The kernel doesn't have an ABI to support when it queries the
list itself.


>> Along with memblock list, we will have more accurate control over memory
>> usage.

>>> If the argument is walking memblock gives a better answer than the stringy
>>> walk_system_ram_res() thing, is there any mileage in moving this code into
>>> kexec_file.c, and using it if !IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK)?
>>>
>>> This would save arm64/powerpc having near-identical implementations.
>>> 32bit arm keeps memblock if it has kexec, so it may be useful there too if
>>> kexec_file_load() support is added.

> If you don't have further objection, I will take memblock approach
> (with factoring out powerpc's arch_kexec_walk_mem()).

If we're agreed that the memblock walking is generic, then it would be quicker
to make the arm64 version as close as possible and merge them as a later series.
(saves a cross arch dependency)

With that,
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
