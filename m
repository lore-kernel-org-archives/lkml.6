Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05288C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF39B2151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF39B2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbeHGVKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:10:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbeHGVKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:10:54 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A69E2D07;
        Tue,  7 Aug 2018 18:55:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anil Gurumurthy <anil.gurumurthy@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 02/17] scsi: qla2xxx: Return error when TMF returns
Date:   Tue,  7 Aug 2018 20:51:38 +0200
Message-Id: <20180807172342.257482285@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172342.071526922@linuxfoundation.org>
References: <20180807172342.071526922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anil Gurumurthy <anil.gurumurthy@cavium.com>

commit b4146c4929ef61d5afca011474d59d0918a0cd82 upstream.

Propagate the task management completion status properly to avoid
unnecessary waits for commands to complete.

Fixes: faef62d13463 ("[SCSI] qla2xxx: Fix Task Management command asynchronous handling")
Cc: <stable@vger.kernel.org>
Signed-off-by: Anil Gurumurthy <anil.gurumurthy@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -329,11 +329,10 @@ qla2x00_async_tm_cmd(fc_port_t *fcport,
 
 	wait_for_completion(&tm_iocb->u.tmf.comp);
 
-	rval = tm_iocb->u.tmf.comp_status == CS_COMPLETE ?
-	    QLA_SUCCESS : QLA_FUNCTION_FAILED;
+	rval = tm_iocb->u.tmf.data;
 
-	if ((rval != QLA_SUCCESS) || tm_iocb->u.tmf.data) {
-		ql_dbg(ql_dbg_taskm, vha, 0x8030,
+	if (rval != QLA_SUCCESS) {
+		ql_log(ql_log_warn, vha, 0x8030,
 		    "TM IOCB failed (%x).\n", rval);
 	}
 


