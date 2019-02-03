Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FD4C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC55421906
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfBCOX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:23:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55840 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730522AbfBCOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:31 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeH-0006Rn-Q2; Sun, 03 Feb 2019 14:21:29 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqICc-000831-Tq; Sun, 03 Feb 2019 14:52:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Petr Machata" <petrm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.944717662@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 299/305] vxlan: Fix error path in __vxlan_dev_create()
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@mellanox.com>

commit 6db9246871394b3a136cd52001a0763676563840 upstream.

When a failure occurs in rtnl_configure_link(), the current code
calls unregister_netdevice() to roll back the earlier call to
register_netdevice(), and jumps to errout, which calls
vxlan_fdb_destroy().

However unregister_netdevice() calls transitively ndo_uninit, which is
vxlan_uninit(), and that already takes care of deleting the default FDB
entry by calling vxlan_fdb_delete_default(). Since the entry added
earlier in __vxlan_dev_create() is exactly the default entry, the
cleanup code in the errout block always leads to double free and thus a
panic.

Besides, since vxlan_fdb_delete_default() always destroys the FDB entry
with notification enabled, the deletion of the default entry is notified
even before the addition was notified.

Instead, move the unregister_netdevice() call after the manual destroy,
which solves both problems.

Fixes: 0241b836732f ("vxlan: fix default fdb entry netlink notify ordering during netdev create")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/vxlan.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2615,6 +2615,7 @@ static int vxlan_newlink(struct net *net
 	struct vxlan_dev *vxlan = netdev_priv(dev), *tmp;
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	struct vxlan_fdb *f = NULL;
+	bool unregister = false;
 	__u32 vni;
 	int err;
 	bool use_ipv6 = false;
@@ -2766,12 +2767,11 @@ static int vxlan_newlink(struct net *net
 	err = register_netdevice(dev);
 	if (err)
 		goto errout;
+	unregister = true;
 
 	err = rtnl_configure_link(dev, NULL);
-	if (err) {
-		unregister_netdevice(dev);
+	if (err)
 		goto errout;
-	}
 
 	/* notify default fdb entry */
 	if (f)
@@ -2780,9 +2780,16 @@ static int vxlan_newlink(struct net *net
 	list_add(&vxlan->next, &vn->vxlan_list);
 
 	return 0;
+
 errout:
+	/* unregister_netdevice() destroys the default FDB entry with deletion
+	 * notification. But the addition notification was not sent yet, so
+	 * destroy the entry by hand here.
+	 */
 	if (f)
 		vxlan_fdb_destroy(vxlan, f);
+	if (unregister)
+		unregister_netdevice(dev);
 	return err;
 }
 

