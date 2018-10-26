Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87454C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1B920834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1B920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeJZPEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:04:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbeJZPEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:04:06 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9C56EE4EA4200;
        Fri, 26 Oct 2018 14:28:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 26 Oct 2018 14:28:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        John Garry <john.garry@huawei.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        "Johannes Thumshirn" <jthumshirn@suse.de>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] mvsas: remove set but not used variables 'res_flag'
Date:   Fri, 26 Oct 2018 06:38:36 +0000
Message-ID: <1540535916-45509-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/mvsas/mv_init.c: In function 'mvs_ioremap':
drivers/scsi/mvsas/mv_init.c:315:36: warning:
 variable 'res_flag' set but not used [-Wunused-but-set-variable]
  unsigned long res_start, res_len, res_flag, res_flag_ex = 0;

It not used anymore after commit
92b19ff50e8f ("cleanup IORESOURCE_CACHEABLE vs ioremap()")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/mvsas/mv_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 3ac3437..d7534fb 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -312,7 +312,7 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
 
 int mvs_ioremap(struct mvs_info *mvi, int bar, int bar_ex)
 {
-	unsigned long res_start, res_len, res_flag, res_flag_ex = 0;
+	unsigned long res_start, res_len, res_flag_ex = 0;
 	struct pci_dev *pdev = mvi->pdev;
 	if (bar_ex != -1) {
 		/*
@@ -340,7 +340,6 @@ int mvs_ioremap(struct mvs_info *mvi, int bar, int bar_ex)
 		goto err_out;
 	}
 
-	res_flag = pci_resource_flags(pdev, bar);
 	mvi->regs = ioremap(res_start, res_len);
 
 	if (!mvi->regs) {

