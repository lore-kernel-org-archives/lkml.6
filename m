Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28C5C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8326E20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x6zaQRQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8326E20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbeKIIBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729920AbeKIHmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:39 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D958920844;
        Thu,  8 Nov 2018 22:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714709;
        bh=FP3TBXnOhvI8T1AdM9Ak+R2URZWoCismJhDM5v6dYeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6zaQRQGlZy9P+/3+oIQg3LBqXPu+jIN993U7YXrM9GI3DP+uClabHlmb92qB5r9G
         jMpjF3H4WL7ceb3+T44P1OyPBP/Py3jmRKVslHgl9a4pRGWGUGT1DbeUDrSqxAlLq3
         VT4ant64FnZ9bJMurNw1ftoeuIakmIwMrAvdwVKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alaa Hleihel <alaa@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 045/171] IB/ipoib: Do not warn if IPoIB debugfs doesnt exist
Date:   Thu,  8 Nov 2018 13:50:15 -0800
Message-Id: <20181108215130.775099388@linuxfoundation.org>
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



