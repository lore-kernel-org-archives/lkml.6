Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48TnQRaFAburrZBdw6tLaomaYG7rmKgLycYuzsnDi4h0yijqQmtAu1TWo5xqJmALH59grHP
ARC-Seal: i=1; a=rsa-sha256; t=1523980939; cv=none;
        d=google.com; s=arc-20160816;
        b=iwGlSUjC5UMe57F1esm296a8LWBUeK5CiLSxTK+s5h7F9dkRV7bVv/Wu5R3rcSXJf9
         w0hhZMSgi3CtWTx6Zaa6imKiLNP1adK2SFIz9bzhwrn6C5bYhrQ3GAJxU4IWnAQV9+j4
         pCjRH4A0ZNHg/HyrT7iyA/xaav/Ju3mc3NFHubxXksKOux5Z9TTHmkn8t0NK7LmqvmgJ
         VkgwFboP/nBJrhVy5iCS2LgX+hos73JF2XeqViTFQzV6C9sxqx+URA6UEit0NK9mrvwf
         0LIfyt48VXwHDhElQZHfSvCxx5d+3vAXG19SHpiWW5MAzdgl8JJ+/DDONGyUzCm0ekL/
         g67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uS553Fjc55FUKVL2/ldelsb8eyxwcCMajiY+4eNdn6w=;
        b=ke2CpKmZzBTu+qXL8ZOQHFsTwB+hvKUS/hoJpxkwSIqavsoE5z86DFtvz4+3rFnz2P
         /DHx7VAbE1MKUVfIsneBVKGXAWh3nKF2qZrWIkXyURKMtidqieX/Rw0PUsh3cdOfwIy8
         5VEZ6He13bwxOiB/Zy7g5AYc5goupuWxD0HVU/BZ9axZG5oWoJ+RQBlIe6T9hzalK+Sv
         5jYUfLm/YmiHopZyGegC0IVRqMNbDH7v60DQZWnmu1B8S03mci13zVY4XfWsUTrJQoy3
         BProkPJ7pnTpczj2ZMPGqnyWZa1a+kU9FnDijjZh12B374wpBiDM22v4bcFmH1y1yZVp
         rkUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <bot+48594378e9851eab70bcd6f99327c7db58c5a28a@syzkaller.appspotmail.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jens Axboe <axboe@fb.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 57/68] block/loop: fix deadlock after loop_set_status
Date: Tue, 17 Apr 2018 17:58:10 +0200
Message-Id: <20180417155751.656856369@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009837369883753?=
X-GMAIL-MSGID: =?utf-8?q?1598009837369883753?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 1e047eaab3bb5564f25b41e9cd3a053009f4e789 upstream.

syzbot is reporting deadlocks at __blkdev_get() [1].

----------------------------------------
[   92.493919] systemd-udevd   D12696   525      1 0x00000000
[   92.495891] Call Trace:
[   92.501560]  schedule+0x23/0x80
[   92.502923]  schedule_preempt_disabled+0x5/0x10
[   92.504645]  __mutex_lock+0x416/0x9e0
[   92.510760]  __blkdev_get+0x73/0x4f0
[   92.512220]  blkdev_get+0x12e/0x390
[   92.518151]  do_dentry_open+0x1c3/0x2f0
[   92.519815]  path_openat+0x5d9/0xdc0
[   92.521437]  do_filp_open+0x7d/0xf0
[   92.527365]  do_sys_open+0x1b8/0x250
[   92.528831]  do_syscall_64+0x6e/0x270
[   92.530341]  entry_SYSCALL_64_after_hwframe+0x42/0xb7

[   92.931922] 1 lock held by systemd-udevd/525:
[   92.933642]  #0: 00000000a2849e25 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x73/0x4f0
----------------------------------------

The reason of deadlock turned out that wait_event_interruptible() in
blk_queue_enter() got stuck with bdev->bd_mutex held at __blkdev_put()
due to q->mq_freeze_depth == 1.

----------------------------------------
[   92.787172] a.out           S12584   634    633 0x80000002
[   92.789120] Call Trace:
[   92.796693]  schedule+0x23/0x80
[   92.797994]  blk_queue_enter+0x3cb/0x540
[   92.803272]  generic_make_request+0xf0/0x3d0
[   92.807970]  submit_bio+0x67/0x130
[   92.810928]  submit_bh_wbc+0x15e/0x190
[   92.812461]  __block_write_full_page+0x218/0x460
[   92.815792]  __writepage+0x11/0x50
[   92.817209]  write_cache_pages+0x1ae/0x3d0
[   92.825585]  generic_writepages+0x5a/0x90
[   92.831865]  do_writepages+0x43/0xd0
[   92.836972]  __filemap_fdatawrite_range+0xc1/0x100
[   92.838788]  filemap_write_and_wait+0x24/0x70
[   92.840491]  __blkdev_put+0x69/0x1e0
[   92.841949]  blkdev_close+0x16/0x20
[   92.843418]  __fput+0xda/0x1f0
[   92.844740]  task_work_run+0x87/0xb0
[   92.846215]  do_exit+0x2f5/0xba0
[   92.850528]  do_group_exit+0x34/0xb0
[   92.852018]  SyS_exit_group+0xb/0x10
[   92.853449]  do_syscall_64+0x6e/0x270
[   92.854944]  entry_SYSCALL_64_after_hwframe+0x42/0xb7

[   92.943530] 1 lock held by a.out/634:
[   92.945105]  #0: 00000000a2849e25 (&bdev->bd_mutex){+.+.}, at: __blkdev_put+0x3c/0x1e0
----------------------------------------

The reason of q->mq_freeze_depth == 1 turned out that loop_set_status()
forgot to call blk_mq_unfreeze_queue() at error paths for
info->lo_encrypt_type != NULL case.

----------------------------------------
[   37.509497] CPU: 2 PID: 634 Comm: a.out Tainted: G        W        4.16.0+ #457
[   37.513608] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[   37.518832] RIP: 0010:blk_freeze_queue_start+0x17/0x40
[   37.521778] RSP: 0018:ffffb0c2013e7c60 EFLAGS: 00010246
[   37.524078] RAX: 0000000000000000 RBX: ffff8b07b1519798 RCX: 0000000000000000
[   37.527015] RDX: 0000000000000002 RSI: ffffb0c2013e7cc0 RDI: ffff8b07b1519798
[   37.529934] RBP: ffffb0c2013e7cc0 R08: 0000000000000008 R09: 47a189966239b898
[   37.532684] R10: dad78b99b278552f R11: 9332dca72259d5ef R12: ffff8b07acd73678
[   37.535452] R13: 0000000000004c04 R14: 0000000000000000 R15: ffff8b07b841e940
[   37.538186] FS:  00007fede33b9740(0000) GS:ffff8b07b8e80000(0000) knlGS:0000000000000000
[   37.541168] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.543590] CR2: 00000000206fdf18 CR3: 0000000130b30006 CR4: 00000000000606e0
[   37.546410] Call Trace:
[   37.547902]  blk_freeze_queue+0x9/0x30
[   37.549968]  loop_set_status+0x67/0x3c0 [loop]
[   37.549975]  loop_set_status64+0x3b/0x70 [loop]
[   37.549986]  lo_ioctl+0x223/0x810 [loop]
[   37.549995]  blkdev_ioctl+0x572/0x980
[   37.550003]  block_ioctl+0x34/0x40
[   37.550006]  do_vfs_ioctl+0xa7/0x6d0
[   37.550017]  ksys_ioctl+0x6b/0x80
[   37.573076]  SyS_ioctl+0x5/0x10
[   37.574831]  do_syscall_64+0x6e/0x270
[   37.576769]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
----------------------------------------

[1] https://syzkaller.appspot.com/bug?id=cd662bc3f6022c0979d01a262c318fab2ee9b56f

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <bot+48594378e9851eab70bcd6f99327c7db58c5a28a@syzkaller.appspotmail.com>
Fixes: ecdd09597a572513 ("block/loop: fix race between I/O and set_status")
Cc: Ming Lei <tom.leiming@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: stable <stable@vger.kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1103,11 +1103,15 @@ loop_set_status(struct loop_device *lo,
 	if (info->lo_encrypt_type) {
 		unsigned int type = info->lo_encrypt_type;
 
-		if (type >= MAX_LO_CRYPT)
-			return -EINVAL;
+		if (type >= MAX_LO_CRYPT) {
+			err = -EINVAL;
+			goto exit;
+		}
 		xfer = xfer_funcs[type];
-		if (xfer == NULL)
-			return -EINVAL;
+		if (xfer == NULL) {
+			err = -EINVAL;
+			goto exit;
+		}
 	} else
 		xfer = NULL;
 
