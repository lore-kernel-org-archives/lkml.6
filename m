Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kBjDDxlHGVtsOwAAmS7hNA
	; Thu, 07 Jun 2018 14:54:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7BA07608C1; Thu,  7 Jun 2018 14:54:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9EC9C601C3;
	Thu,  7 Jun 2018 14:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9EC9C601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935363AbeFGOyT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:54:19 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40980 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935328AbeFGOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:54:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbT-0005Zn-Kd; Thu, 07 Jun 2018 15:09:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003BS-Gj; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jens Axboe" <axboe@kernel.dk>,
        "Michael Lyle" <mlyle@lyle.org>, "Marc MERLIN" <marc@merlins.org>,
        "Tang Junhui" <tang.junhui@zte.com.cn>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.767376120@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 322/410] bcache: fix crashes in duplicate cache
 device register
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tang Junhui <tang.junhui@zte.com.cn>

commit cc40daf91bdddbba72a4a8cd0860640e06668309 upstream.

Kernel crashed when register a duplicate cache device, the call trace is
bellow:
[  417.643790] CPU: 1 PID: 16886 Comm: bcache-register Tainted: G
   W  OE    4.15.5-amd64-preempt-sysrq-20171018 #2
[  417.643861] Hardware name: LENOVO 20ERCTO1WW/20ERCTO1WW, BIOS
N1DET41W (1.15 ) 12/31/2015
[  417.643870] RIP: 0010:bdevname+0x13/0x1e
[  417.643876] RSP: 0018:ffffa3aa9138fd38 EFLAGS: 00010282
[  417.643884] RAX: 0000000000000000 RBX: ffff8c8f2f2f8000 RCX: ffffd6701f8
c7edf
[  417.643890] RDX: ffffa3aa9138fd88 RSI: ffffa3aa9138fd88 RDI: 00000000000
00000
[  417.643895] RBP: ffffa3aa9138fde0 R08: ffffa3aa9138fae8 R09: 00000000000
1850e
[  417.643901] R10: ffff8c8eed34b271 R11: ffff8c8eed34b250 R12: 00000000000
00000
[  417.643906] R13: ffffd6701f78f940 R14: ffff8c8f38f80000 R15: ffff8c8ea7d
90000
[  417.643913] FS:  00007fde7e66f500(0000) GS:ffff8c8f61440000(0000) knlGS:
0000000000000000
[  417.643919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  417.643925] CR2: 0000000000000314 CR3: 00000007e6fa0001 CR4: 00000000003
606e0
[  417.643931] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000
00000
[  417.643938] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000
00400
[  417.643946] Call Trace:
[  417.643978]  register_bcache+0x1117/0x1270 [bcache]
[  417.643994]  ? slab_pre_alloc_hook+0x15/0x3c
[  417.644001]  ? slab_post_alloc_hook.isra.44+0xa/0x1a
[  417.644013]  ? kernfs_fop_write+0xf6/0x138
[  417.644020]  kernfs_fop_write+0xf6/0x138
[  417.644031]  __vfs_write+0x31/0xcc
[  417.644043]  ? current_kernel_time64+0x10/0x36
[  417.644115]  ? __audit_syscall_entry+0xbf/0xe3
[  417.644124]  vfs_write+0xa5/0xe2
[  417.644133]  SyS_write+0x5c/0x9f
[  417.644144]  do_syscall_64+0x72/0x81
[  417.644161]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  417.644169] RIP: 0033:0x7fde7e1c1974
[  417.644175] RSP: 002b:00007fff13009a38 EFLAGS: 00000246 ORIG_RAX: 0000000
000000001
[  417.644183] RAX: ffffffffffffffda RBX: 0000000001658280 RCX: 00007fde7e1c
1974
[  417.644188] RDX: 000000000000000a RSI: 0000000001658280 RDI: 000000000000
0001
[  417.644193] RBP: 000000000000000a R08: 0000000000000003 R09: 000000000000
0077
[  417.644198] R10: 000000000000089e R11: 0000000000000246 R12: 000000000000
0001
[  417.644203] R13: 000000000000000a R14: 7fffffffffffffff R15: 000000000000
0000
[  417.644213] Code: c7 c2 83 6f ee 98 be 20 00 00 00 48 89 df e8 6c 27 3b 0
0 48 89 d8 5b c3 0f 1f 44 00 00 48 8b 47 70 48 89 f2 48 8b bf 80 00 00 00 <8
b> b0 14 03 00 00 e9 73 ff ff ff 0f 1f 44 00 00 48 8b 47 40 39
[  417.644302] RIP: bdevname+0x13/0x1e RSP: ffffa3aa9138fd38
[  417.644306] CR2: 0000000000000314

When registering duplicate cache device in register_cache(), after failure
on calling register_cache_set(), bch_cache_release() will be called, then
bdev will be freed, so bdevname(bdev, name) caused kernel crash.

Since bch_cache_release() will free bdev, so in this patch we make sure
bdev being freed if register_cache() fail, and do not free bdev again in
register_bcache() when register_cache() fail.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reported-by: Marc MERLIN <marc@merlins.org>
Tested-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/bcache/super.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1203,7 +1203,7 @@ static void register_bdev(struct cache_s
 
 	return;
 err:
-	pr_notice("error opening %s: %s", bdevname(bdev, name), err);
+	pr_notice("error %s: %s", bdevname(bdev, name), err);
 	bcache_device_stop(&dc->disk);
 }
 
@@ -1861,6 +1861,8 @@ static int register_cache(struct cache_s
 	const char *err = NULL; /* must be set for any error case */
 	int ret = 0;
 
+	bdevname(bdev, name);
+
 	memcpy(&ca->sb, sb, sizeof(struct cache_sb));
 	ca->bdev = bdev;
 	ca->bdev->bd_holder = ca;
@@ -1871,11 +1873,12 @@ static int register_cache(struct cache_s
 	ca->sb_bio.bi_io_vec[0].bv_page = sb_page;
 	get_page(sb_page);
 
-	if (blk_queue_discard(bdev_get_queue(ca->bdev)))
+	if (blk_queue_discard(bdev_get_queue(bdev)))
 		ca->discard = CACHE_DISCARD(&ca->sb);
 
 	ret = cache_alloc(sb, ca);
 	if (ret != 0) {
+		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 		if (ret == -ENOMEM)
 			err = "cache_alloc(): -ENOMEM";
 		else
@@ -1898,14 +1901,14 @@ static int register_cache(struct cache_s
 		goto out;
 	}
 
-	pr_info("registered cache device %s", bdevname(bdev, name));
+	pr_info("registered cache device %s", name);
 
 out:
 	kobject_put(&ca->kobj);
 
 err:
 	if (err)
-		pr_notice("error opening %s: %s", bdevname(bdev, name), err);
+		pr_notice("error %s: %s", name, err);
 
 	return ret;
 }
@@ -1994,6 +1997,7 @@ static ssize_t register_bcache(struct ko
 	if (err)
 		goto err_close;
 
+	err = "failed to register device";
 	if (SB_IS_BDEV(sb)) {
 		struct cached_dev *dc = kzalloc(sizeof(*dc), GFP_KERNEL);
 		if (!dc)
@@ -2008,7 +2012,7 @@ static ssize_t register_bcache(struct ko
 			goto err_close;
 
 		if (register_cache(sb, sb_page, bdev, ca) != 0)
-			goto err_close;
+			goto err;
 	}
 out:
 	if (sb_page)
@@ -2021,7 +2025,7 @@ out:
 err_close:
 	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 err:
-	pr_info("error opening %s: %s", path, err);
+	pr_info("error %s: %s", path, err);
 	ret = -EINVAL;
 	goto out;
 }
