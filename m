Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB6EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C34222CF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405792AbfBNGig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:38:36 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:33520 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfBNGig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:38:36 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 880D0FFCEF06D08D5AA8;
        Thu, 14 Feb 2019 14:38:27 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1E6cK4p047761;
        Thu, 14 Feb 2019 14:38:20 +0800 (GMT-8)
        (envelope-from huang.zijiang@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021414385043-26034948 ;
          Thu, 14 Feb 2019 14:38:50 +0800 
From:   Huang Zijiang <huang.zijiang@zte.com.cn>
To:     thor.thayer@linux.intel.com
Cc:     bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] EDAC, altera: Add missing of_node_put()
Date:   Thu, 14 Feb 2019 14:39:07 +0800
Message-Id: <1550126347-27984-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-14 14:38:50,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-14 14:38:09,
        Serialize complete at 2019-02-14 14:38:09
X-MAIL: mse01.zte.com.cn x1E6cK4p047761
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
---
 drivers/edac/altera_edac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index c89d82a..1bcd778 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1046,14 +1046,17 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 			return -ENODEV;
 		}
 
-		if (of_address_to_resource(sysmgr_np, 0, &res))
+		if (of_address_to_resource(sysmgr_np, 0, &res)) {
+			of_node_put(sysmgr_np);
 			return -ENOMEM;
+		}
 
 		/* Need physical address for SMCC call */
 		base = res.start;
 
 		ecc_mgr_map = regmap_init(NULL, NULL, (void *)base,
 					  &s10_sdram_regmap_cfg);
+		of_node_put(sysmgr_np);
 	}
 	of_node_put(np_eccmgr);
 	if (IS_ERR(ecc_mgr_map)) {
-- 
1.8.3.1

