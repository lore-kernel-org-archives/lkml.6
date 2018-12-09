Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC28C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B6520661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B6520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeLIW2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:28:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34600 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726361AbeLIVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:11 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0002im-Da; Sun, 09 Dec 2018 21:55:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0003EL-UG; Sun, 09 Dec 2018 21:55:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Roopa Prabhu" <roopa@cumulusnetworks.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.613617241@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 028/328] vxlan: add new fdb alloc and create helpers
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Roopa Prabhu <roopa@cumulusnetworks.com>

commit 25e20e730d56471cffa25419bf2a66078bd55330 upstream.

- Add new vxlan_fdb_alloc helper
- rename existing vxlan_fdb_create into vxlan_fdb_update:
        because it really creates or updates an existing
        fdb entry
- move new fdb creation into a separate vxlan_fdb_create

Main motivation for this change is to introduce the ability
to decouple vxlan fdb creation and notify, used in a later patch.

Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - s/vxlan->cfg\.addrmax/vxlan->addrmax/g
 - Drop src_vni parameters and initialisation of vxlan_fdb::vni
 - Drop last argument to vxlan_fdb_head()
 - Drop change to vxlan_changelink()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/vxlan.c | 91 ++++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 29 deletions(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -685,9 +685,60 @@ static void vxlan_notify_del_rx_port(str
 		udp_del_offload(&vs->udp_offloads);
 }
 
-/* Add new entry to forwarding table -- assumes lock held */
+static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan,
+					 const u8 *mac, __u16 state,
+					 __u8 ndm_flags)
+{
+	struct vxlan_fdb *f;
+
+	f = kmalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		return NULL;
+	f->state = state;
+	f->flags = ndm_flags;
+	f->updated = f->used = jiffies;
+	INIT_LIST_HEAD(&f->remotes);
+	memcpy(f->eth_addr, mac, ETH_ALEN);
+
+	return f;
+}
+
 static int vxlan_fdb_create(struct vxlan_dev *vxlan,
 			    const u8 *mac, union vxlan_addr *ip,
+			    __u16 state, __be16 port,
+			    __be32 vni, __u32 ifindex, __u8 ndm_flags,
+			    struct vxlan_fdb **fdb)
+{
+	struct vxlan_rdst *rd = NULL;
+	struct vxlan_fdb *f;
+	int rc;
+
+	if (vxlan->addrmax && vxlan->addrcnt >= vxlan->addrmax)
+		return -ENOSPC;
+
+	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
+	f = vxlan_fdb_alloc(vxlan, mac, state, ndm_flags);
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
+			   vxlan_fdb_head(vxlan, mac));
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
 			    __be16 port, __u32 vni, __u32 ifindex,
 			    __u8 ndm_flags)
@@ -740,35 +791,17 @@ static int vxlan_fdb_create(struct vxlan
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
 
-		if (vxlan->addrmax && vxlan->addrcnt >= vxlan->addrmax)
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
-		INIT_LIST_HEAD(&f->remotes);
-		memcpy(f->eth_addr, mac, ETH_ALEN);
-
-		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
-		if (rc < 0) {
-			kfree(f);
+		rc = vxlan_fdb_create(vxlan, mac, ip, state, port,
+				      vni, ifindex, ndm_flags, &f);
+		if (rc < 0)
 			return rc;
-		}
-
-		++vxlan->addrcnt;
-		hlist_add_head_rcu(&f->hlist,
-				   vxlan_fdb_head(vxlan, mac));
+		notify = 1;
 	}
 
 	if (notify) {
@@ -886,7 +919,7 @@ static int vxlan_fdb_add(struct ndmsg *n
 		return -EAFNOSUPPORT;
 
 	spin_lock_bh(&vxlan->hash_lock);
-	err = vxlan_fdb_create(vxlan, addr, &ip, ndm->ndm_state, flags,
+	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
 			       port, vni, ifindex, ndm->ndm_flags);
 	spin_unlock_bh(&vxlan->hash_lock);
 
@@ -1012,7 +1045,7 @@ static bool vxlan_snoop(struct net_devic
 
 		/* close off race between vxlan_flush and incoming packets */
 		if (netif_running(dev))
-			vxlan_fdb_create(vxlan, src_mac, src_ip,
+			vxlan_fdb_update(vxlan, src_mac, src_ip,
 					 NUD_REACHABLE,
 					 NLM_F_EXCL|NLM_F_CREATE,
 					 vxlan->dst_port,
@@ -2718,7 +2751,7 @@ static int vxlan_newlink(struct net *net
 
 	/* create an fdb entry for a valid default destination */
 	if (!vxlan_addr_any(&vxlan->default_dst.remote_ip)) {
-		err = vxlan_fdb_create(vxlan, all_zeros_mac,
+		err = vxlan_fdb_update(vxlan, all_zeros_mac,
 				       &vxlan->default_dst.remote_ip,
 				       NUD_REACHABLE|NUD_PERMANENT,
 				       NLM_F_EXCL|NLM_F_CREATE,

