Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1F8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD91921486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD91921486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbeIXSqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:46:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732506AbeIXSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:46:22 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17A9E1099;
        Mon, 24 Sep 2018 12:44:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 216/235] scsi: lpfc: Fix panic if driver unloaded when port is offline
Date:   Mon, 24 Sep 2018 13:53:22 +0200
Message-Id: <20180924113125.143659988@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit d580c6137476ab307a66e278cf7dbc666230f714 ]

System crashes when the lpfc module is unloaded after making the port
offline

The nvme queue pointers were freed during port offline, but were later
accessed in pci remove path.

Validate the pointers in pci remove path before accessing them.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2976,7 +2976,7 @@ lpfc_nvme_wait_for_io_drain(struct lpfc_
 	struct lpfc_sli_ring  *pring;
 	u32 i, wait_cnt = 0;
 
-	if (phba->sli_rev < LPFC_SLI_REV4)
+	if (phba->sli_rev < LPFC_SLI_REV4 || !phba->sli4_hba.nvme_wq)
 		return;
 
 	/* Cycle through all NVME rings and make sure all outstanding
@@ -2985,6 +2985,9 @@ lpfc_nvme_wait_for_io_drain(struct lpfc_
 	for (i = 0; i < phba->cfg_nvme_io_channel; i++) {
 		pring = phba->sli4_hba.nvme_wq[i]->pring;
 
+		if (!pring)
+			continue;
+
 		/* Retrieve everything on the txcmplq */
 		while (!list_empty(&pring->txcmplq)) {
 			msleep(LPFC_XRI_EXCH_BUSY_WAIT_T1);


