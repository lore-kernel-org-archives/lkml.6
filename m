Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277B8C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2AA21B34
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2AA21B34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbeHIDk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 23:40:58 -0400
Received: from nautica.notk.org ([91.121.71.147]:55034 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeHIDk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 23:40:57 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 062B1C009; Thu,  9 Aug 2018 03:18:43 +0200 (CEST)
Date:   Thu, 9 Aug 2018 03:18:28 +0200
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
Message-ID: <20180809011828.GA2966@nautica>
References: <5B6AA65E.3030907@huawei.com>
 <20180808083630.GB16121@nautica>
 <5B6AB081.6090608@huawei.com>
 <20180808094014.GA5585@nautica>
 <5B6B8E96.9070302@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B6B8E96.9070302@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Thu, Aug 09, 2018:
> > What exact kernel commit are you running?
>
> My kernel commit id 6edf1d4cb0acde, and I replace the 9p code with
> 9p-next. And I wonder if this will work well?

That is somewhere on top of 4.18-rc1 and got merged in 4.18-rc4, which
are close enough so while I can question the practice I don't see why
not.

I've just tried the following:
$ git checkout 6edf1d4cb0acde
$ git checkout martinetd/9p-next net/9p fs/9p include/net/9p
(martinetd/9p-next is 9f961802a7 as of this mail)
<make, install, reboot>
$ uname -r
4.18.0-rc1+
$ lsmod | grep -E '^9pnet_virtio' || echo "not loaded"
9pnet_virtio           32768  0
$ sudo modprobe -r 9pnet_virtio
$ lsmod | grep -E '^9pnet_virtio' || echo "not loaded"
not loaded
$ sudo modprobe 9pnet_virtio
$ sudo mount -t 9p -o debug=1,trans=virtio shm /mnt
$ ls /mnt
<stuff>
$ cat /sys/module/9pnet_virtio/drivers/virtio\:9pnet_virtio/*/mount_tag
tmpshm (these could use a new line...)
$ sudo umount /mnt
$ sudo modprobe -r 9pnet_virtio
$ lsmod | grep -E '^9pnet_virtio' || echo "not loaded"
not loaded

The /sys/devices/pci*/*/virtio*/mount_tag files are also removed
properly; I don't see any problem.


Not being able to reproduce is fine in general, but I also get problems
when applying the patch and unloading the module multiple times so I
can't help but question this patch and think your problem lies somewhere
else.

-- 
Dominique
