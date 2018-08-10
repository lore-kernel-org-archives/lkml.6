Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C52C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07EA223B7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07EA223B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeHJERX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:17:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725198AbeHJERX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:17:23 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 46EF396E17439;
        Fri, 10 Aug 2018 09:49:43 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Fri, 10 Aug 2018
 09:49:41 +0800
Subject: Re: [PATCH v3 2/2] net/9p: add a per-client fcall kmem_cache
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <1533177452-2165-1-git-send-email-asmadeus@codewreck.org>
 <1533825236-22896-1-git-send-email-asmadeus@codewreck.org>
 <1533825236-22896-2-git-send-email-asmadeus@codewreck.org>
 <5B6CE900.1010103@huawei.com> <20180810014147.GB14699@nautica>
CC:     <v9fs-developer@lists.sourceforge.net>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Greg Kurz" <groug@kaod.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B6CEF2C.2070606@huawei.com>
Date:   Fri, 10 Aug 2018 09:49:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180810014147.GB14699@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for clearing my doubt, and you can add:

Acked-by: Jun Piao <piaojun@huawei.com>

On 2018/8/10 9:41, Dominique Martinet wrote:
> piaojun wrote on Fri, Aug 10, 2018:
>> Could you help paste the test result of before-after-applied this patch in
>> comment? And please see my comments below.
> 
> Thanks the the review, do you mean the commit message?
> 
> I'll add the summary I wrote in reply to your question a few mails
> before.
> 
Yes, I mean the commit message.

> 
>>> diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
>>> index e23896116d9a..645266b74652 100644
>>> --- a/include/net/9p/9p.h
>>> +++ b/include/net/9p/9p.h
>>> @@ -336,6 +336,9 @@ enum p9_qid_t {
>>>  #define P9_NOFID	(u32)(~0)
>>>  #define P9_MAXWELEM	16
>>>  
>>> +/* Minimal header size: len + id + tag */
>>
>> Here should be 'size + id + tag'.
> 
> hm I didn't want to repeat size, but I guess people do refer to that
> field as size.
> I'll actually rewrite it as:
>  Minimal header size: size[4] type[1] tag[2]
> 
It looks better.

>>> +	kmem_cache_destroy(clnt->fcall_cache);
>>
>> I'm afraid that we should check NULL for clnt->fcall_cache.
> 
> kmem_cache_destroy() in mm/slab_common.c does the null check for us:
> ------
> void kmem_cache_destroy(struct kmem_cache *s)
> {
>         int err;
>         
>         if (unlikely(!s))
>                 return;
> ------
> 
OK, it makes sense.
