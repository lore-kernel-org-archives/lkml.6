Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0373C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B0D25A7B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B0D25A7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934129AbeFYNcv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:32:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21928 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933785AbeFYNct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:32:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41Dqq04v1Nz9txd0;
        Mon, 25 Jun 2018 15:32:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id M-Ht8ZYJGn8i; Mon, 25 Jun 2018 15:32:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41Dqq04JRsz9txcm;
        Mon, 25 Jun 2018 15:32:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D4DB78B7A0;
        Mon, 25 Jun 2018 15:32:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RWhLy7_ecLVj; Mon, 25 Jun 2018 15:32:35 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.35])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6DEAF8B7C2;
        Mon, 25 Jun 2018 15:32:35 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] kobject: Fix -Wstringop-truncation warning
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-crypto@vger.kernel.org
References: <20180625124538.21051-1-shorne@gmail.com>
 <20180625124538.21051-3-shorne@gmail.com>
 <c89dd856-3637-b235-f134-e15621eab2c6@c-s.fr>
 <20180625132445.GI24595@lianli.shorne-pla.net>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d962dac0-ed9c-6894-09df-ad5f6c00c8f1@c-s.fr>
Date:   Mon, 25 Jun 2018 15:32:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625132445.GI24595@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/06/2018 à 15:24, Stafford Horne a écrit :
> On Mon, Jun 25, 2018 at 02:57:13PM +0200, Christophe LEROY wrote:
>>
>>
>> Le 25/06/2018 à 14:45, Stafford Horne a écrit :
>>> When compiling with GCC 9.0.0 I am seeing the following warning:
>>>
>>>       In function ‘fill_kobj_path’,
>>> 	inlined from ‘kobject_get_path’ at lib/kobject.c:155:2:
>>>       lib/kobject.c:128:3: warning: ‘strncpy’ output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
>>>          strncpy(path + length, kobject_name(parent), cur);
>>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>       lib/kobject.c: In function ‘kobject_get_path’:
>>>       lib/kobject.c:125:13: note: length computed here
>>>          int cur = strlen(kobject_name(parent));
>>> 		 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> This is not really an issue since the buffer we are writing to is
>>> pre-zero'd and we have already allocated the buffer based on the
>>> calculated strlen size and accounted for the terminating '\0'.
>>> Just use memcpy() instead.
>>
>> If we are already sure the destination is big enough, why not just do a
>> strcpy() and drop the 'cur = strlen()' ?
> 
> Hi Christophe,
> 
> Here were are writing multiple strings into a buffer from back to front.  We are
> copying exactly strlen() bytes at a time to avoid the nul terminator being
> copied into the buffer.
> 
> I don't doubt we could use strcpy() but I was trying to keep the change small.

Ok, fair enough.

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> 
> -Stafford
> 
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Eric Biggers <ebiggers3@gmail.com>
>>> Signed-off-by: Stafford Horne <shorne@gmail.com>
>>> ---
>>>    lib/kobject.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/kobject.c b/lib/kobject.c
>>> index 18989b5b3b56..e876957743c8 100644
>>> --- a/lib/kobject.c
>>> +++ b/lib/kobject.c
>>> @@ -125,7 +125,7 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
>>>    		int cur = strlen(kobject_name(parent));
>>>    		/* back up enough to print this name with '/' */
>>>    		length -= cur;
>>> -		strncpy(path + length, kobject_name(parent), cur);
>>> +		memcpy(path + length, kobject_name(parent), cur);
>>>    		*(path + --length) = '/';
>>>    	}
>>>
