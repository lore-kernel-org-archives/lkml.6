Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD92EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7A72080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7A72080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeKLF4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52036 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727449AbeKLF4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:19 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt9-0000oM-96; Sun, 11 Nov 2018 19:59:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001R6-EM; Sun, 11 Nov 2018 19:58:33 +0000
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
Message-ID: <lsq.1541965745.957640843@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 063/366] scsi: zfcp: fix missing REC trigger trace on
 terminate_rport_io early return
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
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/scsi/zfcp_erp.c  | 20 ++++++++++++++++++++
 drivers/s390/scsi/zfcp_ext.h  |  3 +++
 drivers/s390/scsi/zfcp_scsi.c |  5 +++++
 3 files changed, 28 insertions(+)

--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -282,6 +282,26 @@ static int zfcp_erp_action_enqueue(int w
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
@@ -624,6 +624,11 @@ static void zfcp_scsi_terminate_rport_io
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
 

