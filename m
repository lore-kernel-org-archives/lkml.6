Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED8DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026ED20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YAPZ7hYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfAQK7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:59:38 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12233 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbfAQK7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:59:35 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43gLgS1XXHz9v2C2;
        Thu, 17 Jan 2019 11:59:32 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=YAPZ7hYs; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 46iSN4xSOAEa; Thu, 17 Jan 2019 11:59:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43gLgR74jzz9v2By;
        Thu, 17 Jan 2019 11:59:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1547722772; bh=j1qBj5EFQPkYjhifaDgiu5IwIYflUbomCpdiIJbHl/U=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=YAPZ7hYsHmTktDoksvOoxa2yyn51SEVR72WkZZ38CaF1XeW5ZhNiY7OaiolfkllOJ
         ucbVpENyb82HZnuOu18Rbu2naXfZi5E1CA8lpbl5x5p4HT9YP9tNy61TC2rV8lcqTu
         D1MhpnINTPGbPCPv30HRLc4UIOPF07KBQs9ZC9iQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2AAAB8B858;
        Thu, 17 Jan 2019 11:59:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id srtPCZbvyH-Y; Thu, 17 Jan 2019 11:59:33 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C8918B75B;
        Thu, 17 Jan 2019 11:59:32 +0100 (CET)
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RESENDING PATCH] powerpc/wii: properly disable use of BATs when
 requested.
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org
References: <7e6748349978f4f177b6a1f3f1c773da98ae3b59.1547570012.git.christophe.leroy@c-s.fr>
 <20190117010509.GH22334@latitude>
Message-ID: <19fd4dd4-ece2-d508-1ed5-5a9ed2aa84fe@c-s.fr>
Date:   Thu, 17 Jan 2019 11:29:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117010509.GH22334@latitude>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/01/2019 à 02:05, Jonathan Neuschäfer a écrit :
> Hi again,
> 
> On Tue, Jan 15, 2019 at 04:43:20PM +0000, Christophe Leroy wrote:
>> 'nobats' kernel parameter or some options like CONFIG_DEBUG_PAGEALLOC
>> deny the use of BATS for mapping memory.
>>
>> This patch makes sure that the specific wii RAM mapping function
>> takes it into account as well.
>>
>> Fixes: de32400dd26e ("wii: use both mem1 and mem2 as ram")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
> [...]
>>   	/* MEM2 64MB@0x10000000 */
>>   	delta = wii_hole_start + wii_hole_size;
>> +	if (__map_without_bats)
>> +		return delta;
>> +
> 
> Nothing is visibly broken without this patch, even with
> CONFIG_DEBUG_PAGEALLOC (tested on top of v5.0-rc2), but the patch still
> looks correct.

Obviously, CONFIG_DEBUG_PAGEALLOC cannot work without this patch.
The purpose of CONFIG_DEBUG_PAGEALLOC is to unmap unused parts of memory 
so that any access to them will pagefault.

As this function inconditionnaly sets a BAT for the second block of RAM, 
any access to free area in the upper block will be granted without a fault.

I think you can test it by doing a kmalloc() then a kfree(), then try to 
read in that area (hopefully kmalloc() allocates memory from the top so 
it should go in the upper block). Maybe there is an LKDTM test for that.

> 
> I'd prefer the 'if' block to be before the whole delta/size calculation,
> to make the code slightly more readable because the delta and size
> calculations stay in one visual block. It doesn't need to happen after
> delta is calculated.

Euh ... the function has to return 'delta', so if I put the if block 
before the calculation of delta, it means we have to calculate delta twice:

	if (__map_without_bats)
		return wii_hole_start + wii_hole_size;

	delta = wii_hole_start + wii_hole_size;

My eyes don't really like it, so if we want to keep delta and size 
calculation together, the 'if' will go after calculation of size.

In anycase, this change is only really for fixing stable releases 
because this function will go away with my other serie.

Christophe

> 
> tentatively,
> Reviewed-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> 
> 
> Thanks,
> Jonathan
> 
