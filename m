Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407A6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB222133D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M6o+RHxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB222133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934444AbeGFSiQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:38:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934112AbeGFSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7pCxR79CKR/a6VjVA6KTtpHV/iHPrBoWPzeeDLGpMPU=; b=M6o+RHxFDAL+bggx5xPkHisQ8
        uV1Egif0e/Ri/K/wDAK/hCQK/BIu5Tihx9o2ECc878y/DK0EEHWZ9Zbxm1/V9rhU2+PvUnbV3O2sT
        FjbBPO1eu0iTOa6lToHImPB7g8ipCFTErHWtIlcL5TaeKkoDesB4oapBJCLlcMLwHQ2vh1QTrAGs/
        VjkVbUTjhUSob37djdoKZOiTHkaO9DdPeyI2e5NzovcsHziAUPTCkfAm1e7v8s6wiDqV78oqxt81/
        7e6miNyd3kowN7h9fygadAtxwtk1CkKv/V7iD0zDGnuJuU+k2tybmJCwOzgUIp7BJnIG/6uku9Vdu
        VHY24hgJA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbVcS-0003bS-Tu; Fri, 06 Jul 2018 18:38:12 +0000
Subject: Re: [PATCH] bitops: Introduce BITS_PER_TYPE
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20180706094458.14116-1-chris@chris-wilson.co.uk>
 <48904284-14d7-45c2-cf41-0c0b311ccf7e@infradead.org>
 <153089946144.7594.5374061827926275070@cwilso3-mobl.ger.corp.intel.com>
 <2d7d3dfc-e7cc-f844-4728-e1dbe13858fe@infradead.org>
 <153090001992.7594.17876223022816534941@cwilso3-mobl.ger.corp.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d1da022b-1a0e-9ed7-a1e7-0ae0cf7bb199@infradead.org>
Date:   Fri, 6 Jul 2018 11:38:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <153090001992.7594.17876223022816534941@cwilso3-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/18 11:00, Chris Wilson wrote:
> Quoting Randy Dunlap (2018-07-06 18:55:57)
>> On 07/06/18 10:51, Chris Wilson wrote:
>>> Quoting Randy Dunlap (2018-07-06 18:48:55)
>>>>
>>>> On 07/06/18 02:44, Chris Wilson wrote:
>>>>> net_dim.h has a rather useful extension to BITS_PER_BYTE to compute the
>>>>> number of bits in a type (BITS_PER_BYTE * sizeof(T)), so promote the
>>>>> macro to bitops.h, alongside BITS_PER_BYTE, for wider usage.
>>>>>
>>>>> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
>>>>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>>>>> Cc: Andy Gospodarek <gospo@broadcom.com>
>>>>> Cc: David S. Miller <davem@davemloft.net>
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: Ingo Molnar <mingo@kernel.org>
>>>>> ---
>>>>>  include/linux/bitops.h  | 3 ++-
>>>>>  include/linux/net_dim.h | 1 -
>>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
>>>>> index 4cac4e1a72ff..091cb17d1a9b 100644
>>>>> --- a/include/linux/bitops.h
>>>>> +++ b/include/linux/bitops.h
>>>>> @@ -11,7 +11,8 @@
>>>>>  #define BIT_ULL_MASK(nr)     (1ULL << ((nr) % BITS_PER_LONG_LONG))
>>>>>  #define BIT_ULL_WORD(nr)     ((nr) / BITS_PER_LONG_LONG)
>>>>>  #define BITS_PER_BYTE                8
>>>>> -#define BITS_TO_LONGS(nr)    DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
>>>>> +#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
>>>>> +#define BITS_TO_LONGS(nr)    DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
>>>>>  #endif
>>>>>  
>>>>>  /*
>>>>
>>>> doesn't <linux/net_dim.h> need to #include <linux/bitops.h> ?
>>>
>>> It already has to in order to obtain BITS_PER_BYTE. Just doesn't do so
>>> directly.
>>
>> Right.  and does that work on all $ARCHes?
> 
> It's a pre-existing dependency in the header, net_dim.h cannot
> compile unless BITS_PER_BYTE is defined i.e. bitops.h is included.
> The patch does not affect that.

Yes, I see.  net_dim.h should have #included bits.h and/or bitops.h previously.

thanks,
-- 
~Randy
