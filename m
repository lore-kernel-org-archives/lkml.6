Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEC7ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354212077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="buNmfCEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354212077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeKICpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:45:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39398 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKICpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:45:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id n11-v6so9578084pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 09:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=A9/0kpOkbUFX6Cs4ROIwbJe6H8AsAc8U63ivXKgPQgs=;
        b=buNmfCEh3PM2toAPVWAiYB4BadC2IIXG3TEfFRkQueEi4CG5vjInU2IY7aw2M12JoY
         yUiBEkMcZCyz1hPxpxyMUwpe7rpH0izeauucNSsYMQ3P6pK57yUKgeNb58UHZ84+Col3
         FpLoz7Go3sz49DnYoHBCVGJ3cRlI3eCWNh2sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A9/0kpOkbUFX6Cs4ROIwbJe6H8AsAc8U63ivXKgPQgs=;
        b=bwjxONmVJ4mr86YxYjzqPjTBQP2Ign/4+QKDFdvaO6kJiJsBhbJDI6XLNVdvsNbTc4
         F1WSrmJ6W2NJxdcqZPvnoz7lkBVPvMx4eOG+DyYLRUZ98nFC9WLm8vhMrk/ImCKdL4qN
         dIOnebQ3YUuNY6R0oX48N2HXOp39SdVpkurmmcVS7pRkOujs1DBADktJNwHS0jUk8+ua
         xt6kR5deduDNaflhBFbH66A8YBsocHoF/ZLzDsUggUe14QtD1Hl0WLGOGN8VdZZS/i4Z
         4bw47PnqCSTi/TqBTeGkCD6YijPljIqyawjzOlTlemmk+Qn6CdOS1xWLz9nm4wNTHmeW
         06pw==
X-Gm-Message-State: AGRZ1gLyRTHkSU4l39r6or1h51y96F7+BAJPV8hGG+tRkM9OmPENRily
        xeSLuMt4g4pUaDvJ1CREe40adxifG/82SA==
X-Google-Smtp-Source: AJdET5czrxPZpCQU0tWB0hs1DV0tm9Z/7P9qS4q36EG58ZF52vEsRqH98vOJ/f4FCttoYg2DiBMbfA==
X-Received: by 2002:a62:6143:: with SMTP id v64-v6mr5391265pfb.125.1541696914909;
        Thu, 08 Nov 2018 09:08:34 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id u9-v6sm4102228pfm.175.2018.11.08.09.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 09:08:34 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [RESEND][PATCH v3] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
Date:   Thu,  8 Nov 2018 09:08:29 -0800
Message-Id: <1541696909-31620-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei213@huawei.com>

Hynix ufs has deviations on hi36xx platform which will result in
ufs bursts transfer failures.

To fix the problem, the Hynix device must set the register
VS_DebugSaveConfigTime to 0x10, which will set time reference
for SaveConfigTime is 250 ns. The time reference for SaveConfigTime
is 40 ns by default.

This patch is necessary to boot on HiKey960 boards that use
Hynix UFS chips (H28U62301AMR model: hB8aL1).

Cc: Vinayak Holikatti <vinholikatti@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Wei Li <liwei213@huawei.com>
Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
[jstultz: Forward ported from older code, slight tweak to commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Narrowed the UFS chip model to the specific model where
  the issue has been seen. (SKhynix  H28U62301AMR model: hB8aL1)
* Reworked logic to be contained in ufs-hisi.c since it seems to
  be a controller issue that crops up with this specific chip
v3:
* Reworked back to using generic hba quriks which we then key on
  in the hisi driver.
---
 drivers/scsi/ufs/ufs-hisi.c   | 9 +++++++++
 drivers/scsi/ufs/ufs_quirks.h | 6 ++++++
 drivers/scsi/ufs/ufshcd.c     | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 46df707..452e19f 100644
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
index 71f73d1..5d2dfdb 100644
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
index 23d7cca..ce2b4df 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -231,6 +231,8 @@ static struct ufs_dev_fix ufs_fixups[] = {
 	UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL, UFS_DEVICE_NO_VCCQ),
 	UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL,
 		UFS_DEVICE_QUIRK_HOST_PA_SAVECONFIGTIME),
+	UFS_FIX(UFS_VENDOR_SKHYNIX, "hB8aL1" /*H28U62301AMR*/,
+		UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME),
 
 	END_FIX
 };
-- 
2.7.4

