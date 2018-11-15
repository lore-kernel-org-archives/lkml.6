Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6FEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C5120854
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GzZBuqL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C5120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbeKOKvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:51:35 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17770 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeKOKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:51:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5becc1b40001>; Wed, 14 Nov 2018 16:45:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 14 Nov 2018 16:45:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 14 Nov 2018 16:45:59 -0800
Received: from ngvpn01-165-105.dyn.scz.us.nvidia.com (172.20.13.39) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 15 Nov 2018 00:45:58 +0000
Subject: Re: [PATCH v2 1/6] mm/gup: finish consolidating error handling
To:     Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
CC:     John Hubbard <john.hubbard@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
References: <20181110085041.10071-1-jhubbard@nvidia.com>
 <20181110085041.10071-2-jhubbard@nvidia.com>
 <20181112154127.GA8247@localhost.localdomain>
 <CAPcyv4j7nqLOFD5dZEe_nBysHDL2pQ-tRO9Crp9oyTUP7RoDHw@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <da9907a9-3150-15c3-fb4e-460d63fc5a1f@nvidia.com>
Date:   Wed, 14 Nov 2018 16:45:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4j7nqLOFD5dZEe_nBysHDL2pQ-tRO9Crp9oyTUP7RoDHw@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542242741; bh=U41ZC4geVVvMHx+mM0ibMk8kLN4aKbTJsEDe/zn0p8E=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GzZBuqL4r/IJGkNkt6V/OS+Ux1QM/aTE0rMWXi3EuNiuEtY7nFf4+yd55BDI7NlGR
         HLZ91Tdv7B4Bltq2nkDxTt/IjsYv7XbXDdgi1MGoQjsheAPRxsgjSQbYdninpSjiOZ
         HERSO38iJ26AOsOKYIdxl4aT2evEY3jfd2R7UV1W25Avb6SCxoP6koaPxKArgrEqqC
         YKCzzU+yTF7kdpw2IM6qgGd5aFeBlbvl/Lo8kIs46O9hrMuTBWnC+dzShUPy8ksls+
         drY0oszsCrL1ZdGyLVn33voz2oR7nUAMLOO2acs3OIu16ZNMQGYZvQuP1iLcwvAaW1
         EhELCoeq2wl5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 8:14 AM, Dan Williams wrote:
> On Mon, Nov 12, 2018 at 7:45 AM Keith Busch <keith.busch@intel.com> wrote:
>>
>> On Sat, Nov 10, 2018 at 12:50:36AM -0800, john.hubbard@gmail.com wrote:
>>> From: John Hubbard <jhubbard@nvidia.com>
>>>
>>> An upcoming patch wants to be able to operate on each page that
>>> get_user_pages has retrieved. In order to do that, it's best to
>>> have a common exit point from the routine. Most of this has been
>>> taken care of by commit df06b37ffe5a4 ("mm/gup: cache dev_pagemap while
>>> pinning pages"), but there was one case remaining.
>>>
>>> Also, there was still an unnecessary shadow declaration (with a
>>> different type) of the "ret" variable, which this commit removes.
>>>
>>> Cc: Keith Busch <keith.busch@intel.com>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>> ---
>>>   mm/gup.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index f76e77a2d34b..55a41dee0340 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -696,12 +696,11 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>>>                if (!vma || start >= vma->vm_end) {
>>>                        vma = find_extend_vma(mm, start);
>>>                        if (!vma && in_gate_area(mm, start)) {
>>> -                             int ret;
>>>                                ret = get_gate_page(mm, start & PAGE_MASK,
>>>                                                gup_flags, &vma,
>>>                                                pages ? &pages[i] : NULL);
>>>                                if (ret)
>>> -                                     return i ? : ret;
>>> +                                     goto out;
>>>                                ctx.page_mask = 0;
>>>                                goto next_page;
>>>                        }
>>
>> This also fixes a potentially leaked dev_pagemap reference count if a
>> failure occurs when an iteration crosses a vma boundary. I don't think
>> it's normal to have different vma's on a users mapped zone device memory,
>> but good to fix anyway.
> 
> Does not sound abnormal to me, we should promote this as a fix for the
> current cycle with an updated changelog.
> 

Andrew, should I send this patch separately, or do you have what you 
need already?

thanks,
-- 
John Hubbard
NVIDIA
