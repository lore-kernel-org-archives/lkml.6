Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC5CC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3482084A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3482084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030623AbeGARxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:53:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965769AbeGAQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:31:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A01749B;
        Sun,  1 Jul 2018 16:31:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH 4.14 062/157] IB/core: Make testing MR flags for writability a static inline function
Date:   Sun,  1 Jul 2018 18:22:14 +0200
Message-Id: <20180701160855.722992272@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

commit 08bb558ac11ab944e0539e78619d7b4c356278bd upstream.

Make the MR writability flags check, which is performed in umem.c,
a static inline function in file ib_verbs.h

This allows the function to be used by low-level infiniband drivers.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/umem.c |   11 +----------
 include/rdma/ib_verbs.h        |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -119,16 +119,7 @@ struct ib_umem *ib_umem_get(struct ib_uc
 	umem->length     = size;
 	umem->address    = addr;
 	umem->page_shift = PAGE_SHIFT;
-	/*
-	 * We ask for writable memory if any of the following
-	 * access flags are set.  "Local write" and "remote write"
-	 * obviously require write access.  "Remote atomic" can do
-	 * things like fetch and add, which will modify memory, and
-	 * "MW bind" can change permissions by binding a window.
-	 */
-	umem->writable  = !!(access &
-		(IB_ACCESS_LOCAL_WRITE   | IB_ACCESS_REMOTE_WRITE |
-		 IB_ACCESS_REMOTE_ATOMIC | IB_ACCESS_MW_BIND));
+	umem->writable   = ib_access_writable(access);
 
 	if (access & IB_ACCESS_ON_DEMAND) {
 		ret = ib_umem_odp_get(context, umem, access);
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3558,6 +3558,20 @@ static inline int ib_check_mr_access(int
 	return 0;
 }
 
+static inline bool ib_access_writable(int access_flags)
+{
+	/*
+	 * We have writable memory backing the MR if any of the following
+	 * access flags are set.  "Local write" and "remote write" obviously
+	 * require write access.  "Remote atomic" can do things like fetch and
+	 * add, which will modify memory, and "MW bind" can change permissions
+	 * by binding a window.
+	 */
+	return access_flags &
+		(IB_ACCESS_LOCAL_WRITE   | IB_ACCESS_REMOTE_WRITE |
+		 IB_ACCESS_REMOTE_ATOMIC | IB_ACCESS_MW_BIND);
+}
+
 /**
  * ib_check_mr_status: lightweight check of MR status.
  *     This routine may provide status checks on a selected


