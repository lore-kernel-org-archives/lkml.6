Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88759ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7602064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7602064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbeGRBeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:34:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730614AbeGRBeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:34:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E19E7B43B4F99;
        Wed, 18 Jul 2018 08:58:39 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Wed, 18 Jul 2018
 08:58:39 +0800
Subject: Re: [V9fs-developer] [PATCH v2] net/9p: Fix a deadlock case in the
 virtio transport
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B4DCD0A.8040600@huawei.com> <20180717114215.GA14414@nautica>
 <5B4DE09F.5000800@huawei.com> <20180717130720.GA23759@nautica>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B4E90BE.5030307@huawei.com>
Date:   Wed, 18 Jul 2018 08:58:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180717130720.GA23759@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/17 21:07, Dominique Martinet wrote:
> jiangyiwen wrote on Tue, Jul 17, 2018:
>> On 2018/7/17 19:42, Dominique Martinet wrote:
>>>
>>>> Subject: net/9p: Fix a deadlock case in the virtio transport
>>>
>>> I hadn't noticed in the v1, but how is that a deadlock fix?
>>> The previous code doesn't look like it deadlocks to me, the commit
>>> message is more correct.
>>>
>>
>> If cpu is running in the irq context for a long time,
>> NMI watchdog will detect the hard lockup in the cpu,
>> and then it will cause kernel panic. So I use this
>> subject to underline the scenario.
> 
> That's still not a deadlock - fix lockup would be more appropriate?
> 
> 

Okay.

>>> Do we have a guarantee that req_done is only called if there is at least
>>> one buf to read?
>>> For example, that there isn't two threads queueing the same callback but
>>> the first one reads everything and the second has nothing to read?
>>>
>>> If virtblk_done takes care of setting up a "req_done" bool to only
>>> notify waiters if something has been done I'd rather have a reason to do
>>> differently, even if you can argue that nothing bad will happen in case
>>> of a gratuitous wake_up
>>>
>>
>> Sorry, I don't fully understand what your mean.
>> I think even if the ring buffer don't have the data, wakeup operation
>> will not cause any other problem, and the loss of performance can be
>> ignored.
> 
> I just mean "others do check, why not us?". It's almost free to check if
> we had something to read, but if there are many pending read/writes
> waiting for a buffer they will all wake up and spin uselessly.
> 
> I've checked other callers of virtqueue_get_buf() and out of 9 that loop
> around in a callback then wake another thread up, 6 do check before
> waking up, two check that something happened just to print a debug
> statement if not (virtio_test and virtgpu) and one doesn't check
> (virtio_input); so I guess we wouldn't be the first ones, just not
> following the trend.
> 
> But yes, nothing bad will happen, so let's agree to disagree and I'll
> defer to others opinion on this
> 
> 
> Thanks,
> 

Thanks for your reply, you're right, other callers also check whether
Virtio ring has data then do wakeup operation, we also should follow
the trend.

Okay, I will resend the patch later.

Thanks,
Yiwen.

