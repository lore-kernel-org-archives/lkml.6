Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D59EC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80E62098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDp6WT4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80E62098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJQBCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJQBCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:02:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F702089E;
        Tue, 16 Oct 2018 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709844;
        bh=t+v/u9IveNb6jrkU0xa8g9kC8usnEFqJZeyl0CYpX5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDp6WT4r3kD9KgEiMIoNMbdLHOrAEvli+R7HrBuUYrf/D/bGVyzephptEqKna+/YD
         wi+SXxCXU18u7z8SZzFwtH76pMNC8poXqkhisekf+2DryxvuYBQoXc1x17mfRyYLog
         CzZcj3YOhkBkFiD572jwsrhk4RkGboN/9qw4HZUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 016/135] net: sched: cls_u32: fix hnode refcounting
Date:   Tue, 16 Oct 2018 19:04:06 +0200
Message-Id: <20181016170516.477109260@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 6d4c407744dd0338da5d5d76f40dce5adabfb30a ]

cls_u32.c misuses refcounts for struct tc_u_hnode - it counts references
via ->hlist and via ->tp_root together.  u32_destroy() drops the former
and, in case when there had been links, leaves the sucker on the list.
As the result, there's nothing to protect it from getting freed once links
are dropped.
That also makes the "is it busy" check incapable of catching the root
hnode - it *is* busy (there's a reference from tp), but we don't see it as
something separate.  "Is it our root?" check partially covers that, but
the problem exists for others' roots as well.

AFAICS, the minimal fix preserving the existing behaviour (where it doesn't
include oopsen, that is) would be this:
        * count tp->root and tp_c->hlist as separate references.  I.e.
have u32_init() set refcount to 2, not 1.
	* in u32_destroy() we always drop the former;
in u32_destroy_hnode() - the latter.

	That way we have *all* references contributing to refcount.  List
removal happens in u32_destroy_hnode() (called only when ->refcnt is 1)
an in u32_destroy() in case of tc_u_common going away, along with
everything reachable from it.  IOW, that way we know that
u32_destroy_key() won't free something still on the list (or pointed to by
someone's ->root).

Reproducer:

tc qdisc add dev eth0 ingress
tc filter add dev eth0 parent ffff: protocol ip prio 100 handle 1: \
u32 divisor 1
tc filter add dev eth0 parent ffff: protocol ip prio 200 handle 2: \
u32 divisor 1
tc filter add dev eth0 parent ffff: protocol ip prio 100 \
handle 1:0:11 u32 ht 1: link 801: offset at 0 mask 0f00 shift 6 \
plus 0 eat match ip protocol 6 ff
tc filter delete dev eth0 parent ffff: protocol ip prio 200
tc filter change dev eth0 parent ffff: protocol ip prio 100 \
handle 1:0:11 u32 ht 1: link 0: offset at 0 mask 0f00 shift 6 plus 0 \
eat match ip protocol 6 ff
tc filter delete dev eth0 parent ffff: protocol ip prio 100

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_u32.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -397,6 +397,7 @@ static int u32_init(struct tcf_proto *tp
 	rcu_assign_pointer(tp_c->hlist, root_ht);
 	root_ht->tp_c = tp_c;
 
+	root_ht->refcnt++;
 	rcu_assign_pointer(tp->root, root_ht);
 	tp->data = tp_c;
 	return 0;
@@ -608,7 +609,7 @@ static int u32_destroy_hnode(struct tcf_
 	struct tc_u_hnode __rcu **hn;
 	struct tc_u_hnode *phn;
 
-	WARN_ON(ht->refcnt);
+	WARN_ON(--ht->refcnt);
 
 	u32_clear_hnode(tp, ht, extack);
 
@@ -647,7 +648,7 @@ static void u32_destroy(struct tcf_proto
 
 	WARN_ON(root_ht == NULL);
 
-	if (root_ht && --root_ht->refcnt == 0)
+	if (root_ht && --root_ht->refcnt == 1)
 		u32_destroy_hnode(tp, root_ht, extack);
 
 	if (--tp_c->refcnt == 0) {
@@ -696,7 +697,6 @@ static int u32_delete(struct tcf_proto *
 	}
 
 	if (ht->refcnt == 1) {
-		ht->refcnt--;
 		u32_destroy_hnode(tp, ht, extack);
 	} else {
 		NL_SET_ERR_MSG_MOD(extack, "Can not delete in-use filter");
@@ -706,11 +706,11 @@ static int u32_delete(struct tcf_proto *
 out:
 	*last = true;
 	if (root_ht) {
-		if (root_ht->refcnt > 1) {
+		if (root_ht->refcnt > 2) {
 			*last = false;
 			goto ret;
 		}
-		if (root_ht->refcnt == 1) {
+		if (root_ht->refcnt == 2) {
 			if (!ht_empty(root_ht)) {
 				*last = false;
 				goto ret;


