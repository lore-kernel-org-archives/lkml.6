Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2910ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FCE2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FCE2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbeGSDHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:07:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730811AbeGSDHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:07:49 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B51BC2844B840;
        Thu, 19 Jul 2018 10:26:50 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 10:26:52 +0800
Subject: Re: [PATCH] net/9p/trans_virtio.c: replace mutex_lock with spin_lock
 to protect 'virtio_chan_list'
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B4EF511.7090104@huawei.com> <20180718095420.GA28377@nautica>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eric Van Hensbergen" <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        "Latchesar Ionkov" <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B4FF6DB.1040101@huawei.com>
Date:   Thu, 19 Jul 2018 10:26:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180718095420.GA28377@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

On 2018/7/18 17:54, Dominique Martinet wrote:
> piaojun wrote on Wed, Jul 18, 2018:
>> spin_lock is more effective for short time protection than mutex_lock, as
>> mutex lock may cause process sleep and wake up which consume much cpu
>> time.
> 
> That's not a fast path operation, I don't mind changing things but I'd
> like to understand why - these functions are only ever called at unmount
> time or when something happens on the virtio bus (probe will happen on
> probing on the pci bus and I'm not too sure on remove but probably pci
> removal i.e. basically never?)
> 
> I don't see why this wouldn't work, but I won't take this without a
> (good?) reason.
> 
virtio_9p_lock is responsable for protecting virtio_chan_list which has 3
operation:

1. Add a virtio chan to virtio_chan_list. This will happen when we insmod
9pnet_virtio.ko:
p9_virtio_probe
--list_add_tail(&chan->chan_list, &virtio_chan_list);

2. Remove a virtio chan. This will happen when remnod 9pnet_virtio.ko:
p9_virtio_remove
--list_del(&chan->chan_list);

3. Find a unused virtio chan when mount 9p:
mount
--p9_virtio_create
--list_for_each_entry(chan, &virtio_chan_list, chan_list)

Multi mount process will compete for virtio_9p_lock when finding unused
virtio chan, in which case mutex lock will cause process sleep and wake
up. I think this a waste of CPU time. So we could use spin lock to avoid
this.

Thanks,
Jun
