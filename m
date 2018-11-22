Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E7D20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oYnNnC16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E7D20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405027AbeKVS0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:26:16 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19540 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbeKVS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:26:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf65f3a0000>; Wed, 21 Nov 2018 23:48:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 21 Nov 2018 23:48:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Nov 2018 23:48:01 -0800
Received: from [10.2.163.130] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 22 Nov
 2018 07:48:00 +0000
Subject: Re: [PATCH] mm/gup: finish consolidating error handling
To:     Andrew Morton <akpm@linux-foundation.org>, <john.hubbard@gmail.com>
CC:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
References: <20181121081402.29641-1-jhubbard@nvidia.com>
 <20181121081402.29641-2-jhubbard@nvidia.com>
 <20181121144404.efdab6dbccd7780034a55e1d@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b6f9adb2-81d0-ae2e-e8b6-1769452a6c00@nvidia.com>
Date:   Wed, 21 Nov 2018 23:48:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181121144404.efdab6dbccd7780034a55e1d@linux-foundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542872890; bh=/e4mMXJNPzA6WJnKWXFcrYn4TniyxFTAPC5LwDNe8qs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oYnNnC16+zIp/yCHa+PLZxVL4hj7Jt8AGKOKc528RnmwEbLz4JfJSbgwMAL8ZqHdL
         7pJdqKLFvfpanjwDWD3XnrQwy3fYMjoAkyNqnoqCm0EwVObEtxESBOpW1nBwJyG60B
         +xSSUFl0FFvPQSltT2+dGgITyCaSx6BurFwXrt5epyLXRtLAJszNkgI8FZgM1dUO7a
         JtuswrKiJ7XFP3sMebQN4vB3jk9NQ7Lc1wsftkqxUMcwy5MkYDYP4l3OB/mC9FNJGA
         jD0uF8hzUpzGbDDfUID9VwORAWGYA8hg9Ybxro7QPV9AUkbuvvpPnCjjkBf4+m+B+F
         jRJ61EaJll3dA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/18 2:44 PM, Andrew Morton wrote:
> On Wed, 21 Nov 2018 00:14:02 -0800 john.hubbard@gmail.com wrote:
> 
>> Commit df06b37ffe5a4 ("mm/gup: cache dev_pagemap while pinning pages")
>> attempted to operate on each page that get_user_pages had retrieved. In
>> order to do that, it created a common exit point from the routine.
>> However, one case was missed, which this patch fixes up.
>>
>> Also, there was still an unnecessary shadow declaration (with a
>> different type) of the "ret" variable, which this patch removes.
>>
> 
> What is the bug which this supposedly fixes and what is that bug's
> user-visible impact?
> 

Keith's description of the situation is:

  This also fixes a potentially leaked dev_pagemap reference count if a
  failure occurs when an iteration crosses a vma boundary. I don't think
  it's normal to have different vma's on a users mapped zone device memory,
  but good to fix anyway.

I actually thought that this code:

    /* first iteration or cross vma bound */
    if (!vma || start >= vma->vm_end) {
        vma = find_extend_vma(mm, start);
        if (!vma && in_gate_area(mm, start)) {
            ret = get_gate_page(mm, start & PAGE_MASK,
                    gup_flags, &vma,
                    pages ? &pages[i] : NULL);
            if (ret)
                goto out;

...dealt with the "you're trying to pin the gate page, as part of this call",
rather than the generic case of crossing a vma boundary. (I think there's a fine
point that I must be overlooking.) But it's still a valid case, either way.

-- 
thanks,
John Hubbard
NVIDIA
