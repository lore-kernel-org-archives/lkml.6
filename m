Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B40C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147A320820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147A320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501907AbeKWNeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:34:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15581 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392981AbeKWNeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:34:05 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4A75238FC0DC;
        Fri, 23 Nov 2018 10:51:44 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 23 Nov
 2018 10:51:38 +0800
Subject: Re: [PATCH 05/10] staging: erofs: add a full barrier in
 erofs_workgroup_unfreeze
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-6-gaoxiang25@huawei.com>
 <20181122102230.GF3189@kroah.com>
 <1d1fd688-0cb5-cbac-9213-f56f7e356bca@huawei.com>
 <20181122185058.GA3466@andrea>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <b2f367c5-a54c-9edf-42ad-d256bc725cf7@huawei.com>
Date:   Fri, 23 Nov 2018 10:51:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181122185058.GA3466@andrea>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On 2018/11/23 2:50, Andrea Parri wrote:
> On Thu, Nov 22, 2018 at 06:56:32PM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> On 2018/11/22 18:22, Greg Kroah-Hartman wrote:
>>> Please document this memory barrier.  It does not make much sense to
>>> me...
>>
>> Because we need to make the other observers noticing the latest values modified
>> in this locking period before unfreezing the whole workgroup, one way is to use
>> a memory barrier and the other way is to use ACQUIRE and RELEASE. we selected
>> the first one.
>>
>> Hmmm...ok, I will add a simple message to explain this, but I think that is
>> plain enough for a lock...
> 
> Sympathizing with Greg's request, let me add some specific suggestions:
> 
>   1. It wouldn't hurt to indicate a pair of memory accesses which are
>      intended to be "ordered" by the memory barrier in question (yes,
>      this pair might not be unique, but you should be able to provide
>      an example).
> 
>   2. Memory barriers always come matched by other memory barriers, or
>      dependencies (it really does not make sense to talk about a full
>      barrier "in isolation"): please also indicate (an instance of) a
>      matching barrier or the matching barriers.
> 
>   3. How do the hardware threads communicate?  In the acquire/release
>      pattern you mentioned above, the load-acquire *reads from* a/the
>      previous store-release, a memory access that follows the acquire
>      somehow communicate with a memory access preceding the release...
> 
>   4. It is a good practice to include the above information within an
>      (inline) comment accompanying the added memory barrier (in fact,
>      IIRC, checkpatch.pl gives you a "memory barrier without comment"
>      warning when you omit to do so); not just in the commit message.
> 
> Hope this helps.  Please let me know if something I wrote is unclear,

Thanks for taking time on the detailed explanation. I think it is helpful for me. :)
And you are right, barriers should be in pairs, and I think I need to explain more:

255 static inline bool erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
256 {
257         int o;
258
259 repeat:
260         o = erofs_wait_on_workgroup_freezed(grp);
261
262         if (unlikely(o <= 0))
263                 return -1;
264
265         if (unlikely(atomic_cmpxchg(&grp->refcount, o, o + 1) != o)) <- *
266                 goto repeat;
            imply a memory barrier here
267
268         *ocnt = o;
269         return 0;
270 }

I think atomic_cmpxchg implies a memory barrier semantics when the value comparison (*) succeeds...

I don't know whether my understanding is correct, If I am wrong..please correct me, or
I need to add more detailed code comments to explain in the code?

Thanks,
Gao Xiang


> 
>   Andrea
> 
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> thanks,
>>>
>>> greg k-h
