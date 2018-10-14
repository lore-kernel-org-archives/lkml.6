Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94839C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693B120645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693B120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbeJNX3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:29:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37327 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728128AbeJNX3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:29:49 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM6-0004cf-9R; Sun, 14 Oct 2018 16:30:58 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLR-0000J3-KN; Sun, 14 Oct 2018 16:30:17 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "syzbot" <syzkaller@googlegroups.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.279267313@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 122/366] net: fix uninit-value in __hw_addr_add_ex()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 77d36398d99f2565c0a8d43a86fd520a82e64bb8 upstream.

syzbot complained :

BUG: KMSAN: uninit-value in memcmp+0x119/0x180 lib/string.c:861
CPU: 0 PID: 3 Comm: kworker/0:0 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 memcmp+0x119/0x180 lib/string.c:861
 __hw_addr_add_ex net/core/dev_addr_lists.c:60 [inline]
 __dev_mc_add+0x1c2/0x8e0 net/core/dev_addr_lists.c:670
 dev_mc_add+0x6d/0x80 net/core/dev_addr_lists.c:687
 igmp6_group_added+0x2db/0xa00 net/ipv6/mcast.c:662
 ipv6_dev_mc_inc+0xe9e/0x1130 net/ipv6/mcast.c:914
 addrconf_join_solict net/ipv6/addrconf.c:2078 [inline]
 addrconf_dad_begin net/ipv6/addrconf.c:3828 [inline]
 addrconf_dad_work+0x427/0x2150 net/ipv6/addrconf.c:3954
 process_one_work+0x12c6/0x1f60 kernel/workqueue.c:2113
 worker_thread+0x113c/0x24f0 kernel/workqueue.c:2247
 kthread+0x539/0x720 kernel/kthread.c:239

Fixes: f001fde5eadd ("net: introduce a list of device addresses dev_addr_list (v6)")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/core/dev_addr_lists.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -57,8 +57,8 @@ static int __hw_addr_add_ex(struct netde
 		return -EINVAL;
 
 	list_for_each_entry(ha, &list->list, list) {
-		if (!memcmp(ha->addr, addr, addr_len) &&
-		    ha->type == addr_type) {
+		if (ha->type == addr_type &&
+		    !memcmp(ha->addr, addr, addr_len)) {
 			if (global) {
 				/* check if addr is already used as global */
 				if (ha->global_use)

