Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445DDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FCE23EF6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FCE23EF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932962AbeGFO2o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:28:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37654 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932429AbeGFO2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:28:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC587ED1;
        Fri,  6 Jul 2018 07:28:42 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7AAD83F2EA;
        Fri,  6 Jul 2018 07:28:41 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
Subject: [PATCH] ipv4: fib: avoid NULL dereference
Date:   Fri,  6 Jul 2018 15:28:36 +0100
Message-Id: <20180706142836.1822-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tnode_free() we iterate over a callback_head list with a while loop.
At the start of the loop body we generate the next head pointer, and at
the end of the loop body we generate the tn pointer for the next
iteration of the loop by using container_of() on the head pointer to
find the tnode, and deriving the kv pointer from this.

In the final iteration of the loop, this means that we derive a pointer
from NULL, which is undefined behaviour, which UBSAN detects:

================================================================================
UBSAN: Undefined behaviour in net/ipv4/fib_trie.c:504:6
member access within null pointer of type 'struct tnode'
CPU: 1 PID: 94 Comm: ip Not tainted 4.18.0-rc3+ #23
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x458
 show_stack+0x20/0x30
 dump_stack+0x18c/0x248
 ubsan_epilogue+0x18/0x94
 handle_null_ptr_deref+0x1d4/0x228
 __ubsan_handle_type_mismatch_v1+0x188/0x1e0
 tnode_free+0x16c/0x1d0
 replace+0x1e0/0x5d0
 resize+0xd98/0x2008
 fib_insert_alias+0xb38/0x10c8
 fib_table_insert+0x7d0/0x1108
 fib_magic+0x530/0x780
 fib_add_ifaddr+0x378/0x468
 fib_netdev_event+0x2ac/0x3e8
 notifier_call_chain+0x190/0x2f8
 raw_notifier_call_chain+0x3c/0x68
 call_netdevice_notifiers_info+0x3c/0xc0
 __dev_notify_flags+0x1f8/0x398
 dev_change_flags+0xe8/0x150
 do_setlink+0x924/0x4050
 rtnl_newlink+0x8c4/0x14b0
 rtnetlink_rcv_msg+0x408/0xef8
 netlink_rcv_skb+0x144/0x390
 rtnetlink_rcv+0x24/0x30
 netlink_unicast+0x4e8/0x740
 netlink_sendmsg+0x6d8/0xe78
 sock_sendmsg+0x90/0x168
 ___sys_sendmsg+0x680/0x9b0
 __sys_sendmsg+0xf0/0x230
 sys_sendmsg+0x34/0x48
 el0_svc_naked+0x30/0x34
================================================================================

We can avoid the undefined behaviour by generating tn for the current
iteration of the loop before we advance head, so let's do that.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: David S. Miller <davem@davemloft.net>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org
---
 net/ipv4/fib_trie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 5bc0c89e81e4..8d98c8162554 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -497,11 +497,11 @@ static void tnode_free(struct key_vector *tn)
 	struct callback_head *head = &tn_info(tn)->rcu;
 
 	while (head) {
+		tn = container_of(head, struct tnode, rcu)->kv;
+
 		head = head->next;
 		tnode_free_size += TNODE_SIZE(1ul << tn->bits);
 		node_free(tn);
-
-		tn = container_of(head, struct tnode, rcu)->kv;
 	}
 
 	if (tnode_free_size >= PAGE_SIZE * sync_pages) {
-- 
2.11.0

