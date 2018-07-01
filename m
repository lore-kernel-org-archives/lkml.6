Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88515C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EACC250DE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EACC250DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964910AbeGAQR7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:17:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964888AbeGAQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:17:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 47C6949B;
        Sun,  1 Jul 2018 16:17:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 066/105] scsi: zfcp: fix misleading REC trigger trace where erp_action setup failed
Date:   Sun,  1 Jul 2018 18:02:16 +0200
Message-Id: <20180701153154.242388493@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
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

From: Steffen Maier <maier@linux.ibm.com>

commit 512857a795cbbda5980efa4cdb3c0b6602330408 upstream.

If a SCSI device is deleted during scsi_eh host reset, we cannot get a
reference to the SCSI device anymore since scsi_device_get returns !=0 by
design. Assuming the recovery of adapter and port(s) was successful,
zfcp_erp_strategy_followup_success() attempts to trigger a LUN reset for the
half-gone SCSI device. Unfortunately, it causes the following confusing
trace record which states that zfcp will do a LUN recovery as "ERP need" is
ZFCP_ERP_ACTION_REOPEN_LUN == 1 and equals "ERP want".

Old example trace record formatted with zfcpdbf from s390-tools:

Tag:           : ersfs_3 ERP, trigger, unit reopen, port reopen succeeded
LUN            : 0x<FCP_LUN>
WWPN           : 0x<WWPN>
D_ID           : 0x<N_Port-ID>
Adapter status : 0x5400050b
Port status    : 0x54000001
LUN status     : 0x40000000     ZFCP_STATUS_COMMON_RUNNING
                                but not ZFCP_STATUS_COMMON_UNBLOCKED as it
                                was closed on close part of adapter reopen
ERP want       : 0x01
ERP need       : 0x01           misleading

However, zfcp_erp_setup_act() returns NULL as it cannot get the reference.
Hence, zfcp_erp_action_enqueue() takes an early goto out and _NO_ recovery
actually happens.

We always do want the recovery trigger trace record even if no erp_action
could be enqueued as in this case. For other cases where we did not enqueue
an erp_action, 'need' has always been zero to indicate this. In order to
indicate above goto out, introduce an eyecatcher "flag" to mark the "ERP
need" as 'not needed' but still keep the information which erp_action type,
that zfcp_erp_required_act() had decided upon, is needed.  0xc_ is chosen to
be visibly different from 0x0_ in "ERP want".

New example trace record formatted with zfcpdbf from s390-tools:

Tag:           : ersfs_3 ERP, trigger, unit reopen, port reopen succeeded
LUN            : 0x<FCP_LUN>
WWPN           : 0x<WWPN>
D_ID           : 0x<N_Port-ID>
Adapter status : 0x5400050b
Port status    : 0x54000001
LUN status     : 0x40000000
ERP want       : 0x01
ERP need       : 0xc1           would need LUN ERP, but no action set up
                   ^

Before v2.6.38 commit ae0904f60fab ("[SCSI] zfcp: Redesign of the debug
tracing for recovery actions.") we could detect this case because the
"erp_action" field in the trace was NULL. The rework removed erp_action as
argument and field from the trace.

This patch here is for tracing. A fix to allow LUN recovery in the case at
hand is a topic for a separate patch.

See also commit fdbd1c5e27da ("[SCSI] zfcp: Allow running unit/LUN shutdown
without acquiring reference") for a similar case and background info.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: ae0904f60fab ("[SCSI] zfcp: Redesign of the debug tracing for recovery actions.")
Cc: <stable@vger.kernel.org> #2.6.38+
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/scsi/zfcp_erp.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -34,11 +34,23 @@ enum zfcp_erp_steps {
 	ZFCP_ERP_STEP_LUN_OPENING	= 0x2000,
 };
 
+/**
+ * enum zfcp_erp_act_type - Type of ERP action object.
+ * @ZFCP_ERP_ACTION_REOPEN_LUN: LUN recovery.
+ * @ZFCP_ERP_ACTION_REOPEN_PORT: Port recovery.
+ * @ZFCP_ERP_ACTION_REOPEN_PORT_FORCED: Forced port recovery.
+ * @ZFCP_ERP_ACTION_REOPEN_ADAPTER: Adapter recovery.
+ * @ZFCP_ERP_ACTION_NONE: Eyecatcher pseudo flag to bitwise or-combine with
+ *			  either of the other enum values.
+ *			  Used to indicate that an ERP action could not be
+ *			  set up despite a detected need for some recovery.
+ */
 enum zfcp_erp_act_type {
 	ZFCP_ERP_ACTION_REOPEN_LUN         = 1,
 	ZFCP_ERP_ACTION_REOPEN_PORT	   = 2,
 	ZFCP_ERP_ACTION_REOPEN_PORT_FORCED = 3,
 	ZFCP_ERP_ACTION_REOPEN_ADAPTER     = 4,
+	ZFCP_ERP_ACTION_NONE		   = 0xc0,
 };
 
 enum zfcp_erp_act_state {
@@ -256,8 +268,10 @@ static int zfcp_erp_action_enqueue(int w
 		goto out;
 
 	act = zfcp_erp_setup_act(need, act_status, adapter, port, sdev);
-	if (!act)
+	if (!act) {
+		need |= ZFCP_ERP_ACTION_NONE; /* marker for trace */
 		goto out;
+	}
 	atomic_or(ZFCP_STATUS_ADAPTER_ERP_PENDING, &adapter->status);
 	++adapter->erp_total_count;
 	list_add_tail(&act->list, &adapter->erp_ready_head);


