Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F889C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76E125103
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76E125103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965032AbeGAQTs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:19:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965012AbeGAQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:19:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E45FB49B;
        Sun,  1 Jul 2018 16:19:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Timo Teras <timo.teras@iki.fi>,
        Christophe Gouault <christophe.gouault@6wind.com>,
        syzbot 
        <bot+c028095236fcb6f4348811565b75084c754dc729@syzkaller.appspotmail.com>,
        Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.4 076/105] xfrm: skip policies marked as dead while rehashing
Date:   Sun,  1 Jul 2018 18:02:26 +0200
Message-Id: <20180701153154.914240155@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 862591bf4f519d1b8d859af720fafeaebdd0162a upstream.

syzkaller triggered following KASAN splat:

BUG: KASAN: slab-out-of-bounds in xfrm_hash_rebuild+0xdbe/0xf00 net/xfrm/xfrm_policy.c:618
read of size 2 at addr ffff8801c8e92fe4 by task kworker/1:1/23 [..]
Workqueue: events xfrm_hash_rebuild [..]
 __asan_report_load2_noabort+0x14/0x20 mm/kasan/report.c:428
 xfrm_hash_rebuild+0xdbe/0xf00 net/xfrm/xfrm_policy.c:618
 process_one_work+0xbbf/0x1b10 kernel/workqueue.c:2112
 worker_thread+0x223/0x1990 kernel/workqueue.c:2246 [..]

The reproducer triggers:
1016                 if (error) {
1017                         list_move_tail(&walk->walk.all, &x->all);
1018                         goto out;
1019                 }

in xfrm_policy_walk() via pfkey (it sets tiny rcv space, dump
callback returns -ENOBUFS).

In this case, *walk is located the pfkey socket struct, so this socket
becomes visible in the global policy list.

It looks like this is intentional -- phony walker has walk.dead set to 1
and all other places skip such "policies".

Ccing original authors of the two commits that seem to expose this
issue (first patch missed ->dead check, second patch adds pfkey
sockets to policies dumper list).

Fixes: 880a6fab8f6ba5b ("xfrm: configure policy hash table thresholds by netlink")
Fixes: 12a169e7d8f4b1c ("ipsec: Put dumpers on the dump list")
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Timo Teras <timo.teras@iki.fi>
Cc: Christophe Gouault <christophe.gouault@6wind.com>
Reported-by: syzbot <bot+c028095236fcb6f4348811565b75084c754dc729@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_policy.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -626,7 +626,8 @@ static void xfrm_hash_rebuild(struct wor
 
 	/* re-insert all policies by order of creation */
 	list_for_each_entry_reverse(policy, &net->xfrm.policy_all, walk.all) {
-		if (xfrm_policy_id2dir(policy->index) >= XFRM_POLICY_MAX) {
+		if (policy->walk.dead ||
+		    xfrm_policy_id2dir(policy->index) >= XFRM_POLICY_MAX) {
 			/* skip socket policies */
 			continue;
 		}


