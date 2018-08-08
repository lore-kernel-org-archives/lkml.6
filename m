Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE43C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4706F216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4706F216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeHHTlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:41:01 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36647 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727706AbeHHTlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:41:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T6Gr7pI_1533748797;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T6Gr7pI_1533748797)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Aug 2018 01:20:00 +0800
Subject: Re: [RFC v6 PATCH 2/2] mm: mmap: zap pages with read mmap_sem in
 munmap
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
Cc:     willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1532628614-111702-1-git-send-email-yang.shi@linux.alibaba.com>
 <1532628614-111702-3-git-send-email-yang.shi@linux.alibaba.com>
 <20180803090759.GI27245@dhcp22.suse.cz>
 <aff7e86d-2e48-ff58-5d5d-9c67deb68674@linux.alibaba.com>
 <20180806094005.GG19540@dhcp22.suse.cz>
 <76c0fc2b-fca7-9f22-214a-920ee2537898@linux.alibaba.com>
 <20180806204119.GL10003@dhcp22.suse.cz>
 <28de768b-c740-37b3-ea5a-8e2cb07d2bdc@linux.alibaba.com>
 <20180806205232.GN10003@dhcp22.suse.cz>
 <0cdff13a-2713-c5be-a33e-28c07e093bcc@linux.alibaba.com>
 <20180807054524.GQ10003@dhcp22.suse.cz>
 <04a22c49-fe30-63ac-c1b7-46a405c810e2@linux.alibaba.com>
 <3f960117-1485-9a61-8468-cb1590494e3c@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <907e441d-43e2-9a57-a3fd-deb533046b6c@linux.alibaba.com>
Date:   Wed, 8 Aug 2018 10:19:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3f960117-1485-9a61-8468-cb1590494e3c@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/18 2:22 AM, Vlastimil Babka wrote:
> On 08/08/2018 03:51 AM, Yang Shi wrote:
>> On 8/6/18 10:45 PM, Michal Hocko wrote:
>>> On Mon 06-08-18 15:19:06, Yang Shi wrote:
>>>> On 8/6/18 1:52 PM, Michal Hocko wrote:
>>>>> On Mon 06-08-18 13:48:35, Yang Shi wrote:
>>>>>> On 8/6/18 1:41 PM, Michal Hocko wrote:
>>>>>>> On Mon 06-08-18 09:46:30, Yang Shi wrote:
>>>>>>>> On 8/6/18 2:40 AM, Michal Hocko wrote:
>>>>>>>>> On Fri 03-08-18 14:01:58, Yang Shi wrote:
>>>>>>>>>> On 8/3/18 2:07 AM, Michal Hocko wrote:
>>>>>>>>>>> On Fri 27-07-18 02:10:14, Yang Shi wrote:
>>>>>>> [...]
>>>>>>>>>>>> If the vma has VM_LOCKED | VM_HUGETLB | VM_PFNMAP or uprobe, they are
>>>>>>>>>>>> considered as special mappings. They will be dealt with before zapping
>>>>>>>>>>>> pages with write mmap_sem held. Basically, just update vm_flags.
>>>>>>>>>>> Well, I think it would be safer to simply fallback to the current
>>>>>>>>>>> implementation with these mappings and deal with them on top. This would
>>>>>>>>>>> make potential issues easier to bisect and partial reverts as well.
>>>>>>>>>> Do you mean just call do_munmap()? It sounds ok. Although we may waste some
>>>>>>>>>> cycles to repeat what has done, it sounds not too bad since those special
>>>>>>>>>> mappings should be not very common.
>>>>>>>>> VM_HUGETLB is quite spread. Especially for DB workloads.
>>>>>>>> Wait a minute. In this way, it sounds we go back to my old implementation
>>>>>>>> with special handling for those mappings with write mmap_sem held, right?
>>>>>>> Yes, I would really start simple and add further enhacements on top.
>>>>>> If updating vm_flags with read lock is safe in this case, we don't have to
>>>>>> do this. The only reason for this special handling is about vm_flags update.
>>>>> Yes, maybe you are right that this is safe. I would still argue to have
>>>>> it in a separate patch for easier review, bisectability etc...
>>>> Sorry, I'm a little bit confused. Do you mean I should have the patch
>>>> *without* handling the special case (just like to assume it is safe to
>>>> update vm_flags with read lock), then have the other patch on top of it,
>>>> which simply calls do_munmap() to deal with the special cases?
>>> Just skip those special cases in the initial implementation and handle
>>> each special case in its own patch on top.
>> Thanks. VM_LOCKED area will not be handled specially since it is easy to
>> handle it, just follow what do_munmap does. The special cases will just
>> handle VM_HUGETLB, VM_PFNMAP and uprobe mappings.
> So I think you could maybe structure code like this: instead of
> introducing do_munmap_zap_rlock() and all those "bool skip_vm_flags"
> additions, add a boolean parameter in do_munmap() to use the new
> behavior, with only the first user SYSCALL_DEFINE2(munmap) setting it to
> true. If true, do_munmap() will do the
> - down_write_killable() itself instead of assuming it's already locked
> - munmap_lookup_vma()
> - check if any of the vma's in the range is "special", if yes, change
> the boolean param to "false", and continue like previously, e.g. no mmap
> sem downgrade etc.

Thanks for the suggestion. Actually, I did the similar thing in v1 
patches, which added a bool parameter in vm_munmap() to tell if 
releasing mmap_sem is acceptable for some code paths. But, it got pushed 
back by tglx since vm_munmap() is called by x86 specific code too (and 
some other architectures). He suggested to define a new function to do 
the optimization. So, I followed this approach in the later versions.

Yang

>
> That would be a basis for further optimizing the special vma cases in
> subsequent patches (maybe it's really ok to touch the vma flags with
> mmap sem for read as vma's are detached), and to eventually convert more
> do_munmap() callers to the new mode.
>
> HTH,
> Vlastimil
>
>
>

