Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF02C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D300921565
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/0K9i4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D300921565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeJHWj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeJHWjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE3942152C;
        Mon,  8 Oct 2018 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012430;
        bh=gDOp7mPyEDchUtQ7pGNLgUb/uj7ORoZf9CRBcNPJeAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/0K9i4vy1yZ//nm9olOFeXadQFuRJDyxvC5Mr8PyOw39DP2Y2Q8oRv8Vd4aJT1df
         0PuYrS7ktgwJPVbOCKhigpZ9+YLL8OLcisn6xupCMKVkLwYdAHA4DIKsNs+OysK+iv
         Cav0k2XgW/ECa6meKf2QpYgHbS58tR2sXHY3Phyk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 05/23] batman-adv: Prevent duplicated softif_vlan entry
Date:   Mon,  8 Oct 2018 11:26:45 -0400
Message-Id: <20181008152703.70891-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152703.70891-1-sashal@kernel.org>
References: <20181008152703.70891-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit 94cb82f594ed86be303398d6dfc7640a6f1d45d4 ]

The function batadv_softif_vlan_get is responsible for adding new
softif_vlan to the softif_vlan_list. It first checks whether the entry
already is in the list or not. If it is, then the creation of a new entry
is aborted.

But the lock for the list is only held when the list is really modified.
This could lead to duplicated entries because another context could create
an entry with the same key between the check and the list manipulation.

The check and the manipulation of the list must therefore be in the same
locked code section.

Fixes: 5d2c05b21337 ("batman-adv: add per VLAN interface attribute framework")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/batman-adv/soft-interface.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 84c1b388d9ed..05bc176decf0 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -565,15 +565,20 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	struct batadv_softif_vlan *vlan;
 	int err;
 
+	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
+
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
 	if (vlan) {
 		batadv_softif_vlan_put(vlan);
+		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 		return -EEXIST;
 	}
 
 	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
-	if (!vlan)
+	if (!vlan) {
+		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 		return -ENOMEM;
+	}
 
 	vlan->bat_priv = bat_priv;
 	vlan->vid = vid;
@@ -581,17 +586,23 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 
 	atomic_set(&vlan->ap_isolation, 0);
 
+	kref_get(&vlan->refcount);
+	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
+	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
+
+	/* batadv_sysfs_add_vlan cannot be in the spinlock section due to the
+	 * sleeping behavior of the sysfs functions and the fs_reclaim lock
+	 */
 	err = batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
 	if (err) {
-		kfree(vlan);
+		/* ref for the function */
+		batadv_softif_vlan_put(vlan);
+
+		/* ref for the list */
+		batadv_softif_vlan_put(vlan);
 		return err;
 	}
 
-	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
-	kref_get(&vlan->refcount);
-	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
-	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
-
 	/* add a new TT local entry. This one will be marked with the NOPURGE
 	 * flag
 	 */
-- 
2.17.1

