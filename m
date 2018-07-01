Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AC4C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C0F253E4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C0F253E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032318AbeGAQnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:43:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37744 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031992AbeGAQm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:42:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF828A73;
        Sun,  1 Jul 2018 16:42:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 139/220] scsi: zfcp: fix missing SCSI trace for retry of abort / scsi_eh TMF
Date:   Sun,  1 Jul 2018 18:22:43 +0200
Message-Id: <20180701160914.113105578@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org> #2.6.38+
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/scsi/zfcp_scsi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -181,6 +181,7 @@ static int zfcp_scsi_eh_abort_handler(st
 		if (abrt_req)
 			break;
 
+		zfcp_dbf_scsi_abort("abrt_wt", scpnt, NULL);
 		zfcp_erp_wait(adapter);
 		ret = fc_block_scsi_eh(scpnt);
 		if (ret) {
@@ -277,6 +278,7 @@ static int zfcp_task_mgmt_function(struc
 		if (fsf_req)
 			break;
 
+		zfcp_dbf_scsi_devreset("wait", scpnt, tm_flags, NULL);
 		zfcp_erp_wait(adapter);
 		ret = fc_block_scsi_eh(scpnt);
 		if (ret) {


