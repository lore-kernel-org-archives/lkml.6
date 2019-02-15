Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACDA2190B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393981AbfBOKeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:34:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393317AbfBOKeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:34:17 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48D52F61EDCCE060CA23;
        Fri, 15 Feb 2019 18:34:08 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 15 Feb
 2019 18:33:58 +0800
Subject: Re: [PATCH v2] staging: erofs: keep corrupted fs from crashing kernel
 in erofs_namei()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Chao Yu <chao@kernel.org>, <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <weidu.du@huawei.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
References: <20190201121631.15179-1-gaoxiang25@huawei.com>
 <a9381c0d-9857-4d03-710d-80006d426bbc@huawei.com>
 <20190215075757.GG2326@kadam>
 <fb99bac2-2587-04fa-6ac2-f2e5f83af7c9@huawei.com>
 <20190215093503.GH2326@kadam>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <d151a09a-6bbf-93d6-a7fe-b0cc6769a851@huawei.com>
Date:   Fri, 15 Feb 2019 18:33:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190215093503.GH2326@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2019/2/15 17:35, Dan Carpenter wrote:
> On Fri, Feb 15, 2019 at 05:32:33PM +0800, Chao Yu wrote:
>> On 2019/2/15 15:57, Dan Carpenter wrote:
>>> On Fri, Feb 15, 2019 at 03:02:25PM +0800, Chao Yu wrote:
>>>> On 2019/2/1 20:16, Gao Xiang wrote:
>>>>> +	/*
>>>>> +	 * on-disk error, let's only BUG_ON in the debugging mode.
>>>>> +	 * otherwise, it will return 1 to just skip the invalid name
>>>>> +	 * and go on (in consideration of the lookup performance).
>>>>> +	 */
>>>>> +	DBG_BUGON(qd->name > qd->end);
>>>>
>>>> qd->name == qd->end is not allowed as well?
>>>>
>>>> So will it be better to return directly here?
>>>>
>>>> 	if (unlikely(qd->name >= qd->end)) {
>>>> 		DBG_BUGON(1);
>>>> 		return 1;
>>>> 	}
>>>
>>> Please don't add likely/unlikely() annotations unless you have
>>> benchmarked it and it makes a difference.
>>
>> Well, it only occur for corrupted image, since the image is readonly, so it
>> is really rare.
> 
> The likely/unlikely() annotations make the code harder to read.  It's
> only worth it if it's is a speedup on a fast path.

Yes, I think abuse of using likely/unlikely() should be avoided (I agree that
some odd likely/unlikely() exists in the current code, that should be cleaned up).

However, likely/unlikely()s are also clearly highlight critical/corner paths).
I personally think it should be used in case-by-case basis rather than a unified
conclusion ("that makes the code harder to read").

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
> 
