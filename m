Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B8FC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A8920854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A8920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbeIMSut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:50:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbeIMSus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:50:48 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 029BACF3;
        Thu, 13 Sep 2018 13:41:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 71/78] sch_netem: avoid null pointer deref on init failure
Date:   Thu, 13 Sep 2018 15:31:58 +0200
Message-Id: <20180913131812.799083427@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

commit 634576a1844dba15bc5e6fc61d72f37e13a21615 upstream.

netem can fail in ->init due to missing options (either not supplied by
user-space or used as a default qdisc) causing a timer->base null
pointer deref in its ->destroy() and ->reset() callbacks.

Reproduce:
$ sysctl net.core.default_qdisc=netem
$ ip l set ethX up

Crash log:
[ 1814.846943] BUG: unable to handle kernel NULL pointer dereference at (null)
[ 1814.847181] IP: hrtimer_active+0x17/0x8a
[ 1814.847270] PGD 59c34067
[ 1814.847271] P4D 59c34067
[ 1814.847337] PUD 37374067
[ 1814.847403] PMD 0
[ 1814.847468]
[ 1814.847582] Oops: 0000 [#1] SMP
[ 1814.847655] Modules linked in: sch_netem(O) sch_fq_codel(O)
[ 1814.847761] CPU: 3 PID: 1573 Comm: ip Tainted: G           O 4.13.0-rc6+ #62
[ 1814.847884] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140531_083030-gandalf 04/01/2014
[ 1814.848043] task: ffff88003723a700 task.stack: ffff88005adc8000
[ 1814.848235] RIP: 0010:hrtimer_active+0x17/0x8a
[ 1814.848407] RSP: 0018:ffff88005adcb590 EFLAGS: 00010246
[ 1814.848590] RAX: 0000000000000000 RBX: ffff880058e359d8 RCX: 0000000000000000
[ 1814.848793] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff880058e359d8
[ 1814.848998] RBP: ffff88005adcb5b0 R08: 00000000014080c0 R09: 00000000ffffffff
[ 1814.849204] R10: ffff88005adcb660 R11: 0000000000000020 R12: 0000000000000000
[ 1814.849410] R13: ffff880058e359d8 R14: 00000000ffffffff R15: 0000000000000001
[ 1814.849616] FS:  00007f733bbca740(0000) GS:ffff88005d980000(0000) knlGS:0000000000000000
[ 1814.849919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1814.850107] CR2: 0000000000000000 CR3: 0000000059f0d000 CR4: 00000000000406e0
[ 1814.850313] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1814.850518] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1814.850723] Call Trace:
[ 1814.850875]  hrtimer_try_to_cancel+0x1a/0x93
[ 1814.851047]  hrtimer_cancel+0x15/0x20
[ 1814.851211]  qdisc_watchdog_cancel+0x12/0x14
[ 1814.851383]  netem_reset+0xe6/0xed [sch_netem]
[ 1814.851561]  qdisc_destroy+0x8b/0xe5
[ 1814.851723]  qdisc_create_dflt+0x86/0x94
[ 1814.851890]  ? dev_activate+0x129/0x129
[ 1814.852057]  attach_one_default_qdisc+0x36/0x63
[ 1814.852232]  netdev_for_each_tx_queue+0x3d/0x48
[ 1814.852406]  dev_activate+0x4b/0x129
[ 1814.852569]  __dev_open+0xe7/0x104
[ 1814.852730]  __dev_change_flags+0xc6/0x15c
[ 1814.852899]  dev_change_flags+0x25/0x59
[ 1814.853064]  do_setlink+0x30c/0xb3f
[ 1814.853228]  ? check_chain_key+0xb0/0xfd
[ 1814.853396]  ? check_chain_key+0xb0/0xfd
[ 1814.853565]  rtnl_newlink+0x3a4/0x729
[ 1814.853728]  ? rtnl_newlink+0x117/0x729
[ 1814.853905]  ? ns_capable_common+0xd/0xb1
[ 1814.854072]  ? ns_capable+0x13/0x15
[ 1814.854234]  rtnetlink_rcv_msg+0x188/0x197
[ 1814.854404]  ? rcu_read_unlock+0x3e/0x5f
[ 1814.854572]  ? rtnl_newlink+0x729/0x729
[ 1814.854737]  netlink_rcv_skb+0x6c/0xce
[ 1814.854902]  rtnetlink_rcv+0x23/0x2a
[ 1814.855064]  netlink_unicast+0x103/0x181
[ 1814.855230]  netlink_sendmsg+0x326/0x337
[ 1814.855398]  sock_sendmsg_nosec+0x14/0x3f
[ 1814.855584]  sock_sendmsg+0x29/0x2e
[ 1814.855747]  ___sys_sendmsg+0x209/0x28b
[ 1814.855912]  ? do_raw_spin_unlock+0xcd/0xf8
[ 1814.856082]  ? _raw_spin_unlock+0x27/0x31
[ 1814.856251]  ? __handle_mm_fault+0x651/0xdb1
[ 1814.856421]  ? check_chain_key+0xb0/0xfd
[ 1814.856592]  __sys_sendmsg+0x45/0x63
[ 1814.856755]  ? __sys_sendmsg+0x45/0x63
[ 1814.856923]  SyS_sendmsg+0x19/0x1b
[ 1814.857083]  entry_SYSCALL_64_fastpath+0x23/0xc2
[ 1814.857256] RIP: 0033:0x7f733b2dd690
[ 1814.857419] RSP: 002b:00007ffe1d3387d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 1814.858238] RAX: ffffffffffffffda RBX: ffffffff810d278c RCX: 00007f733b2dd690
[ 1814.858445] RDX: 0000000000000000 RSI: 00007ffe1d338820 RDI: 0000000000000003
[ 1814.858651] RBP: ffff88005adcbf98 R08: 0000000000000001 R09: 0000000000000003
[ 1814.858856] R10: 00007ffe1d3385a0 R11: 0000000000000246 R12: 0000000000000002
[ 1814.859060] R13: 000000000066f1a0 R14: 00007ffe1d3408d0 R15: 0000000000000000
[ 1814.859267]  ? trace_hardirqs_off_caller+0xa7/0xcf
[ 1814.859446] Code: 10 55 48 89 c7 48 89 e5 e8 45 a1 fb ff 31 c0 5d c3
31 c0 c3 66 66 66 66 90 55 48 89 e5 41 56 41 55 41 54 53 49 89 fd 49 8b
45 30 <4c> 8b 20 41 8b 5c 24 38 31 c9 31 d2 48 c7 c7 50 8e 1d 82 41 89
[ 1814.860022] RIP: hrtimer_active+0x17/0x8a RSP: ffff88005adcb590
[ 1814.860214] CR2: 0000000000000000

Fixes: 87b60cfacf9f ("net_sched: fix error recovery at qdisc creation")
Fixes: 0fbbeb1ba43b ("[PKT_SCHED]: Fix missing qdisc_destroy() in qdisc_create_dflt()")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sched/sch_netem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -937,11 +937,11 @@ static int netem_init(struct Qdisc *sch,
 	struct netem_sched_data *q = qdisc_priv(sch);
 	int ret;
 
+	qdisc_watchdog_init(&q->watchdog, sch);
+
 	if (!opt)
 		return -EINVAL;
 
-	qdisc_watchdog_init(&q->watchdog, sch);
-
 	q->loss_model = CLG_RANDOM;
 	ret = netem_change(sch, opt);
 	if (ret)


