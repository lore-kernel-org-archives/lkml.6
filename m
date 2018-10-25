Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4CFECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C920620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDtx+6nA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C920620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeJYWuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbeJYWtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:40 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A287220848;
        Thu, 25 Oct 2018 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477003;
        bh=Wx16khg9vWFJw5gOXMnjXIOcAA6NliSgr6NNk1I2nFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDtx+6nAlEH9qa0czL6ykxSaVrOkgDW98sJ4o8Rp1XjWQzs0BhFUCMCLVw9Zo0ivz
         t0Dc4pVAAMLaoA3MGTDX5Vpn0Ckb1njII5mqAp7vjNZLcefkH9BdAaZLlvWICoMP7f
         FClh/DHT1+pL6D8J+a1d648Rhc8mqhW00P172doU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 95/98] IB/mlx4: Fix an error handling path in 'mlx4_ib_rereg_user_mr()'
Date:   Thu, 25 Oct 2018 10:14:20 -0400
Message-Id: <20181025141423.213774-95-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

[ Upstream commit 3dc7c7badb7502ec3e3aa817a8bdd9e53aa54c52 ]

Before returning -EPERM we should release some resources, as already done
in the other error handling path of the function.

Fixes: d8f9cc328c88 ("IB/mlx4: Mark user MR as writable if actual virtual memory is writable")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/mr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 0d4878efd643..ddd3182138ac 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -247,8 +247,11 @@ int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags,
 	}
 
 	if (flags & IB_MR_REREG_ACCESS) {
-		if (ib_access_writable(mr_access_flags) && !mmr->umem->writable)
-			return -EPERM;
+		if (ib_access_writable(mr_access_flags) &&
+		    !mmr->umem->writable) {
+			err = -EPERM;
+			goto release_mpt_entry;
+		}
 
 		err = mlx4_mr_hw_change_access(dev->dev, *pmpt_entry,
 					       convert_access(mr_access_flags));
-- 
2.17.1

