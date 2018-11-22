Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4246C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0E720663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0E720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405510AbeKVVuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:50:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405477AbeKVVuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:50:14 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7DD9357664B80;
        Thu, 22 Nov 2018 19:11:16 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 22 Nov
 2018 19:11:07 +0800
Subject: Re: [PATCH 07/10] staging: erofs: separate into init_once / always
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-8-gaoxiang25@huawei.com>
 <20181122102339.GG3189@kroah.com>
 <66b90226-5d0e-7344-5220-908aa243b014@huawei.com>
 <20181122110500.GC5287@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <ef49bf11-b937-46b4-1b9a-c068182aa7d9@huawei.com>
Date:   Thu, 22 Nov 2018 19:11:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181122110500.GC5287@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/11/22 19:05, Greg Kroah-Hartman wrote:
> On Thu, Nov 22, 2018 at 06:34:10PM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> On 2018/11/22 18:23, Greg Kroah-Hartman wrote:
>>>> +
>>>> +	DBG_BUGON(work->nr_pages);
>>>> +	DBG_BUGON(work->vcnt);
>>> How can these ever be triggered?  I understand the need for debugging
>>> code when you are writing code, but at this point it shouldn't be needed
>>> anymore, right?
>>
>> I need to avoid some fields is not 0 when the new workgroup is created (because
>> work->nr_pages and work->vcnt == 0 usually after the previous workgroup is freed).
>> But that is not obvious, it is promised by the current logic.
> 
> Then delete these lines if they can never happen :)

I don't know how to observe such a race in our beta test and community users.

Because if the kernel is crashed, we could collect the whole kernel dump to observe the memory
and all registers, if we only have some warning, it will be not easy to get the state as early as possible.

Thank,
Gao Xiang

> 
>> In order to not introduce such a issue in the future, or there are some potential
>> race (work->nr_pages and work->vcnt != 0 when the previous workgroup == 0), it need
>> to be noticed to developpers as early as possible.
> 
> Then make it a real call, do not wrap it in odd macros that do not
> really explain why it is "debugging only".  Your code is "real" now,
> make the logic real for all developers and users.
> 
> thanks,
> 
> greg k-h
> 
