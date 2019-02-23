Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9FEC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EC220861
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956260;
	bh=ZiLNHYdKaWKniVRwm1jKv8+0hrFtyngNgBaIgF/DuNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bGtKACSjziiTxzTmdU84WKVniYjCYatQmqqijwhkGgThgsMWU240x7FLxDBE4//lG
	 qro17MN6YTmwBok8JNQUGqAqycuxLgqeB70XhA7ZVAXlTt4CQqKqtQruAKGk0Su6Zh
	 pa9r4b4hAvBlHuPWRK7AF4qCgPnUUuP/jw2pH2wQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfBWVK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:10:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbfBWVK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:10:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA4E2085A;
        Sat, 23 Feb 2019 21:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956255;
        bh=ZiLNHYdKaWKniVRwm1jKv8+0hrFtyngNgBaIgF/DuNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Upc/1MXzc1ViavM1InogqKh8JxCosFCMRMjggqWlRz4KthPhSVoHtJWfFMfggDdIR
         9kW3NpJPU4yHPEI6B3r/SQNhsw1hqI+Sz5pRZXwwQOINZ8yX4ENVcZno5pv0TxLQzV
         lMJlnPVLA/SCMMIZ36sxpHXT01i064QgxbXaJslo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Welty <brian.welty@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.4 04/26] IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM
Date:   Sat, 23 Feb 2019 16:10:25 -0500
Message-Id: <20190223211047.202725-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211047.202725-1-sashal@kernel.org>
References: <20190223211047.202725-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Welty <brian.welty@intel.com>

[ Upstream commit 904bba211acc2112fdf866e5a2bc6cd9ecd0de1b ]

The work completion length for a receiving a UD send with immediate is
short by 4 bytes causing application using this opcode to fail.

The UD receive logic incorrectly subtracts 4 bytes for immediate
value. These bytes are already included in header length and are used to
calculate header/payload split, so the result is these 4 bytes are
subtracted twice, once when the header length subtracted from the overall
length and once again in the UD opcode specific path.

Remove the extra subtraction when handling the opcode.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Brian Welty <brian.welty@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/qib/qib_ud.c | 1 -
 drivers/staging/rdma/hfi1/ud.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_ud.c b/drivers/infiniband/hw/qib/qib_ud.c
index 59193f67ea787..56bd59bc08b54 100644
--- a/drivers/infiniband/hw/qib/qib_ud.c
+++ b/drivers/infiniband/hw/qib/qib_ud.c
@@ -515,7 +515,6 @@ void qib_ud_rcv(struct qib_ibport *ibp, struct qib_ib_header *hdr,
 	    opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
 		wc.ex.imm_data = ohdr->u.ud.imm_data;
 		wc.wc_flags = IB_WC_WITH_IMM;
-		tlen -= sizeof(u32);
 	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
 		wc.ex.imm_data = 0;
 		wc.wc_flags = 0;
diff --git a/drivers/staging/rdma/hfi1/ud.c b/drivers/staging/rdma/hfi1/ud.c
index 5a9c784bec04c..a88e37444be0e 100644
--- a/drivers/staging/rdma/hfi1/ud.c
+++ b/drivers/staging/rdma/hfi1/ud.c
@@ -793,7 +793,6 @@ void hfi1_ud_rcv(struct hfi1_packet *packet)
 	    opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
 		wc.ex.imm_data = ohdr->u.ud.imm_data;
 		wc.wc_flags = IB_WC_WITH_IMM;
-		tlen -= sizeof(u32);
 	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
 		wc.ex.imm_data = 0;
 		wc.wc_flags = 0;
-- 
2.19.1

