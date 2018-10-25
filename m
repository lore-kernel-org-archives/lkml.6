Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E9EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F292084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F292084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeJYXtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:49:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40164 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeJYXtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:49:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gFhKI-0001BJ-EK; Thu, 25 Oct 2018 15:13:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: Fix unintended sign extension issue
Date:   Thu, 25 Oct 2018 16:13:34 +0100
Message-Id: <20181025151334.15622-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the expression "ahc_inb(ahc, port+3) << 24", the initial value is a
u8, but is promoted to a signed int, then sign-extended to uint64_t.  If
the value read from the port has the upper bit set then the sign
extension will set all the upper bits of the expression which is probably
not what was intended.  Cast to uint64_t to avoid the sign extension.

Detected by CoverityScan, CID#138806, 138807 ("Unintended sign extension")

Fixes: be0d67680d52 ("[SCSI] aic7xxx, aic79xx: deinline functions")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/aic7xxx/aic79xx_core.c | 2 +-
 drivers/scsi/aic7xxx/aic7xxx_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 9ee75c9a9aa1..a836233edb91 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -622,7 +622,7 @@ ahd_inq(struct ahd_softc *ahd, u_int port)
 	return ((ahd_inb(ahd, port))
 	      | (ahd_inb(ahd, port+1) << 8)
 	      | (ahd_inb(ahd, port+2) << 16)
-	      | (ahd_inb(ahd, port+3) << 24)
+	      | (((uint64_t)ahd_inb(ahd, port+3)) << 24)
 	      | (((uint64_t)ahd_inb(ahd, port+4)) << 32)
 	      | (((uint64_t)ahd_inb(ahd, port+5)) << 40)
 	      | (((uint64_t)ahd_inb(ahd, port+6)) << 48)
diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index f3362f4ab16e..74d3f1dd0427 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -493,7 +493,7 @@ ahc_inq(struct ahc_softc *ahc, u_int port)
 	return ((ahc_inb(ahc, port))
 	      | (ahc_inb(ahc, port+1) << 8)
 	      | (ahc_inb(ahc, port+2) << 16)
-	      | (ahc_inb(ahc, port+3) << 24)
+	      | (((uint64_t)ahc_inb(ahc, port+3)) << 24)
 	      | (((uint64_t)ahc_inb(ahc, port+4)) << 32)
 	      | (((uint64_t)ahc_inb(ahc, port+5)) << 40)
 	      | (((uint64_t)ahc_inb(ahc, port+6)) << 48)
-- 
2.19.1

