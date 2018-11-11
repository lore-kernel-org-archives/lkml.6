Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BB5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10DA2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10DA2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbeKLGEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:04:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52866 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726816AbeKLGEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:04:01 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt9-0000oN-8c; Sun, 11 Nov 2018 19:59:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001RB-Fc; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Steffen Maier" <maier@linux.ibm.com>,
        "Benjamin Block" <bblock@linux.ibm.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.439872654@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 064/366] scsi: zfcp: fix missing REC trigger trace on
 terminate_rport_io for ERP_FAILED
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

commit d70aab55924b44f213fec2b900b095430b33eec6 upstream.

For problem determination we always want to see when we were invoked on the
terminate_rport_io callback whether we perform something or not.

Temporal event sequence of interest with a long fast_io_fail_tmo of 27 sec:

loose remote port

t   workqueue
[s] zfcp_q_<dev>       IRQ                 zfcperp<dev>

=== ================== =================== ============================

  0                    recv RSCN
                       q p.test_link_work
    block rport
     start fast_io_fail_tmo
    send ADISC ELS
  4                    recv ADISC fail
                       block zfcp_port
                                           port forced reopen
                                           send open port
 12                    recv open port fail
                                           q p.gid_pn_work
                                           zfcp_erp_wakeup
                                           (zfcp_erp_wait would return)
    GID_PN fail

Before this point, we got a SCSI trace with tag "sctrpi1" on fast_io_fail,
e.g. with the typical 5 sec setting.

    port.status |= ERP_FAILED

If fast_io_fail_tmo triggers after this point, we missed a SCSI trace.

    workqueue
    fc_dl_<host>
    ==================
 27 fc_timeout_fail_rport_io
    fc_terminate_rport_io
    zfcp_scsi_terminate_rport_io
    zfcp_erp_port_forced_reopen
    _zfcp_erp_port_forced_reopen
     if (port.status & ERP_FAILED)
      return;

Therefore, write a trace before above early return.

Example trace record formatted with zfcpdbf from s390-tools:

Timestamp      : ...
Area           : REC
Subarea        : 00
Level          : 1
Exception      : -
CPU ID         : ..
Caller         : 0x...
Record ID      : 1                      ZFCP_DBF_REC_TRIG
Tag            : sctrpi1                SCSI terminate rport I/O
LUN            : 0xffffffffffffffff                     none (invalid)
WWPN           : 0x<wwpn>
D_ID           : 0x<n_port_id>
Adapter status : 0x...
Port status    : 0x...
LUN status     : 0x00000000                             none (invalid)
Ready count    : 0x...
Running count  : 0x...
ERP want       : 0x03                   ZFCP_ERP_ACTION_REOPEN_PORT_FORCED
ERP need       : 0xe0                   ZFCP_ERP_ACTION_FAILED

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/scsi/zfcp_erp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -41,9 +41,13 @@ enum zfcp_erp_steps {
  * @ZFCP_ERP_ACTION_REOPEN_PORT_FORCED: Forced port recovery.
  * @ZFCP_ERP_ACTION_REOPEN_ADAPTER: Adapter recovery.
  * @ZFCP_ERP_ACTION_NONE: Eyecatcher pseudo flag to bitwise or-combine with
- *			  either of the other enum values.
+ *			  either of the first four enum values.
  *			  Used to indicate that an ERP action could not be
  *			  set up despite a detected need for some recovery.
+ * @ZFCP_ERP_ACTION_FAILED: Eyecatcher pseudo flag to bitwise or-combine with
+ *			    either of the first four enum values.
+ *			    Used to indicate that ERP not needed because
+ *			    the object has ZFCP_STATUS_COMMON_ERP_FAILED.
  */
 enum zfcp_erp_act_type {
 	ZFCP_ERP_ACTION_REOPEN_LUN         = 1,
@@ -51,6 +55,7 @@ enum zfcp_erp_act_type {
 	ZFCP_ERP_ACTION_REOPEN_PORT_FORCED = 3,
 	ZFCP_ERP_ACTION_REOPEN_ADAPTER     = 4,
 	ZFCP_ERP_ACTION_NONE		   = 0xc0,
+	ZFCP_ERP_ACTION_FAILED		   = 0xe0,
 };
 
 enum zfcp_erp_act_state {
@@ -378,8 +383,12 @@ static void _zfcp_erp_port_forced_reopen
 	zfcp_erp_port_block(port, clear);
 	zfcp_scsi_schedule_rport_block(port);
 
-	if (atomic_read(&port->status) & ZFCP_STATUS_COMMON_ERP_FAILED)
+	if (atomic_read(&port->status) & ZFCP_STATUS_COMMON_ERP_FAILED) {
+		zfcp_dbf_rec_trig(id, port->adapter, port, NULL,
+				  ZFCP_ERP_ACTION_REOPEN_PORT_FORCED,
+				  ZFCP_ERP_ACTION_FAILED);
 		return;
+	}
 
 	zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_PORT_FORCED,
 				port->adapter, port, NULL, id, 0);

