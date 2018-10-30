Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5346DC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C3220870
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd9MxhU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C3220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeJ3WUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeJ3WUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:20:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940B82075D;
        Tue, 30 Oct 2018 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906029;
        bh=rMT0/y60u8AtevcrEZIg2nK88xmSIGhihC/lLrnhstk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wd9MxhU2Nz9GdtLCMzmkZFOfzrNu0UFAEDOk/UPx9fyTlirHxuszOSyR2b5i+XYpU
         wvEhjvYj4GfrXV7bnek/VtSuN7ZpL60tbs9wWlMumeSbE1UbBXpCGMvdx2vhhmHqLD
         C0P90vHtdCBY71DvmrQYEbKCj4QFnwdRlQ0nFpTo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 03/33] nvme: remove ns sibling before clearing path
Date:   Tue, 30 Oct 2018 09:26:27 -0400
Message-Id: <20181030132657.217970-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit 48f78be3326052a7718678ff9a78d6d884a50323 ]

The code had been clearing a namespace being deleted as the current
path while that namespace was still in the path siblings list. It is
possible a new IO could set that namespace back to the current path
since it appeared to be an eligable path to select, which may result in
a use-after-free error.

This patch ensures a namespace being removed is not eligable to be reset
as a current path prior to clearing it as the current path.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bf65501e6ed6..f1f375fb362b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3119,8 +3119,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	}
 
 	mutex_lock(&ns->ctrl->subsys->lock);
-	nvme_mpath_clear_current_path(ns);
 	list_del_rcu(&ns->siblings);
+	nvme_mpath_clear_current_path(ns);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	down_write(&ns->ctrl->namespaces_rwsem);
-- 
2.17.1

