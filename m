Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDDCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278DD2190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390599AbfBOJEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:04:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbfBOJEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:04:41 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 914185349BB74FEEC5A6;
        Fri, 15 Feb 2019 17:04:38 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 15 Feb
 2019 17:04:29 +0800
Subject: Re: [PATCH v2] staging: erofs: keep corrupted fs from crashing kernel
 in erofs_namei()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <yuchao0@huawei.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Miao Xie <miaoxie@huawei.com>
References: <20190201121631.15179-1-gaoxiang25@huawei.com>
 <a9381c0d-9857-4d03-710d-80006d426bbc@huawei.com>
 <20190215075757.GG2326@kadam>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <71f44997-a32a-1384-e350-dc822a2cea13@huawei.com>
Date:   Fri, 15 Feb 2019 17:04:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190215075757.GG2326@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2019/2/15 15:57, Dan Carpenter wrote:
> On Fri, Feb 15, 2019 at 03:02:25PM +0800, Chao Yu wrote:
>> On 2019/2/1 20:16, Gao Xiang wrote:
>>> +	/*
>>> +	 * on-disk error, let's only BUG_ON in the debugging mode.
>>> +	 * otherwise, it will return 1 to just skip the invalid name
>>> +	 * and go on (in consideration of the lookup performance).
>>> +	 */
>>> +	DBG_BUGON(qd->name > qd->end);
>>
>> qd->name == qd->end is not allowed as well?
>>
>> So will it be better to return directly here?
>>
>> 	if (unlikely(qd->name >= qd->end)) {
>> 		DBG_BUGON(1);
>> 		return 1;
>> 	}
> 
> Please don't add likely/unlikely() annotations unless you have
> benchmarked it and it makes a difference.

I tend not to add this branch above since the current logic can handle
qd->name >= qd->end (it only happens in corrupted images) and
it will return 1;

Let's just leave DBG_BUGON(qd->name > qd->end); here for debugging use
(to detect corrupted image in some degree earlier).

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
> 
> 
