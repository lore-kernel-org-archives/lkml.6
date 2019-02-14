Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE8EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BF0222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="U1Eawyj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502073AbfBNP1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:27:25 -0500
Received: from mailin.studentenwerk.mhn.de ([141.84.225.229]:51568 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407551AbfBNP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:27:24 -0500
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 440gHb0XxlzRhSK;
        Thu, 14 Feb 2019 16:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de;
        s=stwm-20170627; t=1550158043;
        bh=zWZc5prG9PG/gbLgwFpHQXgXSX3bPKTrNUpmOt+TsBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1Eawyj6aOC4zQq0jVuA5NoQciwRlLPpK1dq436DfXO2woGT6tl5C3VbucphAwWDe
         zSwMUiiyBVkoPNUxBRtLAE1lSVGaCD8JOwnd9mY7GD6giWHXm6U++zZGyDElFQOJyP
         gx6eZR4RAGoTt5u1UJnSdF+GCQ7ni+Yty+jtcpcnJHZ4ChBzsIQcy4jXwE6/aoqaM0
         9rbGGxW+LaonHXAtH5wH57AarVEYcsUUGy6lu0mT0Wy4V4iuok8ngNtyodqEWhoO4X
         sBvBsO3n/e4RIPslV1Y0OBQJcVnSo/wDg5xasbhF3j0vWUwkdUNglPZkdV/QyOgDBx
         BAsYSDqFDKHGQ==
From:   Wolfgang Walter <linux@stwm.de>
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux 4.19.19: md0_raid:1317 blocked for more than 120 seconds.
Date:   Thu, 14 Feb 2019 16:27:22 +0100
Message-ID: <3877135.KJXZSZYZ1L@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.18.12-041812-generic; KDE/4.14.13; x86_64; ; )
In-Reply-To: <0c832f67-de10-8872-d3db-6a9f11c97454@suse.com>
References: <2131016.q2kFhguZXe@stwm.de> <3057098.nBgIypvgED@stwm.de> <0c832f67-de10-8872-d3db-6a9f11c97454@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Februar 2019, 10:09:56 schrieb Guoqing Jiang:
> On 2/12/19 7:20 PM, Wolfgang Walter wrote:
> > Am Dienstag, 12. Februar 2019, 16:20:11 schrieb Guoqing Jiang:
> >> On 2/11/19 11:12 PM, Wolfgang Walter wrote:
> >>> With 4.19.19 we see sometimes the following issue (practically on=
ly with
> >>> blk_mq, though):
> >>>=20
> >>> Feb  4 20:04:46 tettnang kernel: [252300.060165] INFO: task
> >>> md0_raid1:317
> >>> blocked for more than 120 seconds. Feb  4 20:04:46 tettnang kerne=
l:
> >>> [252300.060188]       Not tainted 4.19.19-debian64.all+1.1 #1 Feb=
  4
> >>> 20:04:46 tettnang kernel: [252300.060197] "echo 0 >
> >>> /proc/sys/kernel/hung_task_timeout_secs" disables this message. F=
eb  4
> >>> 20:04:46 tettnang kernel: [252300.060207] md0_raid1       D    0 =
  317
> >>>=20
> >>>    2 0x80000000 Feb  4 20:04:46 tettnang kernel: [252300.060211] =
Call
> >>>=20
> >>> Trace:
> >>> Feb  4 20:04:46 tettnang kernel: [252300.060222]  ?
> >>> __schedule+0x2a2/0x8c0
> >>> Feb  4 20:04:46 tettnang kernel: [252300.060226]  ?
> >>> _raw_spin_unlock_irqrestore+0x20/0x40 Feb  4 20:04:46 tettnang ke=
rnel:
> >>> [252300.060229]  schedule+0x32/0x90 Feb  4 20:04:46 tettnang kern=
el:
> >>> [252300.060241]  md_super_wait+0x69/0xa0 [md_mod] Feb  4 20:04:46=

> >>> tettnang kernel: [252300.060247]  ? finish_wait+0x80/0x80 Feb  4
> >>> 20:04:46
> >>> tettnang kernel: [252300.060255]  md_bitmap_wait_writes+0x8e/0xa0=

> >>> [md_mod] Feb  4 20:04:46 tettnang kernel: [252300.060263]  ?
> >>> md_bitmap_get_counter+0x42/0xd0 [md_mod] Feb  4 20:04:46 tettnang=

> >>> kernel:
> >>> [252300.060271]  md_bitmap_daemon_work+0x1e8/0x380 [md_mod] Feb  =
4
> >>> 20:04:46 tettnang kernel: [252300.060278]  ? md_rdev_init+0xb0/0x=
b0
> >>> [md_mod] Feb  4 20:04:46 tettnang kernel: [252300.060285]
> >>> md_check_recovery+0x26/0x540 [md_mod] Feb  4 20:04:46 tettnang ke=
rnel:
> >>> [252300.060290]  raid1d+0x5c/0xf00 [raid1] Feb  4 20:04:46 tettna=
ng
> >>> kernel: [252300.060294]  ? preempt_count_add+0x79/0xb0 Feb  4 20:=
04:46
> >>> tettnang kernel: [252300.060298]  ? lock_timer_base+0x67/0x80 Feb=
  4
> >>> 20:04:46 tettnang kernel: [252300.060302]  ?
> >>> _raw_spin_unlock_irqrestore+0x20/0x40 Feb  4 20:04:46 tettnang ke=
rnel:
> >>> [252300.060304]  ? try_to_del_timer_sync+0x4d/0x80 Feb  4 20:04:4=
6
> >>> tettnang kernel: [252300.060306]  ? del_timer_sync+0x35/0x40 Feb =
 4
> >>> 20:04:46 tettnang kernel: [252300.060309]  ?
> >>> schedule_timeout+0x17a/0x3b0
> >>> Feb  4 20:04:46 tettnang kernel: [252300.060312]  ?
> >>> preempt_count_add+0x79/0xb0 Feb  4 20:04:46 tettnang kernel:
> >>> [252300.060315]  ? _raw_spin_lock_irqsave+0x25/0x50 Feb  4 20:04:=
46
> >>> tettnang kernel: [252300.060321]  ? md_rdev_init+0xb0/0xb0 [md_mo=
d] Feb
> >>> 4 20:04:46 tettnang kernel: [252300.060327]  ? md_thread+0xf9/0x1=
60
> >>> [md_mod] Feb  4 20:04:46 tettnang kernel: [252300.060330]  ?
> >>> r1bio_pool_alloc+0x20/0x20 [raid1] Feb  4 20:04:46 tettnang kerne=
l:
> >>> [252300.060336]  md_thread+0xf9/0x160 [md_mod] Feb  4 20:04:46 te=
ttnang
> >>> kernel: [252300.060340]  ? finish_wait+0x80/0x80 Feb  4 20:04:46
> >>> tettnang
> >>> kernel: [252300.060344]  kthread+0x112/0x130 Feb  4 20:04:46 tett=
nang
> >>> kernel: [252300.060346]  ? kthread_create_worker_on_cpu+0x70/0x70=
 Feb  4
> >>> 20:04:46 tettnang kernel: [252300.060350]  ret_from_fork+0x35/0x4=
0
> >>>=20
> >>> I saw that there was a similar problem with raid10 and an upstrea=
m patch
> >>>=20
> >>> e820d55cb99dd93ac2dc949cf486bb187e5cd70d
> >>> md: fix raid10 hang issue caused by barrier
> >>> by  Guoqing Jiang
> >>>=20
> >>> I wonder if there is a similar fix needed for raid1?
> >>=20
> >> Seems not, the calltrace tells the previous write superblock IO wa=
s not
> >> finish as expected,
> >> there is a report for raid5 which has similar problem with md_supe=
r_wait
> >> in the link [1]. Maybe
> >> you can disable blk-mq to narrow down the issue as well.
> >=20
> > I already did for 4 weeks. I didn't saw this with blk-mq disabled (=
for
> > scsi
> > and md), though this may be by luck.
>=20
> Then I guess it maybe related to blk-mq, which scheduler are you used=

> with blk-mq?
> And maybe you can switch it to see if it is caused by specified
> scheduler or not.

mq-deadline for SCSI and none for md and dm.

>=20
> >> [1] |https://bbs.archlinux.org/viewtopic.php?id=3D243520
> >=20
> > I found this bug report in debian:
> >=20
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D904822
>=20
> Thanks, the bug report also said it didn't happen after disable blk-m=
q.
>=20

Regards,
--=20
Wolfgang Walter
Studentenwerk M=FCnchen
Anstalt des =F6ffentlichen Rechts
