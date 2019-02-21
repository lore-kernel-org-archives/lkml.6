Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD645C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDC72083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dXD1Lqdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfBUTDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:03:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:64840 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfBUTDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:03:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4453lG6GJgz9v6l1;
        Thu, 21 Feb 2019 20:03:06 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dXD1Lqdw; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id R0oiRFtOu_Fj; Thu, 21 Feb 2019 20:03:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4453lG580kz9v6jt;
        Thu, 21 Feb 2019 20:03:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550775786; bh=P13Pznnz4SECXyfoPjqca8tjebP4ZlSv0SzbWcDRTVk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dXD1LqdwY57zZhL7oa22tjup8tSeFy0DzwpyoFVou209BjblZGYwPabS2oYrsNtok
         +FuA1yWU/IWuLbKhV/ZHfTFODMunkGpC32WKWY6jSG0gefaRkyciILTag40AnsGcLF
         8v/YDUAfVHFeIo1XnrkxUnO1liltCwqC+CLPFEiE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 144E28B88A;
        Thu, 21 Feb 2019 20:03:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BaHTZHGCZYIT; Thu, 21 Feb 2019 20:03:05 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9FB18B86D;
        Thu, 21 Feb 2019 20:02:47 +0100 (CET)
Subject: Re: [PATCH v4 04/16] powerpc/mm/32s: use generic mmu_mapin_ram() for
 all blocks.
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1550692943.git.christophe.leroy@c-s.fr>
 <790cf44815f8c56b3c600560bad9139f63be9f68.1550692943.git.christophe.leroy@c-s.fr>
 <87o9755jy2.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <719e3340-dd91-9504-d39c-4257e1bf0282@c-s.fr>
Date:   Thu, 21 Feb 2019 19:02:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87o9755jy2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/21/2019 01:51 PM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Now that mmu_mapin_ram() is able to handle other blocks
>> than the one starting at 0, the WII can use it for all
>> its blocks.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/pgtable_32.c | 27 +++++++++------------------
>>   1 file changed, 9 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index b4858818523f..2bf9bf8867d4 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -254,26 +254,17 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
>>   
>>   void __init mapin_ram(void)
>>   {
>> -	unsigned long s, top;
>> -
>> -#ifndef CONFIG_WII
>> -	top = total_lowmem;
>> -	s = mmu_mapin_ram(0, top);
>> -	__mapin_ram_chunk(s, top);
>> -#else
>> -	if (!wii_hole_size) {
>> -		s = mmu_mapin_ram(0, total_lowmem);
>> -		__mapin_ram_chunk(s, total_lowmem);
>> -	} else {
>> -		top = wii_hole_start;
>> -		s = mmu_mapin_ram(0, top);
>> -		__mapin_ram_chunk(s, top);
>> +	struct memblock_region *reg;
>> +
>> +	for_each_memblock(memory, reg) {
>> +		unsigned long base = reg->base;
>> +		unsigned long top = min(base + reg->size, (unsigned long)total_lowmem);
> 
> This gives me:
> 
> In file included from ../arch/powerpc/mm/pgtable_32.c:22:
> ../arch/powerpc/mm/pgtable_32.c: In function ‘mapin_ram’:
> ../include/linux/kernel.h:846:29: error: comparison of distinct pointer types lacks a cast [-Werror]
>     (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>                               ^~
> ../include/linux/kernel.h:860:4: note: in expansion of macro ‘__typecheck’
>     (__typecheck(x, y) && __no_side_effects(x, y))
>      ^~~~~~~~~~~
> ../include/linux/kernel.h:870:24: note: in expansion of macro ‘__safe_cmp’
>    __builtin_choose_expr(__safe_cmp(x, y), \
>                          ^~~~~~~~~~
> ../include/linux/kernel.h:879:19: note: in expansion of macro ‘__careful_cmp’
>   #define min(x, y) __careful_cmp(x, y, <)
>                     ^~~~~~~~~~~~~
> ../arch/powerpc/mm/pgtable_32.c:261:23: note: in expansion of macro ‘min’
>     unsigned long top = min(base + reg->size, (unsigned long)total_lowmem);
>                         ^~~
> cc1: all warnings being treated as errors
> ../scripts/Makefile.build:276: recipe for target 'arch/powerpc/mm/pgtable_32.o' failed
> 
> 
> For 44x/bamboo_defconfig.
> 

The patch below should make it. Tested it on half a dozen of config.

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 2bf9bf8867d4..c4b0eb51f6d8 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -257,8 +257,8 @@ void __init mapin_ram(void)
  	struct memblock_region *reg;

  	for_each_memblock(memory, reg) {
-		unsigned long base = reg->base;
-		unsigned long top = min(base + reg->size, (unsigned long)total_lowmem);
+		phys_addr_t base = reg->base;
+		phys_addr_t top = min(base + reg->size, total_lowmem);

  		if (base >= top)
  			continue;

I'll send out v5, hope it'll be the last one :(

Christophe
