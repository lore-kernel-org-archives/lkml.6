Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3A4C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E4E20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg/EukGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E4E20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeKIHn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731817AbeKIHn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91B820844;
        Thu,  8 Nov 2018 22:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714758;
        bh=bIKBdRWIIzarXPPvwA5Gr8sGsK/uxbhZvz3vvXqIsdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eg/EukGyJ9RLNjIi/BkU+3aYdc+BH6ayG08Glpc6kxOdWBnOwOHF9l3foCKG3lCFj
         fRm4gbq1XYf9vLU2gV4uhLF900Lo5K0o937uMbiN/eq7BgjoR/3QuDXZIBtjITSPp1
         JslXMpPiGzmbHaiaG1/DQAbywuZB3vOZ37GChFSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Alex Estrin <alex.estrin@intel.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 102/171] Revert "IB/ipoib: Update broadcast object if PKey value was changed in index 0"
Date:   Thu,  8 Nov 2018 13:51:12 -0800
Message-Id: <20181108215134.817147413@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



