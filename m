Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E5DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8420F2174C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8420F2174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeHMP3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:29:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728356AbeHMP3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:29:17 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E941AB5737379;
        Mon, 13 Aug 2018 20:47:05 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 13 Aug
 2018 20:46:59 +0800
Subject: Re: [PATCH 3/8] staging: erofs: add error handling for xattr
 submodule
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <chao@kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, Chao Yu <yuchao0@huawei.com>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-4-chao@kernel.org>
 <20180813114725.kgoupvppcwsw2vyj@mwanda>
 <c14184af-6378-fd96-3b9b-52c9a7da8463@huawei.com>
 <20180813124014.iivbtjrsdv5odnuu@mwanda>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <99754359-647a-700f-95d1-421103735ed6@huawei.com>
Date:   Mon, 13 Aug 2018 20:46:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180813124014.iivbtjrsdv5odnuu@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2018/8/13 20:40, Dan Carpenter wrote:
> On Mon, Aug 13, 2018 at 08:17:27PM +0800, Gao Xiang wrote:
>>>> @@ -294,8 +322,11 @@ static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
>>>>  		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
>>>>  		if (ret >= 0)
>>>>  			break;
>>>> +
>>>> +		if (unlikely(ret != -ENOATTR))	/* -ENOMEM, -EIO, etc. */
>>> I have held off commenting on all the likely/unlikely annotations we
>>> are adding because I don't know what the fast paths are in this code.
>>> However, this is clearly an error path here, not on a fast path.
>>>
>>> Generally the rule on likely/unlikely is that they hurt readability so
>>> we should only add them if it makes a difference in benchmarking.
>>>
>> In my opinion, return values other than 0 and ENOATTR(ENODATA) rarely happens,
>> it should be in the slow path...
>>
> What I'm trying to say is please stop adding so many likely/unlikely
> annotations.  You should only add them if you have the benchmark data to
> show the it really is required.
> 
> 
OK, I'll follow your suggestion.

I could say it is my personal code tendency(style).
If you don't like it/think them useless, I will remove them all. 

Thanks for your suggestion.

Thanks,
Gao Xiang

> regards,
> dan carpenter
> 
