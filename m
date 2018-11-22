Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B0EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CA12081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CA12081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395289AbeKWAi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:38:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15135 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388851AbeKWAi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:38:57 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1C8A8722E3115;
        Thu, 22 Nov 2018 21:59:25 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 22 Nov
 2018 21:59:21 +0800
Subject: Re: [PATCH 07/10] staging: erofs: separate into init_once / always
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-8-gaoxiang25@huawei.com>
 <20181122102339.GG3189@kroah.com>
 <66b90226-5d0e-7344-5220-908aa243b014@huawei.com>
 <20181122110500.GC5287@kroah.com>
 <ef49bf11-b937-46b4-1b9a-c068182aa7d9@huawei.com>
 <20181122112645.GA7527@kroah.com>
 <448b2d41-8156-3fe8-a037-29a31771721e@huawei.com>
 <c6ec315b-6f80-911f-3abe-ee056e730fc9@huawei.com>
 <20181122132311.GB14300@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <7a8ad8ce-1764-2baa-d9a3-e8bfae83d61a@huawei.com>
Date:   Thu, 22 Nov 2018 21:59:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181122132311.GB14300@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/11/22 21:23, Greg Kroah-Hartman wrote:
> On Thu, Nov 22, 2018 at 09:01:31PM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> On 2018/11/22 20:00, Gao Xiang wrote:
>>> Hi Greg,
>>>
>>> On 2018/11/22 19:26, Greg Kroah-Hartman wrote:
>>>> Don't make people rebuild your code with different options for
>>>> debugging.  That will never work in the 'real world' when people start
>>>> using the code.  You need to have things enabled for people all the
>>>> time, which is why we have dynamic debugging in the kernel now, and not
>>>> a zillion different "DRIVER_DEBUG" build options anymore.
>>> Actually, current erofs handle differently for beta users (in eng mode)
>>> and commercial users.
>>>
>>> CONFIG_EROFS_FS_DEBUG is enable for all beta users, after an observed
>>> expression is false, we could get the whole memorydump as early as possible.
>>> But for commercial users, there are no such observing points to promise
>>> the kernel stability and performance.
>>>
>>> It has helped us to find several bug, and I cannot find some alternative way
>>> to get the the first scene of the accident...
>>
>> I'm about to send v2 of this patchset... I need to get your opinion...
>>
>> I think for the current erofs development state, I tend to leave such a
>> developping switch because the code could be modified frequently,
>> many potential bugs could be avoid when this debugging mode is on and
>> it will be dropped after erofs becomes more stable...
> 
> You have two competing issues here.  You need to have some sort of debug
> build that allows you to get feedback from users, and you need to
> provide a solid, reliable system for those not wanting to debug
> anything.

Yes, you are right :)

> 
> If you use a kernel build option, then you can do what you are doing
> now, just that do not expect for any user that has problems with the
> filesystem, they will rebuild the code just to try to help debug it.
> That is going to require run-time debugging to be enabled as they will
> not usually have built their own kernel/module at all.

Yes, actually the current Android system have 2 modes -- eng and commerical build
for all versions.

A large number of beta users will receive eng build, and many buges were observed
from these users. That is the debugging benefit what Android system does now.

I do not expect real users to rebuild kernels for debugging, I think after the Android
use case, erofs has become solid enough. For commerical builds, it will have enough
error handing case found by Android users and developers.

> 
> For now, keep doing what you are doing, I just started to worry when I
> saw the initial BUG_ON() as we had just talked about these at the
> Maintainers summit a few weeks ago, and how we need to get rid of them
> from the kernel as they are a crutch that we need to solve.

Thanks for understanding...

Thanks,
Gao Xiang

> 
> thanks, and sorry for the noise.  Please resend this series again,
> 
> greg k-h
> 
