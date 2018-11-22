Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86D7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C8D20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C8D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394373AbeKVVIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:08:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38677 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388128AbeKVVIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:08:32 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9E3E5A4B3FC57;
        Thu, 22 Nov 2018 18:29:40 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 22 Nov
 2018 18:29:34 +0800
Subject: Re: [PATCH 04/10] staging: erofs: fix
 `erofs_workgroup_{try_to_freeze, unfreeze}'
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-5-gaoxiang25@huawei.com>
 <20181122102155.GE3189@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <ee829ce6-e59e-3ed6-b9a4-16c29c9eb59f@huawei.com>
Date:   Thu, 22 Nov 2018 18:29:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181122102155.GE3189@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/11/22 18:21, Greg Kroah-Hartman wrote:
> On Tue, Nov 20, 2018 at 10:34:19PM +0800, Gao Xiang wrote:
>> There are two minor issues in the current freeze interface:
>>
>>    1) Freeze interfaces have not related with CONFIG_DEBUG_SPINLOCK,
>>       therefore fix the incorrect conditions;
>>
>>    2) For SMP platforms, it should also disable preemption before
>>       doing atomic_cmpxchg in case that some high priority tasks
>>       preempt between atomic_cmpxchg and disable_preempt, then spin
>>       on the locked refcount later.
> 
> spinning on a refcount implies that you are trying to do your own type
> of locking.  Why not use the in-kernel locking api instead?  It will
> always do better than trying to do your own logic as the developers
> there know locking across all types of cpus better than filesystem
> developers :)

It is because refcount also plays a role as a spinlock on a specific value
(== EROFS_LOCKED_MAGIC), no need to introduce such a value since the spin
window is small.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
