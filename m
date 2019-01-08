Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F033AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DA120651
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Jcbob2Lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfAHJaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:30:08 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:43956 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727367AbfAHJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:30:08 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id E959C219C4;
        Tue,  8 Jan 2019 12:30:03 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id km6jRh9bSC-U3MmhjRE;
        Tue, 08 Jan 2019 12:30:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1546939803; bh=S6PJGIpbFKuIM+CevDzLcHQLDsrocdVdhip87MGJSpw=;
        h=Subject:From:To:Cc:Date:Message-ID;
        b=Jcbob2LvrnqZpmnCgfJQ71GJBfe3NT1czzaHeEGOHU1sSP6eEI0wIQLyYdg2Uo1nx
         0ZZZfQiABWn3OWfG4oH0wdGNrgna2lJwDcgx0CfbQszImxxIi4vMgcwlwIHLAuO6Wb
         JfM+o9GCLlx8gyVA+5AodH2PT6STxJHZCnnoE7Dk=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:0:827::1:2])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id CiL51olxVn-U3k8N6ba;
        Tue, 08 Jan 2019 12:30:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] net/core/neighbour: tell kmemleak about hash tables
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Jan 2019 12:30:00 +0300
Message-ID: <154693980088.104235.16222977463502002037.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes false-positive kmemleak reports about leaked neighbour entries:

unreferenced object 0xffff8885c6e4d0a8 (size 1024):
  comm "softirq", pid 0, jiffies 4294922664 (age 167640.804s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 2c f3 83 ff ff ff ff  ........ ,......
    08 c0 ef 5f 84 88 ff ff 01 8c 7d 02 01 00 00 00  ..._......}.....
  backtrace:
    [<00000000748509fe>] ip6_finish_output2+0x887/0x1e40
    [<0000000036d7a0d8>] ip6_output+0x1ba/0x600
    [<0000000027ea7dba>] ip6_send_skb+0x92/0x2f0
    [<00000000d6e2111d>] udp_v6_send_skb.isra.24+0x680/0x15e0
    [<000000000668a8be>] udpv6_sendmsg+0x18c9/0x27a0
    [<000000004bd5fa90>] sock_sendmsg+0xb3/0xf0
    [<000000008227b29f>] ___sys_sendmsg+0x745/0x8f0
    [<000000008698009d>] __sys_sendmsg+0xde/0x170
    [<00000000889dacf1>] do_syscall_64+0x9b/0x400
    [<0000000081cdb353>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<000000005767ed39>] 0xffffffffffffffff

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 net/core/neighbour.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 763a7b08df67..3e27a779f288 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -18,6 +18,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/slab.h>
+#include <linux/kmemleak.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -443,12 +444,14 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
 	if (!ret)
 		return NULL;
-	if (size <= PAGE_SIZE)
+	if (size <= PAGE_SIZE) {
 		buckets = kzalloc(size, GFP_ATOMIC);
-	else
+	} else {
 		buckets = (struct neighbour __rcu **)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
+		kmemleak_alloc(buckets, size, 0, GFP_ATOMIC);
+	}
 	if (!buckets) {
 		kfree(ret);
 		return NULL;
@@ -468,10 +471,12 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
 	struct neighbour __rcu **buckets = nht->hash_buckets;
 
-	if (size <= PAGE_SIZE)
+	if (size <= PAGE_SIZE) {
 		kfree(buckets);
-	else
+	} else {
+		kmemleak_free(buckets);
 		free_pages((unsigned long)buckets, get_order(size));
+	}
 	kfree(nht);
 }
 

