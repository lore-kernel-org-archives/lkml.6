Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96110C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CC92080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CC92080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbeKLGG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:06:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53250 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731987AbeKLGG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:06:26 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt9-0000oJ-8T; Sun, 11 Nov 2018 19:59:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001R1-DB; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Benjamin Block" <bblock@linux.ibm.com>,
        "Steffen Maier" <maier@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.859458@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 062/366] scsi: zfcp: fix misleading REC trigger trace
 where erp_action setup failed
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/scsi/zfcp_erp.c | 16 +++++++++++++++-
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
 	atomic_set_mask(ZFCP_STATUS_ADAPTER_ERP_PENDING, &adapter->status);
 	++adapter->erp_total_count;
 	list_add_tail(&act->list, &adapter->erp_ready_head);

