Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD56C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEDC218A1
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864467;
	bh=DLK89QLYMvIO4g81JtYgjwk7CYxJrnXslCt5m1IKPa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r99W9QMrNqdjOj5nd4GrvbmkvTMKzjxkUFPWMulXw7ONSRDyFrZSc0R1b4Asn9RqP
	 qSYZ+oCFXVI7oaBf6KZVl0aGT3qPKjre6f0aq1W55ggGc5zKVzPIvXazHdLbGnwVVW
	 VMBu3k3+3j0uEVvhyWa1RPD17nTZYpnR+PlaJ45Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfAGMe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:34:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfAGMeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:34:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 575E02177B;
        Mon,  7 Jan 2019 12:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864461;
        bh=DLK89QLYMvIO4g81JtYgjwk7CYxJrnXslCt5m1IKPa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5RmPwH4Mx0dBR4DdYfb14dC6VmWd1g60t2zuhzuHEbtq13mSjsQA0yX72vbD/CwT
         YvoCQvnARZwCTeBcV6g6PS26PAA0cXFFQ1AX5CkZMAZcCZfNXeOdxMCOfAcOHvKTb+
         UvxkHavEar1WYa5r50SQlRT1wtuONqzGMHfi/pWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 011/145] net/hamradio/6pack: use mod_timer() to rearm timers
Date:   Mon,  7 Jan 2019 13:30:48 +0100
Message-Id: <20190107104438.783053455@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 202700e30740c6568b5a6943662f3829566dd533 ]

Using del_timer() + add_timer() is generally unsafe on SMP,
as noticed by syzbot. Use mod_timer() instead.

kernel BUG at kernel/time/timer.c:1136!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 1026 Comm: kworker/u4:4 Not tainted 4.20.0+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:add_timer kernel/time/timer.c:1136 [inline]
RIP: 0010:add_timer+0xa81/0x1470 kernel/time/timer.c:1134
Code: 4d 89 7d 40 48 c7 85 70 fe ff ff 00 00 00 00 c7 85 7c fe ff ff ff ff ff ff 48 89 85 90 fe ff ff e9 e6 f7 ff ff e8 cf 42 12 00 <0f> 0b e8 c8 42 12 00 0f 0b e8 c1 42 12 00 4c 89 bd 60 fe ff ff e9
RSP: 0018:ffff8880a7fdf5a8 EFLAGS: 00010293
RAX: ffff8880a7846340 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816f3ee1 RDI: ffff88808a514ff8
RBP: ffff8880a7fdf760 R08: 0000000000000007 R09: ffff8880a7846c58
R10: ffff8880a7846340 R11: 0000000000000000 R12: ffff88808a514ff8
R13: ffff88808a514ff8 R14: ffff88808a514dc0 R15: 0000000000000030
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000061c500 CR3: 00000000994d9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 decode_prio_command drivers/net/hamradio/6pack.c:903 [inline]
 sixpack_decode drivers/net/hamradio/6pack.c:971 [inline]
 sixpack_receive_buf drivers/net/hamradio/6pack.c:457 [inline]
 sixpack_receive_buf+0xf9c/0x1470 drivers/net/hamradio/6pack.c:434
 tty_ldisc_receive_buf+0x164/0x1c0 drivers/tty/tty_buffer.c:465
 tty_port_default_receive_buf+0x114/0x190 drivers/tty/tty_port.c:38
 receive_buf drivers/tty/tty_buffer.c:481 [inline]
 flush_to_ldisc+0x3b2/0x590 drivers/tty/tty_buffer.c:533
 process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
 worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
 kthread+0x357/0x430 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hamradio/6pack.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -523,10 +523,7 @@ static void resync_tnc(struct timer_list
 
 
 	/* Start resync timer again -- the TNC might be still absent */
-
-	del_timer(&sp->resync_t);
-	sp->resync_t.expires	= jiffies + SIXP_RESYNC_TIMEOUT;
-	add_timer(&sp->resync_t);
+	mod_timer(&sp->resync_t, jiffies + SIXP_RESYNC_TIMEOUT);
 }
 
 static inline int tnc_init(struct sixpack *sp)
@@ -537,9 +534,7 @@ static inline int tnc_init(struct sixpac
 
 	sp->tty->ops->write(sp->tty, &inbyte, 1);
 
-	del_timer(&sp->resync_t);
-	sp->resync_t.expires = jiffies + SIXP_RESYNC_TIMEOUT;
-	add_timer(&sp->resync_t);
+	mod_timer(&sp->resync_t, jiffies + SIXP_RESYNC_TIMEOUT);
 
 	return 0;
 }
@@ -897,11 +892,8 @@ static void decode_prio_command(struct s
         /* if the state byte has been received, the TNC is present,
            so the resync timer can be reset. */
 
-	if (sp->tnc_state == TNC_IN_SYNC) {
-		del_timer(&sp->resync_t);
-		sp->resync_t.expires	= jiffies + SIXP_INIT_RESYNC_TIMEOUT;
-		add_timer(&sp->resync_t);
-	}
+	if (sp->tnc_state == TNC_IN_SYNC)
+		mod_timer(&sp->resync_t, jiffies + SIXP_INIT_RESYNC_TIMEOUT);
 
 	sp->status1 = cmd & SIXP_PRIO_DATA_MASK;
 }


