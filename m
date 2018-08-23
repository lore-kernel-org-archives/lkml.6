Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5ADC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCE62147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCE62147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbeHWMBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:01:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48256 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbeHWMBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:01:32 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED397C7B;
        Thu, 23 Aug 2018 08:32:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saurav Kashyap <saurav.kashyap@cavium.com>,
        Chad Dupuis <chad.dupuis@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 165/217] scsi: qedf: Send the driver state to MFW
Date:   Thu, 23 Aug 2018 09:54:38 +0200
Message-Id: <20180823075512.990673373@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
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

From: Saurav Kashyap <saurav.kashyap@cavium.com>

[ Upstream commit 6ac174756dfc9884f08b23af840ca911155f5578 ]

Need to notify firmware when driver is loaded and unloaded.

Signed-off-by: Saurav Kashyap <saurav.kashyap@cavium.com>
Signed-off-by: Chad Dupuis <chad.dupuis@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qedf/qedf_main.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3240,6 +3240,11 @@ static int __qedf_probe(struct pci_dev *
 
 	init_completion(&qedf->flogi_compl);
 
+	status = qed_ops->common->update_drv_state(qedf->cdev, true);
+	if (status)
+		QEDF_ERR(&(qedf->dbg_ctx),
+			"Failed to send drv state to MFW.\n");
+
 	memset(&link_params, 0, sizeof(struct qed_link_params));
 	link_params.link_up = true;
 	status = qed_ops->common->set_link(qedf->cdev, &link_params);
@@ -3288,6 +3293,7 @@ static int qedf_probe(struct pci_dev *pd
 static void __qedf_remove(struct pci_dev *pdev, int mode)
 {
 	struct qedf_ctx *qedf;
+	int rc;
 
 	if (!pdev) {
 		QEDF_ERR(NULL, "pdev is NULL.\n");
@@ -3382,6 +3388,12 @@ static void __qedf_remove(struct pci_dev
 		qed_ops->common->set_power_state(qedf->cdev, PCI_D0);
 		pci_set_drvdata(pdev, NULL);
 	}
+
+	rc = qed_ops->common->update_drv_state(qedf->cdev, false);
+	if (rc)
+		QEDF_ERR(&(qedf->dbg_ctx),
+			"Failed to send drv state to MFW.\n");
+
 	qed_ops->common->slowpath_stop(qedf->cdev);
 	qed_ops->common->remove(qedf->cdev);
 


