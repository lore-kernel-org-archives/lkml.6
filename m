Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A12C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D418420A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D418420A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeHWLpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:45:06 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:37520 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbeHWLgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:36:13 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55b7e6b4be11-bc67c; Thu, 23 Aug 2018 16:07:40 +0800 (CST)
X-RM-TRANSID: 2ee55b7e6b4be11-bc67c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from bclinux72.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5b7e6b4b00c-19bcb;
        Thu, 23 Aug 2018 16:07:40 +0800 (CST)
X-RM-TRANSID: 2eea5b7e6b4b00c-19bcb
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     mdr@sgi.com, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla1280: Fix memory leak when open DUMP_IT_BACK
Date:   Thu, 23 Aug 2018 05:19:03 -0400
Message-Id: <1535015943-4907-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If open DUMP_IT_BACK and unfortunately fw is error, memory leak
will happen.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/scsi/qla1280.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 390775d..abdcf70 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -1756,8 +1756,12 @@ static void qla1280_mailbox_timeout(struct timer_list *t)
 #endif
 
 	fw = qla1280_request_firmware(ha);
-	if (IS_ERR(fw))
+	if (IS_ERR(fw)) {
+#if DUMP_IT_BACK
+		pci_free_consistent(ha->pdev, 8000, tbuf, p_tbuf);
+#endif
 		return PTR_ERR(fw);
+	}
 
 	fw_data = (const __le16 *)&fw->data[0];
 	ha->fwstart = __le16_to_cpu(fw_data[2]);
-- 
1.8.3.1



