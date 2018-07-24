Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CBA20844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CBA20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbeGXTEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:04:21 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43261 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388386AbeGXTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:04:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T5GDPxi_1532454991;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T5GDPxi_1532454991)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Jul 2018 01:56:36 +0800
Subject: Re: [RFC v5 PATCH 2/2] mm: mmap: zap pages with read mmap_sem in
 munmap
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>, mhocko@kernel.org,
        willy@infradead.org, kirill@shutemov.name,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1531956101-8526-1-git-send-email-yang.shi@linux.alibaba.com>
 <1531956101-8526-3-git-send-email-yang.shi@linux.alibaba.com>
 <25fca2a1-0a55-13eb-0c75-6d0238fe780b@linux.vnet.ibm.com>
 <b8c128c4-3a8e-ed17-2d9f-76f71bfdad43@linux.alibaba.com>
 <e9553340-3b8d-bc26-781d-8a6a8716bc8f@linux.vnet.ibm.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <02228f42-438b-7840-5653-f076fc190f14@linux.alibaba.com>
Date:   Tue, 24 Jul 2018 10:56:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e9553340-3b8d-bc26-781d-8a6a8716bc8f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +static int vm_munmap_zap_rlock(unsigned long start, size_t len)
>>>> +{
>>>> +    int ret;
>>>> +    struct mm_struct *mm = current->mm;
>>>> +    LIST_HEAD(uf);
>>>> +
>>>> +    ret = do_munmap_zap_rlock(mm, start, len, &uf);
>>>> +    userfaultfd_unmap_complete(mm, &uf);
>>>> +    return ret;
>>>> +}
>>>> +
>>>>    int vm_munmap(unsigned long start, size_t len)
>>>>    {
>>>>        int ret;
>>> A stupid question, since the overhead of vm_munmap_zap_rlock() compared to
>>> vm_munmap() is not significant, why not putting that in vm_munmap() instead of
>>> introducing a new vm_munmap_zap_rlock() ?
>> Since vm_munmap() is called in other paths too, i.e. drm driver, kvm, etc. I'm
>> not quite sure if those paths are safe enough to this optimization. And, it
>> looks they are not the main sources of the latency, so here I introduced
>> vm_munmap_zap_rlock() for munmap() only.
> For my information, what could be unsafe for these paths ?

I'm just not sure if they are safe enough nor not, because I'm not 
knowledgeable enough to kvm and drm drivers. They might be safe, but I 
don't know how to prove that.

So, since they might be not the main sources of latency (I haven't seen 
any hung report due to them), so it sounds safe to not touch them for now.

>
>> If someone reports or we see they are the sources of latency too, and the
>> optimization is proved safe to them, we can definitely extend this to all
>> vm_munmap() calls
>>
>> Thanks,
>> Yang
>>
>>>> @@ -2855,10 +2939,9 @@ int vm_munmap(unsigned long start, size_t len)
>>>>    SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
>>>>    {
>>>>        profile_munmap(addr);
>>>> -    return vm_munmap(addr, len);
>>>> +    return vm_munmap_zap_rlock(addr, len);
>>>>    }
>>>>
>>>> -
>>>>    /*
>>>>     * Emulation of deprecated remap_file_pages() syscall.
>>>>     */
>>>> @@ -3146,7 +3229,7 @@ void exit_mmap(struct mm_struct *mm)
>>>>        tlb_gather_mmu(&tlb, mm, 0, -1);
>>>>        /* update_hiwater_rss(mm) here? but nobody should be looking */
>>>>        /* Use -1 here to ensure all VMAs in the mm are unmapped */
>>>> -    unmap_vmas(&tlb, vma, 0, -1);
>>>> +    unmap_vmas(&tlb, vma, 0, -1, false);
>>>>        free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
>>>>        tlb_finish_mmu(&tlb, 0, -1);
>>>>

