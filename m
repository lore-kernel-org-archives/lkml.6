Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7CAC46471
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 00:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C248D21BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 00:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C248D21BC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbeHIDHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 23:07:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727530AbeHIDHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 23:07:25 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 080E4B34D4ADB;
        Thu,  9 Aug 2018 08:45:14 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Thu, 9 Aug 2018
 08:45:11 +0800
Subject: Re: [PATCH] net/9p/trans_virtio.c: decrease the refcount of 9p virtio
 device when removing it
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B6AA65E.3030907@huawei.com> <20180808083630.GB16121@nautica>
 <5B6AB081.6090608@huawei.com> <20180808094014.GA5585@nautica>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eric Van Hensbergen" <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        "Latchesar Ionkov" <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B6B8E96.9070302@huawei.com>
Date:   Thu, 9 Aug 2018 08:45:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180808094014.GA5585@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

On 2018/8/8 17:40, Dominique Martinet wrote:
> piaojun wrote on Wed, Aug 08, 2018:
>> I try to remove 9pnet_virtio.ko by 'rmmod 9pnet_virtio' as I want to
>> replace it without rebooting system.
> 
> I do that all the time when testing, it works for me.
> What exact kernel commit are you running?
> 
My kernel commit id 6edf1d4cb0acde, and I replace the 9p code with
9p-next. And I wonder if this will work well?

>> Here I have not mount 9pfs yet, so the refcount is still 0.
>>
>> Before rmmod:
>> # lsmod | grep 9p
>> 9pnet_virtio           20480  0
>> 9pnet                 106496  1 9pnet_virtio
>> virtio_ring            28672  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net
>> virtio                 16384  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net
>>
>> After rmmod:
>> # lsmod | grep 9p
>> 9pnet_virtio           20480  0
>> 9pnet                 106496  1 9pnet_virtio
>> virtio_ring            28672  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net
>> virtio                 16384  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net
>>
>> Normally 9pnet_virtio should be invisible after rmmod like this:
>> # lsmod | grep 9p
>> 9pnet                 106496  0
> 
> Right, that obviously didn't work...
> 
> But on the other hand, if I apply your commit and load/unload
> 9pnet_virtio 5-10 times (I ran it in a loop) I get KASAN errors because
> we put too many of these refs ; that doesn't happen without your patch
> so it's apparently wrong.
> I'm curious how that could make modprobe work better for you as well, it
> shouldn't depend on that...
> 
> Maybe `modprobe -r` might give a better error, or something in dmesg?
> 
In my testing, `modprobe -r` has the same behavior with rmmod.
