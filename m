Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F361C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D8A21653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D8A21653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390091AbeHNUaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:30:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390039AbeHNUaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:05 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 613D4DDC;
        Tue, 14 Aug 2018 17:33:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 011/104] scsi: qla2xxx: Fix memory leak for allocating abort IOCB
Date:   Tue, 14 Aug 2018 19:16:25 +0200
Message-Id: <20180814171515.969434032@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
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

From: Quinn Tran <quinn.tran@cavium.com>

commit 5e53be8e476a3397ed5383c23376f299555a2b43 upstream.

In the case of IOCB QFull, Initiator code can leave behind a stale pointer
to an SRB structure on the outstanding command array.

Fixes: 82de802ad46e ("scsi: qla2xxx: Preparation for Target MQ.")
Cc: stable@vger.kernel.org #v4.16+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_iocb.c |   53 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2128,34 +2128,11 @@ __qla2x00_alloc_iocbs(struct qla_qpair *
 	req_cnt = 1;
 	handle = 0;
 
-	if (!sp)
-		goto skip_cmd_array;
-
-	/* Check for room in outstanding command list. */
-	handle = req->current_outstanding_cmd;
-	for (index = 1; index < req->num_outstanding_cmds; index++) {
-		handle++;
-		if (handle == req->num_outstanding_cmds)
-			handle = 1;
-		if (!req->outstanding_cmds[handle])
-			break;
-	}
-	if (index == req->num_outstanding_cmds) {
-		ql_log(ql_log_warn, vha, 0x700b,
-		    "No room on outstanding cmd array.\n");
-		goto queuing_error;
-	}
-
-	/* Prep command array. */
-	req->current_outstanding_cmd = handle;
-	req->outstanding_cmds[handle] = sp;
-	sp->handle = handle;
-
-	/* Adjust entry-counts as needed. */
-	if (sp->type != SRB_SCSI_CMD)
+	if (sp && (sp->type != SRB_SCSI_CMD)) {
+		/* Adjust entry-counts as needed. */
 		req_cnt = sp->iocbs;
+	}
 
-skip_cmd_array:
 	/* Check for room on request queue. */
 	if (req->cnt < req_cnt + 2) {
 		if (ha->mqenable || IS_QLA83XX(ha) || IS_QLA27XX(ha))
@@ -2179,6 +2156,28 @@ skip_cmd_array:
 	if (req->cnt < req_cnt + 2)
 		goto queuing_error;
 
+	if (sp) {
+		/* Check for room in outstanding command list. */
+		handle = req->current_outstanding_cmd;
+		for (index = 1; index < req->num_outstanding_cmds; index++) {
+			handle++;
+			if (handle == req->num_outstanding_cmds)
+				handle = 1;
+			if (!req->outstanding_cmds[handle])
+				break;
+		}
+		if (index == req->num_outstanding_cmds) {
+			ql_log(ql_log_warn, vha, 0x700b,
+			    "No room on outstanding cmd array.\n");
+			goto queuing_error;
+		}
+
+		/* Prep command array. */
+		req->current_outstanding_cmd = handle;
+		req->outstanding_cmds[handle] = sp;
+		sp->handle = handle;
+	}
+
 	/* Prep packet */
 	req->cnt -= req_cnt;
 	pkt = req->ring_ptr;
@@ -2191,6 +2190,8 @@ skip_cmd_array:
 		pkt->handle = handle;
 	}
 
+	return pkt;
+
 queuing_error:
 	qpair->tgt_counters.num_alloc_iocb_failed++;
 	return pkt;


