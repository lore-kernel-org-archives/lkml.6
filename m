Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1720FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B623920870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7Ow87i3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B623920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJKGhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbeJKGho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:44 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 282322150D;
        Wed, 10 Oct 2018 23:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213203;
        bh=Dco7IKPWXjlRbilRv1G8V3Tbyhp6hacccUSOP4QfdmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7Ow87i3tBaOt5BtwcwnjQKEL8D7dClq6WIymDqafe8yUhkV/5YIYPgK05foGbaS1
         +Lgo0xkIQStCQ4+OrYrFnKc1IK7nc9bpvEvpa6FMUbMgu2IiasSpCeai5BjdUfcMld
         DEDChv6uktdj3VCaFr1tQh2gxWuixGSBzdZyenVM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 17/30] isdn: Prepare isdn_net_get_locked_lp() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:12:04 +0200
Message-Id: <1539213137-13953-18-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is implemented on top of spin_lock_bh() that is going to
handle a softirq mask in order to apply finegrained vector disablement.
The lock function is going to return the previous vectors enabled mask
prior to the last call to local_bh_disable(), following a similar model
to that of local_irq_save/restore. Subsequent calls to local_bh_disable()
and friends can then stack up:

	bh = local_bh_disable(vec_mask);
		isdn_net_get_locked_lp(&bh2) {
			spin_lock(...)
			*bh2 = local_bh_disable(...)
		}
		...
		spin_unlock_bh(bh2, ...);
	local_bh_enable(bh);

To prepare for that, make isdn_net_get_locked_lp() able to return a
saved vector enabled mask. We'll plug it to spin_[un]lock_bh() in a
subsequent patch.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 drivers/isdn/i4l/isdn_concap.c | 3 ++-
 drivers/isdn/i4l/isdn_net.c    | 3 ++-
 drivers/isdn/i4l/isdn_net.h    | 3 ++-
 drivers/isdn/i4l/isdn_ppp.c    | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_concap.c b/drivers/isdn/i4l/isdn_concap.c
index 336523e..4352bec 100644
--- a/drivers/isdn/i4l/isdn_concap.c
+++ b/drivers/isdn/i4l/isdn_concap.c
@@ -41,9 +41,10 @@
 
 static int isdn_concap_dl_data_req(struct concap_proto *concap, struct sk_buff *skb)
 {
+	unsigned int bh;
 	struct net_device *ndev = concap->net_dev;
 	isdn_net_dev *nd = ((isdn_net_local *) netdev_priv(ndev))->netdev;
-	isdn_net_local *lp = isdn_net_get_locked_lp(nd);
+	isdn_net_local *lp = isdn_net_get_locked_lp(nd, &bh);
 
 	IX25DEBUG("isdn_concap_dl_data_req: %s \n", concap->net_dev->name);
 	if (!lp) {
diff --git a/drivers/isdn/i4l/isdn_net.c b/drivers/isdn/i4l/isdn_net.c
index c138f66..a9687ca 100644
--- a/drivers/isdn/i4l/isdn_net.c
+++ b/drivers/isdn/i4l/isdn_net.c
@@ -1054,6 +1054,7 @@ isdn_net_xmit(struct net_device *ndev, struct sk_buff *skb)
 	isdn_net_local *slp;
 	isdn_net_local *lp = netdev_priv(ndev);
 	int retv = NETDEV_TX_OK;
+	unsigned int bh;
 
 	if (((isdn_net_local *) netdev_priv(ndev))->master) {
 		printk("isdn BUG at %s:%d!\n", __FILE__, __LINE__);
@@ -1068,7 +1069,7 @@ isdn_net_xmit(struct net_device *ndev, struct sk_buff *skb)
 	}
 #endif
 	nd = ((isdn_net_local *) netdev_priv(ndev))->netdev;
-	lp = isdn_net_get_locked_lp(nd);
+	lp = isdn_net_get_locked_lp(nd, &bh);
 	if (!lp) {
 		printk(KERN_WARNING "%s: all channels busy - requeuing!\n", ndev->name);
 		return NETDEV_TX_BUSY;
diff --git a/drivers/isdn/i4l/isdn_net.h b/drivers/isdn/i4l/isdn_net.h
index cca6d68..f4621b1 100644
--- a/drivers/isdn/i4l/isdn_net.h
+++ b/drivers/isdn/i4l/isdn_net.h
@@ -76,7 +76,8 @@ static __inline__ int isdn_net_lp_busy(isdn_net_local *lp)
  * For the given net device, this will get a non-busy channel out of the
  * corresponding bundle. The returned channel is locked.
  */
-static __inline__ isdn_net_local *isdn_net_get_locked_lp(isdn_net_dev *nd)
+static __inline__ isdn_net_local *isdn_net_get_locked_lp(isdn_net_dev *nd,
+							 unsigned int *bh)
 {
 	unsigned long flags;
 	isdn_net_local *lp;
diff --git a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
index a7b275e..4c5ac13 100644
--- a/drivers/isdn/i4l/isdn_ppp.c
+++ b/drivers/isdn/i4l/isdn_ppp.c
@@ -1258,6 +1258,7 @@ isdn_ppp_xmit(struct sk_buff *skb, struct net_device *netdev)
 	unsigned int proto = PPP_IP;     /* 0x21 */
 	struct ippp_struct *ipt, *ipts;
 	int slot, retval = NETDEV_TX_OK;
+	unsigned int bh;
 
 	mlp = netdev_priv(netdev);
 	nd = mlp->netdev;       /* get master lp */
@@ -1292,7 +1293,7 @@ isdn_ppp_xmit(struct sk_buff *skb, struct net_device *netdev)
 		goto out;
 	}
 
-	lp = isdn_net_get_locked_lp(nd);
+	lp = isdn_net_get_locked_lp(nd, &bh);
 	if (!lp) {
 		printk(KERN_WARNING "%s: all channels busy - requeuing!\n", netdev->name);
 		retval = NETDEV_TX_BUSY;
-- 
2.7.4

