Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF1B2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="BaSQQwXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfBLLUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:20:12 -0500
Received: from mailin.studentenwerk.mhn.de ([141.84.225.229]:42200 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728566AbfBLLUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:20:12 -0500
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 43zKvG3sFDzRhSB;
        Tue, 12 Feb 2019 12:20:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de;
        s=stwm-20170627; t=1549970410;
        bh=csFDrj5lnUZFdqUaPI4/vY02iN7w/tP+ZWXd7xFMsGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BaSQQwXdMxKXf0LBRchihxZvQerHJrK68Et+t0L3TiMGHz5FLTtxgULiZLWZ1OCkv
         MKdFbczjILUbSsDX0mg5RqA3BZ73/GJmNXnLRs20v4JVRc3blXN7P0LEH27UJVErLX
         l4OXCaj2vD8VMrZEZ7Oy7hQgLeyzxhExxTyM1Q+ypV/nQuI18JbLSwXvKDxFI8Sjk0
         PLLxsT56tDJvhmYFeiNSl4gay9YKk27Xy95ire9a1rktbIPuLFfwzRxlNHcXCS2Wza
         HyE2XH/QcykedujOVQbHGiLVqmwlTBBDdF5iOKbo7Mbd5cFIZFTD6ZYEYDn4gPJbbi
         riGbTFCqsy7IQ==
From:   Wolfgang Walter <linux@stwm.de>
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux 4.19.19: md0_raid:1317 blocked for more than 120 seconds.
Date:   Tue, 12 Feb 2019 12:20:10 +0100
Message-ID: <3057098.nBgIypvgED@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.18.12-041812-generic; KDE/4.14.13; x86_64; ; )
In-Reply-To: <0ee180ac-bb43-6c2f-4084-5cc452a18c9d@suse.com>
References: <2131016.q2kFhguZXe@stwm.de> <0ee180ac-bb43-6c2f-4084-5cc452a18c9d@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 12. Februar 2019, 16:20:11 schrieb Guoqing Jiang:
> On 2/11/19 11:12 PM, Wolfgang Walter wrote:
> > With 4.19.19 we see sometimes the following issue (practically only=
 with
> > blk_mq, though):
> >=20
> > Feb  4 20:04:46 tettnang kernel: [252300.060165] INFO: task md0_rai=
d1:317
> > blocked for more than 120 seconds. Feb  4 20:04:46 tettnang kernel:=

> > [252300.060188]       Not tainted 4.19.19-debian64.all+1.1 #1 Feb  =
4
> > 20:04:46 tettnang kernel: [252300.060197] "echo 0 >
> > /proc/sys/kernel/hung_task_timeout_secs" disables this message. Feb=
  4
> > 20:04:46 tettnang kernel: [252300.060207] md0_raid1       D    0   =
317  =20
> >   2 0x80000000 Feb  4 20:04:46 tettnang kernel: [252300.060211] Cal=
l
> > Trace:
> > Feb  4 20:04:46 tettnang kernel: [252300.060222]  ? __schedule+0x2a=
2/0x8c0
> > Feb  4 20:04:46 tettnang kernel: [252300.060226]  ?
> > _raw_spin_unlock_irqrestore+0x20/0x40 Feb  4 20:04:46 tettnang kern=
el:
> > [252300.060229]  schedule+0x32/0x90 Feb  4 20:04:46 tettnang kernel=
:
> > [252300.060241]  md_super_wait+0x69/0xa0 [md_mod] Feb  4 20:04:46
> > tettnang kernel: [252300.060247]  ? finish_wait+0x80/0x80 Feb  4 20=
:04:46
> > tettnang kernel: [252300.060255]  md_bitmap_wait_writes+0x8e/0xa0
> > [md_mod] Feb  4 20:04:46 tettnang kernel: [252300.060263]  ?
> > md_bitmap_get_counter+0x42/0xd0 [md_mod] Feb  4 20:04:46 tettnang k=
ernel:
> > [252300.060271]  md_bitmap_daemon_work+0x1e8/0x380 [md_mod] Feb  4
> > 20:04:46 tettnang kernel: [252300.060278]  ? md_rdev_init+0xb0/0xb0=

> > [md_mod] Feb  4 20:04:46 tettnang kernel: [252300.060285]=20
> > md_check_recovery+0x26/0x540 [md_mod] Feb  4 20:04:46 tettnang kern=
el:
> > [252300.060290]  raid1d+0x5c/0xf00 [raid1] Feb  4 20:04:46 tettnang=

> > kernel: [252300.060294]  ? preempt_count_add+0x79/0xb0 Feb  4 20:04=
:46
> > tettnang kernel: [252300.060298]  ? lock_timer_base+0x67/0x80 Feb  =
4
> > 20:04:46 tettnang kernel: [252300.060302]  ?
> > _raw_spin_unlock_irqrestore+0x20/0x40 Feb  4 20:04:46 tettnang kern=
el:
> > [252300.060304]  ? try_to_del_timer_sync+0x4d/0x80 Feb  4 20:04:46
> > tettnang kernel: [252300.060306]  ? del_timer_sync+0x35/0x40 Feb  4=

> > 20:04:46 tettnang kernel: [252300.060309]  ? schedule_timeout+0x17a=
/0x3b0
> > Feb  4 20:04:46 tettnang kernel: [252300.060312]  ?
> > preempt_count_add+0x79/0xb0 Feb  4 20:04:46 tettnang kernel:
> > [252300.060315]  ? _raw_spin_lock_irqsave+0x25/0x50 Feb  4 20:04:46=

> > tettnang kernel: [252300.060321]  ? md_rdev_init+0xb0/0xb0 [md_mod]=
 Feb=20
> > 4 20:04:46 tettnang kernel: [252300.060327]  ? md_thread+0xf9/0x160=

> > [md_mod] Feb  4 20:04:46 tettnang kernel: [252300.060330]  ?
> > r1bio_pool_alloc+0x20/0x20 [raid1] Feb  4 20:04:46 tettnang kernel:=

> > [252300.060336]  md_thread+0xf9/0x160 [md_mod] Feb  4 20:04:46 tett=
nang
> > kernel: [252300.060340]  ? finish_wait+0x80/0x80 Feb  4 20:04:46 te=
ttnang
> > kernel: [252300.060344]  kthread+0x112/0x130 Feb  4 20:04:46 tettna=
ng
> > kernel: [252300.060346]  ? kthread_create_worker_on_cpu+0x70/0x70 F=
eb  4
> > 20:04:46 tettnang kernel: [252300.060350]  ret_from_fork+0x35/0x40
> >=20
> > I saw that there was a similar problem with raid10 and an upstream =
patch
> >=20
> > e820d55cb99dd93ac2dc949cf486bb187e5cd70d
> > md: fix raid10 hang issue caused by barrier
> > by  Guoqing Jiang
> >=20
> > I wonder if there is a similar fix needed for raid1?
>=20
> Seems not, the calltrace tells the previous write superblock IO was n=
ot
> finish as expected,
> there is a report for raid5 which has similar problem with md_super_w=
ait
> in the link [1]. Maybe
> you can disable blk-mq to narrow down the issue as well.

I already did for 4 weeks. I didn't saw this with blk-mq disabled (for =
scsi=20
and md), though this may be by luck.

>=20
> And I don't know why  md_bitmap_wait_writes is needed in
> bitmap_daemon_work because
> it doesn't call write_page before md_bitmap_wait_writes, and the chan=
ge
> is introduced in
> commit 85c9ccd4f026a ("md/bitmap: Don't write bitmap while earlier
> writes might be in-flight").
> Neil, is it safe to remove it? Thanks.
>=20
> [1] |https://bbs.archlinux.org/viewtopic.php?id=3D243520

I found this bug report in debian:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D904822

Regards,
--=20
Wolfgang Walter
Studentenwerk M=FCnchen
Anstalt des =F6ffentlichen Rechts
