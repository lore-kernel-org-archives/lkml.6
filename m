Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC03FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B8321B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="M22rJE+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391377AbfBKPVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:21:33 -0500
Received: from mailin.studentenwerk.mhn.de ([141.84.225.229]:57622 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731645AbfBKPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:21:31 -0500
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2019 10:21:29 EST
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 43yq6K0NxhzRhS8;
        Mon, 11 Feb 2019 16:12:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de;
        s=stwm-20170627; t=1549897977;
        bh=rKA+/UvRXDP6sz6M9fyG+cbLCzZgCeRXhftfoPNLaCA=;
        h=From:To:Cc:Subject:Date:From;
        b=M22rJE+glZIlij0kG+tSwGfqE/3zKPHHiobPhIMKiSkBH/6Wmar1NLeaNDBrZ2Afv
         d2ByGng9zdVlxZg84yxXvC0hZFsgkXU65QUVSEM5fyi2D1bSN7u3Vk927ff0x3o4cH
         NRC9Vs0KvD35dpeCaB3pC60EDM2UfDN+9+cLW54/i9CTcga7FoMGc4E69eeLHFm5bR
         Eud7vNziyXzbPv5mmEvZ2jiSRABwI0tNSAJsyxu4cwnp7PSmEOVpge2t+fSa60mdAr
         kjTdUkKPMCQ8YBv9pqni1MYTpEjNGWCEeXDpoJnc8AVVxi6HCwCbRbdGNel97uanQX
         3P+NicGXn1jng==
From:   Wolfgang Walter <linux@stwm.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guoqing Jiang <gqjiang@suse.com>
Subject: linux 4.19.19: md0_raid:1317 blocked for more than 120 seconds.
Date:   Mon, 11 Feb 2019 16:12:56 +0100
Message-ID: <2131016.q2kFhguZXe@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.18.12-041812-generic; KDE/4.14.13; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 4.19.19 we see sometimes the following issue (practically only wit=
h blk_mq, though):

Feb  4 20:04:46 tettnang kernel: [252300.060165] INFO: task md0_raid1:3=
17 blocked for more than 120 seconds.
Feb  4 20:04:46 tettnang kernel: [252300.060188]       Not tainted 4.19=
.19-debian64.all+1.1 #1
Feb  4 20:04:46 tettnang kernel: [252300.060197] "echo 0 > /proc/sys/ke=
rnel/hung_task_timeout_secs" disables this message.
Feb  4 20:04:46 tettnang kernel: [252300.060207] md0_raid1       D    0=
   317      2 0x80000000
Feb  4 20:04:46 tettnang kernel: [252300.060211] Call Trace:
Feb  4 20:04:46 tettnang kernel: [252300.060222]  ? __schedule+0x2a2/0x=
8c0
Feb  4 20:04:46 tettnang kernel: [252300.060226]  ? _raw_spin_unlock_ir=
qrestore+0x20/0x40
Feb  4 20:04:46 tettnang kernel: [252300.060229]  schedule+0x32/0x90
Feb  4 20:04:46 tettnang kernel: [252300.060241]  md_super_wait+0x69/0x=
a0 [md_mod]
Feb  4 20:04:46 tettnang kernel: [252300.060247]  ? finish_wait+0x80/0x=
80
Feb  4 20:04:46 tettnang kernel: [252300.060255]  md_bitmap_wait_writes=
+0x8e/0xa0 [md_mod]
Feb  4 20:04:46 tettnang kernel: [252300.060263]  ? md_bitmap_get_count=
er+0x42/0xd0 [md_mod]
Feb  4 20:04:46 tettnang kernel: [252300.060271]  md_bitmap_daemon_work=
+0x1e8/0x380 [md_mod]
Feb  4 20:04:46 tettnang kernel: [252300.060278]  ? md_rdev_init+0xb0/0=
xb0 [md_mod]
Feb  4 20:04:46 tettnang kernel: [252300.060285]  md_check_recovery+0x2=
6/0x540 [md_mod]
Feb  4 20:04:46 tettnang kernel: [252300.060290]  raid1d+0x5c/0xf00 [ra=
id1]
Feb  4 20:04:46 tettnang kernel: [252300.060294]  ? preempt_count_add+0=
x79/0xb0
Feb  4 20:04:46 tettnang kernel: [252300.060298]  ? lock_timer_base+0x6=
7/0x80
Feb  4 20:04:46 tettnang kernel: [252300.060302]  ? _raw_spin_unlock_ir=
qrestore+0x20/0x40
Feb  4 20:04:46 tettnang kernel: [252300.060304]  ? try_to_del_timer_sy=
nc+0x4d/0x80
Feb  4 20:04:46 tettnang kernel: [252300.060306]  ? del_timer_sync+0x35=
/0x40
Feb  4 20:04:46 tettnang kernel: [252300.060309]  ? schedule_timeout+0x=
17a/0x3b0
Feb  4 20:04:46 tettnang kernel: [252300.060312]  ? preempt_count_add+0=
x79/0xb0
Feb  4 20:04:46 tettnang kernel: [252300.060315]  ? _raw_spin_lock_irqs=
ave+0x25/0x50
Feb  4 20:04:46 tettnang kernel: [252300.060321]  ? md_rdev_init+0xb0/0=
xb0 [md_mod]
Feb  4 20:04:46 tettnang kernel: [252300.060327]  ? md_thread+0xf9/0x16=
0 [md_mod]
Feb  4 20:04:46 tettnang kernel: [252300.060330]  ? r1bio_pool_alloc+0x=
20/0x20 [raid1]
Feb  4 20:04:46 tettnang kernel: [252300.060336]  md_thread+0xf9/0x160 =
[md_mod]
Feb  4 20:04:46 tettnang kernel: [252300.060340]  ? finish_wait+0x80/0x=
80
Feb  4 20:04:46 tettnang kernel: [252300.060344]  kthread+0x112/0x130
Feb  4 20:04:46 tettnang kernel: [252300.060346]  ? kthread_create_work=
er_on_cpu+0x70/0x70
Feb  4 20:04:46 tettnang kernel: [252300.060350]  ret_from_fork+0x35/0x=
40

I saw that there was a similar problem with raid10 and an upstream patc=
h

e820d55cb99dd93ac2dc949cf486bb187e5cd70d
md: fix raid10 hang issue caused by barrier
by  Guoqing Jiang

I wonder if there is a similar fix needed for raid1?

Regards,
--=20
Wolfgang Walter
Studentenwerk M=FCnchen
Anstalt des =F6ffentlichen Rechts
