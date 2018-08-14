Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FE0C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C843E21471
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C843E21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbeHNUeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:34:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390473AbeHNUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:34:19 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF226CAE;
        Tue, 14 Aug 2018 17:46:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.4 13/43] IB/core: Make testing MR flags for writability a static inline function
Date:   Tue, 14 Aug 2018 19:17:49 +0200
Message-Id: <20180814171517.962689861@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171517.014285600@linuxfoundation.org>
References: <20180814171517.014285600@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/umem.c |   11 +----------
 include/rdma/ib_verbs.h        |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -122,16 +122,7 @@ struct ib_umem *ib_umem_get(struct ib_uc
 	umem->address   = addr;
 	umem->page_size = PAGE_SIZE;
 	umem->pid       = get_task_pid(current, PIDTYPE_PID);
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
 		put_pid(umem->pid);
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3007,6 +3007,20 @@ static inline int ib_check_mr_access(int
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


