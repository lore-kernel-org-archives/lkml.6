Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6074CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C80420863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UImav6xj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfBKG0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:26:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55663 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfBKG0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:26:53 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43ybR94nTDz9tyv7;
        Mon, 11 Feb 2019 07:26:45 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UImav6xj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id F0Uehg3cyFmr; Mon, 11 Feb 2019 07:26:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43ybR93m3Dz9tyv6;
        Mon, 11 Feb 2019 07:26:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1549866405; bh=pP+qBsacOc7BX7HqUMyCGXaWaf0LuL8H6j/y+Qb/DfE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UImav6xj6WD5+YiGnMf9PKlhmQmGaSW/NOp2WOAyj/o6DenNrA1ZCb7uzh68UNLi3
         nsJhA3fjmmi+WsNS1TxBdxtCXwwtpOFKos3SjcfOnASGkjuZw6BaWHDYDFl34M0VXF
         oO3yLP/LXlBIW3OTMYvKhSkkWqwWVo5oz3E8ouKg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B300C8B791;
        Mon, 11 Feb 2019 07:26:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mQFX59vvXYKb; Mon, 11 Feb 2019 07:26:51 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 848E58B74C;
        Mon, 11 Feb 2019 07:26:51 +0100 (CET)
Subject: Re: [PATCH v1 03/16] powerpc/32: move LOAD_MSR_KERNEL() into
 head_32.h and use it
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1549630193.git.christophe.leroy@c-s.fr>
 <1946d8ed86a92a9a6827ec260d0d9c99e0d88184.1549630193.git.christophe.leroy@c-s.fr>
 <749f719a0881531cad2071a7011dc5e894812d3d.camel@kernel.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b074648b-8896-5591-16fe-3ecaf5c7553a@c-s.fr>
Date:   Mon, 11 Feb 2019 07:26:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <749f719a0881531cad2071a7011dc5e894812d3d.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/02/2019 à 01:21, Benjamin Herrenschmidt a écrit :
> On Fri, 2019-02-08 at 12:52 +0000, Christophe Leroy wrote:
>>   /*
>> + * MSR_KERNEL is > 0x8000 on 4xx/Book-E since it include MSR_CE.
>> + */
>> +.macro __LOAD_MSR_KERNEL r, x
>> +.if \x >= 0x8000
>> +       lis \r, (\x)@h
>> +       ori \r, \r, (\x)@l
>> +.else
>> +       li \r, (\x)
>> +.endif
>> +.endm
>> +#define LOAD_MSR_KERNEL(r, x) __LOAD_MSR_KERNEL r, x
>> +
> 
> You changed the limit from >= 0x10000 to >= 0x8000 without a
> corresponding explanation as to why...

Yes, the existing LOAD_MSR_KERNEL() was buggy because 'li' takes a 
signed u16, ie between -0x8000 and 0x7999.

By chance it was working because until now nobody was trying to set 
MSR_KERNEL | MSR_EE.

Christophe
