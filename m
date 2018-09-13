Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEA0C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECD320854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECD320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbeIMSn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:43:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58794 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbeIMSn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:43:28 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8426BCF3;
        Thu, 13 Sep 2018 13:33:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 52/60] sch_htb: fix crash on init failure
Date:   Thu, 13 Sep 2018 15:30:59 +0200
Message-Id: <20180913131747.900298099@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

commit 88c2ace69dbef696edba77712882af03879abc9c upstream.

The commit below added a call to the ->destroy() callback for all qdiscs
which failed in their ->init(), but some were not prepared for such
change and can't handle partially initialized qdisc. HTB is one of them
and if any error occurs before the qdisc watchdog timer and qdisc work are
initialized then we can hit either a null ptr deref (timer->base) when
canceling in ->destroy or lockdep error info about trying to register
a non-static key and a stack dump. So to fix these two move the watchdog
timer and workqueue init before anything that can err out.
To reproduce userspace needs to send broken htb qdisc create request,
tested with a modified tc (q_htb.c).

Trace log:
[ 2710.897602] BUG: unable to handle kernel NULL pointer dereference at (null)
[ 2710.897977] IP: hrtimer_active+0x17/0x8a
[ 2710.898174] PGD 58fab067
[ 2710.898175] P4D 58fab067
[ 2710.898353] PUD 586c0067
[ 2710.898531] PMD 0
[ 2710.898710]
[ 2710.899045] Oops: 0000 [#1] SMP
[ 2710.899232] Modules linked in:
[ 2710.899419] CPU: 1 PID: 950 Comm: tc Not tainted 4.13.0-rc6+ #54
[ 2710.899646] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140531_083030-gandalf 04/01/2014
[ 2710.900035] task: ffff880059ed2700 task.stack: ffff88005ad4c000
[ 2710.900262] RIP: 0010:hrtimer_active+0x17/0x8a
[ 2710.900467] RSP: 0018:ffff88005ad4f960 EFLAGS: 00010246
[ 2710.900684] RAX: 0000000000000000 RBX: ffff88003701e298 RCX: 0000000000000000
[ 2710.900933] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88003701e298
[ 2710.901177] RBP: ffff88005ad4f980 R08: 0000000000000001 R09: 0000000000000001
[ 2710.901419] R10: ffff88005ad4f800 R11: 0000000000000400 R12: 0000000000000000
[ 2710.901663] R13: ffff88003701e298 R14: ffffffff822a4540 R15: ffff88005ad4fac0
[ 2710.901907] FS:  00007f2f5e90f740(0000) GS:ffff88005d880000(0000) knlGS:0000000000000000
[ 2710.902277] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2710.902500] CR2: 0000000000000000 CR3: 0000000058ca3000 CR4: 00000000000406e0
[ 2710.902744] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2710.902977] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2710.903180] Call Trace:
[ 2710.903332]  hrtimer_try_to_cancel+0x1a/0x93
[ 2710.903504]  hrtimer_cancel+0x15/0x20
[ 2710.903667]  qdisc_watchdog_cancel+0x12/0x14
[ 2710.903866]  htb_destroy+0x2e/0xf7
[ 2710.904097]  qdisc_create+0x377/0x3fd
[ 2710.904330]  tc_modify_qdisc+0x4d2/0x4fd
[ 2710.904511]  rtnetlink_rcv_msg+0x188/0x197
[ 2710.904682]  ? rcu_read_unlock+0x3e/0x5f
[ 2710.904849]  ? rtnl_newlink+0x729/0x729
[ 2710.905017]  netlink_rcv_skb+0x6c/0xce
[ 2710.905183]  rtnetlink_rcv+0x23/0x2a
[ 2710.905345]  netlink_unicast+0x103/0x181
[ 2710.905511]  netlink_sendmsg+0x326/0x337
[ 2710.905679]  sock_sendmsg_nosec+0x14/0x3f
[ 2710.905847]  sock_sendmsg+0x29/0x2e
[ 2710.906010]  ___sys_sendmsg+0x209/0x28b
[ 2710.906176]  ? do_raw_spin_unlock+0xcd/0xf8
[ 2710.906346]  ? _raw_spin_unlock+0x27/0x31
[ 2710.906514]  ? __handle_mm_fault+0x651/0xdb1
[ 2710.906685]  ? check_chain_key+0xb0/0xfd
[ 2710.906855]  __sys_sendmsg+0x45/0x63
[ 2710.907018]  ? __sys_sendmsg+0x45/0x63
[ 2710.907185]  SyS_sendmsg+0x19/0x1b
[ 2710.907344]  entry_SYSCALL_64_fastpath+0x23/0xc2

Note that probably this bug goes further back because the default qdisc
handling always calls ->destroy on init failure too.

Fixes: 87b60cfacf9f ("net_sched: fix error recovery at qdisc creation")
Fixes: 0fbbeb1ba43b ("[PKT_SCHED]: Fix missing qdisc_destroy() in qdisc_create_dflt()")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[AmitP: Rebased for linux-4.4.y]
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_htb.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1025,6 +1025,9 @@ static int htb_init(struct Qdisc *sch, s
 	int err;
 	int i;
 
+	qdisc_watchdog_init(&q->watchdog, sch);
+	INIT_WORK(&q->work, htb_work_func);
+
 	if (!opt)
 		return -EINVAL;
 
@@ -1045,8 +1048,6 @@ static int htb_init(struct Qdisc *sch, s
 	for (i = 0; i < TC_HTB_NUMPRIO; i++)
 		INIT_LIST_HEAD(q->drops + i);
 
-	qdisc_watchdog_init(&q->watchdog, sch);
-	INIT_WORK(&q->work, htb_work_func);
 	__skb_queue_head_init(&q->direct_queue);
 
 	if (tb[TCA_HTB_DIRECT_QLEN])


