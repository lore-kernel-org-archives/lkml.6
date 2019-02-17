Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902FCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A122192D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfBQIpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 03:45:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfBQIpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 03:45:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECDBA5A7A;
        Sun, 17 Feb 2019 08:44:59 +0000 (UTC)
Received: from localhost (ovpn-117-203.ams2.redhat.com [10.36.117.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81B94101E846;
        Sun, 17 Feb 2019 08:44:59 +0000 (UTC)
Date:   Sun, 17 Feb 2019 08:44:58 +0000
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: nbd, nbdkit, loopback mounts and memory management
Message-ID: <20190217084458.GY12500@redhat.com>
References: <20190215191953.GB17897@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215191953.GB17897@amd>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 17 Feb 2019 08:45:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So not to dispute that this could be a bug, but I couldn't cause a
deadlock.  I wonder if you can see something wrong with my method?

*** Set up ***

- kernel 5.0.0-0.rc3.git0.1.fc30.x86_64
- nbd-client 3.19-1.fc30
- nbdkit 1.11.5 (git commit ef9d1978ce28)

Baremetal machine was booted with mem=2G to artificially limit the
RAM.  The machine has 64G of swap.

# free -m
              total        used        free      shared  buff/cache   available
Mem:           1806         329        1383           0          93        1357
Swap:         65535         179       65356

*** Method ***

I started nbdkit as a 4G RAM disk:

  ./nbdkit memory size=4G

This is implemented as a sparse array with a 2 level page table, and
should allocate (using malloc) every time a new area of the disk is
written to.  Exact implementation is here:
https://github.com/libguestfs/nbdkit/tree/master/common/sparse

I started nbd-client using the -swap option which uses
mlockall(MCL_FUTURE) to lock the client into RAM.

  nbd-client -b 512 -swap localhost /dev/nbd0

I then created a filesystem on the RAM disk, mounted it, and copied a
3G file into it.  I tried this various ways, but the variation I was
eventually happy with was:

  mke2fs /dev/nbd0
  mount /dev/nbd0 /tmp/mnt

  dd if=/dev/zero of=/tmp/big bs=1M count=3000
  cp /tmp/big /tmp/mnt/big

I couldn't get any kind of deadlock or failure in this test.

(Note that if you repeat the test several times, in theory you could
delete the file and fstrim the filesystem, but when I was testing it
to be sure I unmounted everything and killed and restarted nbdkit
between each test.)

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
