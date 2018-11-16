Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153ADC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6702089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6702089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeKPUcl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:32:41 -0500
Received: from ozlabs.org ([203.11.71.1]:49779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbeKPUcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:32:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42xDlY43MJz9sBQ;
        Fri, 16 Nov 2018 21:20:57 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        rashmicy@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: dump block address translation on book3s/32
In-Reply-To: <9cb14c1f-02ce-a2a5-94e6-95afb4d3e168@c-s.fr>
References: <26cc609706833f78e3195e3d35c0372b2f40cae3.1542181167.git.christophe.leroy@c-s.fr> <878t1uva0q.fsf@concordia.ellerman.id.au> <9cb14c1f-02ce-a2a5-94e6-95afb4d3e168@c-s.fr>
Date:   Fri, 16 Nov 2018 21:20:56 +1100
Message-ID: <87o9ap2uif.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 15/11/2018 à 12:46, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> 
>>> This patch adds a debugfs file to dump block address translation:
>>>
>>> ~# cat /sys/kernel/debug/block_address_translation
>> 
>> My instinct is it should be in /sys/kernel/debug/powerpc. But I guess
>> the other page table dump files are not.
>
> Lol.
>
> Looks like we have the same instinct ...
>
> But you rejected my patch https://patchwork.ozlabs.org/patch/750426/ :)

Haha. My argument was that the kernel page table dump is not powerpc
specific, but this file *is* powerpc specific. Though I guess it's in
the same are as the page table / hash table dump, so it may as well live
next to them.

>>> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
>>> index ca96e7be4d0e..2adad10b5856 100644
>>> --- a/arch/powerpc/mm/Makefile
>>> +++ b/arch/powerpc/mm/Makefile
>>> @@ -47,7 +47,7 @@ ifdef CONFIG_PPC_PTDUMP
>>>   obj-$(CONFIG_4xx)		+= dump_linuxpagetables-generic.o
>>>   obj-$(CONFIG_PPC_8xx)		+= dump_linuxpagetables-8xx.o
>>>   obj-$(CONFIG_PPC_BOOK3E_MMU)	+= dump_linuxpagetables-generic.o
>>> -obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o
>>> +obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o dump_bats.o
>> 
>> BOOK3S_32 covers quite a lot of CPUs.
>> 
>> But below the only check is that you're on 601 or 603.
>> 
>> So is the 603 code going to work on all other BOOK3S_32 CPUs?
>
> If I understand function setbat() correctly, it should.
>
> See 
> https://elixir.bootlin.com/linux/v4.20-rc1/source/arch/powerpc/mm/ppc_mmu_32.c#L115 
> Tell me if you see something I missed.

I don't know those 32-bit CPUs at all, so as long as you've thought
about it that's good enough for me. We can catch bugs in testing anyway.

cheers
