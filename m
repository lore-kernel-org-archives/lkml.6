Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1426AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF5920868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKennRM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF5920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeK2RBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeK2RBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:01:11 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BB9820834;
        Thu, 29 Nov 2018 05:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471020;
        bh=tCC6tz0NReYFi/RePte3VGyELD7Kxc3cFse0Zk5Ddyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKennRM7Y5/GnM576C3drdeRppekcg91HSiBvNosWKDakdDIxWazs1zmIbeXZLHlz
         X7MFFE6fh/t7e2al1vz3an7PTAxW2azlSpe6sqF6bB5OEN8lEWhKj4EWIsxgkk8zw5
         YEjWO0IJJPWYpIU18dbQZE398fBfk47p8vd6M3jY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 09/68] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
Date:   Thu, 29 Nov 2018 00:55:00 -0500
Message-Id: <20181129055559.159228-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei213@huawei.com>

[ Upstream commit 8e4829c6f7470722c1f5a1dc5769ebe09ef036d6 ]

Hynix ufs has deviations on hi36xx platform which will result in ufs bursts
transfer failures.

To fix the problem, the Hynix device must set the register
VS_DebugSaveConfigTime to 0x10, which will set time reference for
SaveConfigTime is 250 ns. The time reference for SaveConfigTime is 40 ns by
default.

This patch is necessary to boot on HiKey960 boards that use Hynix UFS chips
(H28U62301AMR model: hB8aL1).

Cc: Vinayak Holikatti <vinholikatti@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Wei Li <liwei213@huawei.com>
Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
[jstultz: Forward ported from older code, slight tweak to commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs-hisi.c   | 9 +++++++++
 drivers/scsi/ufs/ufs_quirks.h | 6 ++++++
 drivers/scsi/ufs/ufshcd.c     | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 46df707e6f2c..452e19f8fb47 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -20,6 +20,7 @@
 #include "unipro.h"
 #include "ufs-hisi.h"
 #include "ufshci.h"
+#include "ufs_quirks.h"
 
 static int ufs_hisi_check_hibern8(struct ufs_hba *hba)
 {
@@ -390,6 +391,14 @@ static void ufs_hisi_set_dev_cap(struct ufs_hisi_dev_params *hisi_param)
 
 static void ufs_hisi_pwr_change_pre_change(struct ufs_hba *hba)
 {
+	if (hba->dev_quirks & UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME) {
+		pr_info("ufs flash device must set VS_DebugSaveConfigTime 0x10\n");
+		/* VS_DebugSaveConfigTime */
+		ufshcd_dme_set(hba, UIC_ARG_MIB(0xD0A0), 0x10);
+		/* sync length */
+		ufshcd_dme_set(hba, UIC_ARG_MIB(0x1556), 0x48);
+	}
+
 	/* update */
 	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15A8), 0x1);
 	/* PA_TxSkip */
diff --git a/drivers/scsi/ufs/ufs_quirks.h b/drivers/scsi/ufs/ufs_quirks.h
index 71f73d1d1ad1..5d2dfdb41a6f 100644
--- a/drivers/scsi/ufs/ufs_quirks.h
+++ b/drivers/scsi/ufs/ufs_quirks.h
@@ -131,4 +131,10 @@ struct ufs_dev_fix {
  */
 #define UFS_DEVICE_QUIRK_HOST_PA_SAVECONFIGTIME	(1 << 8)
 
+/*
+ * Some UFS devices require VS_DebugSaveConfigTime is 0x10,
+ * enabling this quirk ensure this.
+ */
+#define UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME	(1 << 9)
+
 #endif /* UFS_QUIRKS_H_ */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 54074dd483a7..0b81d9d03357 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -230,6 +230,8 @@ static struct ufs_dev_fix ufs_fixups[] = {
 	UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL, UFS_DEVICE_NO_VCCQ),
 	UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL,
 		UFS_DEVICE_QUIRK_HOST_PA_SAVECONFIGTIME),
+	UFS_FIX(UFS_VENDOR_SKHYNIX, "hB8aL1" /*H28U62301AMR*/,
+		UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME),
 
 	END_FIX
 };
-- 
2.17.1

