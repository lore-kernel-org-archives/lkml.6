Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5CFC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546B820651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fewIorW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546B820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeJWIwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 04:52:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44729 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbeJWIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 04:52:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so4251747pgs.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6mjVJo8FQcNol+fIkwm+4i7sGlA8vnjlD8h3YNdJi64=;
        b=fewIorW0Ov/kbOpQIkLdcGkZw7y7mdYJzNhY/t7ZdWFWu+KsdULeF6ilNeVOg0oyja
         VCVUTiZKNybVzcsIbVQqSeK+bNsaiKjEvDlj3NL7SoAoFbOufe2QQCpG8KMCdVnjSnru
         GX4BU3l9vx0HXg0iTRRBnmqvHPIK7pfhgV81I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6mjVJo8FQcNol+fIkwm+4i7sGlA8vnjlD8h3YNdJi64=;
        b=jizKbmhp+oEXs9cqpIlcnurOmmeTyv5/UJuHNNEb0zs0JcMHdoLzT2Dksr/IWOljCI
         xuP8m5n/YsofnIoaPy4gYtLapgQA8t3JmLYyKijP5wcyAizJ1GGDNmfXCRJnYfsHQuM4
         /z4wDKQe5DmfobssHoxIs5n1Zah3EQxYM3tQgDfQtN5C9aM4hmzoiQRfS7gghMPkMh37
         j9txY8S/bEMfFx+5ldqwrWpwo0ZIb9zorEeyRHOw8NmIrG/ReSkrIuD3E/z59To3GNb5
         KbEmKte6Es3KAnOxZkYvwQzeO+rgFu1MGF2Cde6R/cE+T/NpwMG3omJW8TE2HmouzGUQ
         lfeg==
X-Gm-Message-State: ABuFfogoxObkeX4jAZwpr89gXtUP4pxSMbeX8huDg8xDOwic42MKH5RC
        Ul+I0yp8wnXyJ76UWaHIkaed1Wl8bZQ=
X-Google-Smtp-Source: ACcGV61KsQH5Xg3EV6JtvK5EHUcafvjxZIzb3suedZb6sjWMQenRnjxsHj8ssIko4qyLNrx+1wAu3Q==
X-Received: by 2002:a62:11cb:: with SMTP id 72-v6mr47220418pfr.120.1540254718925;
        Mon, 22 Oct 2018 17:31:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id j188-v6sm48787664pfg.132.2018.10.22.17.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 17:31:57 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH v2] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
Date:   Mon, 22 Oct 2018 17:31:50 -0700
Message-Id: <1540254710-26936-1-git-send-email-john.stultz@linaro.org>
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

Not sure if this is the preferred way of scoping the quirk to
the controller or not. Feedback would be greatly appreciated!

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
---
 drivers/scsi/ufs/ufs-hisi.c | 14 ++++++++++++++
 drivers/scsi/ufs/ufshcd.c   |  2 +-
 drivers/scsi/ufs/ufshcd.h   |  2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 46df707..a306acf 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -20,6 +20,7 @@
 #include "unipro.h"
 #include "ufs-hisi.h"
 #include "ufshci.h"
+#include "ufs_quirks.h"
 
 static int ufs_hisi_check_hibern8(struct ufs_hba *hba)
 {
@@ -390,6 +391,19 @@ static void ufs_hisi_set_dev_cap(struct ufs_hisi_dev_params *hisi_param)
 
 static void ufs_hisi_pwr_change_pre_change(struct ufs_hba *hba)
 {
+	struct ufs_dev_desc card = {0};
+
+	if (!ufs_get_device_desc(hba, &card)) {
+		if ((card.wmanufacturerid == UFS_VENDOR_SKHYNIX) &&
+		    (STR_PRFX_EQUAL("hB8aL1" /*H28U62301AMR*/, card.model))) {
+			pr_info("Hynix ufs flash device must set VS_DebugSaveConfigTime 0x10\n");
+			/* VS_DebugSaveConfigTime */
+			ufshcd_dme_set(hba, UIC_ARG_MIB(0xD0A0), 0x10);
+			/* sync length */
+			ufshcd_dme_set(hba, UIC_ARG_MIB(0x1556), 0x48);
+		}
+	}
+
 	/* update */
 	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15A8), 0x1);
 	/* PA_TxSkip */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c55f38e..326fa32 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6242,7 +6242,7 @@ static int ufshcd_scsi_add_wlus(struct ufs_hba *hba)
 	return ret;
 }
 
-static int ufs_get_device_desc(struct ufs_hba *hba,
+int ufs_get_device_desc(struct ufs_hba *hba,
 			       struct ufs_dev_desc *dev_desc)
 {
 	int err;
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 33fdd3f..31c0562 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -877,6 +877,8 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 			   u8 param_offset,
 			   u8 *param_read_buf,
 			   u8 param_size);
+int ufs_get_device_desc(struct ufs_hba *hba,
+			struct ufs_dev_desc *dev_desc);
 int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val);
 int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
-- 
2.7.4

