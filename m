Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11297C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC8C208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC8C208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbeHWM3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:29:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55456 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbeHWM3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:29:18 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E0376CBB;
        Thu, 23 Aug 2018 09:00:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manish Rangankar <manish.rangankar@qlogic.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 236/324] scsi: qedi: Send driver state to MFW
Date:   Thu, 23 Aug 2018 09:55:02 +0200
Message-Id: <20180823075007.933618613@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Manish Rangankar <manish.rangankar@cavium.com>

[ Upstream commit a3440d0d2f57f7ba102fc332086961cf261180af ]

In case of iSCSI offload BFS environment, MFW requires to mark virtual
link based upon qedi load status.

Signed-off-by: Manish Rangankar <manish.rangankar@qlogic.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qedi/qedi_main.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2075,6 +2075,7 @@ kset_free:
 static void __qedi_remove(struct pci_dev *pdev, int mode)
 {
 	struct qedi_ctx *qedi = pci_get_drvdata(pdev);
+	int rval;
 
 	if (qedi->tmf_thread) {
 		flush_workqueue(qedi->tmf_thread);
@@ -2104,6 +2105,10 @@ static void __qedi_remove(struct pci_dev
 	if (mode == QEDI_MODE_NORMAL)
 		qedi_free_iscsi_pf_param(qedi);
 
+	rval = qedi_ops->common->update_drv_state(qedi->cdev, false);
+	if (rval)
+		QEDI_ERR(&qedi->dbg_ctx, "Failed to send drv state to MFW\n");
+
 	if (!test_bit(QEDI_IN_OFFLINE, &qedi->flags)) {
 		qedi_ops->common->slowpath_stop(qedi->cdev);
 		qedi_ops->common->remove(qedi->cdev);
@@ -2378,6 +2383,12 @@ static int __qedi_probe(struct pci_dev *
 		if (qedi_setup_boot_info(qedi))
 			QEDI_ERR(&qedi->dbg_ctx,
 				 "No iSCSI boot target configured\n");
+
+		rc = qedi_ops->common->update_drv_state(qedi->cdev, true);
+		if (rc)
+			QEDI_ERR(&qedi->dbg_ctx,
+				 "Failed to send drv state to MFW\n");
+
 	}
 
 	return 0;


