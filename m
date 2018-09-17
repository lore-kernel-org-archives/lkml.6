Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B700ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDDE214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDDE214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbeIREpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:45:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51464 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732623AbeIREpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:45:15 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7F176C49;
        Mon, 17 Sep 2018 23:15:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 152/158] RDMA/hns: Update the data type of immediate data
Date:   Tue, 18 Sep 2018 00:43:02 +0200
Message-Id: <20180917211718.112177435@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lijun Ou <oulijun@huawei.com>

[ Upstream commit 0c4a0e2987a51415de73180ce9f389a99b3dddd1 ]

Because the data structure of hip08 is little endian, it needs to fix the
immediate field of wqe and cqe into __le32.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |   12 ++++++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |    6 +++---
 2 files changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -273,7 +273,8 @@ static int hns_roce_v2_post_send(struct
 			switch (wr->opcode) {
 			case IB_WR_SEND_WITH_IMM:
 			case IB_WR_RDMA_WRITE_WITH_IMM:
-				ud_sq_wqe->immtdata = wr->ex.imm_data;
+				ud_sq_wqe->immtdata =
+				      cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
 				break;
 			default:
 				ud_sq_wqe->immtdata = 0;
@@ -371,7 +372,8 @@ static int hns_roce_v2_post_send(struct
 			switch (wr->opcode) {
 			case IB_WR_SEND_WITH_IMM:
 			case IB_WR_RDMA_WRITE_WITH_IMM:
-				rc_sq_wqe->immtdata = wr->ex.imm_data;
+				rc_sq_wqe->immtdata =
+				      cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
 				break;
 			case IB_WR_SEND_WITH_INV:
 				rc_sq_wqe->inv_key =
@@ -1931,7 +1933,8 @@ static int hns_roce_v2_poll_one(struct h
 		case HNS_ROCE_V2_OPCODE_RDMA_WRITE_IMM:
 			wc->opcode = IB_WC_RECV_RDMA_WITH_IMM;
 			wc->wc_flags = IB_WC_WITH_IMM;
-			wc->ex.imm_data = cqe->immtdata;
+			wc->ex.imm_data =
+				cpu_to_be32(le32_to_cpu(cqe->immtdata));
 			break;
 		case HNS_ROCE_V2_OPCODE_SEND:
 			wc->opcode = IB_WC_RECV;
@@ -1940,7 +1943,8 @@ static int hns_roce_v2_poll_one(struct h
 		case HNS_ROCE_V2_OPCODE_SEND_WITH_IMM:
 			wc->opcode = IB_WC_RECV;
 			wc->wc_flags = IB_WC_WITH_IMM;
-			wc->ex.imm_data = cqe->immtdata;
+			wc->ex.imm_data =
+				cpu_to_be32(le32_to_cpu(cqe->immtdata));
 			break;
 		case HNS_ROCE_V2_OPCODE_SEND_WITH_INV:
 			wc->opcode = IB_WC_RECV;
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -768,7 +768,7 @@ struct hns_roce_v2_cqe {
 	__le32	byte_4;
 	union {
 		__le32 rkey;
-		__be32 immtdata;
+		__le32 immtdata;
 	};
 	__le32	byte_12;
 	__le32	byte_16;
@@ -926,7 +926,7 @@ struct hns_roce_v2_cq_db {
 struct hns_roce_v2_ud_send_wqe {
 	__le32	byte_4;
 	__le32	msg_len;
-	__be32	immtdata;
+	__le32	immtdata;
 	__le32	byte_16;
 	__le32	byte_20;
 	__le32	byte_24;
@@ -1012,7 +1012,7 @@ struct hns_roce_v2_rc_send_wqe {
 	__le32		msg_len;
 	union {
 		__le32  inv_key;
-		__be32  immtdata;
+		__le32  immtdata;
 	};
 	__le32		byte_16;
 	__le32		byte_20;


