Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E90CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20886223FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20886223FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeHJQp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:45:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:38062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727288AbeHJQp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:45:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BB527AF52;
        Fri, 10 Aug 2018 14:15:22 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tim Small <tim@buttersideup.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: i82443bxgx: Fix invalid memory type assignment
Date:   Fri, 10 Aug 2018 16:15:20 +0200
Message-Id: <20180810141520.8993-1-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i82443bxgx_edac driver assigns an invalid negative value when an
unknown DRAM type is detected.  Drop the unnecessary '-' that brings
misbehavior.

Fixes: 5a2c675c8919 ("drivers/edac: new i82443bxgz MC driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/edac/i82443bxgx_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i82443bxgx_edac.c b/drivers/edac/i82443bxgx_edac.c
index a2ca929e2168..1638f288fa47 100644
--- a/drivers/edac/i82443bxgx_edac.c
+++ b/drivers/edac/i82443bxgx_edac.c
@@ -273,7 +273,7 @@ static int i82443bxgx_edacmc_probe1(struct pci_dev *pdev, int dev_idx)
 		break;
 	default:
 		edac_dbg(0, "Unknown/reserved DRAM type value in DRAMC register!\n");
-		mtype = -MEM_UNKNOWN;
+		mtype = MEM_UNKNOWN;
 	}
 
 	if ((mtype == MEM_SDR) || (mtype == MEM_RDR))
-- 
2.18.0

