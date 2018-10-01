Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409C2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04FD2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGTK1O8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04FD2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeJBFia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:38:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36188 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBFia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:38:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id f18-v6so25193pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XVGguNxmvicpsvPN9XyposHjvHXdJRHd3e9kTGdUpjY=;
        b=AGTK1O8AH3Uc176l48Ttdo/DKB5ks1S7TGG1YA4j+qMzd04FJhqbcUxYLCDTDZ8y3K
         MW9W2NM9mXXPACe3aZAQxxCiMl949ypv/w+9EjQUEGfgC41NY+9YFotzVKb9IbrK+P/U
         Zf9NFw0NwR/8ZoOd3j760P9XQ2jQuqyPRqW4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XVGguNxmvicpsvPN9XyposHjvHXdJRHd3e9kTGdUpjY=;
        b=Q4QFo2n5/S6BctFRmCan8h0Rwni3KcWT9eQiYxEMxslbI2pby9VfGgxfWCYBNZQhzE
         aYThUV9bmhGTDfwDNU18tguun2lSrwQZ23MYCgATNIm5gZHNh3rjq77luMtI5TT188vR
         TScTvx11Gto15FxDxM6HRpt6h1qFYYtJaT5Xe75mTRTZuZ1NMTKjYwOcFkrzaukol399
         1gE3lnFE72+9QRdbHAIcmQqX4t7BkzdwuFZx6BC3NkR/ZQyc9RPg+pKyFVQI490Vduiz
         11rnlq5TCm4kqxtpraZ4kZzM6QQw/4mXCua9Uz+HgEH3dgXLnRaWdlsHL4QBJMbplUQ0
         PeYg==
X-Gm-Message-State: ABuFfojmq8HCgpZLF1qExo2zWVUVuDOYw5bWE7NuBFuXD4KM7Zq4i9L1
        45JEekpeMHZi1T+ktEySIYFP0t67kMY=
X-Google-Smtp-Source: ACcGV63moVCi/iW3DSQxIXaVkr34YlUdIPrmYv40Ush9UTJxjyeOK8xXHoyekLHOp2i2qHsZOdXa2w==
X-Received: by 2002:a17:902:7e0f:: with SMTP id b15-v6mr13668804plm.246.1538434702985;
        Mon, 01 Oct 2018 15:58:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id m26-v6sm20457843pfi.102.2018.10.01.15.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 15:58:21 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [RESEND][PATCH] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
Date:   Mon,  1 Oct 2018 15:58:18 -0700
Message-Id: <1538434698-1042-1-git-send-email-john.stultz@linaro.org>
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
Hynix UFS chips.

Cc: Vinayak Holikatti <vinholikatti@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Wei Li <liwei213@huawei.com>
Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
[jstultz: Forward ported from older code, slight tweak to commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
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
index c55f38e..a67f298 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -230,6 +230,8 @@ static struct ufs_dev_fix ufs_fixups[] = {
 	UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL, UFS_DEVICE_NO_VCCQ),
 	UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL,
 		UFS_DEVICE_QUIRK_HOST_PA_SAVECONFIGTIME),
+	UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL,
+		UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME),
 
 	END_FIX
 };
-- 
2.7.4

