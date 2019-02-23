Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C4CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969BA20652
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957282;
	bh=gWks6RVfohzOKn9BKvJIVNc57liJQe/g/KNLGqshh+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wNiMKIt0+QgTkAHoND4fbmtJZpxF8wh6zI0jvK08Qu/4uWG4+LmaTl9QOHzX8NeZT
	 BVTPFWwst1wcQ9ZCtgh0l8w2+4wtB+w7TFS0tsFwRJkMnEPix5PdSy3ng76Oj9P26I
	 A0WytJKYuvR01gWPQVUfkNH/o5oI63jBJI5eagbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfBWV1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:27:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbfBWVGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:06:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3396C2085A;
        Sat, 23 Feb 2019 21:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956014;
        bh=gWks6RVfohzOKn9BKvJIVNc57liJQe/g/KNLGqshh+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2lsm+worXP2WJiqdDsfsrEc4ZJLMRzQluRhrMtVzhgSvBUk51YlsuMRtGrO6/hCo
         pY8TUoul8/O5i2Wh68Pjdf9VVH5D7GMt/wgk1mycpilyHJC5pcwM6HaEp+++TM+FWr
         1bjs2kH8yuULGLCJCrTXhGVbG/8tYtCNjeuI7piM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Welty <brian.welty@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/65] IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM
Date:   Sat, 23 Feb 2019 16:05:45 -0500
Message-Id: <20190223210640.200911-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
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
 drivers/infiniband/hw/hfi1/ud.c    | 1 -
 drivers/infiniband/hw/qib/qib_ud.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ud.c b/drivers/infiniband/hw/hfi1/ud.c
index 70d39fc450a1e..54eb695642649 100644
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -980,7 +980,6 @@ void hfi1_ud_rcv(struct hfi1_packet *packet)
 	    opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
 		wc.ex.imm_data = packet->ohdr->u.ud.imm_data;
 		wc.wc_flags = IB_WC_WITH_IMM;
-		tlen -= sizeof(u32);
 	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
 		wc.ex.imm_data = 0;
 		wc.wc_flags = 0;
diff --git a/drivers/infiniband/hw/qib/qib_ud.c b/drivers/infiniband/hw/qib/qib_ud.c
index f8d029a2390ff..bce2b5cd3c7b7 100644
--- a/drivers/infiniband/hw/qib/qib_ud.c
+++ b/drivers/infiniband/hw/qib/qib_ud.c
@@ -513,7 +513,6 @@ void qib_ud_rcv(struct qib_ibport *ibp, struct ib_header *hdr,
 	    opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
 		wc.ex.imm_data = ohdr->u.ud.imm_data;
 		wc.wc_flags = IB_WC_WITH_IMM;
-		tlen -= sizeof(u32);
 	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
 		wc.ex.imm_data = 0;
 		wc.wc_flags = 0;
-- 
2.19.1

