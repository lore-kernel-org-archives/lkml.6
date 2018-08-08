Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A47C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE7921708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE7921708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeHHLl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:41:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:43090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727187AbeHHLl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:41:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B557BACF2;
        Wed,  8 Aug 2018 09:22:33 +0000 (UTC)
Subject: Re: [RFC v6 PATCH 2/2] mm: mmap: zap pages with read mmap_sem in
 munmap
To:     Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
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
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <3f960117-1485-9a61-8468-cb1590494e3c@suse.cz>
Date:   Wed, 8 Aug 2018 11:22:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <04a22c49-fe30-63ac-c1b7-46a405c810e2@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 03:51 AM, Yang Shi wrote:
> On 8/6/18 10:45 PM, Michal Hocko wrote:
>> On Mon 06-08-18 15:19:06, Yang Shi wrote:
>>>
>>> On 8/6/18 1:52 PM, Michal Hocko wrote:
>>>> On Mon 06-08-18 13:48:35, Yang Shi wrote:
>>>>> On 8/6/18 1:41 PM, Michal Hocko wrote:
>>>>>> On Mon 06-08-18 09:46:30, Yang Shi wrote:
>>>>>>> On 8/6/18 2:40 AM, Michal Hocko wrote:
>>>>>>>> On Fri 03-08-18 14:01:58, Yang Shi wrote:
>>>>>>>>> On 8/3/18 2:07 AM, Michal Hocko wrote:
>>>>>>>>>> On Fri 27-07-18 02:10:14, Yang Shi wrote:
>>>>>> [...]
>>>>>>>>>>> If the vma has VM_LOCKED | VM_HUGETLB | VM_PFNMAP or uprobe, they are
>>>>>>>>>>> considered as special mappings. They will be dealt with before zapping
>>>>>>>>>>> pages with write mmap_sem held. Basically, just update vm_flags.
>>>>>>>>>> Well, I think it would be safer to simply fallback to the current
>>>>>>>>>> implementation with these mappings and deal with them on top. This would
>>>>>>>>>> make potential issues easier to bisect and partial reverts as well.
>>>>>>>>> Do you mean just call do_munmap()? It sounds ok. Although we may waste some
>>>>>>>>> cycles to repeat what has done, it sounds not too bad since those special
>>>>>>>>> mappings should be not very common.
>>>>>>>> VM_HUGETLB is quite spread. Especially for DB workloads.
>>>>>>> Wait a minute. In this way, it sounds we go back to my old implementation
>>>>>>> with special handling for those mappings with write mmap_sem held, right?
>>>>>> Yes, I would really start simple and add further enhacements on top.
>>>>> If updating vm_flags with read lock is safe in this case, we don't have to
>>>>> do this. The only reason for this special handling is about vm_flags update.
>>>> Yes, maybe you are right that this is safe. I would still argue to have
>>>> it in a separate patch for easier review, bisectability etc...
>>> Sorry, I'm a little bit confused. Do you mean I should have the patch
>>> *without* handling the special case (just like to assume it is safe to
>>> update vm_flags with read lock), then have the other patch on top of it,
>>> which simply calls do_munmap() to deal with the special cases?
>> Just skip those special cases in the initial implementation and handle
>> each special case in its own patch on top.
> 
> Thanks. VM_LOCKED area will not be handled specially since it is easy to 
> handle it, just follow what do_munmap does. The special cases will just 
> handle VM_HUGETLB, VM_PFNMAP and uprobe mappings.

So I think you could maybe structure code like this: instead of
introducing do_munmap_zap_rlock() and all those "bool skip_vm_flags"
additions, add a boolean parameter in do_munmap() to use the new
behavior, with only the first user SYSCALL_DEFINE2(munmap) setting it to
true. If true, do_munmap() will do the
- down_write_killable() itself instead of assuming it's already locked
- munmap_lookup_vma()
- check if any of the vma's in the range is "special", if yes, change
the boolean param to "false", and continue like previously, e.g. no mmap
sem downgrade etc.

That would be a basis for further optimizing the special vma cases in
subsequent patches (maybe it's really ok to touch the vma flags with
mmap sem for read as vma's are detached), and to eventually convert more
do_munmap() callers to the new mode.

HTH,
Vlastimil




