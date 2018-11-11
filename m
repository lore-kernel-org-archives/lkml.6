Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C08FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698AD2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698AD2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbeKLFyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:54:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51694 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbeKLFyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:54:03 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtA-0000oU-60; Sun, 11 Nov 2018 19:59:20 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001Qw-Bz; Sun, 11 Nov 2018 19:58:33 +0000
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
Message-ID: <lsq.1541965745.879694944@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 061/366] scsi: zfcp: fix missing SCSI trace for retry
 of abort / scsi_eh TMF
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

commit 81979ae63e872ef650a7197f6ce6590059d37172 upstream.

We already have a SCSI trace for the end of abort and scsi_eh TMF. Due to
zfcp_erp_wait() and fc_block_scsi_eh() time can pass between the start of
our eh callback and an actual send/recv of an abort / TMF request.  In order
to see the temporal sequence including any abort / TMF send retries, add a
trace before the above two blocking functions.  This supports problem
determination with scsi_eh and parallel zfcp ERP.

No need to explicitly trace the beginning of our eh callback, since we
typically can send an abort / TMF and see its HBA response (in the worst
case, it's a pseudo response on dismiss all of adapter recovery, e.g. due to
an FSF request timeout [fsrth_1] of the abort / TMF). If we cannot send, we
now get a trace record for the first "abrt_wt" or "[lt]r_wait" which denotes
almost the beginning of the callback.

No need to explicitly trace the wakeup after the above two blocking
functions because the next retry loop causes another trace in any case and
that is sufficient.

Example trace records formatted with zfcpdbf from s390-tools:

Timestamp      : ...
Area           : SCSI
Subarea        : 00
Level          : 1
Exception      : -
CPU ID         : ..
Caller         : 0x...
Record ID      : 1
Tag            : abrt_wt        abort, before zfcp_erp_wait()
Request ID     : 0x0000000000000000                     none (invalid)
SCSI ID        : 0x<scsi_id>
SCSI LUN       : 0x<scsi_lun>
SCSI LUN high  : 0x<scsi_lun_high>
SCSI result    : 0x<scsi_result_of_cmd_to_be_aborted>
SCSI retries   : 0x<retries_of_cmd_to_be_aborted>
SCSI allowed   : 0x<allowed_retries_of_cmd_to_be_aborted>
SCSI scribble  : 0x<req_id_of_cmd_to_be_aborted>
SCSI opcode    : <CDB_of_cmd_to_be_aborted>
FCP rsp inf cod: 0x..                                   none (invalid)
FCP rsp IU     : ...                                    none (invalid)

Timestamp      : ...
Area           : SCSI
Subarea        : 00
Level          : 1
Exception      : -
CPU ID         : ..
Caller         : 0x...
Record ID      : 1
Tag            : lr_wait        LUN reset, before zfcp_erp_wait()
Request ID     : 0x0000000000000000                     none (invalid)
SCSI ID        : 0x<scsi_id>
SCSI LUN       : 0x<scsi_lun>
SCSI LUN high  : 0x<scsi_lun_high>
SCSI result    : 0x...                                  unrelated
SCSI retries   : 0x..                                   unrelated
SCSI allowed   : 0x..                                   unrelated
SCSI scribble  : 0x...                                  unrelated
SCSI opcode    : ...                                    unrelated
FCP rsp inf cod: 0x..                                   none (invalid)
FCP rsp IU     : ...                                    none (invalid)

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: 63caf367e1c9 ("[SCSI] zfcp: Improve reliability of SCSI eh handlers in zfcp")
Fixes: af4de36d911a ("[SCSI] zfcp: Block scsi_eh thread for rport state BLOCKED")
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/scsi/zfcp_scsi.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -201,6 +201,7 @@ static int zfcp_scsi_eh_abort_handler(st
 		if (abrt_req)
 			break;
 
+		zfcp_dbf_scsi_abort("abrt_wt", scpnt, NULL);
 		zfcp_erp_wait(adapter);
 		ret = fc_block_scsi_eh(scpnt);
 		if (ret) {
@@ -297,6 +298,7 @@ static int zfcp_task_mgmt_function(struc
 		if (fsf_req)
 			break;
 
+		zfcp_dbf_scsi_devreset("wait", scpnt, tm_flags, NULL);
 		zfcp_erp_wait(adapter);
 		ret = fc_block_scsi_eh(scpnt);
 		if (ret) {

