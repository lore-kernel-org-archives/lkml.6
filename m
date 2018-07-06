Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6535FC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215D823E4F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215D823E4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933305AbeGFMiu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:38:50 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:56668 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933192AbeGFMiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:38:46 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2018 08:38:37 EDT
X-IronPort-AV: E=Sophos;i="5.51,316,1526322600"; 
   d="scan'208";a="98710"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Jul 2018 18:00:55 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,8945"; a="470262"
Received: from asutoshd-linux.qualcomm.com ([10.206.24.163])
  by ironmsg03-blr.qualcomm.com with ESMTP; 06 Jul 2018 18:00:54 +0530
Received: by asutoshd-linux.qualcomm.com (Postfix, from userid 92687)
        id BDA922FAF; Fri,  6 Jul 2018 18:00:53 +0530 (IST)
From:   Asutosh Das <asutoshd@codeaurora.org>
To:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 9/9] scsi: ufs: enable FASTAUTO mode during low load condition
Date:   Fri,  6 Jul 2018 18:00:36 +0530
Message-Id: <e121bd8d45e6789ee00bd4b11803107cc9330a0b.1530880007.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1530880006.git.asutoshd@codeaurora.org>
References: <cover.1530880006.git.asutoshd@codeaurora.org>
In-Reply-To: <cover.1530880006.git.asutoshd@codeaurora.org>
References: <cover.1530880006.git.asutoshd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

We are currently running UFS link in HS-G3 FAST mode during high load
condition for best possible performance and in HS-G2 FAST mode during
low load condition to save power. As we are anyway scaling down from
HS-G3 to HS-G2, we can also change the mode from FAST to FASTAUTO.
So we looked at the performance numbers with HS-G2 FASTAUTO mode and
they are good enough for most of the low bandwidth usecases. But Samsung
UFS memory devices are exception which has really low sequential read
throughput in FAST AUTO mode hence we will only be enabling FAST AUTO mode
for other UFS device vendors.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 50588cf..a6e43f9 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1088,6 +1088,10 @@ static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
 			/* scale down gear */
 			new_pwr_info.gear_tx = UFS_MIN_GEAR_TO_SCALE_DOWN;
 			new_pwr_info.gear_rx = UFS_MIN_GEAR_TO_SCALE_DOWN;
+			if (!(hba->dev_quirks & UFS_DEVICE_NO_FASTAUTO)) {
+				new_pwr_info.pwr_tx = FASTAUTO_MODE;
+				new_pwr_info.pwr_rx = FASTAUTO_MODE;
+			}
 		}
 	}
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

