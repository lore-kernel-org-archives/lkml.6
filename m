Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE69C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B5A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV529bDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B5A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeLEJjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:39:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbeLEJjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:39:11 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D594820850;
        Wed,  5 Dec 2018 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002750;
        bh=TbzAYYo8B/spgYCCSI1sRGMA5kUbpPAqWm80fdLenIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qV529bDfzHu8eWIe9SzAqgm5hssc3CWzHp6AZFm2/ljctqwSWMJA0T1LZLdbSMa2B
         8Be1Xeg/m3Mdtzqganf1PB+AL+bs2kUE2CtKwoJBLAPxbKgxK0dM14EA54O8GnLhW2
         j2ogrQRZF3LpKMbckgJBMg+jsob9uhjCJFMs1fiM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kamal Heib <kamalheib1@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 057/123] RDMA/rdmavt: Fix rvt_create_ah function signature
Date:   Wed,  5 Dec 2018 04:34:49 -0500
Message-Id: <20181205093555.5386-57-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kamal Heib <kamalheib1@gmail.com>

[ Upstream commit 4f32fb921b153ae9ea280e02a3e91509fffc03d3 ]

rdmavt uses a crazy system that looses the type checking when assinging
functions to struct ib_device function pointers. Because of this the
signature to this function was not changed when the below commit revised
things.

Fix the signature so we are not calling a function pointer with a
mismatched signature.

Fixes: 477864c8fcd9 ("IB/core: Let create_ah return extended response to user")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rdmavt/ah.c | 4 +++-
 drivers/infiniband/sw/rdmavt/ah.h | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/ah.c b/drivers/infiniband/sw/rdmavt/ah.c
index 89ec0f64abfc..084bb4baebb5 100644
--- a/drivers/infiniband/sw/rdmavt/ah.c
+++ b/drivers/infiniband/sw/rdmavt/ah.c
@@ -91,13 +91,15 @@ EXPORT_SYMBOL(rvt_check_ah);
  * rvt_create_ah - create an address handle
  * @pd: the protection domain
  * @ah_attr: the attributes of the AH
+ * @udata: pointer to user's input output buffer information.
  *
  * This may be called from interrupt context.
  *
  * Return: newly allocated ah
  */
 struct ib_ah *rvt_create_ah(struct ib_pd *pd,
-			    struct rdma_ah_attr *ah_attr)
+			    struct rdma_ah_attr *ah_attr,
+			    struct ib_udata *udata)
 {
 	struct rvt_ah *ah;
 	struct rvt_dev_info *dev = ib_to_rvt(pd->device);
diff --git a/drivers/infiniband/sw/rdmavt/ah.h b/drivers/infiniband/sw/rdmavt/ah.h
index 16105af99189..25271b48a683 100644
--- a/drivers/infiniband/sw/rdmavt/ah.h
+++ b/drivers/infiniband/sw/rdmavt/ah.h
@@ -51,7 +51,8 @@
 #include <rdma/rdma_vt.h>
 
 struct ib_ah *rvt_create_ah(struct ib_pd *pd,
-			    struct rdma_ah_attr *ah_attr);
+			    struct rdma_ah_attr *ah_attr,
+			    struct ib_udata *udata);
 int rvt_destroy_ah(struct ib_ah *ibah);
 int rvt_modify_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr);
 int rvt_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr);
-- 
2.17.1

