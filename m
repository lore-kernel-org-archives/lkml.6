Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17F6C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9685520C09
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9685520C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeHUJvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:51:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHUJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:50:59 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1AA6CBC1;
        Tue, 21 Aug 2018 06:32:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 06/29] net_sched: Fix missing res info when create new tc_index filter
Date:   Tue, 21 Aug 2018 08:20:59 +0200
Message-Id: <20180821055108.677270436@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055108.333930282@linuxfoundation.org>
References: <20180821055108.333930282@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 008369dcc5f7bfba526c98054f8525322acf0ea3 ]

Li Shuang reported the following warn:

[  733.484610] WARNING: CPU: 6 PID: 21123 at net/sched/sch_cbq.c:1418 cbq_destroy_class+0x5d/0x70 [sch_cbq]
[  733.495190] Modules linked in: sch_cbq cls_tcindex sch_dsmark rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat l
[  733.574155]  syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm igb ixgbe ahci libahci i2c_algo_bit libata i40e i2c_core dca mdio megaraid_sas dm_mirror dm_region_hash dm_log dm_mod
[  733.592500] CPU: 6 PID: 21123 Comm: tc Not tainted 4.18.0-rc8.latest+ #131
[  733.600169] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.1.5 04/11/2016
[  733.608518] RIP: 0010:cbq_destroy_class+0x5d/0x70 [sch_cbq]
[  733.614734] Code: e7 d9 d2 48 8b 7b 48 e8 61 05 da d2 48 8d bb f8 00 00 00 e8 75 ae d5 d2 48 39 eb 74 0a 48 89 df 5b 5d e9 16 6c 94 d2 5b 5d c3 <0f> 0b eb b6 0f 1f 44 00 00 66 2e 0f 1f 84
[  733.635798] RSP: 0018:ffffbfbb066bb9d8 EFLAGS: 00010202
[  733.641627] RAX: 0000000000000001 RBX: ffff9cdd17392800 RCX: 000000008010000f
[  733.649588] RDX: ffff9cdd1df547e0 RSI: ffff9cdd17392800 RDI: ffff9cdd0f84c800
[  733.657547] RBP: ffff9cdd0f84c800 R08: 0000000000000001 R09: 0000000000000000
[  733.665508] R10: ffff9cdd0f84d000 R11: 0000000000000001 R12: 0000000000000001
[  733.673469] R13: 0000000000000000 R14: 0000000000000001 R15: ffff9cdd17392200
[  733.681430] FS:  00007f911890a740(0000) GS:ffff9cdd1f8c0000(0000) knlGS:0000000000000000
[  733.690456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  733.696864] CR2: 0000000000b5544c CR3: 0000000859374002 CR4: 00000000001606e0
[  733.704826] Call Trace:
[  733.707554]  cbq_destroy+0xa1/0xd0 [sch_cbq]
[  733.712318]  qdisc_destroy+0x62/0x130
[  733.716401]  dsmark_destroy+0x2a/0x70 [sch_dsmark]
[  733.721745]  qdisc_destroy+0x62/0x130
[  733.725829]  qdisc_graft+0x3ba/0x470
[  733.729817]  tc_get_qdisc+0x2a6/0x2c0
[  733.733901]  ? cred_has_capability+0x7d/0x130
[  733.738761]  rtnetlink_rcv_msg+0x263/0x2d0
[  733.743330]  ? rtnl_calcit.isra.30+0x110/0x110
[  733.748287]  netlink_rcv_skb+0x4d/0x130
[  733.752576]  netlink_unicast+0x1a3/0x250
[  733.756949]  netlink_sendmsg+0x2ae/0x3a0
[  733.761324]  sock_sendmsg+0x36/0x40
[  733.765213]  ___sys_sendmsg+0x26f/0x2d0
[  733.769493]  ? handle_pte_fault+0x586/0xdf0
[  733.774158]  ? __handle_mm_fault+0x389/0x500
[  733.778919]  ? __sys_sendmsg+0x5e/0xa0
[  733.783099]  __sys_sendmsg+0x5e/0xa0
[  733.787087]  do_syscall_64+0x5b/0x180
[  733.791171]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  733.796805] RIP: 0033:0x7f9117f23f10
[  733.800791] Code: c3 48 8b 05 82 6f 2c 00 f7 db 64 89 18 48 83 cb ff eb dd 0f 1f 80 00 00 00 00 83 3d 8d d0 2c 00 00 75 10 b8 2e 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8
[  733.821873] RSP: 002b:00007ffe96818398 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  733.830319] RAX: ffffffffffffffda RBX: 000000005b71244c RCX: 00007f9117f23f10
[  733.838280] RDX: 0000000000000000 RSI: 00007ffe968183e0 RDI: 0000000000000003
[  733.846241] RBP: 00007ffe968183e0 R08: 000000000000ffff R09: 0000000000000003
[  733.854202] R10: 00007ffe96817e20 R11: 0000000000000246 R12: 0000000000000000
[  733.862161] R13: 0000000000662ee0 R14: 0000000000000000 R15: 0000000000000000
[  733.870121] ---[ end trace 28edd4aad712ddca ]---

This is because we didn't update f->result.res when create new filter. Then in
tcindex_delete() -> tcf_unbind_filter(), we will failed to find out the res
and unbind filter, which will trigger the WARN_ON() in cbq_destroy_class().

Fix it by updating f->result.res when create new filter.

Fixes: 6e0565697a106 ("net_sched: fix another crash in cls_tcindex")
Reported-by: Li Shuang <shuali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_tcindex.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sched/cls_tcindex.c
+++ b/net/sched/cls_tcindex.c
@@ -482,6 +482,7 @@ tcindex_set_parms(struct net *net, struc
 		struct tcindex_filter *nfp;
 		struct tcindex_filter __rcu **fp;
 
+		f->result.res = r->res;
 		tcf_exts_change(&f->result.exts, &r->exts);
 
 		fp = cp->h + (handle % cp->hash);


