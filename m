Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A2420858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A2420858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbeGVWSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:18:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:38830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387732AbeGVWSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:18:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2715DAFCE;
        Sun, 22 Jul 2018 21:20:22 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Damien Horsley <damien.horsley@imgtec.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: [PATCH 09/15] dmaengine: img-mdc: Handle early status read
Date:   Sun, 22 Jul 2018 23:20:04 +0200
Message-Id: <20180722212010.3979-10-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Horsley <damien.horsley@imgtec.com>

It is possible that mdc_tx_status may be called before the first
node has been read from memory.

In this case, the residue value stored in the register is undefined.
Return the transfer size instead.

Signed-off-by: Damien Horsley <damien.horsley@imgtec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/dma/img-mdc-dma.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
index 25cec9c243e1..0f2f0f52d83a 100644
--- a/drivers/dma/img-mdc-dma.c
+++ b/drivers/dma/img-mdc-dma.c
@@ -621,25 +621,33 @@ static enum dma_status mdc_tx_status(struct dma_chan *chan,
 			(MDC_CMDS_PROCESSED_CMDS_DONE_MASK + 1);
 
 		/*
-		 * If the command loaded event hasn't been processed yet, then
-		 * the difference above includes an extra command.
+		 * If the first node has not yet been read from memory,
+		 * the residue register value is undefined
 		 */
-		if (!mdesc->cmd_loaded)
-			cmds--;
-		else
-			cmds += mdesc->list_cmds_done;
-
-		bytes = mdesc->list_xfer_size;
-		ldesc = mdesc->list;
-		for (i = 0; i < cmds; i++) {
-			bytes -= ldesc->xfer_size + 1;
-			ldesc = ldesc->next_desc;
-		}
-		if (ldesc) {
-			if (residue != MDC_TRANSFER_SIZE_MASK)
-				bytes -= ldesc->xfer_size - residue;
+		if (!mdesc->cmd_loaded && !cmds) {
+			bytes = mdesc->list_xfer_size;
+		} else {
+			/*
+			 * If the command loaded event hasn't been processed yet, then
+			 * the difference above includes an extra command.
+			 */
+			if (!mdesc->cmd_loaded)
+				cmds--;
 			else
+				cmds += mdesc->list_cmds_done;
+
+			bytes = mdesc->list_xfer_size;
+			ldesc = mdesc->list;
+			for (i = 0; i < cmds; i++) {
 				bytes -= ldesc->xfer_size + 1;
+				ldesc = ldesc->next_desc;
+			}
+			if (ldesc) {
+				if (residue != MDC_TRANSFER_SIZE_MASK)
+					bytes -= ldesc->xfer_size - residue;
+				else
+					bytes -= ldesc->xfer_size + 1;
+			}
 		}
 	}
 	spin_unlock_irqrestore(&mchan->vc.lock, flags);
-- 
2.16.4

