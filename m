Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqwhFLagsylXDUr/MdwukIPOw47ALt8Qf2Q6t5iWIyzwN0EbqJL4RP5begif5tz2o5EGOgi
ARC-Seal: i=1; a=rsa-sha256; t=1527155696; cv=none;
        d=google.com; s=arc-20160816;
        b=FfUw7lxHOHpSEll90gQ4lB4O6Ana2HKhUHrELttH+40c6uYtCz/lKXBZ4lEeytllbR
         PwBztiBpeVBTqRM7TDSwBciwUjyl5kyotOm9Oxih92Gisqp16vTAh2c0wdxXunMuZqCA
         zcu6Q1oEZOZXT0ID3WJ8s2BkaEopeNaUeH/jJ/H046iFZm2HozuRu3XLTA3wuo14qw37
         /jQDaCAfCEKngjir1/SnScnZM6TONKVuddIw++4dsJCKmmmBjI3nm0goi1QYmRlPijBk
         S/MOZMX5Js708NagNpudkBIKSn9ktmg/6oZHgY9WpileFOoxHmdyb6m2fu/ras875iqJ
         J0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Rv/FNk8XU8bw/dU24Kl4ok+X7xyA3g+Gn+LNK7gCNek=;
        b=s3ddwJjw8Rq0+vQKZ1+zK9niqoVI99J5gDRHH2kIXlcQ5Kjw2bsQnOSs3sjdjXKUgP
         qaIM2UsFPSMp8bMXnKoOMOkG8NwWHghx/gYWLNkrRI1CEE4Zt11o0HUk580B46D2qCfd
         28YKFFTCw7FoWf/COjn9/05pSKC+PmAAlPJVaPFetnSueLyfpdF34+wiiKE7q21ePq62
         SG+OR8LyY+c0zkb6L4ul21bg4nhuAYfsPwwE5pTCGuMXuqmZFiH+XhnIOfYmj8xgPaW8
         ShcoWm44H2sLxJjRyrGUHBEFotnp9RIGDvCGaXAiCvVi+WHiHtbZau7pYz3L6qZAzttX
         Kkrw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Em+WRpfO;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Em+WRpfO;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sebastian Ott <sebott@linux.ibm.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Benjamin Block <bblock@linux.vnet.ibm.com>,
	Steffen Maier <maier@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 048/165] scsi: zfcp: fix infinite iteration on ERP ready list
Date: Thu, 24 May 2018 11:37:34 +0200
Message-Id: <20180524093623.972682166@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338310664115267?=
X-GMAIL-MSGID: =?utf-8?q?1601338811994482783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org> # 2.6.32+
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/scsi/zfcp_dbf.c  |   23 ++++++++++++++++++++++-
 drivers/s390/scsi/zfcp_ext.h  |    5 ++++-
 drivers/s390/scsi/zfcp_scsi.c |   14 +++++++-------
 3 files changed, 33 insertions(+), 9 deletions(-)

--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -4,7 +4,7 @@
  *
  * Debug traces for zfcp.
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2018
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -308,6 +308,27 @@ void zfcp_dbf_rec_trig(char *tag, struct
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
@@ -4,7 +4,7 @@
  *
  * External function declarations.
  *
- * Copyright IBM Corp. 2002, 2016
+ * Copyright IBM Corp. 2002, 2018
  */
 
 #ifndef ZFCP_EXT_H
@@ -35,6 +35,9 @@ extern int zfcp_dbf_adapter_register(str
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
@@ -4,7 +4,7 @@
  *
  * Interface to Linux SCSI midlayer.
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2018
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -618,9 +618,9 @@ static void zfcp_scsi_rport_register(str
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
@@ -642,9 +642,9 @@ static void zfcp_scsi_rport_block(struct
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
