Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15ABECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3165D208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3165D208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeGPCVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 22:21:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727302AbeGPCVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 22:21:07 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8A1598757A3D1;
        Mon, 16 Jul 2018 09:55:53 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.382.0; Mon, 16 Jul 2018
 09:55:55 +0800
Subject: Re: [V9fs-developer] [PATCH] net/9p: Fix a deadlock case in the
 virtio transport
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B49B8CF.40709@huawei.com> <20180714090502.GA16186@nautica>
 <5B49DAA5.3020600@huawei.com> <20180714124715.GA16134@nautica>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B4BFB29.3080507@huawei.com>
Date:   Mon, 16 Jul 2018 09:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180714124715.GA16134@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/14 20:47, Dominique Martinet wrote:
> jiangyiwen wrote on Sat, Jul 14, 2018:
>> On 2018/7/14 17:05, Dominique Martinet wrote:
>>> jiangyiwen wrote on Sat, Jul 14, 2018:
>>>> When client has multiple threads that issue io requests all the
>>>> time, and the server has a very good performance, it may cause
>>>> cpu is running in the irq context for a long time because it can
>>>> check virtqueue has buf in the *while* loop.
>>>>
>>>> So we should keep chan->lock in the whole loop.
>>>
>>> Hmm, this is generally bad practice to hold a spin lock for long.
>>> In general, spin locks are meant to protect data, not code.
>>>
>>> I'd want some numbers to decide on this one, even if I think this
>>> particular case is safe (e.g. this cannot dead-lock)
>>>
>>
>> Actually, the loop will not hold a spin lock for long, because other
>> threads will not issue new requests in this case. In addition,
>> virtio-blk or virtio-scsi also use this solution, I guess it may also
>> encounter this problem before.
> 
> Fair enough. If you do have some numbers to give though (throughput
> and/or iops before/after) I'd still be really curious.
> 
>>>>  		chan->ring_bufs_avail = 1;
>>>> -		spin_unlock_irqrestore(&chan->lock, flags);
>>>>  		/* Wakeup if anyone waiting for VirtIO ring space. */
>>>>  		wake_up(chan->vc_wq);
>>>
>>> In particular, the wake up here echoes to wait events that will
>>> immediately try to grab the lock, and will needlessly spin on it until
>>> this thread is done.
>>> If we do go this way I'd want setting chan->ring_bufs_avail to be done
>>> just before unlocking and the wakeup to be done just after unlocking out
>>> of the loop iff we processed at least one iteration here.
>>
>> I can move the wakeup operation after the unlocking. Like what I said
>> above, I think this loop will not execute for long.
> 
> Please do, you listed virtio_blk as doing this and they have the same
> kind of pattern with a req_done bool and only restarting stopped queues
> if they processed something
> 

You're right, this wake up operation should be put after the unlocking,
I will resend it. In addition, whether I should resend this patch based
on your 9p-next branch?

Thanks,
Yiwen.

