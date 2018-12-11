Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E096AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0772082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0772082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeLKJwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:52:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50962 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbeLKJwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:52:35 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B80C3EFB55449;
        Tue, 11 Dec 2018 17:52:31 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Tue, 11 Dec 2018
 17:52:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] i5000_edac: remove set but not used variables 'maxdimmperch, maxch, channel_count'
Date:   Tue, 11 Dec 2018 17:52:07 +0800
Message-ID: <20181211095207.25936-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/edac/i5000_edac.c: In function 'i5000_get_mc_regs':
drivers/edac/i5000_edac.c:1138:6: warning:
 variable 'maxdimmperch' set but not used [-Wunused-but-set-variable]

drivers/edac/i5000_edac.c:1137:6: warning:
 variable 'maxch' set but not used [-Wunused-but-set-variable]

drivers/edac/i5000_edac.c: In function 'i5000_init_csrows':
drivers/edac/i5000_edac.c:1256:13: warning:
 variable 'channel_count' set but not used [-Wunused-but-set-variable]

It never used since introduction in
commit eb60705ac5a9 ("drivers/edac: new intel 5000 MC driver")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/edac/i5000_edac.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index 98bef13..078a735 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -1134,8 +1134,6 @@ static void i5000_get_mc_regs(struct mem_ctl_info *mci)
 	u32 actual_tolm;
 	u16 limit;
 	int slot_row;
-	int maxch;
-	int maxdimmperch;
 	int way0, way1;
 
 	pvt = mci->pvt_info;
@@ -1145,9 +1143,6 @@ static void i5000_get_mc_regs(struct mem_ctl_info *mci)
 	pci_read_config_dword(pvt->system_address, AMBASE + sizeof(u32),
 			&pvt->u.ambase_top);
 
-	maxdimmperch = pvt->maxdimmperch;
-	maxch = pvt->maxch;
-
 	edac_dbg(2, "AMBASE= 0x%lx  MAXCH= %d  MAX-DIMM-Per-CH= %d\n",
 		 (long unsigned int)pvt->ambase, pvt->maxch, pvt->maxdimmperch);
 
@@ -1253,7 +1248,7 @@ static int i5000_init_csrows(struct mem_ctl_info *mci)
 {
 	struct i5000_pvt *pvt;
 	struct dimm_info *dimm;
-	int empty, channel_count;
+	int empty;
 	int max_csrows;
 	int mtr;
 	int csrow_megs;
@@ -1261,8 +1256,6 @@ static int i5000_init_csrows(struct mem_ctl_info *mci)
 	int slot;
 
 	pvt = mci->pvt_info;
-
-	channel_count = pvt->maxch;
 	max_csrows = pvt->maxdimmperch * 2;
 
 	empty = 1;		/* Assume NO memory */
-- 
2.7.4


