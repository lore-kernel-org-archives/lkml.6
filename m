Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD7C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD76320645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD76320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeJNXWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:22:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36242 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728089AbeJNXMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:02 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLp-0004io-To; Sun, 14 Oct 2018 16:30:42 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000XT-Je; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jens Remus" <jremus@linux.ibm.com>,
        "Steffen Maier" <maier@linux.ibm.com>,
        "Sebastian Ott" <sebott@linux.ibm.com>,
        "Benjamin Block" <bblock@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.886385861@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 267/366] scsi: zfcp: fix infinite iteration on ERP
 ready list
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Remus <jremus@linux.ibm.com>

commit fa89adba1941e4f3b213399b81732a5c12fd9131 upstream.

zfcp_erp_adapter_reopen() schedules blocking of all of the adapter's
rports via zfcp_scsi_schedule_rports_block() and enqueues a reopen
adapter ERP action via zfcp_erp_action_enqueue(). Both are separately
processed asynchronously and concurrently.

Blocking of rports is done in a kworker by zfcp_scsi_rport_work(). It
calls zfcp_scsi_rport_block(), which then traces a DBF REC "scpdely" via
zfcp_dbf_rec_trig().  zfcp_dbf_rec_trig() acquires the DBF REC spin lock
and then iterates with list_for_each() over the adapter's ERP ready list
without holding the ERP lock. This opens a race window in which the
current list entry can be moved to another list, causing list_for_each()
to iterate forever on the wrong list, as the erp_ready_head is never
encountered as terminal condition.

Meanwhile the ERP action can be processed in the ERP thread by
zfcp_erp_thread(). It calls zfcp_erp_strategy(), which acquires the ERP
lock and then calls zfcp_erp_action_to_running() to move the ERP action
from the ready to the running list.  zfcp_erp_action_to_running() can
move the ERP action using list_move() just during the aforementioned
race window. It then traces a REC RUN "erator1" via zfcp_dbf_rec_run().
zfcp_dbf_rec_run() tries to acquire the DBF REC spin lock. If this is
held by the infinitely looping kworker, it effectively spins forever.

Example Sequence Diagram:

Process                ERP Thread             rport_work
-------------------    -------------------    -------------------
zfcp_erp_adapter_reopen()
zfcp_erp_adapter_block()
zfcp_scsi_schedule_rports_block()
lock ERP                                      zfcp_scsi_rport_work()
zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_ADAPTER)
list_add_tail() on ready                      !(rport_task==RPORT_ADD)
wake_up() ERP thread                          zfcp_scsi_rport_block()
zfcp_dbf_rec_trig()    zfcp_erp_strategy()    zfcp_dbf_rec_trig()
unlock ERP                                    lock DBF REC
zfcp_erp_wait()        lock ERP
|                      zfcp_erp_action_to_running()
|                                             list_for_each() ready
|                      list_move()              current entry
|                        ready to running
|                      zfcp_dbf_rec_run()       endless loop over running
|                      zfcp_dbf_rec_run_lvl()
|                      lock DBF REC spins forever

Any adapter recovery can trigger this, such as setting the device offline
or reboot.

V4.9 commit 4eeaa4f3f1d6 ("zfcp: close window with unblocked rport
during rport gone") introduced additional tracing of (un)blocking of
rports. It missed that the adapter->erp_lock must be held when calling
zfcp_dbf_rec_trig().

This fix uses the approach formerly introduced by commit aa0fec62391c
("[SCSI] zfcp: Fix sparse warning by providing new entry in dbf") that got
later removed by commit ae0904f60fab ("[SCSI] zfcp: Redesign of the debug
tracing for recovery actions.").

Introduce zfcp_dbf_rec_trig_lock(), a wrapper for zfcp_dbf_rec_trig() that
acquires and releases the adapter->erp_lock for read.

Reported-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Fixes: 4eeaa4f3f1d6 ("zfcp: close window with unblocked rport during rport gone")
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/scsi/zfcp_dbf.c  | 23 ++++++++++++++++++++++-
 drivers/s390/scsi/zfcp_ext.h  |  5 ++++-
 drivers/s390/scsi/zfcp_scsi.c | 14 +++++++-------
 3 files changed, 33 insertions(+), 9 deletions(-)

--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -3,7 +3,7 @@
  *
  * Debug traces for zfcp.
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2018
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -287,6 +287,27 @@ void zfcp_dbf_rec_trig(char *tag, struct
 	spin_unlock_irqrestore(&dbf->rec_lock, flags);
 }
 
+/**
+ * zfcp_dbf_rec_trig_lock - trace event related to triggered recovery with lock
+ * @tag: identifier for event
+ * @adapter: adapter on which the erp_action should run
+ * @port: remote port involved in the erp_action
+ * @sdev: scsi device involved in the erp_action
+ * @want: wanted erp_action
+ * @need: required erp_action
+ *
+ * The adapter->erp_lock must not be held.
+ */
+void zfcp_dbf_rec_trig_lock(char *tag, struct zfcp_adapter *adapter,
+			    struct zfcp_port *port, struct scsi_device *sdev,
+			    u8 want, u8 need)
+{
+	unsigned long flags;
+
+	read_lock_irqsave(&adapter->erp_lock, flags);
+	zfcp_dbf_rec_trig(tag, adapter, port, sdev, want, need);
+	read_unlock_irqrestore(&adapter->erp_lock, flags);
+}
 
 /**
  * zfcp_dbf_rec_run_lvl - trace event related to running recovery
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -3,7 +3,7 @@
  *
  * External function declarations.
  *
- * Copyright IBM Corp. 2002, 2016
+ * Copyright IBM Corp. 2002, 2018
  */
 
 #ifndef ZFCP_EXT_H
@@ -34,6 +34,9 @@ extern int zfcp_dbf_adapter_register(str
 extern void zfcp_dbf_adapter_unregister(struct zfcp_adapter *);
 extern void zfcp_dbf_rec_trig(char *, struct zfcp_adapter *,
 			      struct zfcp_port *, struct scsi_device *, u8, u8);
+extern void zfcp_dbf_rec_trig_lock(char *tag, struct zfcp_adapter *adapter,
+				   struct zfcp_port *port,
+				   struct scsi_device *sdev, u8 want, u8 need);
 extern void zfcp_dbf_rec_run(char *, struct zfcp_erp_action *);
 extern void zfcp_dbf_rec_run_lvl(int level, char *tag,
 				 struct zfcp_erp_action *erp);
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -3,7 +3,7 @@
  *
  * Interface to Linux SCSI midlayer.
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2018
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -637,9 +637,9 @@ static void zfcp_scsi_rport_register(str
 	ids.port_id = port->d_id;
 	ids.roles = FC_RPORT_ROLE_FCP_TARGET;
 
-	zfcp_dbf_rec_trig("scpaddy", port->adapter, port, NULL,
-			  ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD,
-			  ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD);
+	zfcp_dbf_rec_trig_lock("scpaddy", port->adapter, port, NULL,
+			       ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD,
+			       ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD);
 	rport = fc_remote_port_add(port->adapter->scsi_host, 0, &ids);
 	if (!rport) {
 		dev_err(&port->adapter->ccw_device->dev,
@@ -661,9 +661,9 @@ static void zfcp_scsi_rport_block(struct
 	struct fc_rport *rport = port->rport;
 
 	if (rport) {
-		zfcp_dbf_rec_trig("scpdely", port->adapter, port, NULL,
-				  ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL,
-				  ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL);
+		zfcp_dbf_rec_trig_lock("scpdely", port->adapter, port, NULL,
+				       ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL,
+				       ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL);
 		fc_remote_port_delete(rport);
 		port->rport = NULL;
 	}

