Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE33ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2554120868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp7DYr+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2554120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeJYWtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbeJYWtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:08 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE4120868;
        Thu, 25 Oct 2018 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476971;
        bh=bQAc0EFA6P4cK70aapV+fJXzBSBOrS7GccmQx9143Q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gp7DYr+piqeAk7RgD5ZfxMrp6TCATcm+GaEPbc8aeLaR4VsQll3YPj56biVQFCITl
         /micqN7jrIw5/UXkbECLqlGlh1jYj/MEhoemnHD5c6JzK+8+VJCIHVFBQBcWzfFwO9
         4/HKJN94Vh/hFNpqgBF9V2DMiu+H1wlozKbiHlsU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Estrin <alex.estrin@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 73/98] Revert "IB/ipoib: Update broadcast object if PKey value was changed in index 0"
Date:   Thu, 25 Oct 2018 10:13:58 -0400
Message-Id: <20181025141423.213774-73-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Estrin <alex.estrin@intel.com>

[ Upstream commit 612601d0013f03de9dc134809f242ba6da9ca252 ]

commit 9a9b8112699d will cause core to fail UD QP from being destroyed
on ipoib unload, therefore cause resources leakage.
On pkey change event above patch modifies mgid before calling underlying
driver to detach it from QP. Drivers' detach_mcast() will fail to find
modified mgid it was never given to attach in a first place.
Core qp->usecnt will never go down, so ib_destroy_qp() will fail.

IPoIB driver actually does take care of new broadcast mgid based on new
pkey by destroying an old mcast object in ipoib_mcast_dev_flush())
....
	if (priv->broadcast) {
		rb_erase(&priv->broadcast->rb_node, &priv->multicast_tree);
		list_add_tail(&priv->broadcast->list, &remove_list);
		priv->broadcast = NULL;
	}
...

then in restarted ipoib_macst_join_task() creating a new broadcast mcast
object, sending join request and on completion tells the driver to attach
to reinitialized QP:
...
if (!priv->broadcast) {
...
	broadcast = ipoib_mcast_alloc(dev, 0);
...
	memcpy(broadcast->mcmember.mgid.raw, priv->dev->broadcast + 4,
	       sizeof (union ib_gid));
	priv->broadcast = broadcast;
...

Fixes: 9a9b8112699d ("IB/ipoib: Update broadcast object if PKey value was changed in index 0")
Cc: stable@vger.kernel.org
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Reviewed-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 3dd5bf6c6c7a..ad3089c23e18 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -974,19 +974,6 @@ static inline int update_parent_pkey(struct ipoib_dev_priv *priv)
 		 */
 		priv->dev->broadcast[8] = priv->pkey >> 8;
 		priv->dev->broadcast[9] = priv->pkey & 0xff;
-
-		/*
-		 * Update the broadcast address in the priv->broadcast object,
-		 * in case it already exists, otherwise no one will do that.
-		 */
-		if (priv->broadcast) {
-			spin_lock_irq(&priv->lock);
-			memcpy(priv->broadcast->mcmember.mgid.raw,
-			       priv->dev->broadcast + 4,
-			sizeof(union ib_gid));
-			spin_unlock_irq(&priv->lock);
-		}
-
 		return 0;
 	}
 
-- 
2.17.1

