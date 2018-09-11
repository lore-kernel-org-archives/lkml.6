Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD48C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DDF2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DDF2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeIKK0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:26:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43266 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeIKK0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:26:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 428YNJ36qSz9ttCL;
        Tue, 11 Sep 2018 07:28:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fBx9YVu_OI0Z; Tue, 11 Sep 2018 07:28:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 428YNJ2SW1z9ttCK;
        Tue, 11 Sep 2018 07:28:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D07B8B7D4;
        Tue, 11 Sep 2018 07:28:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ihpfLZbBp2hM; Tue, 11 Sep 2018 07:28:26 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B10098B79F;
        Tue, 11 Sep 2018 07:28:25 +0200 (CEST)
Subject: Re: How to handle PTE tables with non contiguous entries ?
To:     Dan Malek <dan.malek@konsulko.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
 <98C61C92-0D24-41C6-B9DA-8335B34D3B07@konsulko.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7e78d550-abd3-e263-cc34-5b55adaabfa5@c-s.fr>
Date:   Tue, 11 Sep 2018 07:28:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <98C61C92-0D24-41C6-B9DA-8335B34D3B07@konsulko.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/09/2018 à 22:05, Dan Malek a écrit :
> 
> Hello Cristophe.
> 
>> On Sep 10, 2018, at 7:34 AM, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>> On the powerpc8xx, handling 16k size pages requires to have page tables with 4 identical entries.
> 
> Do you think a 16k page is useful?  Back in the day, the goal was to keep the fault handling and management overhead as simple and generic as possible, as you know this affects the system performance.  I understand there would be fewer page faults and more efficient use of the MMU resources with 16k, but if this comes at an overhead cost, is it really worth it?

Yes that's definitly usefull, the current 16k implementation already 
provides nice results, but it is based on the Linux structure, which 
implies not being able to use the 8xx HW assistance in TLBmiss handlers.

That's the reason why I'm trying to alter the Linux structure to match 
the 8xx page layout, hence the need to have 4 entries in the PTE for 
each 16k page.

> 
> In addition to the normal 4k mapping, I had thought about using 512k mapping, which could be easily detected at level 2 (PMD), with a single entry loaded into the MMU.  We would need an aux header or something from the executable/library to assist with knowing when this could be done.  I never got around to it. :)

Yes, 512k and 8M hugepages are implemented as well, but they are based 
on Linux structure, hence requiring some time consuming handling like 
checking the page size on every miss in order to run the appropriate 
part of the handler.

With the HW layout, the 512k entries are spread every 128 bytes in the 
PTE table but with those I don't have much problem because the hugepage 
code uses huge_pte_offset() and never increase the pte pointer directly.


> 
> The 8xx platforms tended to have smaller memory resources, so the 4k granularity was also useful in making better use of the available space.

Well, on my boards I have 128Mbytes, 16k page and hugepages have shown 
their benefit.

> 
>> Would someone have an idea of an elegent way to handle that ?
> 
> My suggestion would be to not change the PTE table, but have the fault handler detect a 16k page and load any one of the four entries based upon miss offset.  Kinda use the same 4k miss hander, but with 16k knowledge.  You wouldn’t save any PTE table space, but the MMU efficiency may be worth it.  As I recall, the hardware may ignore/mask any LS bits, and there is PMD level information to utilize as well.

That's exactly what I want to do, which means that everytime pte++ is 
encountered in some mm/memory.c file needs to push the index to the next 
16k page ie increase the pointer by 4 entries.

> 
> It’s been a long time since I’ve investigated how things have evolved, glad it’s still in use, and I hope you at least have some fun with the development :)

Thanks
Christophe

