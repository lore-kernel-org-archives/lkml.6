Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DB6ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D288420644
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D288420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeJSU63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:58:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727011AbeJSU62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:58:28 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2E3982076FC56;
        Fri, 19 Oct 2018 20:52:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Fri, 19 Oct 2018 20:52:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     YueHaibing <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] octeontx2-af: Remove set but not used variables 'devnum, is_pf'
Date:   Fri, 19 Oct 2018 13:03:06 +0000
Message-ID: <1539954186-193695-1-git-send-email-yuehaibing@huawei.com>
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

drivers/net/ethernet/marvell/octeontx2/af/rvu.c: In function 'rvu_detach_rsrcs':
drivers/net/ethernet/marvell/octeontx2/af/rvu.c:855:6: warning:
 variable 'devnum' set but not used [-Wunused-but-set-variable]
 
drivers/net/ethernet/marvell/octeontx2/af/rvu.c:853:7: warning:
 variable 'is_pf' set but not used [-Wunused-but-set-variable]

drivers/net/ethernet/marvell/octeontx2/af/rvu.c: In function 'rvu_mbox_handler_ATTACH_RESOURCES':
drivers/net/ethernet/marvell/octeontx2/af/rvu.c:1054:7: warning:
 variable 'is_pf' set but not used [-Wunused-but-set-variable]

drivers/net/ethernet/marvell/octeontx2/af/rvu.c:1053:6: warning:
 variable 'devnum' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit
746ea74241fa ("octeontx2-af: Add RVU block LF provisioning support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index c06cca9..60b3623 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -914,18 +914,9 @@ static int rvu_detach_rsrcs(struct rvu *rvu, struct rsrc_detach *detach,
 			    u16 pcifunc)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
-	bool is_pf, detach_all = true;
+	bool detach_all = true;
 	struct rvu_block *block;
-	int devnum, blkid;
-
-	/* Check if this is for a RVU PF or VF */
-	if (pcifunc & RVU_PFVF_FUNC_MASK) {
-		is_pf = false;
-		devnum = rvu_get_hwvf(rvu, pcifunc);
-	} else {
-		is_pf = true;
-		devnum = rvu_get_pf(pcifunc);
-	}
+	int blkid;
 
 	spin_lock(&rvu->rsrc_lock);
 
@@ -1114,22 +1105,12 @@ static int rvu_mbox_handler_ATTACH_RESOURCES(struct rvu *rvu,
 					     struct msg_rsp *rsp)
 {
 	u16 pcifunc = attach->hdr.pcifunc;
-	int devnum, err;
-	bool is_pf;
+	int err;
 
 	/* If first request, detach all existing attached resources */
 	if (!attach->modify)
 		rvu_detach_rsrcs(rvu, NULL, pcifunc);
 
-	/* Check if this is for a RVU PF or VF */
-	if (pcifunc & RVU_PFVF_FUNC_MASK) {
-		is_pf = false;
-		devnum = rvu_get_hwvf(rvu, pcifunc);
-	} else {
-		is_pf = true;
-		devnum = rvu_get_pf(pcifunc);
-	}
-
 	spin_lock(&rvu->rsrc_lock);
 
 	/* Check if the request can be accommodated */

