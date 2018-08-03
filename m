Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D21FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2049C2172E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2049C2172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeHCKNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:13:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727682AbeHCKNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:13:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 26388B1A0D732;
        Fri,  3 Aug 2018 16:18:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Fri, 3 Aug 2018
 16:18:22 +0800
Subject: Re: [V9fs-developer] [PATCH] net/9p: avoid request size exceed to the
 virtqueue number in the zero copy
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B63FB4D.1050703@huawei.com> <20180803073240.GA26848@nautica>
CC:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>, <netdev@vger.kernel.org>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B640FCC.3000704@huawei.com>
Date:   Fri, 3 Aug 2018 16:18:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180803073240.GA26848@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/3 15:32, Dominique Martinet wrote:
> jiangyiwen wrote on Fri, Aug 03, 2018:
>> Unfortunately, when the address(input and response headers) are not
>> at page boundary, it will need two extra entry in the zero copy, or
>> else it will cause sg array out of bounds.
>>
>> To avoid the problem, we should subtract two pages for maxsize.
> 
> Good catch, that must have been painful to figure.
> 
> Given we know how big the headers are (something like 11 or 23 bytes
> depending on the op/direction, it's capped by P9_IOHDRSZ at 24),
> couldn't we just cheat and not use the start of the buffer if we detect
> it's overlapping?
> 

Actually, generally the P9_IOHDRSZ will not cause the problem, because
24 bytes is too small, but P9_ZC_HDR_SZ(4096 bytes) often cause two pages.

So I have a question about why we need to use P9_ZC_HDR_SZ, actually we
may use P9_IOHDRSZ instead.

> It's probably faster to memcpy a few bytes than to use two pages for the
> sg list...
> It's definitely ugly though, just taking more margin here is probably
> just as good.
> 
> 
> 
> I'm going to be picky about English again, sorry, please bear with me.
> 
>> Subject: net/9p: avoid request size exceed to the virtqueue number in
>> the zero copy
> 
> This is >72 characters so a little bit too long, if possible to shorten
> it.
> I'm also not sure 'exceed' is a noun so I probably wouldn't have
> understood this sentence without the rest of the message...
> 
> The balance is difficult but it doesn't need to contain too much details
> either something like "9p/virtio: reduce transport maxsize" is simple
> but probably enough as it describes what is done: someone can look at
> the rest of the message for the justification.
> 

Thanks, I will resend the patch later.

> 
> 
>> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
>> ---
>>  net/9p/trans_virtio.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
>> index 6265d1d..63591b2 100644
>> --- a/net/9p/trans_virtio.c
>> +++ b/net/9p/trans_virtio.c
>> @@ -754,11 +754,12 @@ static void p9_virtio_remove(struct virtio_device *vdev)
>>  	.cancel = p9_virtio_cancel,
>>  	/*
>>  	 * We leave one entry for input and one entry for response
>> -	 * headers. We also skip one more entry to accomodate, address
>> -	 * that are not at page boundary, that can result in an extra
>> -	 * page in zero copy.
>> +	 * headers. We also skip three more entrys to accomodate
> 
> "entry"'s plural is "entries", this word is in checkpatch's dictionary
> as a common typo

Thanks, I will modify it.

> 
>> +	 * (input + response headers + data pages), address
>> +	 * that are not at page boundary, that can result in
>> +	 * an extra page in zero copy.
>>  	 */
>> -	.maxsize = PAGE_SIZE * (VIRTQUEUE_NUM - 3),
>> +	.maxsize = PAGE_SIZE * (VIRTQUEUE_NUM - 5),
>>  	.def = 1,
>>  	.owner = THIS_MODULE,
>>  };
> 
> Thanks,
> 


