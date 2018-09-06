Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BBCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06B02083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06B02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbeIFNjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:39:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62610 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbeIFNjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:39:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 425ZQJ4nNdz9ttSN;
        Thu,  6 Sep 2018 11:04:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KME0-XV5d7mT; Thu,  6 Sep 2018 11:04:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 425ZQJ4Hnrz9ttSJ;
        Thu,  6 Sep 2018 11:04:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EDACB8B8EA;
        Thu,  6 Sep 2018 11:04:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9uBX43tP1N9c; Thu,  6 Sep 2018 11:04:41 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 93CF68B8E8;
        Thu,  6 Sep 2018 11:04:40 +0200 (CEST)
Subject: Re: [PATCH 1/2] powerpc/process: fix nested output in
 show_user_instructions()
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, muriloo@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <718cc9c9bd1d4bb2b4c2596f1a7ee00334e77055.1534192631.git.christophe.leroy@c-s.fr>
 <877ekkmdy7.fsf@concordia.ellerman.id.au>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <ebf2318b-7d72-6f20-2457-f97064d28164@c-s.fr>
Date:   Thu, 6 Sep 2018 11:04:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <877ekkmdy7.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/08/2018 à 08:27, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> When two processes crash at the same time, we sometimes encounter
>> nesting in the middle of a line:
> 
> I think "interleaved" is the right word, rather than "nesting".
> 
> They're actually (potentially) completely unrelated segfaults, that just
> happen to occur at the same time.
> 
> And in fact any output that happens simultaneously will mess things up,
> it doesn't have to be another segfault.

Ok, i reworded in v2.

> 
>> [    4.365317] init[1]: segfault (11) at 0 nip 0 lr 0 code 1
>> [    4.370452] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>> [    4.372042] init[74]: segfault (11) at 10a74 nip 1000c198 lr 100078c8 code 1 in sh[10000000+14000]
>> [    4.386829] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>> [    4.391542] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>> [    4.400863] init[74]: code: 90010024 bf61000c 91490a7c 3fa01002 3be00000 7d3e4b78 3bbd0c20 3b600000
>> [    4.409867] init[74]: code: 3b9d0040 7c7fe02e 2f830000 419e0028 <89230000> 2f890000 41be001c 4b7f6e79
>>
>> This patch fixes it by preparing complete lines in a buffer and
>> printing it at once.
>>
>> Fixes: 88b0fe1757359 ("powerpc: Add show_user_instructions()")
>> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/kernel/process.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> index 913c5725cdb2..c722ce4ca1c0 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -1303,32 +1303,33 @@ void show_user_instructions(struct pt_regs *regs)
>>   {
>>   	unsigned long pc;
>>   	int i;
>> +	char buf[96]; /* enough for 8 times 9 + 2 chars */
>> +	int l = 0;
> 
> I'm sure your math is right, but still an on-stack buffer with sprintf()
> is a bit scary.
> 
> Can you try using seq_buf instead? It is safe against overflow.
> 
> eg, something like:
> 
> struct seq_buf s;
> char buf[96];
> 
> seq_buf_init(&s, buf, sizeof(buf));
> ...
> seq_buf_printf(&s, ...);

Ok, I did that in v2. In the meantime I reworked the loop to avoid this 
uggly test against i % 8 and this duplication of the pr_info() of the 
code line.

Christophe
