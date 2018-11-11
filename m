Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56426C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205BB21582
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSB2nFCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205BB21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390835AbeKLIWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403841AbeKLIWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:46 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4E1022353;
        Sun, 11 Nov 2018 22:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975568;
        bh=6w4aKS/s/TBeLRIrE+1322nL9/ny+ZOt3sEU/d16VaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSB2nFCZ8IzdSGaLIHF8VbmBlKLluA5qhF78RkGZI/z5iatfBsSISzBVZmpsLymLZ
         zMRNWoMK444kc2pgbG32X/hyQSiSjF4lTm3hpzbupO+3oTw5KXPbhppaLPk/Ml1IDh
         rVQ5jCRTSiUYVLg0YkJgqHT+T0rYfnRcjIlz7OW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vijay Immanuel <vijayi@attalasystems.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 107/222] IB/rxe: fix for duplicate request processing and ack psns
Date:   Sun, 11 Nov 2018 14:23:24 -0800
Message-Id: <20181111221657.411739735@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rxe/rxe_resp.c  |    8 ++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |    2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -683,6 +683,7 @@ static enum resp_states read_reply(struc
 		rxe_advance_resp_resource(qp);
 
 		res->type		= RXE_READ_MASK;
+		res->replay		= 0;
 
 		res->read.va		= qp->resp.va;
 		res->read.va_org	= qp->resp.va;
@@ -753,7 +754,8 @@ static enum resp_states read_reply(struc
 		state = RESPST_DONE;
 	} else {
 		qp->resp.res = NULL;
-		qp->resp.opcode = -1;
+		if (!res->replay)
+			qp->resp.opcode = -1;
 		if (psn_compare(res->cur_psn, qp->resp.psn) >= 0)
 			qp->resp.psn = res->cur_psn;
 		state = RESPST_CLEANUP;
@@ -815,6 +817,7 @@ static enum resp_states execute(struct r
 
 	/* next expected psn, read handles this separately */
 	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
+	qp->resp.ack_psn = qp->resp.psn;
 
 	qp->resp.opcode = pkt->opcode;
 	qp->resp.status = IB_WC_SUCCESS;
@@ -1071,7 +1074,7 @@ static enum resp_states duplicate_reques
 					  struct rxe_pkt_info *pkt)
 {
 	enum resp_states rc;
-	u32 prev_psn = (qp->resp.psn - 1) & BTH_PSN_MASK;
+	u32 prev_psn = (qp->resp.ack_psn - 1) & BTH_PSN_MASK;
 
 	if (pkt->mask & RXE_SEND_MASK ||
 	    pkt->mask & RXE_WRITE_MASK) {
@@ -1114,6 +1117,7 @@ static enum resp_states duplicate_reques
 			res->state = (pkt->psn == res->first_psn) ?
 					rdatm_res_state_new :
 					rdatm_res_state_replay;
+			res->replay = 1;
 
 			/* Reset the resource, except length. */
 			res->read.va_org = iova;
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -173,6 +173,7 @@ enum rdatm_res_state {
 
 struct resp_res {
 	int			type;
+	int			replay;
 	u32			first_psn;
 	u32			last_psn;
 	u32			cur_psn;
@@ -197,6 +198,7 @@ struct rxe_resp_info {
 	enum rxe_qp_state	state;
 	u32			msn;
 	u32			psn;
+	u32			ack_psn;
 	int			opcode;
 	int			drop_msg;
 	int			goto_error;


