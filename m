Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF40ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D25720C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D25720C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbeGQM7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:59:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728489AbeGQM7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:59:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D60AE774A53CE;
        Tue, 17 Jul 2018 20:27:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Tue, 17 Jul 2018
 20:27:12 +0800
Subject: Re: [V9fs-developer] [PATCH v2] net/9p: Fix a deadlock case in the
 virtio transport
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B4DCD0A.8040600@huawei.com> <20180717114215.GA14414@nautica>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B4DE09F.5000800@huawei.com>
Date:   Tue, 17 Jul 2018 20:27:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180717114215.GA14414@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/17 19:42, Dominique Martinet wrote:
> 
>> Subject: net/9p: Fix a deadlock case in the virtio transport
> 
> I hadn't noticed in the v1, but how is that a deadlock fix?
> The previous code doesn't look like it deadlocks to me, the commit
> message is more correct.
> 

Hi Dominique,

If cpu is running in the irq context for a long time,
NMI watchdog will detect the hard lockup in the cpu,
and then it will cause kernel panic. So I use this
subject to underline the scenario.

> jiangyiwen wrote on Tue, Jul 17, 2018:
>> When client has multiple threads that issue io requests
>> all the time, and the server has a very good performance,
>> it may cause cpu is running in the irq context for a long
>> time because it can check virtqueue has buf in the *while*
>> loop.
>>
>> So we should keep chan->lock in the whole loop.
>>
>> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
>> ---
>>  net/9p/trans_virtio.c | 17 ++++++-----------
>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
>> index 05006cb..e5fea8b 100644
>> --- a/net/9p/trans_virtio.c
>> +++ b/net/9p/trans_virtio.c
>> @@ -148,20 +148,15 @@ static void req_done(struct virtqueue *vq)
>>
>>  	p9_debug(P9_DEBUG_TRANS, ": request done\n");
>>
>> -	while (1) {
>> -		spin_lock_irqsave(&chan->lock, flags);
>> -		req = virtqueue_get_buf(chan->vq, &len);
>> -		if (req == NULL) {
>> -			spin_unlock_irqrestore(&chan->lock, flags);
>> -			break;
>> -		}
>> -		chan->ring_bufs_avail = 1;
>> -		spin_unlock_irqrestore(&chan->lock, flags);
>> -		/* Wakeup if anyone waiting for VirtIO ring space. */
>> -		wake_up(chan->vc_wq);
>> +	spin_lock_irqsave(&chan->lock, flags);
>> +	while ((req = virtqueue_get_buf(chan->vq, &len)) != NULL) {
>>  		if (len)
>>  			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
>>  	}
>> +	chan->ring_bufs_avail = 1;
> 
> Do we have a guarantee that req_done is only called if there is at least
> one buf to read?
> For example, that there isn't two threads queueing the same callback but
> the first one reads everything and the second has nothing to read?
> 
> If virtblk_done takes care of setting up a "req_done" bool to only
> notify waiters if something has been done I'd rather have a reason to do
> differently, even if you can argue that nothing bad will happen in case
> of a gratuitous wake_up
> 

Sorry, I don't fully understand what your mean.
I think even if the ring buffer don't have the data, wakeup operation
will not cause any other problem, and the loss of performance can be
ignored.

Thanks.

>> +	spin_unlock_irqrestore(&chan->lock, flags);
>> +	/* Wakeup if anyone waiting for VirtIO ring space. */
>> +	wake_up(chan->vc_wq);
>>  }
> 
> Thanks,
> 


