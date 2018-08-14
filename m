Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295EDC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF2021738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="uXgvHipi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF2021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbeHNR3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:29:22 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:48688 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbeHNR3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:29:22 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 1DFAD5C045E;
        Tue, 14 Aug 2018 16:41:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1534257713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=oyejj8NItz3F+MgAEpe3HIbrtrX56fEn3BcwkpCHXDw=;
        b=uXgvHipi8SdVYirA7ditcCP5Zost8t1aN89zst8mdu7KqqdetBh3bzeqJwrBBaAY1LFrnk
        POdnEKr6qJ3cy6hZrbbfgDI70JJOQv1C4TULpMXFE8hbhzxPVMPA3+qF9s/TILlvsYWS8S
        9eWeGr2CqrS80MOrhPj6PjFpC3eq5Dk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Aug 2018 16:41:51 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     idryomov@gmail.com, axboe@kernel.dk
Cc:     sagi@grimberg.me, torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Warning when using eMMC and partprobe: generic_make_request: Trying
 to write to read-only block-device
Message-ID: <7f57199f45df7212fdbba0bd1e78142a@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using Linux 4.18 on a i.MX 6Q I see the following warning during
boot-up:

[   23.928916] ------------[ cut here ]------------
[   23.933795] WARNING: CPU: 1 PID: 527 at block/blk-core.c:2161
generic_make_request_checks+0x868/0xa18
[   23.943306] generic_make_request: Trying to write to read-only
block-device mmcblk2boot0 (partno 0)
[   23.952569] Modules linked in: joydev flexcan can_dev coda imx_vdoa
v4l2_mem2mem videobuf2_vmalloc dw_hdmi_ahb_audio evbug nhc_mobility
nhc_hop nhc_routing nhc_ipv6 nhc_dest nhc_fragment nhc_udp fuse
bluetooth_6lowpan 6lowpan
[   23.973115] CPU: 1 PID: 527 Comm: partprobe Not tainted 4.18.0 #1
[   23.979336] Hardware name: Freescale i.MX6 Quad/DualLite (Device
Tree)
[   23.985984] Backtrace:
[   23.988513] [<c010ecdc>] (dump_backtrace) from [<c010f064>]
(show_stack+0x18/0x1c)
[   23.996231]  r7:00000000 r6:60060013 r5:00000000 r4:c118ca44
[   24.002009] [<c010f04c>] (show_stack) from [<c0bc54e4>]
(dump_stack+0xb4/0xec)
[   24.009377] [<c0bc5430>] (dump_stack) from [<c012d7dc>]
(__warn+0xc4/0x108)
[   24.016471]  r10:c1108908 r9:c04864f0 r8:00000871 r7:c0ea02dc
r6:00000009 r5:00000000
[   24.024447]  r4:d73d1d1c r3:abf2ba7b
[   24.028111] [<c012d718>] (__warn) from [<c012d424>]
(warn_slowpath_fmt+0x4c/0x6c)
[   24.035741]  r9:d73d0000 r8:c01011e4 r7:c04873cc r6:d6f27400
r5:c0ea05b0 r4:c1108908
[   24.043641] [<c012d3dc>] (warn_slowpath_fmt) from [<c04864f0>]
(generic_make_request_checks+0x868/0xa18)
[   24.053296]  r3:d73d1d74 r2:c0ea05b0
[   24.058425]  r5:d6d4d0a0 r4:d6f94240
[   24.063538] [<c0485c88>] (generic_make_request_checks) from
[<c04873cc>] (generic_make_request+0xc0/0x480)
[   24.076301]  r10:d6f94240 r9:d73d0000 r8:c01011e4 r7:c1108908
r6:d73d1e98 r5:c1108908
[   24.087212]  r4:d6d4d0a0
[   24.091251] [<c048730c>] (generic_make_request) from [<c04877c4>]
(submit_bio+0x38/0x19c)
[   24.102438]  r10:00000076 r9:d73d0000 r8:c01011e4 r7:7fffffff
r6:d73d1e98 r5:c1108908
[   24.113265]  r4:d6f94240
[   24.117278] [<c048778c>] (submit_bio) from [<c047d8c4>]
(submit_bio_wait+0x5c/0x98)
[   24.127914]  r10:00000076 r9:d73d0000 r8:c01011e4 r7:7fffffff
r6:d73d1e98 r5:c1108908
[   24.138724]  r4:d6f94240
[   24.142739] [<c047d868>] (submit_bio_wait) from [<c048bd20>]
(blkdev_issue_flush+0x80/0xb0)
[   24.154038]  r6:00000000 r5:d4164340 r4:d6f94240
[   24.160143] [<c048bca0>] (blkdev_issue_flush) from [<c02de510>]
(blkdev_fsync+0x3c/0x54)
[   24.171143]  r7:7fffffff r6:d4164428 r5:7fffffff r4:00000000
[   24.178322] [<c02de4d4>] (blkdev_fsync) from [<c02d434c>]
(vfs_fsync_range+0x44/0x84)
[   24.189080]  r6:ffffffff r5:00000000 r4:d66ce000
[   24.195173] [<c02d4308>] (vfs_fsync_range) from [<c02d4404>]
(do_fsync+0x44/0x78)
[   24.205530]  r7:00000076 r6:00000000 r5:d66ce000 r4:d66ce000
[   24.212672] [<c02d43c0>] (do_fsync) from [<c02d46f8>]
(sys_fsync+0x14/0x18)
[   24.221140]  r6:01320248 r5:00000001 r4:013201d0
[   24.227266] [<c02d46e4>] (sys_fsync) from [<c0101000>]
(ret_fast_syscall+0x0/0x28)
[   24.237781] Exception stack(0xd73d1fa8 to 0xd73d1ff0)
[   24.244320] 1fa0:                   013201d0 00000001 00000004
be863b1c 00000064 00000000
[   24.255437] 1fc0: 013201d0 00000001 01320248 00000076 b6ef8aec
b6ef4c04 b6f37fa4 00000000
[   24.266593] 1fe0: 00000076 be863a00 b6e61faf b6de8306
[   24.273302] irq event stamp: 13037
[   24.278202] hardirqs last  enabled at (13045): [<c019a9e4>]
console_unlock+0x3e0/0x4e4
[   24.289163] hardirqs last disabled at (13054): [<c019a684>]
console_unlock+0x80/0x4e4
[   24.300085] softirqs last  enabled at (12880): [<c010240c>]
__do_softirq+0x224/0x2d0
[   24.310934] softirqs last disabled at (12833): [<c01334e4>]
irq_exit+0xc8/0x1ac
[   24.321438] ---[ end trace 05a4aba40df38a0c ]---

The system I am using calls partprobe for some reason, which causes the
stack
trace to appear. 

The mmcblkXbootY partitions are hardware partitions on eMMC devices
which are
by default set to read only. Partition probing should really not lead to
a
write as far as I can tell...

strace shows what partprobe is actually doing:

...
openat(AT_FDCWD, "/dev/mmcblk2boot0", O_RDONLY|O_LARGEFILE) = 4
...
ioctl(4, BLKFLSBUF)                     = 0
...
ioctl(4, BLKSSZGET, [512])              = 0
fadvise64_64(4, 0, 0, POSIX_FADV_RANDOM) = 0
fstat64(4, {st_mode=S_IFBLK|0660, st_rdev=makedev(179, 64), ...}) = 0
ioctl(4, BLKGETSIZE64, [2097152])       = 0
...
ioctl(4, CDROM_GET_CAPABILITY, 0)       = -1 EINVAL (Invalid argument)
ioctl(4, BLKALIGNOFF, [0])              = 0
ioctl(4, BLKIOMIN, [512])               = 0
ioctl(4, BLKIOOPT, [0])                 = 0
ioctl(4, BLKPBSZGET, [512])             = 0
ioctl(4, BLKSSZGET, [512])              = 0
ioctl(4, BLKGETSIZE64, [2097152])       = 0
ioctl(4, HDIO_GETGEO, {heads=4, sectors=16, cylinders=64, start=0}) = 0
fsync(4)                                = 0
close(4)                                = 0
...

Any idea?

--
Stefan
