Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B855C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19DC21723
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19DC21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeHOBWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:22:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:29445 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbeHOBWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:22:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 15:33:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,240,1531810800"; 
   d="scan'208";a="254137267"
Received: from sethhowe-desk.ch.intel.com ([143.182.136.105])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2018 15:33:25 -0700
From:   Seth Howell <seth.howell@intel.com>
Cc:     benjamin.walker@intel.com, Seth Howell <seth.howell@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Date:   Tue, 14 Aug 2018 15:33:02 -0700
Message-Id: <20180814223303.83556-1-seth.howell@intel.com>
X-Mailer: git-send-email 2.14.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By making this enum accessible to the userspace API, we can avoid
conflicts between the kernel-space ib_wr_opcode and the user-space
ibv_wr_opcode enums.

When using the rxe software driver interface between kernel and user
space, the enum value IBV_WR_SEND_WITH_INV was being improperly
translated to IB_WR_READ_WITH_INV causing the userspace application to
fail.

Signed-off-by: Seth Howell <seth.howell@intel.com>
---
 include/rdma/ib_verbs.h           | 31 -------------------------------
 include/uapi/rdma/ib_user_verbs.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6c003995347a..02fe3960378d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1295,37 +1295,6 @@ struct ib_qp_attr {
 	u32			rate_limit;
 };
 
-enum ib_wr_opcode {
-	IB_WR_RDMA_WRITE,
-	IB_WR_RDMA_WRITE_WITH_IMM,
-	IB_WR_SEND,
-	IB_WR_SEND_WITH_IMM,
-	IB_WR_RDMA_READ,
-	IB_WR_ATOMIC_CMP_AND_SWP,
-	IB_WR_ATOMIC_FETCH_AND_ADD,
-	IB_WR_LSO,
-	IB_WR_SEND_WITH_INV,
-	IB_WR_RDMA_READ_WITH_INV,
-	IB_WR_LOCAL_INV,
-	IB_WR_REG_MR,
-	IB_WR_MASKED_ATOMIC_CMP_AND_SWP,
-	IB_WR_MASKED_ATOMIC_FETCH_AND_ADD,
-	IB_WR_REG_SIG_MR,
-	/* reserve values for low level drivers' internal use.
-	 * These values will not be used at all in the ib core layer.
-	 */
-	IB_WR_RESERVED1 = 0xf0,
-	IB_WR_RESERVED2,
-	IB_WR_RESERVED3,
-	IB_WR_RESERVED4,
-	IB_WR_RESERVED5,
-	IB_WR_RESERVED6,
-	IB_WR_RESERVED7,
-	IB_WR_RESERVED8,
-	IB_WR_RESERVED9,
-	IB_WR_RESERVED10,
-};
-
 enum ib_send_flags {
 	IB_SEND_FENCE		= 1,
 	IB_SEND_SIGNALED	= (1<<1),
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 4f9991de8e3a..7c1132f953d8 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -46,6 +46,37 @@
 #define IB_USER_VERBS_ABI_VERSION	6
 #define IB_USER_VERBS_CMD_THRESHOLD    50
 
+enum ib_wr_opcode {
+	IB_WR_RDMA_WRITE,
+	IB_WR_RDMA_WRITE_WITH_IMM,
+	IB_WR_SEND,
+	IB_WR_SEND_WITH_IMM,
+	IB_WR_RDMA_READ,
+	IB_WR_ATOMIC_CMP_AND_SWP,
+	IB_WR_ATOMIC_FETCH_AND_ADD,
+	IB_WR_LSO,
+	IB_WR_SEND_WITH_INV,
+	IB_WR_RDMA_READ_WITH_INV,
+	IB_WR_LOCAL_INV,
+	IB_WR_REG_MR,
+	IB_WR_MASKED_ATOMIC_CMP_AND_SWP,
+	IB_WR_MASKED_ATOMIC_FETCH_AND_ADD,
+	IB_WR_REG_SIG_MR,
+	/* reserve values for low level drivers' internal use.
+	 * These values will not be used at all in the ib core layer.
+	 */
+	IB_WR_RESERVED1 = 0xf0,
+	IB_WR_RESERVED2,
+	IB_WR_RESERVED3,
+	IB_WR_RESERVED4,
+	IB_WR_RESERVED5,
+	IB_WR_RESERVED6,
+	IB_WR_RESERVED7,
+	IB_WR_RESERVED8,
+	IB_WR_RESERVED9,
+	IB_WR_RESERVED10,
+};
+
 enum {
 	IB_USER_VERBS_CMD_GET_CONTEXT,
 	IB_USER_VERBS_CMD_QUERY_DEVICE,
-- 
2.14.4

