Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81012C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C742083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C742083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbeHAKJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:09:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387699AbeHAKJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:09:53 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C9F94D586D2F1;
        Wed,  1 Aug 2018 16:25:11 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 16:25:07 +0800
Subject: Re: [PATCH] net/9p/trans_virtio.c: add a terminal char for mount tag
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B6164F6.60004@huawei.com> <20180801081157.GA20127@nautica>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>, Greg Kurz <groug@kaod.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B616E3B.4050205@huawei.com>
Date:   Wed, 1 Aug 2018 16:24:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180801081157.GA20127@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

On 2018/8/1 16:11, Dominique Martinet wrote:
> piaojun wrote on Wed, Aug 01, 2018:
>> chan->tag has no terminal char at last which will result in printing messy
>> code when debugging code. So we should add '\0' for tag.
> 
> 9p is full of non null-terminated string so I'm not sure how I feel
> about it, is there anything wrong with how this is used or was this just
> when you tried to printf it?

There is nothing wrong at the places using tag, as they calculated the
tag_len carefully. Adding '\0' for it will make the code more robust. And
I'm glad to hear others' opinions.

Thanks,
Jun

> 
> If it's just for debugging I'd suggest using the printf format "%.*s"
> with "chan->tag_len, chan->tag" arguments,
> 
> 
> That said it's not like this is costly, so I'll take it if someone else
> thinks this is helpful
> 
>>
>> Signed-off-by: Jun Piao <piaojun@huawei.com>
>> ---
>>  net/9p/trans_virtio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
>> index d422bfc..49d71d6 100644
>> --- a/net/9p/trans_virtio.c
>> +++ b/net/9p/trans_virtio.c
>> @@ -585,7 +585,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>>  		err = -EINVAL;
>>  		goto out_free_vq;
>>  	}
>> -	tag = kmalloc(tag_len, GFP_KERNEL);
>> +	tag = kzalloc(tag_len + 1, GFP_KERNEL);
>>  	if (!tag) {
>>  		err = -ENOMEM;
>>  		goto out_free_vq;
>> -- 
