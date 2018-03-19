Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeCSLTm convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:19:42 -0400
Received: from ozlabs.org ([103.22.144.67]:51517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932659AbeCSLTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:19:41 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/5] powerpc/mm/32: Use page_is_ram to check for RAM
In-Reply-To: <874llcha6p.fsf@concordia.ellerman.id.au>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net> <20180222121516.23415-4-j.neuschaefer@gmx.net> <874llcha6p.fsf@concordia.ellerman.id.au>
Date: Mon, 19 Mar 2018 22:19:32 +1100
Message-ID: <87y3iofh2z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Jonathan Neuschäfer <j.neuschaefer@gmx.net> writes:
>
>> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
>> ---
>>  arch/powerpc/mm/pgtable_32.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index d35d9ad3c1cd..d54e1a9c1c99 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -145,9 +145,8 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
>>  #ifndef CONFIG_CRASH_DUMP
>>  	/*
>>  	 * Don't allow anybody to remap normal RAM that we're using.
>> -	 * mem_init() sets high_memory so only do the check after that.
>>  	 */
>> -	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
>> +	if (page_is_ram(__phys_to_pfn(p)) &&
>>  	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
>>  		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
>>  		       (unsigned long long)p, __builtin_return_address(0));
>
>
> This is killing my p5020ds (Freescale e5500) unfortunately:

Duh, I should actually read the patch :)

This is a 32-bit system with 4G of RAM, so not all of RAM is mapped,
some of it is highem which is why removing the test against high_memory
above breaks it.

So I need the high_memory test on this system.

I'm not clear why it was a problem for you on the Wii, do you even build
the Wii kernel with HIGHMEM enabled?

cheers
