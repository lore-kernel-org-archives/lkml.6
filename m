Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeBUFHJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:07:09 -0500
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:54422 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751461AbeBUFHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:07:05 -0500
X-IronPort-AV: E=Sophos;i="5.46,542,1511798400";
   d="scan'208";a="1477"
X-IronPort-AV: E=McAfee;i="5900,7806,8810"; a="2386722"
From: Asutosh Das <asutoshd@codeaurora.org>
To: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, Yaniv Gardi <ygardi@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/9] scsi: ufs: Allowing power mode change
Date: Wed, 21 Feb 2018 10:26:32 +0530
Message-Id: <70df05c82a8624987c76b16c65143f00a111c94d.1519120988.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1519120988.git.asutoshd@codeaurora.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
In-Reply-To: <cover.1519120988.git.asutoshd@codeaurora.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaniv Gardi <ygardi@codeaurora.org>

Due to M-PHY issues, moving from HS to any other mode or gear or
even Hibern8 causes some un-predicted behavior of the device.
This patch fixes this issues.

Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 011c336..d74d529 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4167,9 +4167,13 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 			goto out;
 	} while (ret && retries--);
 
-	if (ret)
+	if (ret) {
 		/* failed to get the link up... retire */
 		goto out;
+	} else {
+		ufshcd_dme_set(hba, UIC_ARG_MIB(TX_LCC_ENABLE), 0);
+		ufshcd_dme_set(hba, UIC_ARG_MIB(TX_LCC_ENABLE), 1);
+	}
 
 	if (link_startup_again) {
 		link_startup_again = false;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
