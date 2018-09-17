Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8FCECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E554A214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E554A214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeIQRyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:54:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23471 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeIQRyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:54:19 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42DQNk3ndBz9ttCP;
        Mon, 17 Sep 2018 14:27:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0MYFMlEue0Tc; Mon, 17 Sep 2018 14:27:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42DQNk3HRsz9ttBj;
        Mon, 17 Sep 2018 14:27:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE9F88B7A0;
        Mon, 17 Sep 2018 14:27:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8TcXA_9GMHyX; Mon, 17 Sep 2018 14:27:11 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C90B8B79C;
        Mon, 17 Sep 2018 14:27:11 +0200 (CEST)
Subject: Re: [PATCH] powerpc: fix csum_ipv6_magic() on little endian platforms
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Xin Long <lucien.xin@gmail.com>, benh@kernel.crashing.org,
        paulus@samba.org, jishi@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
References: <3c4cddf185438cc7200908b4f971a8e6ed7472fd.1536558233.git.christophe.leroy@c-s.fr>
 <CADvbK_c+VVoC=tcX4z-NbX6xGHfkzzNuBXoMHFJfZdiBMzX3+w@mail.gmail.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <76289d79-0e7e-7b22-2364-0b5777f42c8b@c-s.fr>
Date:   Mon, 17 Sep 2018 14:27:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADvbK_c+VVoC=tcX4z-NbX6xGHfkzzNuBXoMHFJfZdiBMzX3+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Le 10/09/2018 à 16:28, Xin Long a écrit :
> On Mon, Sep 10, 2018 at 2:09 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> On little endian platforms, csum_ipv6_magic() keeps len and proto in
>> CPU byte order. This generates a bad results leading to ICMPv6 packets
>> from other hosts being dropped by powerpc64le platforms.
>>
>> In order to fix this, len and proto should be converted to network
>> byte order ie bigendian byte order. However checksumming 0x12345678
>> and 0x56341278 provide the exact same result so it is enough to
>> rotate the sum of len and proto by 1 byte.
>>
>> PPC32 only support bigendian so the fix is needed for PPC64 only
>>
>> Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
>> Reported-by: Jianlin Shi <jishi@redhat.com>
>> Reported-by: Xin Long <lucien.xin@gmail.com>
>> Cc: <stable@vger.kernel.org> # 4.18+
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/lib/checksum_64.S | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
>> index 886ed94b9c13..2a68c43e13f5 100644
>> --- a/arch/powerpc/lib/checksum_64.S
>> +++ b/arch/powerpc/lib/checksum_64.S
>> @@ -443,6 +443,9 @@ _GLOBAL(csum_ipv6_magic)
>>          addc    r0, r8, r9
>>          ld      r10, 0(r4)
>>          ld      r11, 8(r4)
>> +#ifndef CONFIG_CPU_BIG_ENDIAN
>> +       rotldi  r5, r5, 8
>> +#endif
>>          adde    r0, r0, r10
>>          add     r5, r5, r7
>>          adde    r0, r0, r11
>> --
>> 2.13.3
>>
> Tested-by: Xin Long <lucien.xin@gmail.com>
> 

Could you take this fix for 4.19 ?

Unless someone takes it through the netdev tree ?

Thanks
Christophe
