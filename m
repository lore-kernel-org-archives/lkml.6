Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8778CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506A221755
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506A221755
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeI1O30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:29:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbeI1O30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:29:26 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 061F9FB218F9A;
        Fri, 28 Sep 2018 16:06:50 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Fri, 28 Sep 2018
 16:06:46 +0800
Message-ID: <5BADE115.7020701@huawei.com>
Date:   Fri, 28 Sep 2018 16:06:45 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linux-foundation.org>
CC:     <iamjoonsoo.kim@lge.com>, <rientjes@google.com>, <cl@linux.com>,
        <penberg@kernel.org>, <akpm@linux-foundation.org>,
        <mhocko@suse.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [STABLE PATCH] slub: make ->cpu_partial unsigned int
References: <1538059420-14439-1-git-send-email-zhongjiang@huawei.com> <20180927154647.GB31654@kroah.com>
In-Reply-To: <20180927154647.GB31654@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/27 23:46, Greg KH wrote:
> On Thu, Sep 27, 2018 at 10:43:40PM +0800, zhong jiang wrote:
>> From: Alexey Dobriyan <adobriyan@gmail.com>
>>
>>         /*
>>          * cpu_partial determined the maximum number of objects
>>          * kept in the per cpu partial lists of a processor.
>>          */
>>
>> Can't be negative.
>>
>> I hit a real issue that it will result in a large number of memory leak.
>> Because Freeing slabs are in interrupt context. So it can trigger this issue.
>> put_cpu_partial can be interrupted more than once.
>> due to a union struct of lru and pobjects in struct page, when other core handles
>> page->lru list, for eaxmple, remove_partial in freeing slab code flow, It will
>> result in pobjects being a negative value(0xdead0000). Therefore, a large number
>> of slabs will be added to per_cpu partial list.
>>
>> I had posted the issue to community before. The detailed issue description is as follows.
>>
>> Link: https://www.spinics.net/lists/kernel/msg2870979.html
>>
>> After applying the patch, The issue is fixed. So the patch is a effective bugfix.
>> It should go into stable.
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>
Will resend with proper format.

Thanks,
zhong jiang

