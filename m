Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4144AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0651F2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0651F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbeKLF4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52092 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbeKLF4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:41 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt9-0000oF-9k; Sun, 11 Nov 2018 19:59:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001RG-H0; Sun, 11 Nov 2018 19:58:33 +0000
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
Message-ID: <lsq.1541965745.33184321@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 065/366] scsi: zfcp: fix missing REC trigger trace
 for all objects in ERP_FAILED
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

commit 8c3d20aada70042a39c6a6625be037c1472ca610 upstream.

That other commit introduced an inconsistency because it would trace on
ERP_FAILED for all callers of port forced reopen triggers (not just
terminate_rport_io), but it would not trace on ERP_FAILED for all callers of
other ERP triggers such as adapter, port regular, LUN.

Therefore, generalize that other commit. zfcp_erp_action_enqueue() already
had two early outs which re-used the one zfcp_dbf_rec_trig() call.  All ERP
trigger functions finally run through zfcp_erp_action_enqueue().  So move
the special handling for ZFCP_STATUS_COMMON_ERP_FAILED into
zfcp_erp_action_enqueue() and add another early out with new trace marker
for pseudo ERP need in this case. This removes all early returns from all
ERP trigger functions so we always end up at zfcp_dbf_rec_trig().

Example trace record formatted with zfcpdbf from s390-tools:

Timestamp      : ...
Area           : REC
Subarea        : 00
Level          : 1
Exception      : -
CPU ID         : ..
Caller         : 0x...
Record ID      : 1                      ZFCP_DBF_REC_TRIG
Tag            : .......
LUN            : 0x...
WWPN           : 0x...
D_ID           : 0x...
Adapter status : 0x...
Port status    : 0x...
LUN status     : 0x...
Ready count    : 0x...
Running count  : 0x...
ERP want       : 0x0.                   ZFCP_ERP_ACTION_REOPEN_...
ERP need       : 0xe0                   ZFCP_ERP_ACTION_FAILED

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/scsi/zfcp_erp.c | 79 +++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 28 deletions(-)

--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -142,6 +142,49 @@ static void zfcp_erp_action_dismiss_adap
 	}
 }
 
+static int zfcp_erp_handle_failed(int want, struct zfcp_adapter *adapter,
+				  struct zfcp_port *port,
+				  struct scsi_device *sdev)
+{
+	int need = want;
+	struct zfcp_scsi_dev *zsdev;
+
+	switch (want) {
+	case ZFCP_ERP_ACTION_REOPEN_LUN:
+		zsdev = sdev_to_zfcp(sdev);
+		if (atomic_read(&zsdev->status) & ZFCP_STATUS_COMMON_ERP_FAILED)
+			need = 0;
+		break;
+	case ZFCP_ERP_ACTION_REOPEN_PORT_FORCED:
+		if (atomic_read(&port->status) & ZFCP_STATUS_COMMON_ERP_FAILED)
+			need = 0;
+		break;
+	case ZFCP_ERP_ACTION_REOPEN_PORT:
+		if (atomic_read(&port->status) &
+		    ZFCP_STATUS_COMMON_ERP_FAILED) {
+			need = 0;
+			/* ensure propagation of failed status to new devices */
+			zfcp_erp_set_port_status(
+				port, ZFCP_STATUS_COMMON_ERP_FAILED);
+		}
+		break;
+	case ZFCP_ERP_ACTION_REOPEN_ADAPTER:
+		if (atomic_read(&adapter->status) &
+		    ZFCP_STATUS_COMMON_ERP_FAILED) {
+			need = 0;
+			/* ensure propagation of failed status to new devices */
+			zfcp_erp_set_adapter_status(
+				adapter, ZFCP_STATUS_COMMON_ERP_FAILED);
+		}
+		break;
+	default:
+		need = 0;
+		break;
+	}
+
+	return need;
+}
+
 static int zfcp_erp_required_act(int want, struct zfcp_adapter *adapter,
 				 struct zfcp_port *port,
 				 struct scsi_device *sdev)
@@ -265,6 +308,12 @@ static int zfcp_erp_action_enqueue(int w
 	int retval = 1, need;
 	struct zfcp_erp_action *act;
 
+	need = zfcp_erp_handle_failed(want, adapter, port, sdev);
+	if (!need) {
+		need = ZFCP_ERP_ACTION_FAILED; /* marker for trace */
+		goto out;
+	}
+
 	if (!adapter->erp_thread)
 		return -EIO;
 
@@ -313,12 +362,6 @@ static int _zfcp_erp_adapter_reopen(stru
 	zfcp_erp_adapter_block(adapter, clear_mask);
 	zfcp_scsi_schedule_rports_block(adapter);
 
-	/* ensure propagation of failed status to new devices */
-	if (atomic_read(&adapter->status) & ZFCP_STATUS_COMMON_ERP_FAILED) {
-		zfcp_erp_set_adapter_status(adapter,
-					    ZFCP_STATUS_COMMON_ERP_FAILED);
-		return -EIO;
-	}
 	return zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_ADAPTER,
 				       adapter, NULL, NULL, id, 0);
 }
@@ -337,12 +380,8 @@ void zfcp_erp_adapter_reopen(struct zfcp
 	zfcp_scsi_schedule_rports_block(adapter);
 
 	write_lock_irqsave(&adapter->erp_lock, flags);
-	if (atomic_read(&adapter->status) & ZFCP_STATUS_COMMON_ERP_FAILED)
-		zfcp_erp_set_adapter_status(adapter,
-					    ZFCP_STATUS_COMMON_ERP_FAILED);
-	else
-		zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_ADAPTER, adapter,
-					NULL, NULL, id, 0);
+	zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_ADAPTER, adapter,
+				NULL, NULL, id, 0);
 	write_unlock_irqrestore(&adapter->erp_lock, flags);
 }
 
@@ -383,13 +422,6 @@ static void _zfcp_erp_port_forced_reopen
 	zfcp_erp_port_block(port, clear);
 	zfcp_scsi_schedule_rport_block(port);
 
-	if (atomic_read(&port->status) & ZFCP_STATUS_COMMON_ERP_FAILED) {
-		zfcp_dbf_rec_trig(id, port->adapter, port, NULL,
-				  ZFCP_ERP_ACTION_REOPEN_PORT_FORCED,
-				  ZFCP_ERP_ACTION_FAILED);
-		return;
-	}
-
 	zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_PORT_FORCED,
 				port->adapter, port, NULL, id, 0);
 }
@@ -415,12 +447,6 @@ static int _zfcp_erp_port_reopen(struct
 	zfcp_erp_port_block(port, clear);
 	zfcp_scsi_schedule_rport_block(port);
 
-	if (atomic_read(&port->status) & ZFCP_STATUS_COMMON_ERP_FAILED) {
-		/* ensure propagation of failed status to new devices */
-		zfcp_erp_set_port_status(port, ZFCP_STATUS_COMMON_ERP_FAILED);
-		return -EIO;
-	}
-
 	return zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_PORT,
 				       port->adapter, port, NULL, id, 0);
 }
@@ -460,9 +486,6 @@ static void _zfcp_erp_lun_reopen(struct
 
 	zfcp_erp_lun_block(sdev, clear);
 
-	if (atomic_read(&zfcp_sdev->status) & ZFCP_STATUS_COMMON_ERP_FAILED)
-		return;
-
 	zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_LUN, adapter,
 				zfcp_sdev->port, sdev, id, act_status);
 }

