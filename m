Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922CE2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tm9fRYVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922CE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeH2K1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:27:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64291 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeH2K1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:27:20 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Aug 2018 06:27:15 EDT
Received: from pb-smtp21.pobox.com (unknown [10.110.30.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPS id DC9E611B8A3;
        Wed, 29 Aug 2018 02:23:03 -0400 (EDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5777F224D6;
        Wed, 29 Aug 2018 02:23:03 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:from
        :subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=06oCUx+4gkRbWLZpkOTESP2TH
        ew=; b=Tm9fRYVwzWKwKOGwq+4j0Ck7VaoPPs77XjDsdfOEpotFbY1OFk5LSX4SO
        OSUdp8ocVjTVs3P7ihrtAUmHq6vqQekfVXRkP77m9z8NSDPDKh4JmSHGTy07zlcS
        /CqTDx9CH5IEWR/kGGvQmHFlx4HijKt4KUEkw6biJoQsk6rMAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:from:subject
        :message-id:date:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=lKualcV2qHZDcyC6BIe
        BB01f2X/XB25ZYil3iQKsKfZbmlUTl2RwkFgXFk1P0P89ud3z52dVLX/XbRCZo5c
        5vjhdvpIH9f/H+KZ5MnqJdwHaM4YwCctAcGbDxy73AVnxLDC0RtJ4ZtERIdvMzyj
        0Yls/SS2WdbAJicIwpHx1t8U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 519B6224D5;
        Wed, 29 Aug 2018 02:23:03 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
Received: from [192.168.1.127] (unknown [76.215.41.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6777E224D1;
        Wed, 29 Aug 2018 02:22:59 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
To:     linux-raid <linux-raid@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Shaohua Li <shli@kernel.org>
From:   Daniel Santos <daniel.santos@pobox.com>
Subject: Deadlock in md
Message-ID: <e16903e0-357a-031e-0f97-d12db200df68@pobox.com>
Date:   Wed, 29 Aug 2018 01:22:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: F9D062BC-AB53-11E8-852B-CC883AD79A78-06139138!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have not rebooted my system since recovering my data off of an old
raid5 array with an external journal which broke after a crash in
write-back mode (https://www.spinics.net/lists/raid/msg61331.html) and I
noticed this in my kernel log.=C2=A0 I had the array assembled in read-on=
ly
mode without a journal.=C2=A0 When I was done getting my data, I had stop=
ped
the array and zeroed the first 1GiB of each raid member.=C2=A0 After this=
 I
modified the partition tables of the disks, but fdisk reported my
/dev/sdb to be in use by the kernel, as did partprobe, presumably due to
a reference leaked from the deadlock.

This is v4.15.67 with an assortment of debugging features enabled, but I
didn't have kmemleak on because I was copying a lot of files (too many
"soft lockups" when it ran).

[203283.385588] md0: detected capacity change from 8796094070784 to 0
[203283.385610] md: md0 stopped.

[203283.430869] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[203283.430870] WARNING: possible circular locking dependency detected
[203283.430872] 4.14.67-gentoo-debug #3 Not tainted
[203283.430873] ------------------------------------------------------
[203283.430875] kworker/13:1/480 is trying to acquire lock:
[203283.430876]=C2=A0 (kn->count#82){++++}, at: [<ffffffffb75c8a3a>]
kernfs_remove+0x1a/0x30
[203283.430883]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 but task is already holding lock:
[203283.430885]=C2=A0 ((&mddev->del_work)){+.+.}, at: [<ffffffffb72b7125>=
]
process_one_work+0x255/0x740
[203283.430889]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 which lock already depends on the new lock.

[203283.430891]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 the existing dependency chain (in reverse order) is:
[203283.430892]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -> #5 ((&mddev->del_work)){+.+.}:
[203283.430896]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_acquire+0x=
a6/0x160
[203283.430898]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 process_one_wor=
k+0x2af/0x740
[203283.430900]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 worker_thread+0=
x43/0x690
[203283.430902]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kthread+0x18f/0=
x260
[203283.430905]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret_from_fork+0=
x27/0x50
[203283.430906]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -> #4 ("md_misc"){+.+.}:
[203283.430910]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_acquire+0x=
a6/0x160
[203283.430911]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flush_workqueue=
+0xa6/0xa00
[203283.430914]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __md_stop_write=
s+0x19/0x130
[203283.430916]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_md_stop+0x18=
d/0x700
[203283.430917]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 md_ioctl+0xcfb/=
0x2290
[203283.430920]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blkdev_ioctl+0x=
6a8/0x1020
[203283.430922]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_ioctl+0x5=
2/0xa0
[203283.430924]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_vfs_ioctl+0x=
c4/0x990
[203283.430926]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SyS_ioctl+0x91/=
0xa0
[203283.430928]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_syscall_64+0=
x83/0x260
[203283.430930]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_SYSCALL_6=
4_after_hwframe+0x42/0xb7
[203283.430931]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -> #3 (&mddev->open_mutex){+.+.}:
[203283.430934]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_acquire+0x=
a6/0x160
[203283.430936]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mutex_lock+0x=
74/0xc60
[203283.430938]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 md_open+0x6c/0x=
140
[203283.430939]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __blkdev_get+0x=
ce/0x560
[203283.430941]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blkdev_get+0x27=
f/0x500
[203283.430943]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_dentry_open+=
0x293/0x4c0
[203283.430945]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path_openat+0x5=
a3/0xf30
[203283.430947]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_filp_open+0x=
b7/0x150
[203283.430948]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_sys_open+0x1=
d1/0x2c0
[203283.430950]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_syscall_64+0=
x83/0x260
[203283.430952]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_SYSCALL_6=
4_after_hwframe+0x42/0xb7
[203283.430953]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -> #2 (&bdev->bd_mutex){+.+.}:
[203283.430956]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_acquire+0x=
a6/0x160
[203283.430957]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mutex_lock+0x=
74/0xc60
[203283.430959]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __blkdev_get+0x=
54/0x560
[203283.430960]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blkdev_get+0x27=
f/0x500
[203283.430962]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blkdev_get_by_d=
ev+0x38/0x60
[203283.430963]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_rdev+0x43/=
0xb0
[203283.430965]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 md_import_devic=
e+0xf7/0x290
[203283.430966]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add_new_disk+0x=
e1/0x782
[203283.430968]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 md_ioctl+0x1664=
/0x2290
[203283.430969]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blkdev_ioctl+0x=
6a8/0x1020
[203283.430971]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_ioctl+0x5=
2/0xa0
[203283.430972]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_vfs_ioctl+0x=
c4/0x990
[203283.430974]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SyS_ioctl+0x91/=
0xa0
[203283.430976]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_syscall_64+0=
x83/0x260
[203283.430978]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_SYSCALL_6=
4_after_hwframe+0x42/0xb7
[203283.430978]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -> #1 (&mddev->reconfig_mutex){+.+.}:
[203283.430982]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_acquire+0x=
a6/0x160
[203283.430983]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mutex_lock+0x=
74/0xc60
[203283.430985]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 array_state_sto=
re+0xcf/0x4e0
[203283.430986]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 md_attr_store+0=
xa5/0x130
[203283.430988]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernfs_fop_writ=
e+0x1ad/0x300
[203283.430990]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __vfs_write+0x6=
4/0x2c0
[203283.430991]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfs_write+0xf1/=
0x2e0
[203283.430993]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SyS_write+0x4e/=
0xc0
[203283.430994]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_syscall_64+0=
x83/0x260
[203283.430996]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_SYSCALL_6=
4_after_hwframe+0x42/0xb7
[203283.430997]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -> #0 (kn->count#82){++++}:
[203283.431000]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __lock_acquire+=
0x14c7/0x1c50
[203283.431002]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_acquire+0x=
a6/0x160
[203283.431004]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __kernfs_remove=
+0x26d/0x390
[203283.431005]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernfs_remove+0=
x1a/0x30
[203283.431008]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kobject_del.par=
t.0+0x21/0x70
[203283.431010]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mddev_delayed_d=
elete+0x1f/0x30
[203283.431012]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 process_one_wor=
k+0x2bc/0x740
[203283.431013]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 worker_thread+0=
x43/0x690
[203283.431015]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kthread+0x18f/0=
x260
[203283.431017]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret_from_fork+0=
x27/0x50
[203283.431018]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 other info that might help us debug this:

[203283.431020] Chain exists of:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 kn->count#82 --> "md_misc" --> (&mddev->del_w=
ork)

[203283.431023]=C2=A0 Possible unsafe locking scenario:

[203283.431025]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU1
[203283.431026]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----
[203283.431027]=C2=A0=C2=A0 lock((&mddev->del_work));
[203283.431028]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock("md_misc");
[203283.431030]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock((&mddev->del_wor=
k));
[203283.431031]=C2=A0=C2=A0 lock(kn->count#82);
[203283.431033]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *** DEADLOCK ***

[203283.431035] 2 locks held by kworker/13:1/480:
[203283.431036]=C2=A0 #0:=C2=A0 ("md_misc"){+.+.}, at: [<ffffffffb72b7125=
>]
process_one_work+0x255/0x740
[203283.431039]=C2=A0 #1:=C2=A0 ((&mddev->del_work)){+.+.}, at:
[<ffffffffb72b7125>] process_one_work+0x255/0x740
[203283.431042]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 stack backtrace:
[203283.431045] CPU: 13 PID: 480 Comm: kworker/13:1 Not tainted
4.14.67-gentoo-debug #3
[203283.431046] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./X470 Taichi Ultimate, BIOS P1.20 04/17/2018
[203283.431048] Workqueue: md_misc mddev_delayed_delete
[203283.431050] Call Trace:
[203283.431053]=C2=A0 dump_stack+0x86/0xcf
[203283.431056]=C2=A0 print_circular_bug.isra.16+0x24c/0x3e0
[203283.431058]=C2=A0 check_prev_add.constprop.24+0x541/0x7f0
[203283.431061]=C2=A0 __lock_acquire+0x14c7/0x1c50
[203283.431064]=C2=A0 lock_acquire+0xa6/0x160
[203283.431066]=C2=A0 ? kernfs_remove+0x1a/0x30
[203283.431068]=C2=A0 __kernfs_remove+0x26d/0x390
[203283.431070]=C2=A0 ? kernfs_remove+0x1a/0x30
[203283.431072]=C2=A0 ? sysfs_remove_dir+0x39/0x90
[203283.431074]=C2=A0 kernfs_remove+0x1a/0x30
[203283.431076]=C2=A0 kobject_del.part.0+0x21/0x70
[203283.431078]=C2=A0 mddev_delayed_delete+0x1f/0x30
[203283.431080]=C2=A0 process_one_work+0x2bc/0x740
[203283.431082]=C2=A0 ? process_one_work+0x255/0x740
[203283.431084]=C2=A0 ? worker_thread+0xef/0x690
[203283.431086]=C2=A0 worker_thread+0x43/0x690
[203283.431088]=C2=A0 ? process_one_work+0x740/0x740
[203283.431090]=C2=A0 kthread+0x18f/0x260
[203283.431092]=C2=A0 ? kthread_create_on_node+0x40/0x40
[203283.431095]=C2=A0 ret_from_fork+0x27/0x50

Regards,
Daniel
