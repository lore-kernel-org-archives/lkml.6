Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8122150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8122150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeHXOot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:44:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6600 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeHXOot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:44:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41xdqb1g4yz9tvNY;
        Fri, 24 Aug 2018 13:10:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Xnxot4He7S4i; Fri, 24 Aug 2018 13:10:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41xdqb19CPz9tvMl;
        Fri, 24 Aug 2018 13:10:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 12BD58B8D8;
        Fri, 24 Aug 2018 13:10:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tsdZFJ5Pnso1; Fri, 24 Aug 2018 13:10:38 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DF1CF8B74C;
        Fri, 24 Aug 2018 13:10:37 +0200 (CEST)
Subject: Re: [PATCH] drivers/video/fbdev: use ioremap_wc() instead of
 __ioremap(_PAGE_NO_CACHE)
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <0fe514f6e105a2c7f773679a14fce80216594a9b.1535103285.git.christophe.leroy@c-s.fr>
 <20180824110548.GV24439@gate.crashing.org>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <78342b34-1a47-26a5-1636-0f7f64588c73@c-s.fr>
Date:   Fri, 24 Aug 2018 13:10:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824110548.GV24439@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/08/2018 à 13:05, Segher Boessenkool a écrit :
> On Fri, Aug 24, 2018 at 10:16:22AM +0000, Christophe Leroy wrote:
>> _PAGE_NO_CACHE is a target specific flag. Prefer generic functions.
> 
>>   #ifdef CONFIG_PPC
>> -	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
>> +	p->screen_base = ioremap_wc(addr, 0x200000);
>>   #else
> 
> But that is not the same.  I think you want ioremap_nocache?
> 
> 

No, ioremap_nocache() is _PAGE_NO_CACHE | _PAGE_GUARDED



/arch/powerpc/include/asm/io.h

#define ioremap_nocache(addr, size)	ioremap((addr), (size))


/arch/powerpc/mm/pgtable_32.c:

void __iomem *
ioremap_wc(phys_addr_t addr, unsigned long size)
{
	return __ioremap_caller(addr, size, _PAGE_NO_CACHE,
				__builtin_return_address(0));
}

void __iomem *
ioremap(phys_addr_t addr, unsigned long size)
{
	return __ioremap_caller(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED,
				__builtin_return_address(0));
}

Christophe
