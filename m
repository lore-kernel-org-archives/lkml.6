Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC18C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531C52080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531C52080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbeKLGCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:02:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52640 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbeKLGCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:02:21 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtA-0000lK-6Y; Sun, 11 Nov 2018 19:59:20 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001Qr-Aj; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Benjamin Block" <bblock@linux.ibm.com>,
        "Steffen Maier" <maier@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Jens Remus" <jremus@linux.ibm.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.439407987@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 060/366] scsi: zfcp: fix missing SCSI trace for
 result of eh_host_reset_handler
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

commit df30781699f53e4fd4c494c6f7dd16e3d5c21d30 upstream.

For problem determination we need to see whether and why we were successful
or not. This allows deduction of scsi_eh escalation.

Example trace record formatted with zfcpdbf from s390-tools:

Timestamp      : ...
Area           : SCSI
Subarea        : 00
Level          : 1
Exception      : -
CPU ID         : ..
Caller         : 0x...
Record ID      : 1
Tag            : schrh_r        SCSI host reset handler result
Request ID     : 0x0000000000000000                     none (invalid)
SCSI ID        : 0xffffffff                             none (invalid)
SCSI LUN       : 0xffffffff                             none (invalid)
SCSI LUN high  : 0xffffffff                             none (invalid)
SCSI result    : 0x00002002     field re-used for midlayer value: SUCCESS
                                or in other cases: 0x2009 == FAST_IO_FAIL
SCSI retries   : 0xff                                   none (invalid)
SCSI allowed   : 0xff                                   none (invalid)
SCSI scribble  : 0xffffffffffffffff                     none (invalid)
SCSI opcode    : ffffffff ffffffff ffffffff ffffffff    none (invalid)
FCP rsp inf cod: 0xff                                   none (invalid)
FCP rsp IU     : 00000000 00000000 00000000 00000000    none (invalid)
                 00000000 00000000

v2.6.35 commit a1dbfddd02d2 ("[SCSI] zfcp: Pass return code from
fc_block_scsi_eh to scsi eh") introduced the first return with something
other than the previously hardcoded single SUCCESS return path.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: a1dbfddd02d2 ("[SCSI] zfcp: Pass return code from fc_block_scsi_eh to scsi eh")
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.16: Drop assignment to zfcp_dbf_scsi::scsi_lun_64_hi
 which doesn't exist here]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -624,6 +624,45 @@ void zfcp_dbf_scsi(char *tag, int level,
 	spin_unlock_irqrestore(&dbf->scsi_lock, flags);
 }
 
+/**
+ * zfcp_dbf_scsi_eh() - Trace event for special cases of scsi_eh callbacks.
+ * @tag: Identifier for event.
+ * @adapter: Pointer to zfcp adapter as context for this event.
+ * @scsi_id: SCSI ID/target to indicate scope of task management function (TMF).
+ * @ret: Return value of calling function.
+ *
+ * This SCSI trace variant does not depend on any of:
+ * scsi_cmnd, zfcp_fsf_req, scsi_device.
+ */
+void zfcp_dbf_scsi_eh(char *tag, struct zfcp_adapter *adapter,
+		      unsigned int scsi_id, int ret)
+{
+	struct zfcp_dbf *dbf = adapter->dbf;
+	struct zfcp_dbf_scsi *rec = &dbf->scsi_buf;
+	unsigned long flags;
+	static int const level = 1;
+
+	if (unlikely(!debug_level_enabled(adapter->dbf->scsi, level)))
+		return;
+
+	spin_lock_irqsave(&dbf->scsi_lock, flags);
+	memset(rec, 0, sizeof(*rec));
+
+	memcpy(rec->tag, tag, ZFCP_DBF_TAG_LEN);
+	rec->id = ZFCP_DBF_SCSI_CMND;
+	rec->scsi_result = ret; /* re-use field, int is 4 bytes and fits */
+	rec->scsi_retries = ~0;
+	rec->scsi_allowed = ~0;
+	rec->fcp_rsp_info = ~0;
+	rec->scsi_id = scsi_id;
+	rec->scsi_lun = (u32)ZFCP_DBF_INVALID_LUN;
+	rec->host_scribble = ~0;
+	memset(rec->scsi_opcode, 0xff, ZFCP_DBF_SCSI_OPCODE);
+
+	debug_event(dbf->scsi, level, rec, sizeof(*rec));
+	spin_unlock_irqrestore(&dbf->scsi_lock, flags);
+}
+
 static debug_info_t *zfcp_dbf_reg(const char *name, int size, int rec_size)
 {
 	struct debug_info *d;
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -52,6 +52,8 @@ extern void zfcp_dbf_san_res(char *, str
 extern void zfcp_dbf_san_in_els(char *, struct zfcp_fsf_req *);
 extern void zfcp_dbf_scsi(char *, int, struct scsi_cmnd *,
 			  struct zfcp_fsf_req *);
+extern void zfcp_dbf_scsi_eh(char *tag, struct zfcp_adapter *adapter,
+			     unsigned int scsi_id, int ret);
 
 /* zfcp_erp.c */
 extern void zfcp_erp_set_adapter_status(struct zfcp_adapter *, u32);
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -343,15 +343,16 @@ static int zfcp_scsi_eh_host_reset_handl
 {
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(scpnt->device);
 	struct zfcp_adapter *adapter = zfcp_sdev->port->adapter;
-	int ret;
+	int ret = SUCCESS, fc_ret;
 
 	zfcp_erp_adapter_reopen(adapter, 0, "schrh_1");
 	zfcp_erp_wait(adapter);
-	ret = fc_block_scsi_eh(scpnt);
-	if (ret)
-		return ret;
+	fc_ret = fc_block_scsi_eh(scpnt);
+	if (fc_ret)
+		ret = fc_ret;
 
-	return SUCCESS;
+	zfcp_dbf_scsi_eh("schrh_r", adapter, ~0, ret);
+	return ret;
 }
 
 struct scsi_transport_template *zfcp_scsi_transport_template;

