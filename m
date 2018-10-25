Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2BEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E2F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UbtMX54F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E2F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeJZCui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:50:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44614 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeJZCui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:50:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id d23-v6so4214966pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RPOZBbzyjbHOPhK8IbljRcHoNrKUr7CmrN5SSf/RjRQ=;
        b=UbtMX54FxCSZrM36Kbe/uISzTjzzFZF/hJsovQCRTiQoTxr7q9yiEI+7P/YuVIJ9p5
         L6TaoQjbpXyiyXtBWsGPvomYtptRhylEdUWu+ZUX+pp3sbjSHIUtDIkdnrA8BoZhFNSV
         /+KozqCX+VRt0CFOgKG+I6RcFWsZfJ8Jh9fmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RPOZBbzyjbHOPhK8IbljRcHoNrKUr7CmrN5SSf/RjRQ=;
        b=KEtOgppw0JKeT7gMkHKo+XnCPRNxhCe+SG4oWh5xifn9NupUT16rTWX/1PcJheueTo
         0MtvluCsO0d+QTB5Dkz2Pd4T5S6Y6DmEV4w3vBzlsBjZFyz2aZ0AlQJmUTijCP/Pb/zg
         b7fXt2LJWD24VjCiBOIeh7Ppe96T83zYgOI0+Qs2Be2QNp5/Pt0+vAi159KijOBsQb9L
         DeivY9zPIJNQAsFevrFMMwiUWlm5C+IaC8QNKCKU2o0ZZcABPw+sYKswRURQI+TvoIsP
         XIgxkQ9eLgTS0vKqVMBvjsM2kkK8v+Ql/qEeUw++oT62k6vhyIFsfNtrFc14VZ2lHy4c
         7ksA==
X-Gm-Message-State: AGRZ1gLkL9CnHuQqEdrx8D17jtF66CTNPtu3TzAgJXx4D0pwoMYW9neQ
        I7wq0klgNEPbgol8UJtbhZDMW46l71g=
X-Google-Smtp-Source: AJdET5fqjgSF01pZk95UDUiCSU/XjMr4rjUj24/84mGflZfFCoEdUXU/OEe4P6RxZ50L+Aw4kCTaMw==
X-Received: by 2002:a17:902:8d88:: with SMTP id v8-v6mr254674plo.21.1540491406315;
        Thu, 25 Oct 2018 11:16:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id r23-v6sm10725700pgm.48.2018.10.25.11.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 11:16:44 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
Date:   Thu, 25 Oct 2018 11:16:40 -0700
Message-Id: <1540491400-16141-1-git-send-email-john.stultz@linaro.org>
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
index c55f38e..9c6cac9 100644
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
2.7.4

