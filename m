Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07071C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847232152C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847232152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeI0RsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:48:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45175 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbeI0RsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:48:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42LXfl1s34z9ttFM;
        Thu, 27 Sep 2018 13:30:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SF4lMWjC3Xv9; Thu, 27 Sep 2018 13:30:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42LXfl12LRz9ttBq;
        Thu, 27 Sep 2018 13:30:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 609D18B894;
        Thu, 27 Sep 2018 13:30:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2WT3prtNIOXq; Thu, 27 Sep 2018 13:30:23 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0BE28B75A;
        Thu, 27 Sep 2018 13:30:22 +0200 (CEST)
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, stable@vger.kernel.org,
        me@tobin.cc
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
 <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org>
 <760ed3ff-43d9-75e5-b36c-aaa7871ffe50@c-s.fr>
 <877ej7urh3.fsf@concordia.ellerman.id.au>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7cf2d115-a58b-4585-37fc-7e58169a43a3@c-s.fr>
Date:   Thu, 27 Sep 2018 13:30:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <877ej7urh3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/09/2018 à 13:09, Michael Ellerman a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> Le 26/09/2018 à 13:11, Daniel Thompson a écrit :
>>> On 16/09/2018 20:06, Daniel Thompson wrote:
>>>> On Fri, Sep 14, 2018 at 12:35:44PM +0000, Christophe Leroy wrote:
>>>>> On a powerpc 8xx, 'btc' fails as follows:
>>>>> Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
> ...
>>>>>
>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>> Cc: <stable@vger.kernel.org> # 4.15+
>>>>
>>>> Would a Fixes: be better here?
>>>> Fixes: ad67b74d2469d9b82 ("printk: hash addresses printed with %p")
>>>
>>> Christophe, When you add the Fixes: could you also add my
>>>
>>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>>
>> Ok, thanks for the review, but do I have to do anything really ?
>>
>> The Fixes: and now your Reviewed-by: appear automatically in patchwork
>> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=65715),
>> so I believe they'll be automatically included when Jason or someone
>> else takes the patch, no ?
> 
> patchwork won't add the Fixes tag from the reply, it needs to be in the
> original mail.
> 
> See:
>    https://github.com/getpatchwork/patchwork/issues/151
> 

Ok, so it accounts it and adds a '1' in the F column in the patches 
list, but won't take it into account.

Then I'll send a v2 with revised commit text.

Christophe
