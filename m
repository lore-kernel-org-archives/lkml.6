Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A49C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3755220867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3755220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIETDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:03:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12758 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeIETDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:03:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4255lq4803z9tvSV;
        Wed,  5 Sep 2018 16:33:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id osML8en1XvK0; Wed,  5 Sep 2018 16:33:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4255lq3WChz9tvSC;
        Wed,  5 Sep 2018 16:33:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A06B8B837;
        Wed,  5 Sep 2018 16:33:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RwoxurArGK2e; Wed,  5 Sep 2018 16:33:11 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 655B18B833;
        Wed,  5 Sep 2018 16:33:11 +0200 (CEST)
Subject: Re: [RFC PATCH v1 00/17] ban the use of _PAGE_XXX flags outside
 platform specific code
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
 <95ee30b8-70b5-0f74-b677-417d3b0ca19e@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d6216a55-307e-ce80-ea37-ca9b5de694a7@c-s.fr>
Date:   Wed, 5 Sep 2018 14:32:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <95ee30b8-70b5-0f74-b677-417d3b0ca19e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2018 02:03 PM, Aneesh Kumar K.V wrote:
> On 09/05/2018 06:06 PM, Christophe Leroy wrote:
>> Today flags like for instance _PAGE_RW or _PAGE_USER are used through
>> common parts of code.
>> Using those directly in common parts of code have proven to lead to
>> mistakes or misbehaviour, because their use is not always as trivial
>> as one could think.
>>
>> For instance, (flags & _PAGE_USER) == 0 isn't enough to tell
>> that a page is a kernel page, because some targets are using
>> _PAGE_PRIVILEDGED and not _PAGE_USER, so the test has to be
>> (flags & (_PAGE_USER | _PAGE_PRIVILEDGED)) == _PAGE_PRIVILEDGED
>> This has to (bad) consequences:
>>
>>   - All targets must define every bit, even the unsupported ones,
>>     leading to a lot of useless #define _PAGE_XXX 0
>>   - If someone forgets to take into account all possible _PAGE_XXX bits
>>     for the case, we can get unexpected behaviour on some targets.
>>
>> This becomes even more complex when we come to using _PAGE_RW.
>> Testing (flags & _PAGE_RW) is not enough to test whether a page
>> if writable or not, because:
>>
>>   - Some targets have _PAGE_RO instead, which has to be unset to tell
>>     a page is writable
>>   - Some targets have _PAGE_R and _PAGE_W, in which case
>>     _PAGE_RW = _PAGE_R | _PAGE_W
>>   - Even knowing whether a page is readable is not always trivial 
>> because:
>>     - Some targets requires to check that _PAGE_R is set to ensure page
>>     is readable
>>     - Some targets requires to check that _PAGE_NA is not set
>>     - Some targets requires to check that _PAGE_RO or _PAGE_RW is set
>>
>> Etc ....
>>
>> In order to work around all those issues and minimise the risks of 
>> errors,
>> this serie aims at removing all use of _PAGE_XXX flags from powerpc code
>> and always use pte_xxx() and pte_mkxxx() accessors instead. Those 
>> accessors
>> are then defined in target specific parts of the kernel code.
> 
> We recently did on book3s 64.
> 
> static inline int pte_present(pte_t pte)
> {
>      /*
>       * A pte is considerent present if _PAGE_PRESENT is set.
>       * We also need to consider the pte present which is marked
>       * invalid during ptep_set_access_flags. Hence we look for 
> _PAGE_INVALID
>       * if we find _PAGE_PRESENT cleared.
>       */
>      return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_INVALID));
> }
> 
> So I guess with that pte_present conversion we need to be careful.
> 
> Do you have a git tree which I can use to double check?

I pushed on branch 'helpers' on https://github.com/chleroy/linux.git

Christophe
