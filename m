Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BCCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C61A20830
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqk/HhFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C61A20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbeKAIIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbeKAIID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C6A20838;
        Wed, 31 Oct 2018 23:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027272;
        bh=LAYdO3kh8klMG9LaXI/ebBUW6eKVOAdcbRmWIL43C1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqk/HhFpXb7hswsKeZsFzJQEA+GxkqC2N5AEsdN1p974bP1fZPAsvom1n/Cx52WUR
         B/T63cXtuD8TtcteBn74lZ++RRmmJHI258teYgsLGlupQB2YawCGqnuTVFds+CSvcr
         WkvHaEHNGBfS5wEndK1V2jwX57M5XW1odXgqSua0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vijay Immanuel <vijayi@attalasystems.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 145/146] IB/rxe: fix for duplicate request processing and ack psns
Date:   Wed, 31 Oct 2018 19:05:40 -0400
Message-Id: <20181031230541.28822-145-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Immanuel <vijayi@attalasystems.com>

[ Upstream commit b97db58557f4aa6d9903f8e1deea6b3d1ed0ba43 ]

Don't reset the resp opcode for a replayed read response.
The resp opcode could be in the middle of a write or send
sequence, when the duplicate read request was received.
An example sequence is as follows:
- Receive read request for 12KB PSN 20. Transmit read response
  first, middle and last with PSNs 20,21,22.
- Receive write first PSN 23.
  At this point the resp psn is 24 and resp opcode is write first.
- The sender notices that PSN 20 is dropped and retransmits.
  Receive read request for 12KB PSN 20. Transmit read response
  first, middle and last with PSNs 20,21,22. The resp opcode is
  set to -1, the resp psn remains 24.
- Receive write first PSN 23. This is processed by duplicate_request().
  The resp opcode remains -1 and resp psn remains 24.
- Receive write middle PSN 24. check_op_seq() reports a missing
  first error since the resp opcode is -1.

When sending an ack for a duplicate send or write request,
use the psn of the previous ack sent. Do not use the psn
of a read response for the ack.
An example sequence is as follows:
- Receive write PSN 30. Transmit ACK for PSN 30.
- Receive read request 4KB PSN 31. Transmit read response with
  PSN 31. The resp psn is now 32.
- The sender notices that PSN 30 is dropped and retransmits.
  Receive write PSN 30. duplicate_request() sends an ACK with
  PSN 31. That is incorrect since PSN 31 was a read request.

Signed-off-by: Vijay Immanuel <vijayi@attalasystems.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_resp.c  | 8 ++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index aa5833318372..fc6c880756da 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -682,6 +682,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		rxe_advance_resp_resource(qp);
 
 		res->type		= RXE_READ_MASK;
+		res->replay		= 0;
 
 		res->read.va		= qp->resp.va;
 		res->read.va_org	= qp->resp.va;
@@ -752,7 +753,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		state = RESPST_DONE;
 	} else {
 		qp->resp.res = NULL;
-		qp->resp.opcode = -1;
+		if (!res->replay)
+			qp->resp.opcode = -1;
 		if (psn_compare(res->cur_psn, qp->resp.psn) >= 0)
 			qp->resp.psn = res->cur_psn;
 		state = RESPST_CLEANUP;
@@ -814,6 +816,7 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 
 	/* next expected psn, read handles this separately */
 	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
+	qp->resp.ack_psn = qp->resp.psn;
 
 	qp->resp.opcode = pkt->opcode;
 	qp->resp.status = IB_WC_SUCCESS;
@@ -1065,7 +1068,7 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 					  struct rxe_pkt_info *pkt)
 {
 	enum resp_states rc;
-	u32 prev_psn = (qp->resp.psn - 1) & BTH_PSN_MASK;
+	u32 prev_psn = (qp->resp.ack_psn - 1) & BTH_PSN_MASK;
 
 	if (pkt->mask & RXE_SEND_MASK ||
 	    pkt->mask & RXE_WRITE_MASK) {
@@ -1108,6 +1111,7 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 			res->state = (pkt->psn == res->first_psn) ?
 					rdatm_res_state_new :
 					rdatm_res_state_replay;
+			res->replay = 1;
 
 			/* Reset the resource, except length. */
 			res->read.va_org = iova;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index af1470d29391..332a16dad2a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -171,6 +171,7 @@ enum rdatm_res_state {
 
 struct resp_res {
 	int			type;
+	int			replay;
 	u32			first_psn;
 	u32			last_psn;
 	u32			cur_psn;
@@ -195,6 +196,7 @@ struct rxe_resp_info {
 	enum rxe_qp_state	state;
 	u32			msn;
 	u32			psn;
+	u32			ack_psn;
 	int			opcode;
 	int			drop_msg;
 	int			goto_error;
-- 
2.17.1

