Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7305DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E44521720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbeLTRIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:08:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60392 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731469AbeLTRIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:08:10 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ga1np-0007z9-OL; Thu, 20 Dec 2018 17:08:05 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: lpfc: replace snprintf with strscpy
Date:   Thu, 20 Dec 2018 17:08:05 +0000
Message-Id: <20181220170805.17802-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Using snprintf without a format specifier is potentially risky if the
string phba->ModelDesc contains format specifiers. Replace this with
the safer and more efficient strscpy.

Cleans up clang warning:
drivers/scsi/lpfc/lpfc_scsi.c:4543:31: warning: format string is not a
string literal (potentially insecure) [-Wformat-security]

Fixes: 5021267af132 ("scsi: lpfc: Adding ability to reset chip via pci bus reset")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index b4f1a840b3b4..7b0cce3b42ed 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4540,7 +4540,7 @@ lpfc_info(struct Scsi_Host *host)
 	memset(lpfcinfobuf, 0, sizeof(lpfcinfobuf));
 	if (phba && phba->pcidev){
 		/* Model Description */
-		scnprintf(tmp, sizeof(tmp), phba->ModelDesc);
+		strscpy(tmp, phba->ModelDesc, sizeof(tmp));
 		if (strlcat(lpfcinfobuf, tmp, sizeof(lpfcinfobuf)) >=
 		    sizeof(lpfcinfobuf))
 			goto buffer_done;
-- 
2.19.1

