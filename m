Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F332C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AE520685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AE520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390872AbeKVVVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:21:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732079AbeKVVVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:21:51 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7DC79DCC11375;
        Thu, 22 Nov 2018 18:42:57 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 22 Nov
 2018 18:42:52 +0800
Subject: Re: [PATCH 02/10] staging: erofs: fix race when the managed cache is
 enabled
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-3-gaoxiang25@huawei.com>
 <20181122101711.GA3189@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <55aed87f-196e-9048-6aae-db09bc497664@huawei.com>
Date:   Thu, 22 Nov 2018 18:42:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181122101711.GA3189@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/11/22 18:17, Greg Kroah-Hartman wrote:
> Any specific reason why you are not using the refcount.h api instead of
> "doing it yourself" with atomic_inc/dec()?
> 
> I'm not rejecting this, just curious.

As I explained in the previous email,
Re: [PATCH 04/10] staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}'

we need such a function when the value is >= 0, it plays as a refcount,
but when the refcount == EROFS_LOCKED_MAGIC (<0, but not 0 as refcount.h),
and actually there is no need to introduce a seperate spinlock_t because
we don't actually care about its performance (rarely locked). and
the corresponding struct is too large for now, we need to decrease its size.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
