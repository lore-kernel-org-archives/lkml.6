Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EFDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE132086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LNkE7jTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE132086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJKB1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:27:06 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12446 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJKB1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:27:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bbe3f090000>; Wed, 10 Oct 2018 11:03:53 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 10 Oct 2018 11:03:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 10 Oct 2018 11:03:50 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 10 Oct
 2018 18:03:50 +0000
Subject: Re: [PATCH] mm: don't clobber partially overlapping VMA with
 MAP_FIXED_NOREPLACE
To:     Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        <abdhalee@linux.vnet.ibm.com>, <joel@jms.id.au>,
        Kees Cook <keescook@chromium.org>, <jasone@google.com>,
        <davidtgoldblatt@gmail.com>, <trasz@freebsd.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Daniel Micay <danielmicay@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20181010152736.99475-1-jannh@google.com>
 <20181010171944.GJ5873@dhcp22.suse.cz>
 <CAG48ez04KK62doMwsTVN4nN8y_wmv7hn+4my2jk5VXKL0wP7Lg@mail.gmail.com>
 <20181010173857.GM5873@dhcp22.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <93ee9489-d4cc-70e2-40fa-c78cf17add9a@nvidia.com>
Date:   Wed, 10 Oct 2018 11:03:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181010173857.GM5873@dhcp22.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539194633; bh=U2eCKJZikg+eSbVdj6YDHupLXDhEXhx4G8/UWkANYZk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LNkE7jTNHYbLpvi6JmlMJAOBJLgrF42FX5HQ9jt2pi46281eJfdGo6R7KL9L7Nukh
         42k2unDzeKozLq1HmngBkMf+uGv3wsE83+1+xDqSRZg5JXvlRyvUdRd5TmF8DI7AIV
         Q25pQIkleWdym8cuT+ndAh75RDTpoV5o3rdjwAMTOkbu+dA6aHiK1UzJnUO15+H27D
         mH/QS6qAHKTvQe1x2+9XoXQ+a+aoSxwYMI7MzfPBbhRpKXMI8Swz6jH5AUu065HvQN
         YnsK30RiR2sX4f29zk464UJGThhDxbmDLhAC+h/TNcxI+ctTpFFOhSV0W5QHZ6MXHA
         zKtdzDsbwKqfg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 10:38 AM, Michal Hocko wrote:
> On Wed 10-10-18 19:26:50, Jann Horn wrote:
> [...]
>> As you can see, the first page of the mapping at 0x10001000 was clobbered.
>>
>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>> index 5f2b2b184c60..f7cd9cb966c0 100644
>>>> --- a/mm/mmap.c
>>>> +++ b/mm/mmap.c
>>>> @@ -1410,7 +1410,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>>>>       if (flags & MAP_FIXED_NOREPLACE) {
>>>>               struct vm_area_struct *vma = find_vma(mm, addr);
>>>>
>>>> -             if (vma && vma->vm_start <= addr)
>>>> +             if (vma && vma->vm_start < addr + len)
>>>
>>> find_vma is documented to - Look up the first VMA which satisfies addr <
>>> vm_end, NULL if none.
>>> This means that the above check guanratees that
>>>         vm_start <= addr < vm_end
>>> so an overlap is guanrateed. Why should we care how much we overlap?
>>
>> "an overlap is guaranteed"? I have no idea what you're trying to say.
> 
> I have misread your changelog and the patch. Sorry about that. I thought
> you meant a false possitive but you in fact meant false negative. Now it
> makes complete sense.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> And thanks a lot for catching that!
> 

This also looks good to me. 

thanks,
-- 
John Hubbard
NVIDIA
