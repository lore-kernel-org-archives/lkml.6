Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B17C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC52D20856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7s54rwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC52D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeJYWrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbeJYWrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:43 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6EA420848;
        Thu, 25 Oct 2018 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476887;
        bh=P9Tkao/rsvV+zDGMQ5U319m4E04tkLDwAFz/EGubU4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R7s54rwjbSDmF9MvYyOXPQ7BKGCZU1yZAWdrybL+G5v6lkwRiZ0L4e/O7en4+5YDl
         8JSbjI4T3+UF9QpWYnYIl9Lf4be+ekmuT9fkvN/4fnBvfDP+zJ6QHkPo9R9XILbnKc
         HTV+cRnGDs9gcoBhAduhhSqtu+dnFtHD9VdujYq8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alaa Hleihel <alaa@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 14/98] IB/ipoib: Do not warn if IPoIB debugfs doesn't exist
Date:   Thu, 25 Oct 2018 10:12:59 -0400
Message-Id: <20181025141423.213774-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alaa Hleihel <alaa@mellanox.com>

[ Upstream commit 14fa91e0fef8e4d6feb8b1fa2a807828e0abe815 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_fs.c b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
index 09396bd7b02d..63be3bcdc0e3 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_fs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
@@ -281,8 +281,6 @@ void ipoib_delete_debug_files(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 
-	WARN_ONCE(!priv->mcg_dentry, "null mcg debug file\n");
-	WARN_ONCE(!priv->path_dentry, "null path debug file\n");
 	debugfs_remove(priv->mcg_dentry);
 	debugfs_remove(priv->path_dentry);
 	priv->mcg_dentry = priv->path_dentry = NULL;
-- 
2.17.1

