Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6368C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8825F2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8825F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeLEMY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:24:26 -0500
Received: from www62.your-server.de ([213.133.104.62]:47064 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeLEMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:24:23 -0500
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gUWDz-0003Xb-Gp; Wed, 05 Dec 2018 13:24:19 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gUWDz-000842-8q; Wed, 05 Dec 2018 13:24:19 +0100
Subject: Re: [PATCH v4 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
 <20181123221804.440-3-ard.biesheuvel@linaro.org>
 <20181130182629.GA16085@arm.com>
 <CAKv+Gu9QVHLWu5H3Ok1Kbm=vtzd1KaHUn2VEij6oToW5aPR9uA@mail.gmail.com>
 <20181203124930.GB25097@arm.com>
 <CAKv+Gu8svuTSOzg7wmmK70tRPgFqGvBh5BZR-V+43dMLvT1bJg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <12954298-de06-349e-6df2-c218e5bf09a3@iogearbox.net>
Date:   Wed, 5 Dec 2018 13:24:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8svuTSOzg7wmmK70tRPgFqGvBh5BZR-V+43dMLvT1bJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25179/Tue Dec  4 15:18:37 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 12/04/2018 04:45 PM, Ard Biesheuvel wrote:
> On Mon, 3 Dec 2018 at 13:49, Will Deacon <will.deacon@arm.com> wrote:
>> On Fri, Nov 30, 2018 at 08:20:06PM +0100, Ard Biesheuvel wrote:
>>> On Fri, 30 Nov 2018 at 19:26, Will Deacon <will.deacon@arm.com> wrote:
>>>> On Fri, Nov 23, 2018 at 11:18:04PM +0100, Ard Biesheuvel wrote:
>>>>> The arm64 module region is a 128 MB region that is kept close to
>>>>> the core kernel, in order to ensure that relative branches are
>>>>> always in range. So using the same region for programs that do
>>>>> not have this restriction is wasteful, and preferably avoided.
>>>>>
>>>>> Now that the core BPF JIT code permits the alloc/free routines to
>>>>> be overridden, implement them by vmalloc()/vfree() calls from a
>>>>> dedicated 128 MB region set aside for BPF programs. This ensures
>>>>> that BPF programs are still in branching range of each other, which
>>>>> is something the JIT currently depends upon (and is not guaranteed
>>>>> when using module_alloc() on KASLR kernels like we do currently).
>>>>> It also ensures that placement of BPF programs does not correlate
>>>>> with the placement of the core kernel or modules, making it less
>>>>> likely that leaking the former will reveal the latter.
>>>>>
>>>>> This also solves an issue under KASAN, where shadow memory is
>>>>> needlessly allocated for all BPF programs (which don't require KASAN
>>>>> shadow pages since they are not KASAN instrumented)
>>>>>
>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>> ---
>>>>>  arch/arm64/include/asm/memory.h |  5 ++++-
>>>>>  arch/arm64/net/bpf_jit_comp.c   | 13 +++++++++++++
>>>>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>>>>> index b96442960aea..ee20fc63899c 100644
>>>>> --- a/arch/arm64/include/asm/memory.h
>>>>> +++ b/arch/arm64/include/asm/memory.h
>>>>> @@ -62,8 +62,11 @@
>>>>>  #define PAGE_OFFSET          (UL(0xffffffffffffffff) - \
>>>>>       (UL(1) << (VA_BITS - 1)) + 1)
>>>>>  #define KIMAGE_VADDR         (MODULES_END)
>>>>> +#define BPF_JIT_REGION_START (VA_START + KASAN_SHADOW_SIZE)
>>>>> +#define BPF_JIT_REGION_SIZE  (SZ_128M)
>>>>> +#define BPF_JIT_REGION_END   (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
>>>>>  #define MODULES_END          (MODULES_VADDR + MODULES_VSIZE)
>>>>> -#define MODULES_VADDR                (VA_START + KASAN_SHADOW_SIZE)
>>>>> +#define MODULES_VADDR                (BPF_JIT_REGION_END)
>>>>>  #define MODULES_VSIZE                (SZ_128M)
>>>>>  #define VMEMMAP_START                (PAGE_OFFSET - VMEMMAP_SIZE)
>>>>>  #define PCI_IO_END           (VMEMMAP_START - SZ_2M)
>>>>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>>>>> index a6fdaea07c63..76c2ab40c02d 100644
>>>>> --- a/arch/arm64/net/bpf_jit_comp.c
>>>>> +++ b/arch/arm64/net/bpf_jit_comp.c
>>>>> @@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>>>                                          tmp : orig_prog);
>>>>>       return prog;
>>>>>  }
>>>>> +
>>>>> +void *bpf_jit_alloc_exec(unsigned long size)
>>>>> +{
>>>>> +     return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
>>>>> +                                 BPF_JIT_REGION_END, GFP_KERNEL,
>>>>> +                                 PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
>>>>> +                                 __builtin_return_address(0));
>>>>
>>>> I guess we'll want VM_IMMEDIATE_UNMAP here if Rich gets that merged.
>>>
>>> I think akpm already queued up that patch.
>>>
>>>> In the
>>>> meantime, I wonder if it's worth zeroing the region in bpf_jit_free_exec()?
>>>> (although we'd need the size information...).
>>>>
>>>
>>> Not sure. What exactly would that achieve?
>>
>> I think the zero encoding is guaranteed to be undefined, so it would limit
>> the usefulness of any stale, executable TLB entries. However, we'd also need
>> cache maintenance to make that stuff visible to the I side, so it's probably
>> not worth it, especially if akpm has queued the stuff from Rich.
>>
>> Maybe just add an:
>>
>> /* FIXME: Remove this when VM_IMMEDIATE_UNMAP is supported */
>> #ifndef VM_IMMEDIATE_UNMAP
>> #define VM_IMMEDIATE_UNMAP      0
>> #endif
>>
>> so we remember to come back and sort this out? Up to you.
> 
> I'll just make a note to send out that patch once the definition lands via -akpm

Could I get an ACK from you for this patch, then I'd take the series into bpf-next.

Thanks,
Daniel
