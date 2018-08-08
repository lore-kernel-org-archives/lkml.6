Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C68C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE2D215F9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE2D215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeHHLRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:17:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbeHHLRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:17:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 949101A03F7F7;
        Wed,  8 Aug 2018 16:58:20 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Wed, 8 Aug 2018
 16:58:17 +0800
Subject: Re: [PATCH] net/9p/trans_virtio.c: decrease the refcount of 9p virtio
 device when removing it
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B6AA65E.3030907@huawei.com> <20180808083630.GB16121@nautica>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eric Van Hensbergen" <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        "Latchesar Ionkov" <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B6AB081.6090608@huawei.com>
Date:   Wed, 8 Aug 2018 16:57:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180808083630.GB16121@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

On 2018/8/8 16:36, Dominique Martinet wrote:
> piaojun wrote on Wed, Aug 08, 2018:
>> I found that 9pnet_virtio.ko could not be removed by rmmod command, and I
>> could still found it by lsmod. The reason is that we forgot decrease the
>> refcount of 9p virtio device by kobject_put. So we should put refcount in
>> p9_virtio_remove.
> 
> 
> Hmm, I cannot seem to reproduce this. Can you give more details on how
> to get into stuck state?
> I tried mounting something, accessing the sysfs files, etc to no avail.
> 
> lsmod gives a counter to how many references there are to the module,
> you can use that to debug a bit.
> For example here I get this line just after loading the module:
>   9pnet_virtio           32768  0
> 
> Then after mounting something there is one reference:
>   9pnet_virtio           32768  1
> 
> Then unmounting puts that back to 0 and 'modprobe -r' (or rmmod) works.
> 
I try to remove 9pnet_virtio.ko by 'rmmod 9pnet_virtio' as I want to
replace it without rebooting system. Here I have not mount 9pfs yet, so
the refcount is still 0.

Before rmmod:
# lsmod | grep 9p
9pnet_virtio           20480  0
9pnet                 106496  1 9pnet_virtio
virtio_ring            28672  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net
virtio                 16384  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net

After rmmod:
# lsmod | grep 9p
9pnet_virtio           20480  0
9pnet                 106496  1 9pnet_virtio
virtio_ring            28672  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net
virtio                 16384  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net

Normally 9pnet_virtio should be invisible after rmmod like this:
# lsmod | grep 9p
9pnet                 106496  0

> 
> 
> 
> I dislike saying the next part but I think form also is important,
> please bear with me:
> 
>  - shorter subject line, please. For example, you can lose 20 characters
> by reodering words so there is no need for pronouns
> "net/9p/virtio: decrease 9p virtio device refcount on removal"
> 
>  - I personally dislike commit messages that are "novelized" (that is,
> put yourself as an actor and describe what you were doing)
> That seems to be somewhat accepted as looking at the kernel's git log I
> see some (few) commits using "I ..." that are not pull request messages
> but if possible please avoid this style and try to describe facts, how
> things are wrong, what got fixed and if required how.
> To give an example again, this says the same thing:
> "The 9pnet_virtio module could not be unloaded because we forgot to
> decrease the refcount of the 9p virtio device with kobject_put.
> 
> Put the reference in 9p_virtio_remove"
> 
Your suggestion really makes sense, and I will make some improvment later.

Thanks,
Jun
> 
> Thanks,
> 
