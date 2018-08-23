Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3234C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03032098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03032098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeHWLcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:32:07 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10418 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeHWLcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:32:06 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5b7e6a5847f-bc0e0; Thu, 23 Aug 2018 16:03:36 +0800 (CST)
X-RM-TRANSID: 2eec5b7e6a5847f-bc0e0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from bclinux72.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5b7e6a57c3c-19678;
        Thu, 23 Aug 2018 16:03:36 +0800 (CST)
X-RM-TRANSID: 2eea5b7e6a57c3c-19678
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scsi: lpfc: use GFP_ATOMIC inside spin lock
Date:   Thu, 23 Aug 2018 05:14:58 -0400
Message-Id: <1535015698-17948-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GFP_KERNEL may sleep,so can not use it in spin lock,use GFP_ATOMIC instead.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 5c7858e..3813f84 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5928,7 +5928,7 @@ struct lpfc_device_data*
 
 	/* Create an lun info structure and add to list of luns */
 	lun_info = lpfc_create_device_data(phba, vport_wwpn, target_wwpn, lun,
-					   pri, false);
+					   pri, true);
 	if (lun_info) {
 		lun_info->oas_enabled = true;
 		lun_info->priority = pri;
-- 
1.8.3.1



