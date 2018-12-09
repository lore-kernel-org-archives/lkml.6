Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3833C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A5F20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A5F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbeLIW2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:28:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34606 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbeLIVzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:10 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0002ib-E6; Sun, 09 Dec 2018 21:55:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0003EQ-VQ; Sun, 09 Dec 2018 21:55:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Roopa Prabhu" <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.995774593@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 029/328] vxlan: fix default fdb entry netlink notify
 ordering during netdev create
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

commit 0241b836732f5f43c3f0fd9e9073c1fb24ea6757 upstream.

Problem:
In vxlan_newlink, a default fdb entry is added before register_netdev.
The default fdb creation function also notifies user-space of the
fdb entry on the vxlan device which user-space does not know about yet.
(RTM_NEWNEIGH goes before RTM_NEWLINK for the same ifindex).

This patch fixes the user-space netlink notification ordering issue
with the following changes:
- decouple fdb notify from fdb create.
- Move fdb notify after register_netdev.
- Call rtnl_configure_link in vxlan newlink handler to notify
userspace about the newlink before fdb notify and
hence avoiding the user-space race.

Fixes: afbd8bae9c79 ("vxlan: add implicit fdb entry for default destination")
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Drop changes to vxlan_changelink()
 - Drop last argument to vxlan_fdb_destroy()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2614,6 +2614,7 @@ static int vxlan_newlink(struct net *net
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_dev *vxlan = netdev_priv(dev), *tmp;
 	struct vxlan_rdst *dst = &vxlan->default_dst;
+	struct vxlan_fdb *f = NULL;
 	__u32 vni;
 	int err;
 	bool use_ipv6 = false;
@@ -2751,27 +2752,38 @@ static int vxlan_newlink(struct net *net
 
 	/* create an fdb entry for a valid default destination */
 	if (!vxlan_addr_any(&vxlan->default_dst.remote_ip)) {
-		err = vxlan_fdb_update(vxlan, all_zeros_mac,
+		err = vxlan_fdb_create(vxlan, all_zeros_mac,
 				       &vxlan->default_dst.remote_ip,
 				       NUD_REACHABLE|NUD_PERMANENT,
-				       NLM_F_EXCL|NLM_F_CREATE,
 				       vxlan->dst_port,
 				       vxlan->default_dst.remote_vni,
 				       vxlan->default_dst.remote_ifindex,
-				       NTF_SELF);
+				       NTF_SELF, &f);
 		if (err)
 			return err;
 	}
 
 	err = register_netdevice(dev);
+	if (err)
+		goto errout;
+
+	err = rtnl_configure_link(dev, NULL);
 	if (err) {
-		vxlan_fdb_delete_default(vxlan);
-		return err;
+		unregister_netdevice(dev);
+		goto errout;
 	}
 
+	/* notify default fdb entry */
+	if (f)
+		vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH);
+
 	list_add(&vxlan->next, &vn->vxlan_list);
 
 	return 0;
+errout:
+	if (f)
+		vxlan_fdb_destroy(vxlan, f);
+	return err;
 }
 
 static void vxlan_dellink(struct net_device *dev, struct list_head *head)

