Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D9FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8969C20891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8969C20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388745AbeG0LJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:09:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbeG0LJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:09:53 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D5AC2C03;
        Fri, 27 Jul 2018 09:48:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 41/66] vxlan: fix default fdb entry netlink notify ordering during netdev create
Date:   Fri, 27 Jul 2018 11:45:34 +0200
Message-Id: <20180727093813.743894260@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit e99465b952861533d9ba748fdbecc96d9a36da3e ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3190,6 +3190,7 @@ static int __vxlan_dev_create(struct net
 {
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb *f = NULL;
 	int err;
 
 	err = vxlan_dev_configure(net, dev, conf, false, extack);
@@ -3200,27 +3201,38 @@ static int __vxlan_dev_create(struct net
 
 	/* create an fdb entry for a valid default destination */
 	if (!vxlan_addr_any(&vxlan->default_dst.remote_ip)) {
-		err = vxlan_fdb_update(vxlan, all_zeros_mac,
+		err = vxlan_fdb_create(vxlan, all_zeros_mac,
 				       &vxlan->default_dst.remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
-				       NLM_F_EXCL | NLM_F_CREATE,
 				       vxlan->cfg.dst_port,
 				       vxlan->default_dst.remote_vni,
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
-		vxlan_fdb_delete_default(vxlan, vxlan->default_dst.remote_vni);
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
+		vxlan_fdb_destroy(vxlan, f, false);
+	return err;
 }
 
 static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
@@ -3449,6 +3461,7 @@ static int vxlan_changelink(struct net_d
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	struct vxlan_rdst old_dst;
 	struct vxlan_config conf;
+	struct vxlan_fdb *f = NULL;
 	int err;
 
 	err = vxlan_nl2conf(tb, data,
@@ -3474,19 +3487,19 @@ static int vxlan_changelink(struct net_d
 					   old_dst.remote_ifindex, 0);
 
 		if (!vxlan_addr_any(&dst->remote_ip)) {
-			err = vxlan_fdb_update(vxlan, all_zeros_mac,
+			err = vxlan_fdb_create(vxlan, all_zeros_mac,
 					       &dst->remote_ip,
 					       NUD_REACHABLE | NUD_PERMANENT,
-					       NLM_F_CREATE | NLM_F_APPEND,
 					       vxlan->cfg.dst_port,
 					       dst->remote_vni,
 					       dst->remote_vni,
 					       dst->remote_ifindex,
-					       NTF_SELF);
+					       NTF_SELF, &f);
 			if (err) {
 				spin_unlock_bh(&vxlan->hash_lock);
 				return err;
 			}
+			vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH);
 		}
 		spin_unlock_bh(&vxlan->hash_lock);
 	}


