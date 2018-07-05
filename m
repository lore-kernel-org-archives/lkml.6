Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB78C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1271B20C0D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1271B20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754044AbeGEQdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:33:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59906 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753347AbeGEQdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:33:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41M3Lq5fwVz9tvS6;
        Thu,  5 Jul 2018 18:33:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZrTaBBYIVzDw; Thu,  5 Jul 2018 18:33:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41M3Lq55qlz9tvS5;
        Thu,  5 Jul 2018 18:33:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A3EC8B8CF;
        Thu,  5 Jul 2018 18:33:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ov2dSAwXfnNS; Thu,  5 Jul 2018 18:33:09 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6584A8B8BC;
        Thu,  5 Jul 2018 18:33:09 +0200 (CEST)
Subject: Re: [PATCH V2 00/10] KASan ppc64 support
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGyMBnGJyBCoq2n9YSgC73GXr9-w3SjCTVdfz++drzOVGw@mail.gmail.com>
 <87k2sic6pw.fsf@linux.vnet.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7d459964-ce68-db1c-3d28-ae206d5ebdb0@c-s.fr>
Date:   Thu, 5 Jul 2018 18:33:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87k2sic6pw.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aneesh,

Are you still working on support for KASan for ppc64 ?

Thanks,
Christophe


Le 26/08/2015 à 19:14, Aneesh Kumar K.V a écrit :
> Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:
> 
>> 2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>>> Hi,
>>>
>>> This patchset implements kernel address sanitizer for ppc64.
>>> Since ppc64 virtual address range is divided into different regions,
>>> we can't have one contigous area for the kasan shadow range. Hence
>>> we don't support the INLINE kasan instrumentation. With Outline
>>> instrumentation, we override the shadow_to_mem and mem_to_shadow
>>> callbacks, so that we map only the kernel linear range (ie,
>>> region with ID 0xc). For region with ID 0xd and 0xf (vmalloc
>>> and vmemmap ) we return the address of the zero page. This
>>> works because kasan doesn't track both vmemmap and vmalloc address.
>>>
>>> Known issues:
>>> * Kasan is not yet enabled for arch/powerpc/kvm
>>> * kexec hang
>>> * outline stack and global support
>>>
>>
>> Is there any problem with globals or you just didn't try it yet?
>> I think it should just work. You need only to add  --param
>> asan-globals=0 to KBUILD_CFLAGS_MODULE
>> to disable it for modules.
> 
> I am hitting BUG_ON in early vmalloc code. I still haven't got time to
> debug it further. Should get to that soon.
> 
> -aneesh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
