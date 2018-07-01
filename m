Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D124BC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8993D2574D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8993D2574D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbeGARrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:47:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35454 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030822AbeGAQdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:33:46 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5C06349B;
        Sun,  1 Jul 2018 16:33:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 101/157] scsi: zfcp: fix missing REC trigger trace on terminate_rport_io for ERP_FAILED
Date:   Sun,  1 Jul 2018 18:22:53 +0200
Message-Id: <20180701160857.598889898@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
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
Cc: <stable@vger.kernel.org> #2.6.38+
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/scsi/zfcp_erp.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -42,9 +42,13 @@ enum zfcp_erp_steps {
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
@@ -52,6 +56,7 @@ enum zfcp_erp_act_type {
 	ZFCP_ERP_ACTION_REOPEN_PORT_FORCED = 3,
 	ZFCP_ERP_ACTION_REOPEN_ADAPTER     = 4,
 	ZFCP_ERP_ACTION_NONE		   = 0xc0,
+	ZFCP_ERP_ACTION_FAILED		   = 0xe0,
 };
 
 enum zfcp_erp_act_state {
@@ -379,8 +384,12 @@ static void _zfcp_erp_port_forced_reopen
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


