Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55290C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBF72087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBF72087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeIYNOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:14:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbeIYNOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:14:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AB0F83F40;
        Tue, 25 Sep 2018 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E1B45C226;
        Tue, 25 Sep 2018 07:08:07 +0000 (UTC)
Subject: Re: [PATCH 1/3 v3] resource: fix an error which walks through iomem
 resources
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        bp@suse.de, brijesh.singh@amd.com, dyoung@redhat.com,
        bhe@redhat.com
References: <20180921073211.20097-1-lijiang@redhat.com>
 <20180921073211.20097-2-lijiang@redhat.com>
 <20180924175241.GO224714@bhelgaas-glaptop.roam.corp.google.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <01551d06-c421-5df3-b19f-fc66f3639e4f@redhat.com>
Date:   Tue, 25 Sep 2018 15:08:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924175241.GO224714@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 25 Sep 2018 07:08:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月25日 01:52, Bjorn Helgaas 写道:
> On Fri, Sep 21, 2018 at 03:32:09PM +0800, Lianbo Jiang wrote:
>> When we walk through iomem resources by calling walk_iomem_res_desc(),
>> the values of the function parameter may be modified in the while loop
>> of __walk_iomem_res_desc(), which will cause us to not get the desired
>> result in some cases.
> 
> If I understand correctly, the issue is caused by the interaction
> between __walk_iomem_res_desc() and find_next_iomem_res() in this
> path:
> 
>   __walk_iomem_res_desc
>     find_next_iomem_res
>       res->flags = p->flags;            # <-- problem
> 
> This path is used by the following interfaces, and I think your patch
> would fix the issue for them:
> 
>   walk_iomem_res_desc()
>   walk_system_ram_res()
>   walk_mem_res()
> 
> However, find_next_iomem_res() is also used directly by
> walk_system_ram_range().  I think that path has the same problem, and
> your patch does not fix that path.
> 
Thanks for your comment. 
Originally, my patch 1 only fixed this issue in kdump path, of course, i can
also improve this patch and fix the same issue in walk_system_ram_range().
If you have fixed this issue, it's good to me.

> I have a few more comments related to the existing code that I'll post
> soon.
> 
>> At present, it only restores the original value of res->end, but it
>> doesn't restore the original value of res->flags in the while loop of
>> __walk_iomem _res_desc(). Whenever the find_next_iomem_res() finds a
>> resource and returns the result, the original values of this resource
>> will be modified, which might lead to an error in the next loop. For
>> example:
>>
>> The original value of resource flags is:
>>  res->flags=0x80000200(initial value)
>>
>> p->flags   _ 0x81000200 _                _ 0x80000200 _
>>           /              \              /              \
>> |________|_______A________|____|_....._|______B_________|..........___|
>> 0                                                            0xffffffff
>>                 (memory address ranges)
>>
>> Note: if ((p->flags & res->flags) != res->flags) continue;
>>
>> When the resource A is found, the original value of this resource flags
>> will be changed to 0x81000200(res->flags=0x81000200), and continue to
>> look for the next resource, when the loop reaches resource B, it can not
>> get the resource B any more(you can refer to the for loop of find_next
>> _iomem_res()), because the value of conditional expression will become
>> true and will also jump the resource B.
>>
>> In fact, we should get the resource A and B when we walk through the
>> whole tree, but it only gets the resource A, the resource B is missed.
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  kernel/resource.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index 30e1bc68503b..f5d9fc70a04c 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -375,6 +375,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>>  				 int (*func)(struct resource *, void *))
>>  {
>>  	u64 orig_end = res->end;
>> +	u64 orig_flags = res->flags;
>>  	int ret = -1;
>>  
>>  	while ((res->start < res->end) &&
>> @@ -385,6 +386,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>>  
>>  		res->start = res->end + 1;
>>  		res->end = orig_end;
>> +		res->flags = orig_flags;
>>  	}
>>  
>>  	return ret;
