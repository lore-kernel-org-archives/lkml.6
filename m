Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B67EC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2129D214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789354;
	bh=1iERpigCWub/RARw5vFEopUscvgeaKEilCsr67Tphwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cl+9V1Gcl7GcZl53UlfJfJgrOtmEG6Bln5Vvlgn0vpJmLy2wO3JXZjMFG8O+tsLhE
	 EhUhVbcFtilRpmAE6AUDdz9FHVTGVpRAN+sAT/OjRVk5wnZR0p94tFqTbmwIJDCAkr
	 jXnRtnIcX26DPdau+ybCY6KFLvFXwpVx/MrzdwII=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2129D214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbeLNMJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731403AbeLNMJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 820522148E;
        Fri, 14 Dec 2018 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789349;
        bh=1iERpigCWub/RARw5vFEopUscvgeaKEilCsr67Tphwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOZCq+5wFum6HjnZ7GQQPsPwoKArH54X4/nABflcWD7Y75sCskWAkSUjiwdSOsWvu
         o0Nmsaf0/iPT+0H1rq30D4/PX4beu7fWbbruLAZo8vEtnS3117phreYy9YBnXaTXs5
         o9QRFr2P60SLEl5rRxq0bdb30t5qTe+zh57IJ6kA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kamal Heib <kamalheib1@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 40/89] RDMA/rdmavt: Fix rvt_create_ah function signature
Date:   Fri, 14 Dec 2018 12:59:53 +0100
Message-Id: <20181214115731.659863939@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ba3639a0d77c..48ea5b8207f0 100644
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
2.19.1



