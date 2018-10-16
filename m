Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21065C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27622089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PelBZHsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27622089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeJQBDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbeJQBC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:02:59 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A9C2147C;
        Tue, 16 Oct 2018 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709897;
        bh=nV/0umfchfTyUGPm/UNSW6fq2y4+D9LfzOTX1VvgtVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PelBZHsAgUyuz+wVcodT/RYqm3ddIPdWhTMBJ3SAeG5IrL8IgBBSUBgwP6ea8tB5S
         OdJV1dM5tzzq3GJlEyzNh+x8yV+KLHrZJVR/VcK0MOiDyiN/xzcMEvJ77tfwlh6Bta
         uaJQOO3NsIXLpkISSbCf/dnlURIQnqVPzPWKFcs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 032/135] tun: napi flags belong to tfile
Date:   Tue, 16 Oct 2018 19:04:22 +0200
Message-Id: <20181016170517.247606034@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit af3fb24eecb2c59246e03c99386037fd5ad84ffd ]

Since tun->flags might be shared by multiple tfile structures,
it is better to make sure tun_get_user() is using the flags
for the current tfile.

Presence of the READ_ONCE() in tun_napi_frags_enabled() gave a hint
of what could happen, but we need something stronger to please
syzbot.

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 13647 Comm: syz-executor5 Not tainted 4.19.0-rc5+ #59
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:dev_gro_receive+0x132/0x2720 net/core/dev.c:5427
Code: 48 c1 ea 03 80 3c 02 00 0f 85 6e 20 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 6e 10 49 8d bd d0 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 59 20 00 00 4d 8b a5 d0 00 00 00 31 ff 41 81 e4
RSP: 0018:ffff8801c400f410 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8618d325
RDX: 000000000000001a RSI: ffffffff86189f97 RDI: 00000000000000d0
RBP: ffff8801c400f608 R08: ffff8801c8fb4300 R09: 0000000000000000
R10: ffffed0038801ed7 R11: 0000000000000003 R12: ffff8801d327d358
R13: 0000000000000000 R14: ffff8801c16dd8c0 R15: 0000000000000004
FS:  00007fe003615700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe1f3c43db8 CR3: 00000001bebb2000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 napi_gro_frags+0x3f4/0xc90 net/core/dev.c:5715
 tun_get_user+0x31d5/0x42a0 drivers/net/tun.c:1922
 tun_chr_write_iter+0xb9/0x154 drivers/net/tun.c:1967
 call_write_iter include/linux/fs.h:1808 [inline]
 new_sync_write fs/read_write.c:474 [inline]
 __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
 vfs_write+0x1fc/0x560 fs/read_write.c:549
 ksys_write+0x101/0x260 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:607
 do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe003614c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000000000012 RSI: 0000000020000000 RDI: 000000000000000a
RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe0036156d4
R13: 00000000004c5574 R14: 00000000004d8e98 R15: 00000000ffffffff
Modules linked in:

RIP: 0010:dev_gro_receive+0x132/0x2720 net/core/dev.c:5427
Code: 48 c1 ea 03 80 3c 02 00 0f 85 6e 20 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 6e 10 49 8d bd d0 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 59 20 00 00 4d 8b a5 d0 00 00 00 31 ff 41 81 e4
RSP: 0018:ffff8801c400f410 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8618d325
RDX: 000000000000001a RSI: ffffffff86189f97 RDI: 00000000000000d0
RBP: ffff8801c400f608 R08: ffff8801c8fb4300 R09: 0000000000000000
R10: ffffed0038801ed7 R11: 0000000000000003 R12: ffff8801d327d358
R13: 0000000000000000 R14: ffff8801c16dd8c0 R15: 0000000000000004
FS:  00007fe003615700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe1f3c43db8 CR3: 00000001bebb2000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -181,6 +181,7 @@ struct tun_file {
 	};
 	struct napi_struct napi;
 	bool napi_enabled;
+	bool napi_frags_enabled;
 	struct mutex napi_mutex;	/* Protects access to the above napi */
 	struct list_head next;
 	struct tun_struct *detached;
@@ -312,9 +313,10 @@ static int tun_napi_poll(struct napi_str
 }
 
 static void tun_napi_init(struct tun_struct *tun, struct tun_file *tfile,
-			  bool napi_en)
+			  bool napi_en, bool napi_frags)
 {
 	tfile->napi_enabled = napi_en;
+	tfile->napi_frags_enabled = napi_en && napi_frags;
 	if (napi_en) {
 		netif_napi_add(tun->dev, &tfile->napi, tun_napi_poll,
 			       NAPI_POLL_WEIGHT);
@@ -334,9 +336,9 @@ static void tun_napi_del(struct tun_file
 		netif_napi_del(&tfile->napi);
 }
 
-static bool tun_napi_frags_enabled(const struct tun_struct *tun)
+static bool tun_napi_frags_enabled(const struct tun_file *tfile)
 {
-	return READ_ONCE(tun->flags) & IFF_NAPI_FRAGS;
+	return tfile->napi_frags_enabled;
 }
 
 #ifdef CONFIG_TUN_VNET_CROSS_LE
@@ -790,7 +792,7 @@ static void tun_detach_all(struct net_de
 }
 
 static int tun_attach(struct tun_struct *tun, struct file *file,
-		      bool skip_filter, bool napi)
+		      bool skip_filter, bool napi, bool napi_frags)
 {
 	struct tun_file *tfile = file->private_data;
 	struct net_device *dev = tun->dev;
@@ -863,7 +865,7 @@ static int tun_attach(struct tun_struct
 		tun_enable_queue(tfile);
 	} else {
 		sock_hold(&tfile->sk);
-		tun_napi_init(tun, tfile, napi);
+		tun_napi_init(tun, tfile, napi, napi_frags);
 	}
 
 	tun_set_real_num_queues(tun);
@@ -1173,13 +1175,11 @@ static void tun_poll_controller(struct n
 		struct tun_file *tfile;
 		int i;
 
-		if (tun_napi_frags_enabled(tun))
-			return;
-
 		rcu_read_lock();
 		for (i = 0; i < tun->numqueues; i++) {
 			tfile = rcu_dereference(tun->tfiles[i]);
-			if (tfile->napi_enabled)
+			if (!tun_napi_frags_enabled(tfile) &&
+			    tfile->napi_enabled)
 				napi_schedule(&tfile->napi);
 		}
 		rcu_read_unlock();
@@ -1750,7 +1750,7 @@ static ssize_t tun_get_user(struct tun_s
 	int err;
 	u32 rxhash = 0;
 	int skb_xdp = 1;
-	bool frags = tun_napi_frags_enabled(tun);
+	bool frags = tun_napi_frags_enabled(tfile);
 
 	if (!(tun->dev->flags & IFF_UP))
 		return -EIO;
@@ -2575,7 +2575,8 @@ static int tun_set_iff(struct net *net,
 			return err;
 
 		err = tun_attach(tun, file, ifr->ifr_flags & IFF_NOFILTER,
-				 ifr->ifr_flags & IFF_NAPI);
+				 ifr->ifr_flags & IFF_NAPI,
+				 ifr->ifr_flags & IFF_NAPI_FRAGS);
 		if (err < 0)
 			return err;
 
@@ -2673,7 +2674,8 @@ static int tun_set_iff(struct net *net,
 			      (ifr->ifr_flags & TUN_FEATURES);
 
 		INIT_LIST_HEAD(&tun->disabled);
-		err = tun_attach(tun, file, false, ifr->ifr_flags & IFF_NAPI);
+		err = tun_attach(tun, file, false, ifr->ifr_flags & IFF_NAPI,
+				 ifr->ifr_flags & IFF_NAPI_FRAGS);
 		if (err < 0)
 			goto err_free_flow;
 
@@ -2822,7 +2824,8 @@ static int tun_set_queue(struct file *fi
 		ret = security_tun_dev_attach_queue(tun->security);
 		if (ret < 0)
 			goto unlock;
-		ret = tun_attach(tun, file, false, tun->flags & IFF_NAPI);
+		ret = tun_attach(tun, file, false, tun->flags & IFF_NAPI,
+				 tun->flags & IFF_NAPI_FRAGS);
 	} else if (ifr->ifr_flags & IFF_DETACH_QUEUE) {
 		tun = rtnl_dereference(tfile->tun);
 		if (!tun || !(tun->flags & IFF_MULTI_QUEUE) || tfile->detached)


