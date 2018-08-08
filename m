Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB54CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CE821700
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CE821700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHHL7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:59:25 -0400
Received: from nautica.notk.org ([91.121.71.147]:47736 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbeHHL7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:59:24 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id DFB85C009; Wed,  8 Aug 2018 11:40:29 +0200 (CEST)
Date:   Wed, 8 Aug 2018 11:40:14 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Greg Kurz <groug@kaod.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] net/9p/trans_virtio.c: decrease the refcount of 9p
 virtio device when removing it
Message-ID: <20180808094014.GA5585@nautica>
References: <5B6AA65E.3030907@huawei.com>
 <20180808083630.GB16121@nautica>
 <5B6AB081.6090608@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B6AB081.6090608@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Wed, Aug 08, 2018:
> I try to remove 9pnet_virtio.ko by 'rmmod 9pnet_virtio' as I want to
> replace it without rebooting system.

I do that all the time when testing, it works for me.
What exact kernel commit are you running?

> Here I have not mount 9pfs yet, so the refcount is still 0.
> 
> Before rmmod:
> # lsmod | grep 9p
> 9pnet_virtio           20480  0
> 9pnet                 106496  1 9pnet_virtio
> virtio_ring            28672  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net
> virtio                 16384  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net
> 
> After rmmod:
> # lsmod | grep 9p
> 9pnet_virtio           20480  0
> 9pnet                 106496  1 9pnet_virtio
> virtio_ring            28672  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net
> virtio                 16384  5 virtio_scsi,9pnet_virtio,virtio_pci,virtio_blk,virtio_net
> 
> Normally 9pnet_virtio should be invisible after rmmod like this:
> # lsmod | grep 9p
> 9pnet                 106496  0

Right, that obviously didn't work...

But on the other hand, if I apply your commit and load/unload
9pnet_virtio 5-10 times (I ran it in a loop) I get KASAN errors because
we put too many of these refs ; that doesn't happen without your patch
so it's apparently wrong.
I'm curious how that could make modprobe work better for you as well, it
shouldn't depend on that...

Maybe `modprobe -r` might give a better error, or something in dmesg?

-- 
Dominique
