Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83207C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B48216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B48216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeHHKC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:02:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24431 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbeHHKC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:02:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41lk180Yfxz9ttkl;
        Wed,  8 Aug 2018 09:44:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id l5mw1hmyJXPx; Wed,  8 Aug 2018 09:44:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41lk1802tpz9ttkf;
        Wed,  8 Aug 2018 09:44:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 911F38B7AC;
        Wed,  8 Aug 2018 09:44:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id v053WW6SXfc0; Wed,  8 Aug 2018 09:44:28 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C5AC8B752;
        Wed,  8 Aug 2018 09:44:28 +0200 (CEST)
Subject: Re: [PATCH] lib/test_hexdump: fix failure on big endian cpu
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr>
 <87mutxb9qy.fsf@concordia.ellerman.id.au>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <1690d8af-3e67-e82b-ef2a-8adee6eaa497@c-s.fr>
Date:   Wed, 8 Aug 2018 09:44:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87mutxb9qy.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/08/2018 à 09:25, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
>> index 3f415d8101f3..626f580b4ff7 100644
>> --- a/lib/test_hexdump.c
>> +++ b/lib/test_hexdump.c
>> @@ -32,16 +32,33 @@ static const char * const test_data_2_le[] __initconst = {
>>   	"d14c", "9919", "b143", "0caf",
>>   };
>>   
>> +static const char * const test_data_2_be[] __initconst = {
>> +	"be32", "db7b", "0a18", "93b2",
>> +	"70ba", "c424", "7d83", "349b",
>> +	"a69c", "31ad", "9c0f", "ace9",
>> +	"4cd1", "1999", "43b1", "af0c",
>> +};
>> +
>>   static const char * const test_data_4_le[] __initconst = {
>>   	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
>>   	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
>>   };
>>   
>> +static const char * const test_data_4_be[] __initconst = {
>> +	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
>> +	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
>> +};
>> +
> 
> Is there a reason we can't do it all at compile time?

Codyingstyle suggests to use IS_ENABLED() as much as possible.
I checked symbols inside resulting vmlinux, only the BE ones are there 
so it has
the same effect as an #ifdef

Extract from Documentation/process/codying-style.rst:

Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
symbol into a C boolean expression, and use it in a normal C conditional:

.. code-block:: c

	if (IS_ENABLED(CONFIG_SOMETHING)) {
		...
	}

The compiler will constant-fold the conditional away, and include or exclude
the block of code just as with an #ifdef, so this will not add any runtime
overhead.  However, this approach still allows the C compiler to see the 
code
inside the block, and check it for correctness (syntax, types, symbol
references, etc).  Thus, you still have to use an #ifdef if the code 
inside the
block references symbols that will not exist if the condition is not met.

Christophe

> 
> eg:
> 
> static const char * const test_data_4[] __initconst = {
> #ifdef CONFIG_CPU_LITTLE_ENDIAN
> 	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
> 	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
> #else
> 	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
> 	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
> #endif
> };
> 
> 
> cheers
> 
