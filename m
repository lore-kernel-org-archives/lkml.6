Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2192086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ecbPQJXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2192086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390140AbeKQDNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:13:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50464 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbeKQDNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=upP0x0LsDyDsUPrJpguytuw1H/Vm0SYnikujVZ3lBiw=; b=ecbPQJXT4EBOWg5gxAuoq+2hIZ
        YwLYo4BCQ1cgUTRTdm/nn0v8a2sieEkpyTXP0SmATtZkWOOUfd0UlgTMx0ixFyNe4zwq9nLfX7pvN
        HIHIfP6Sd60Cj+OQizBHpqK0u4V8u6dlKoa47Dt4XN06RwbPH5V4RBXno0Iua1568nvYeP9NgEwJ0
        kol0F1jY8rMrNz9S1m3rdzU6YgvQJsDMmxXhPSbTdrPbD5UwMe3CfusaSarU4+6Yy1Ij5p9uRrw20
        eTqM7AhqPvs88nd7Tf9EVd9Xf5GzXu7O1zcfjLdlunQZJsdDxVDgsMFeJ/eNJYo6R719f5DRj7m8e
        ISGS9rmg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNhSy-0002yZ-BC; Fri, 16 Nov 2018 16:59:36 +0000
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, Rik van Riel <riel@surriel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>,
        mchehab@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <9655a12e-bd3d-aca2-6155-38924028eb5d@infradead.org>
 <CAFqt6zbLjtDab3Bz67trbnQRQdutvgA=YvAFhoW4bxsg657mGQ@mail.gmail.com>
 <20181116064049.GA5320@bombadil.infradead.org>
 <CAFqt6zbL1tu4VWtZ5Wz-BgbOS+M2GJziMj958_h_ri4Th3n9bQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b54491c4-c119-6e83-93ae-d0df7fc165a1@infradead.org>
Date:   Fri, 16 Nov 2018 08:59:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zbL1tu4VWtZ5Wz-BgbOS+M2GJziMj958_h_ri4Th3n9bQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/18 12:15 AM, Souptick Joarder wrote:
> On Fri, Nov 16, 2018 at 12:11 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Fri, Nov 16, 2018 at 11:00:30AM +0530, Souptick Joarder wrote:
>>> On Thu, Nov 15, 2018 at 11:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>> On 11/15/18 7:45 AM, Souptick Joarder wrote:
>>>> What is the opposite of vm_insert_range() or even of vm_insert_page()?
>>>> or is there no need for that?
>>>
>>> There is no opposite function of vm_insert_range() / vm_insert_page().
>>> My understanding is, in case of any error, mmap handlers will return the
>>> err to user process and user space will decide the next action. So next
>>> time when mmap handler is getting invoked it will map from the beginning.
>>> Correct me if I am wrong.
>>
>> The opposite function, I suppose, is unmap_region().
>>
>>>> s/no./number/
>>>
>>> I didn't get it ??
>>
>> This is a 'sed' expression.  's' is the 'substitute' command; the /
>> is a separator, 'no.' is what you wrote, and 'number' is what Randy
>> is recommending instead.
> 
> Ok. Will change it in v2.

Thanks.

>>>>> +     for (i = 0; i < page_count; i++) {
>>>>> +             ret = vm_insert_page(vma, uaddr, pages[i]);
>>>>> +             if (ret < 0)
>>>>> +                     return ret;
>>>>
>>>> For a non-trivial value of page_count:
>>>> Is it a problem if vm_insert_page() succeeds for several pages
>>>> and then fails?
>>>
>>> No, it will be considered as total failure and mmap handler will return
>>> the err to user space.
>>
>> I think what Randy means is "What happens to the inserted pages?" and
>> the answer is that mmap_region() jumps to the 'unmap_and_free_vma'
>> label, which is an accurate name.

which says:

	/* Undo any partial mapping done by a device driver. */
	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);

and that is what I was missing.  Thanks.

> Sorry for incorrect understanding of the question.

No problem.


-- 
~Randy
