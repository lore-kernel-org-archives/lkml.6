Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FA427191
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FA427191
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935182AbeF1JmA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:42:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39222 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933896AbeF1Jl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:41:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7C8E3712532C0;
        Thu, 28 Jun 2018 17:41:55 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 28 Jun
 2018 17:41:49 +0800
Subject: Re: [RFC PATCH] <linux/taggedptr.h>: Introduce tagged pointer
To:     Matthew Wilcox <willy@infradead.org>
CC:     <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
References: <1530176789-107541-1-git-send-email-gaoxiang25@huawei.com>
 <20180628092303.GD7646@bombadil.infradead.org>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <bcf7bc51-1689-fec5-f167-14fb46409b76@huawei.com>
Date:   Thu, 28 Jun 2018 17:40:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180628092303.GD7646@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 2018/6/28 17:23, Matthew Wilcox wrote:
> On Thu, Jun 28, 2018 at 05:06:29PM +0800, Gao Xiang wrote:
>> Therefore, this patch introduces simple generic methods to fold
>> tags into a pointer integer. It currently reuses the last 2 bits
>> of the pointer for tags, which are safely for all modern platforms.
> 
> The m68k people will have your head.  alignof(unsigned long) == 2 on
> m68k.  Now, kmalloc always returns 8-byte aligned quantities, but
> if you have:
> 
> static unsigned long foo;
> 
> then ((unsigned long)&foo & 2) may be non-zero.
> 

Oh.. I missed it. How about covering dynamic allocation scenario only?
(since 1 bit is too limited to be used for generic purposes... :( )

Or generate different bit mask versions by using macro? --- I could try in the next patch.

Anyway, I think it is depended on specific use cases and corresponding architectures...

>> +/*
>> + * mark these special integers as another type
>> + * in order to highlight the tagged pointer usage.
>> + */
>> +typedef uintptr_t	taggedptr_t;
> 
> I find this a bit verbose.  How about tagptr_t ?
> 

Boths are ok for me :)

Thanks,
Gao Xiang

