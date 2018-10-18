Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B673CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEED21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Xr31rlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEED21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbeJSCEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbeJSCD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:03:59 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4B1721479;
        Thu, 18 Oct 2018 18:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885713;
        bh=thTN0OabMSy0NBoihD5tHi984mRK0S9+GYw0ZUzkZcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Xr31rlJbrnnu5RceXDxTMMkkb53OrQF96yYzr4DDKmU9+KXAyd1N4TdnD7Nn0dJO
         bTYGZwFG77jJwKshvfAlrVxHJBuzyjxDqcdkK3udN9EYjRHmkGnHSwHNzUIV8Jpmlx
         yPbxgw6o8Fu5Gw3owjUtDP+XR1PwGGYL68zzU1hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 07/41] batman-adv: Prevent duplicated softif_vlan entry
Date:   Thu, 18 Oct 2018 19:54:22 +0200
Message-Id: <20181018175417.986474852@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/soft-interface.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -566,15 +566,20 @@ int batadv_softif_create_vlan(struct bat
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
@@ -582,17 +587,23 @@ int batadv_softif_create_vlan(struct bat
 
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


