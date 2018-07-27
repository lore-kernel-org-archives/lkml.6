Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A69C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9B720894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9B720894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbeG0LWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:22:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbeG0LWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:22:34 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 89FF3CBD;
        Fri, 27 Jul 2018 10:01:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 21/48] vxlan: add new fdb alloc and create helpers
Date:   Fri, 27 Jul 2018 12:00:06 +0200
Message-Id: <20180727095920.711188046@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
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

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit 7431016b107c95cb5b2014aa1901fcb115f746bc ]

- Add new vxlan_fdb_alloc helper
- rename existing vxlan_fdb_create into vxlan_fdb_update:
        because it really creates or updates an existing
        fdb entry
- move new fdb creation into a separate vxlan_fdb_create

Main motivation for this change is to introduce the ability
to decouple vxlan fdb creation and notify, used in a later patch.

Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |   91 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 29 deletions(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -636,9 +636,62 @@ static int vxlan_gro_complete(struct soc
 	return eth_gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
 }
 
-/* Add new entry to forwarding table -- assumes lock held */
+static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan,
+					 const u8 *mac, __u16 state,
+					 __be32 src_vni, __u8 ndm_flags)
+{
+	struct vxlan_fdb *f;
+
+	f = kmalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		return NULL;
+	f->state = state;
+	f->flags = ndm_flags;
+	f->updated = f->used = jiffies;
+	f->vni = src_vni;
+	INIT_LIST_HEAD(&f->remotes);
+	memcpy(f->eth_addr, mac, ETH_ALEN);
+
+	return f;
+}
+
 static int vxlan_fdb_create(struct vxlan_dev *vxlan,
 			    const u8 *mac, union vxlan_addr *ip,
+			    __u16 state, __be16 port, __be32 src_vni,
+			    __be32 vni, __u32 ifindex, __u8 ndm_flags,
+			    struct vxlan_fdb **fdb)
+{
+	struct vxlan_rdst *rd = NULL;
+	struct vxlan_fdb *f;
+	int rc;
+
+	if (vxlan->cfg.addrmax &&
+	    vxlan->addrcnt >= vxlan->cfg.addrmax)
+		return -ENOSPC;
+
+	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
+	f = vxlan_fdb_alloc(vxlan, mac, state, src_vni, ndm_flags);
+	if (!f)
+		return -ENOMEM;
+
+	rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
+	if (rc < 0) {
+		kfree(f);
+		return rc;
+	}
+
+	++vxlan->addrcnt;
+	hlist_add_head_rcu(&f->hlist,
+			   vxlan_fdb_head(vxlan, mac, src_vni));
+
+	*fdb = f;
+
+	return 0;
+}
+
+/* Add new entry to forwarding table -- assumes lock held */
+static int vxlan_fdb_update(struct vxlan_dev *vxlan,
+			    const u8 *mac, union vxlan_addr *ip,
 			    __u16 state, __u16 flags,
 			    __be16 port, __be32 src_vni, __be32 vni,
 			    __u32 ifindex, __u8 ndm_flags)
@@ -687,37 +740,17 @@ static int vxlan_fdb_create(struct vxlan
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
 
-		if (vxlan->cfg.addrmax &&
-		    vxlan->addrcnt >= vxlan->cfg.addrmax)
-			return -ENOSPC;
-
 		/* Disallow replace to add a multicast entry */
 		if ((flags & NLM_F_REPLACE) &&
 		    (is_multicast_ether_addr(mac) || is_zero_ether_addr(mac)))
 			return -EOPNOTSUPP;
 
 		netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
-		f = kmalloc(sizeof(*f), GFP_ATOMIC);
-		if (!f)
-			return -ENOMEM;
-
-		notify = 1;
-		f->state = state;
-		f->flags = ndm_flags;
-		f->updated = f->used = jiffies;
-		f->vni = src_vni;
-		INIT_LIST_HEAD(&f->remotes);
-		memcpy(f->eth_addr, mac, ETH_ALEN);
-
-		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
-		if (rc < 0) {
-			kfree(f);
+		rc = vxlan_fdb_create(vxlan, mac, ip, state, port, src_vni,
+				      vni, ifindex, ndm_flags, &f);
+		if (rc < 0)
 			return rc;
-		}
-
-		++vxlan->addrcnt;
-		hlist_add_head_rcu(&f->hlist,
-				   vxlan_fdb_head(vxlan, mac, src_vni));
+		notify = 1;
 	}
 
 	if (notify) {
@@ -863,7 +896,7 @@ static int vxlan_fdb_add(struct ndmsg *n
 		return -EAFNOSUPPORT;
 
 	spin_lock_bh(&vxlan->hash_lock);
-	err = vxlan_fdb_create(vxlan, addr, &ip, ndm->ndm_state, flags,
+	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
 			       port, src_vni, vni, ifindex, ndm->ndm_flags);
 	spin_unlock_bh(&vxlan->hash_lock);
 
@@ -1006,7 +1039,7 @@ static bool vxlan_snoop(struct net_devic
 
 		/* close off race between vxlan_flush and incoming packets */
 		if (netif_running(dev))
-			vxlan_fdb_create(vxlan, src_mac, src_ip,
+			vxlan_fdb_update(vxlan, src_mac, src_ip,
 					 NUD_REACHABLE,
 					 NLM_F_EXCL|NLM_F_CREATE,
 					 vxlan->cfg.dst_port,
@@ -3167,7 +3200,7 @@ static int __vxlan_dev_create(struct net
 
 	/* create an fdb entry for a valid default destination */
 	if (!vxlan_addr_any(&vxlan->default_dst.remote_ip)) {
-		err = vxlan_fdb_create(vxlan, all_zeros_mac,
+		err = vxlan_fdb_update(vxlan, all_zeros_mac,
 				       &vxlan->default_dst.remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_EXCL | NLM_F_CREATE,
@@ -3441,7 +3474,7 @@ static int vxlan_changelink(struct net_d
 					   old_dst.remote_ifindex, 0);
 
 		if (!vxlan_addr_any(&dst->remote_ip)) {
-			err = vxlan_fdb_create(vxlan, all_zeros_mac,
+			err = vxlan_fdb_update(vxlan, all_zeros_mac,
 					       &dst->remote_ip,
 					       NUD_REACHABLE | NUD_PERMANENT,
 					       NLM_F_CREATE | NLM_F_APPEND,


