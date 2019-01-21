Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28EDC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8330F2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078627;
	bh=r1FLOFQhRI/aygtqGHDUNq3zvQXzf5uKQwwA8LDAFrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BPXw6YcflbS2yEV7XLTmSrGqsMGd4usIYmWMxhxDfleEgSEcnY7jsZaf9DReSq15m
	 uMdYfgb9QiTubSuKoafHz23QhoixmmGfipPuKx7FCgcnJHiVW8nlBNJwrKtsY43922
	 /w0q6xHU4PWYV6QrsCIopiAqT8m/iJ3lR97q8kek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfAUNu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:50:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730502AbfAUNuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A3592063F;
        Mon, 21 Jan 2019 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078616;
        bh=r1FLOFQhRI/aygtqGHDUNq3zvQXzf5uKQwwA8LDAFrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3GtTN9O1nvkFjGRK50RvH//9fOt0xgQb7+nEb6knURN4aiFMk082fkQ9wRuOU/Jm
         jwFYnN4Vh5ynM1+SDOwr7MAl2kxKTnBu3kvW9lAEqShHDQxXBneO4XhWylSUWm7XoQ
         II/v56P4mKHo4ZflwpvafC3zjX6MuBoGPPj+/aA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+8951a3065ee7fd6d6e23@syzkaller.appspotmail.com,
        syzbot+75e6e042c5bbf691fc82@syzkaller.appspotmail.com,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 087/111] tipc: fix uninit-value in in tipc_conn_rcv_sub
Date:   Mon, 21 Jan 2019 14:43:21 +0100
Message-Id: <20190121122505.604781574@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

From: Ying Xue <ying.xue@windriver.com>

commit a88289f4ddee4165d5f796bd99e09eec3133c16b upstream.

syzbot reported:

BUG: KMSAN: uninit-value in tipc_conn_rcv_sub+0x184/0x950 net/tipc/topsrv.c:373
CPU: 0 PID: 66 Comm: kworker/u4:4 Not tainted 4.17.0-rc3+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: tipc_rcv tipc_conn_recv_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
 tipc_conn_rcv_sub+0x184/0x950 net/tipc/topsrv.c:373
 tipc_conn_rcv_from_sock net/tipc/topsrv.c:409 [inline]
 tipc_conn_recv_work+0x3cd/0x560 net/tipc/topsrv.c:424
 process_one_work+0x12c6/0x1f60 kernel/workqueue.c:2145
 worker_thread+0x113c/0x24f0 kernel/workqueue.c:2279
 kthread+0x539/0x720 kernel/kthread.c:239
 ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:412

Local variable description: ----s.i@tipc_conn_recv_work
Variable was created at:
 tipc_conn_recv_work+0x65/0x560 net/tipc/topsrv.c:419
 process_one_work+0x12c6/0x1f60 kernel/workqueue.c:2145

In tipc_conn_rcv_from_sock(), it always supposes the length of message
received from sock_recvmsg() is not smaller than the size of struct
tipc_subscr. However, this assumption is false. Especially when the
length of received message is shorter than struct tipc_subscr size,
we will end up touching uninitialized fields in tipc_conn_rcv_sub().

Reported-by: syzbot+8951a3065ee7fd6d6e23@syzkaller.appspotmail.com
Reported-by: syzbot+75e6e042c5bbf691fc82@syzkaller.appspotmail.com
Signed-off-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/topsrv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -398,7 +398,7 @@ static int tipc_conn_rcv_from_sock(struc
 	ret = sock_recvmsg(con->sock, &msg, MSG_DONTWAIT);
 	if (ret == -EWOULDBLOCK)
 		return -EWOULDBLOCK;
-	if (ret > 0) {
+	if (ret == sizeof(s)) {
 		read_lock_bh(&sk->sk_callback_lock);
 		ret = tipc_conn_rcv_sub(srv, con, &s);
 		read_unlock_bh(&sk->sk_callback_lock);


