Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54604C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1964A25755
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1964A25755
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbeGARrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:47:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030820AbeGAQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:33:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4B10AA6;
        Sun,  1 Jul 2018 16:33:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 100/157] scsi: zfcp: fix missing REC trigger trace on terminate_rport_io early return
Date:   Sun,  1 Jul 2018 18:22:52 +0200
Message-Id: <20180701160857.547469330@linuxfoundation.org>
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

commit 96d9270499471545048ed8a6d7f425a49762283d upstream.

get_device() and its internally used kobject_get() only return NULL if they
get passed NULL as argument. zfcp_get_port_by_wwpn() loops over
adapter->port_list so the iteration variable port is always non-NULL.
Struct device is embedded in struct zfcp_port so &port->dev is always
non-NULL. This is the argument to get_device().  However, if we get an
fc_rport in terminate_rport_io() for which we cannot find a match within
zfcp_get_port_by_wwpn(), the latter can return NULL.  v2.6.30 commit
70932935b61e ("[SCSI] zfcp: Fix oops when port disappears") introduced an
early return without adding a trace record for this case.  Even if we don't
need recovery in this case, for debugging we should still see that our
callback was invoked originally by scsi_transport_fc.

Example trace record formatted with zfcpdbf from s390-tools:

Timestamp      : ...
Area           : REC
Subarea        : 00
Level          : 1
Exception      : -
CPU ID         : ..
Caller         : 0x...
Record ID      : 1
Tag            : sctrpin        SCSI terminate rport I/O, no zfcp port
LUN            : 0xffffffffffffffff                     none (invalid)
WWPN           : 0x<wwpn>               WWPN
D_ID           : 0x<n_port_id>          N_Port-ID
Adapter status : 0x...
Port status    : 0xffffffff             unknown (-1)
LUN status     : 0x00000000                             none (invalid)
Ready count    : 0x...
Running count  : 0x...
ERP want       : 0x03                   ZFCP_ERP_ACTION_REOPEN_PORT_FORCED
ERP need       : 0xc0                   ZFCP_ERP_ACTION_NONE

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: 70932935b61e ("[SCSI] zfcp: Fix oops when port disappears")
Cc: <stable@vger.kernel.org> #2.6.38+
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/scsi/zfcp_erp.c  |   20 ++++++++++++++++++++
 drivers/s390/scsi/zfcp_ext.h  |    3 +++
 drivers/s390/scsi/zfcp_scsi.c |    5 +++++
 3 files changed, 28 insertions(+)

--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -283,6 +283,26 @@ static int zfcp_erp_action_enqueue(int w
 	return retval;
 }
 
+void zfcp_erp_port_forced_no_port_dbf(char *id, struct zfcp_adapter *adapter,
+				      u64 port_name, u32 port_id)
+{
+	unsigned long flags;
+	static /* don't waste stack */ struct zfcp_port tmpport;
+
+	write_lock_irqsave(&adapter->erp_lock, flags);
+	/* Stand-in zfcp port with fields just good enough for
+	 * zfcp_dbf_rec_trig() and zfcp_dbf_set_common().
+	 * Under lock because tmpport is static.
+	 */
+	atomic_set(&tmpport.status, -1); /* unknown */
+	tmpport.wwpn = port_name;
+	tmpport.d_id = port_id;
+	zfcp_dbf_rec_trig(id, adapter, &tmpport, NULL,
+			  ZFCP_ERP_ACTION_REOPEN_PORT_FORCED,
+			  ZFCP_ERP_ACTION_NONE);
+	write_unlock_irqrestore(&adapter->erp_lock, flags);
+}
+
 static int _zfcp_erp_adapter_reopen(struct zfcp_adapter *adapter,
 				    int clear_mask, char *id)
 {
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -58,6 +58,9 @@ extern void zfcp_dbf_scsi_eh(char *tag,
 /* zfcp_erp.c */
 extern void zfcp_erp_set_adapter_status(struct zfcp_adapter *, u32);
 extern void zfcp_erp_clear_adapter_status(struct zfcp_adapter *, u32);
+extern void zfcp_erp_port_forced_no_port_dbf(char *id,
+					     struct zfcp_adapter *adapter,
+					     u64 port_name, u32 port_id);
 extern void zfcp_erp_adapter_reopen(struct zfcp_adapter *, int, char *);
 extern void zfcp_erp_adapter_shutdown(struct zfcp_adapter *, int, char *);
 extern void zfcp_erp_set_port_status(struct zfcp_port *, u32);
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -605,6 +605,11 @@ static void zfcp_scsi_terminate_rport_io
 	if (port) {
 		zfcp_erp_port_forced_reopen(port, 0, "sctrpi1");
 		put_device(&port->dev);
+	} else {
+		zfcp_erp_port_forced_no_port_dbf(
+			"sctrpin", adapter,
+			rport->port_name /* zfcp_scsi_rport_register */,
+			rport->port_id /* zfcp_scsi_rport_register */);
 	}
 }
 


