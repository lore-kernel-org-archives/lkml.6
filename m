Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43D1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E4020843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E4020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeIZRbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:31:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42176 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeIZRbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:31:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KwSS0DmXz9ttFk;
        Wed, 26 Sep 2018 13:19:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id j2nLRa-gITL0; Wed, 26 Sep 2018 13:19:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KwSR6ZjLz9ttCH;
        Wed, 26 Sep 2018 13:19:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 114268B80B;
        Wed, 26 Sep 2018 13:19:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xJQKDjtdK-1a; Wed, 26 Sep 2018 13:19:19 +0200 (CEST)
Received: from PO15451 (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A57258B80A;
        Wed, 26 Sep 2018 13:19:19 +0200 (CEST)
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, stable@vger.kernel.org,
        me@tobin.cc
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
 <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <760ed3ff-43d9-75e5-b36c-aaa7871ffe50@c-s.fr>
Date:   Wed, 26 Sep 2018 13:19:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/09/2018 à 13:11, Daniel Thompson a écrit :
> On 16/09/2018 20:06, Daniel Thompson wrote:
>> On Fri, Sep 14, 2018 at 12:35:44PM +0000, Christophe Leroy wrote:
>>> On a powerpc 8xx, 'btc' fails as follows:
>>>
>>> Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
>>> kdb> btc
>>> btc: cpu status: Currently on cpu 0
>>> Available cpus: 0
>>> kdb_getarea: Bad address 0x0
>>>
>>> when booting the kernel with 'debug_boot_weak_hash', it fails as well
>>>
>>> Entering kdb (current=0xba99ad80, pid 284) due to Keyboard Entry
>>> kdb> btc
>>> btc: cpu status: Currently on cpu 0
>>> Available cpus: 0
>>> kdb_getarea: Bad address 0xba99ad80
>>>
>>> On other platforms, Oopses have been observed too, see
>>> https://github.com/linuxppc/linux/issues/139
>>>
>>> This is due to btc calling 'btt' with %p pointer as an argument.
>>>
>>> This patch replaces %p by %px to get the real pointer value as
>>> expected by 'btt'
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> Cc: <stable@vger.kernel.org> # 4.15+
>>
>> Would a Fixes: be better here?
>> Fixes: ad67b74d2469d9b82 ("printk: hash addresses printed with %p")
> 
> Christophe, When you add the Fixes: could you also add my
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Ok, thanks for the review, but do I have to do anything really ?

The Fixes: and now your Reviewed-by: appear automatically in patchwork 
(https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=65715), 
so I believe they'll be automatically included when Jason or someone 
else takes the patch, no ?

Christophe

> 
> 
> Thanks.
> 
> 
>>
>> No blame attached to Tobin, but the fixes makes it super clear what
>> changed and why this breaks kdb (which was not explicitly called out
>> the patch description).
>>
>>
>> Daniel.
>>
>>> ---
>>>   kernel/debug/kdb/kdb_bt.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
>>> index 6ad4a9fcbd6f..7921ae4fca8d 100644
>>> --- a/kernel/debug/kdb/kdb_bt.c
>>> +++ b/kernel/debug/kdb/kdb_bt.c
>>> @@ -179,14 +179,14 @@ kdb_bt(int argc, const char **argv)
>>>                   kdb_printf("no process for cpu %ld\n", cpu);
>>>                   return 0;
>>>               }
>>> -            sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
>>> +            sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
>>>               kdb_parse(buf);
>>>               return 0;
>>>           }
>>>           kdb_printf("btc: cpu status: ");
>>>           kdb_parse("cpu\n");
>>>           for_each_online_cpu(cpu) {
>>> -            sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
>>> +            sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
>>>               kdb_parse(buf);
>>>               touch_nmi_watchdog();
>>>           }
>>> -- 
>>> 2.13.3
>>>
