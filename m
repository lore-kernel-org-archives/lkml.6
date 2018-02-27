Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeB0WUk convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:20:40 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17912 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeB0WUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:20:39 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Feb 2018 14:20:38 -0800
Subject: Re: [PATCH] riscv/barrier: Define __smp_{store_release,load_acquire}
To: Palmer Dabbelt <palmer@sifive.com>, <parri.andrea@gmail.com>
CC: <albert@sifive.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <mhng-d0fc25e5-9a3f-4988-9260-3d584b8f4606@palmer-si-x1c4>
From: Daniel Lustig <dlustig@nvidia.com>
Message-ID: <e482049c-70b5-3b4f-a818-0740bec9a4fa@nvidia.com>
Date: Tue, 27 Feb 2018 14:20:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <mhng-d0fc25e5-9a3f-4988-9260-3d584b8f4606@palmer-si-x1c4>
X-Originating-IP: [10.110.39.68]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/2018 10:21 AM, Palmer Dabbelt wrote:
> On Mon, 26 Feb 2018 18:24:11 PST (-0800), parri.andrea@gmail.com wrote:
>> Introduce __smp_{store_release,load_acquire}, and rely on the generic
>> definitions for smp_{store_release,load_acquire}. This avoids the use
>> of full ("rw,rw") fences on SMP.
>>
>> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>> ---
>>  arch/riscv/include/asm/barrier.h | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
>> index 5510366d169ae..d4628e4b3a5ea 100644
>> --- a/arch/riscv/include/asm/barrier.h
>> +++ b/arch/riscv/include/asm/barrier.h
>> @@ -38,6 +38,21 @@
>>  #define __smp_rmb()    RISCV_FENCE(r,r)
>>  #define __smp_wmb()    RISCV_FENCE(w,w)
>>
>> +#define __smp_store_release(p, v)                    \
>> +do {                                    \
>> +    compiletime_assert_atomic_type(*p);                \
>> +    RISCV_FENCE(rw,w);                        \
>> +    WRITE_ONCE(*p, v);                        \
>> +} while (0)
>> +
>> +#define __smp_load_acquire(p)                        \
>> +({                                    \
>> +    typeof(*p) ___p1 = READ_ONCE(*p);                \
>> +    compiletime_assert_atomic_type(*p);                \
>> +    RISCV_FENCE(r,rw);                        \
>> +    ___p1;                                \
>> +})
>> +
>>  /*
>>   * This is a very specific barrier: it's currently only used in two places in
>>   * the kernel, both in the scheduler.  See include/linux/spinlock.h for the two
> 
> I'm adding Daniel just in case I misunderstood what's going on here,
> but these look good to me.  As this is a non-trivial memory model
> change I'm going to let it bake in linux-next for a bit just so it
> gets some visibility.

Looks good to me too.  In particular, it also covers the
Write->release(p)->acquire(p)->Write ordering that we were debating
in the broader LKMM thread, which is good.

Dan

> 
> Thanks
