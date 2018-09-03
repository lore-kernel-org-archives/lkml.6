Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6694FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D75920779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D75920779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeICVMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:12:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36268 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeICVMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:12:06 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 16A09CEE;
        Mon,  3 Sep 2018 16:51:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 07/56] scsi: libiscsi: fix possible NULL pointer dereference in case of TMF
Date:   Mon,  3 Sep 2018 18:48:57 +0200
Message-Id: <20180903164924.449703849@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit a17037e7d59075053b522048742a08ac9500bde8 ]

In iscsi_check_tmf_restrictions() task->hdr is dereferenced to print the
opcode, it is possible that task->hdr is NULL.

There are two cases based on opcode argument:

1. ISCSI_OP_SCSI_CMD - In this case alloc_pdu() is called
after iscsi_check_tmf_restrictions()

iscsi_prep_scsi_cmd_pdu() -> iscsi_check_tmf_restrictions() -> alloc_pdu().

Transport drivers allocate memory for iSCSI hdr in alloc_pdu() and assign
it to task->hdr. In case of TMF task->hdr will be NULL resulting in NULL
pointer dereference.

2. ISCSI_OP_SCSI_DATA_OUT - In this case transport driver can free the
memory for iSCSI hdr after transmitting the pdu so task->hdr can be NULL or
invalid.

This patch fixes this issue by removing task->hdr->opcode from the printk
statement.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/libiscsi.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -283,11 +283,11 @@ static int iscsi_check_tmf_restrictions(
 		 */
 		if (opcode != ISCSI_OP_SCSI_DATA_OUT) {
 			iscsi_conn_printk(KERN_INFO, conn,
-					  "task [op %x/%x itt "
+					  "task [op %x itt "
 					  "0x%x/0x%x] "
 					  "rejected.\n",
-					  task->hdr->opcode, opcode,
-					  task->itt, task->hdr_itt);
+					  opcode, task->itt,
+					  task->hdr_itt);
 			return -EACCES;
 		}
 		/*
@@ -296,10 +296,10 @@ static int iscsi_check_tmf_restrictions(
 		 */
 		if (conn->session->fast_abort) {
 			iscsi_conn_printk(KERN_INFO, conn,
-					  "task [op %x/%x itt "
+					  "task [op %x itt "
 					  "0x%x/0x%x] fast abort.\n",
-					  task->hdr->opcode, opcode,
-					  task->itt, task->hdr_itt);
+					  opcode, task->itt,
+					  task->hdr_itt);
 			return -EACCES;
 		}
 		break;


