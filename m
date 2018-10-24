Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07992ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D137C206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D137C206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeJYCBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:01:42 -0400
Received: from mail5.windriver.com ([192.103.53.11]:51866 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJYCBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:01:42 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w9OHUCJW013430
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 24 Oct 2018 10:30:22 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Wed, 24 Oct 2018 10:30:00 -0700
From:   <zhe.he@windriver.com>
To:     <pablo@netfilter.org>, <kadlec@blackhole.kfki.hu>, <fw@strlen.de>,
        <davem@davemloft.net>, <netfilter-devel@vger.kernel.org>,
        <coreteam@netfilter.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        <linux-mm@kvack.org>, <zhe.he@windriver.com>
Subject: [RFC] [PATCH] netfilter: Fix kmemleak false positive reports
Date:   Thu, 25 Oct 2018 01:29:57 +0800
Message-ID: <1540402197-173015-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

unreferenced object 0xffff9643edb89900 (size 256):
  comm "sd-resolve", pid 220, jiffies 4295016710 (age 208.256s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 03 00 74 f3 ba b1 b6 b5  ..........t.....
    65 3e 00 00 00 00 00 00 90 f9 a0 ed 43 96 ff ff  e>..........C...
  backtrace:
    [<0000000070d5b185>] kmem_cache_alloc+0x146/0x200
    [<0000000007a27faa>] __nf_conntrack_alloc.isra.13+0x4d/0x170 [nf_conntrack]
    [<00000000ecc5b0ec>] init_conntrack+0x6a/0x2f0 [nf_conntrack]
    [<000000003d38809f>] nf_conntrack_in+0x2c5/0x360 [nf_conntrack]
    [<000000001fe154e3>] ipv4_conntrack_local+0x5d/0x70 [nf_conntrack_ipv4]
    [<0000000027adadb2>] nf_hook_slow+0x48/0xd0
    [<000000009893511f>] __ip_local_out+0xbd/0xf0
    [<00000000d68cbd2f>] ip_local_out+0x1c/0x50
    [<00000000995e2f37>] ip_send_skb+0x19/0x40
    [<000000003d95f220>] udp_send_skb.isra.5+0x157/0x360
    [<00000000ebc25968>] udp_sendmsg+0x9d8/0xc10
    [<000000003bef56ec>] inet_sendmsg+0x3e/0xf0
    [<000000008d23e405>] sock_sendmsg+0x1d/0x30
    [<000000008c297097>] ___sys_sendmsg+0x108/0x2b0
    [<00000000f15a806c>] __sys_sendmmsg+0xba/0x1c0
    [<00000000e195d2cf>] __x64_sys_sendmmsg+0x24/0x30

In __nf_conntrack_confirm, object ct can be referenced to by the stack variable
ct and the members of ct->tuplehash. kmemleak needs at least one of them to find
the ct object during scan.

When the ct object is moved from the unconfirmed hlist to the confirmed hlist.
kmemleak cannot see ct object if things happen in the following order and thus
give the above false positive report.
1) The ct object is removed from the unconfirmed hlist.
2) kmemleak scans data/bss sections(heap scan passes without heap reference).
3) The ct object is added to confirmed hlist and the variable ct is destroyed as
   the function returns.
4) kmemleak scans task stacks(stack scan passes without stack reference).

This patch marks ct object as not a leak.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: pablo@netfilter.org
Cc: kadlec@blackhole.kfki.hu
Cc: fw@strlen.de
Cc: davem@davemloft.net
Cc: catalin.marinas@arm.com
---
So far this is only observed in v4.18, not in v4.19. But the case seems apply    
to both.

 net/netfilter/nf_conntrack_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index a676d5f..067365d 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -35,6 +35,7 @@
 #include <linux/mm.h>
 #include <linux/nsproxy.h>
 #include <linux/rculist_nulls.h>
+#include <linux/kmemleak.h>
 
 #include <net/netfilter/nf_conntrack.h>
 #include <net/netfilter/nf_conntrack_l4proto.h>
@@ -1282,6 +1283,8 @@ __nf_conntrack_alloc(struct net *net,
 	if (ct == NULL)
 		goto out;
 
+	kmemleak_not_leak(ct);
+
 	spin_lock_init(&ct->lock);
 	ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple = *orig;
 	ct->tuplehash[IP_CT_DIR_ORIGINAL].hnnode.pprev = NULL;
-- 
2.7.4

