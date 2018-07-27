Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277A9C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B411F20894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B411F20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbeG0LWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:22:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbeG0LWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:22:37 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44E8CCB8;
        Fri, 27 Jul 2018 10:01:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 22/48] vxlan: make netlink notify in vxlan_fdb_destroy optional
Date:   Fri, 27 Jul 2018 12:00:07 +0200
Message-Id: <20180727095920.837076863@linuxfoundation.org>
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

[ Upstream commit f6e053858671bb156b6e44ad66418acc8c7f4e77 ]

Add a new option do_notify to vxlan_fdb_destroy to make
sending netlink notify optional. Used by a later patch.

Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -774,13 +774,15 @@ static void vxlan_fdb_free(struct rcu_he
 	kfree(f);
 }
 
-static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f)
+static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
+			      bool do_notify)
 {
 	netdev_dbg(vxlan->dev,
 		    "delete %pM\n", f->eth_addr);
 
 	--vxlan->addrcnt;
-	vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_DELNEIGH);
+	if (do_notify)
+		vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_DELNEIGH);
 
 	hlist_del_rcu(&f->hlist);
 	call_rcu(&f->rcu, vxlan_fdb_free);
@@ -930,7 +932,7 @@ static int __vxlan_fdb_delete(struct vxl
 		goto out;
 	}
 
-	vxlan_fdb_destroy(vxlan, f);
+	vxlan_fdb_destroy(vxlan, f, true);
 
 out:
 	return 0;
@@ -2393,7 +2395,7 @@ static void vxlan_cleanup(unsigned long
 					   "garbage collect %pM\n",
 					   f->eth_addr);
 				f->state = NUD_STALE;
-				vxlan_fdb_destroy(vxlan, f);
+				vxlan_fdb_destroy(vxlan, f, true);
 			} else if (time_before(timeout, next_timer))
 				next_timer = timeout;
 		}
@@ -2444,7 +2446,7 @@ static void vxlan_fdb_delete_default(str
 	spin_lock_bh(&vxlan->hash_lock);
 	f = __vxlan_find_mac(vxlan, all_zeros_mac, vni);
 	if (f)
-		vxlan_fdb_destroy(vxlan, f);
+		vxlan_fdb_destroy(vxlan, f, true);
 	spin_unlock_bh(&vxlan->hash_lock);
 }
 
@@ -2498,7 +2500,7 @@ static void vxlan_flush(struct vxlan_dev
 				continue;
 			/* the all_zeros_mac entry is deleted at vxlan_uninit */
 			if (!is_zero_ether_addr(f->eth_addr))
-				vxlan_fdb_destroy(vxlan, f);
+				vxlan_fdb_destroy(vxlan, f, true);
 		}
 	}
 	spin_unlock_bh(&vxlan->hash_lock);


