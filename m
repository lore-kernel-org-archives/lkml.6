Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7vMAFMs7GVsoLwAAmS7hNA
	; Thu, 07 Jun 2018 14:36:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D4373608BA; Thu,  7 Jun 2018 14:36:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3430E601D2;
	Thu,  7 Jun 2018 14:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3430E601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934108AbeFGOgU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:36:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40408 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934072AbeFGOgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:36:14 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbd-0005Zq-Gy; Thu, 07 Jun 2018 15:09:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-00034G-Uq; Thu, 07 Jun 2018 15:09:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Alaa Hleihel" <alaa@mellanox.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        "Leon Romanovsky" <leon@kernel.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.525924293@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 245/410] IB/ipoib: Do not warn if IPoIB debugfs
 doesn't exist
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alaa Hleihel <alaa@mellanox.com>

commit 14fa91e0fef8e4d6feb8b1fa2a807828e0abe815 upstream.

netdev_wait_allrefs() could rebroadcast NETDEV_UNREGISTER event
multiple times until all refs are gone, which will result in calling
ipoib_delete_debug_files multiple times and printing a warning.

Remove the WARN_ONCE since checks of NULL pointers before calling
debugfs_remove are not needed.

Fixes: 771a52584096 ("IB/IPoIB: ibX: failed to create mcg debug file")
Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/ulp/ipoib/ipoib_fs.c | 2 --
 1 file changed, 2 deletions(-)

--- a/drivers/infiniband/ulp/ipoib/ipoib_fs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
@@ -281,8 +281,6 @@ void ipoib_delete_debug_files(struct net
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 
-	WARN_ONCE(!priv->mcg_dentry, "null mcg debug file\n");
-	WARN_ONCE(!priv->path_dentry, "null path debug file\n");
 	debugfs_remove(priv->mcg_dentry);
 	debugfs_remove(priv->path_dentry);
 	priv->mcg_dentry = priv->path_dentry = NULL;
