Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 89FXKhdVGVtsMgAAmS7hNA
	; Thu, 07 Jun 2018 15:54:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9511A607E7; Thu,  7 Jun 2018 15:54:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F3AA060590;
	Thu,  7 Jun 2018 15:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3AA060590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934340AbeFGPyW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:54:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40336 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933751AbeFGOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:34:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005Zs-Pt; Thu, 07 Jun 2018 15:09:47 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002sa-31; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Wei Yongjun" <weiyongjun1@huawei.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Boris Brezillon" <boris.brezillon@free-electrons.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.327600273@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 140/410] mtd: ubi: wl: Fix error return code in
 ubi_wl_init()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 7233982ade15eeac05c6f351e8d347406e6bcd2f upstream.

Fix to return error code -ENOMEM from the kmem_cache_alloc() error
handling case instead of 0, as done elsewhere in this function.

Fixes: f78e5623f45b ("ubi: fastmap: Erase outdated anchor PEBs during
attach")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/ubi/wl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1925,8 +1925,10 @@ int ubi_wl_init(struct ubi_device *ubi,
 		cond_resched();
 
 		e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
-		if (!e)
+		if (!e) {
+			err = -ENOMEM;
 			goto out_free;
+		}
 
 		e->pnum = aeb->pnum;
 		e->ec = aeb->ec;
@@ -1966,8 +1968,10 @@ int ubi_wl_init(struct ubi_device *ubi,
 			cond_resched();
 
 			e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
-			if (!e)
+			if (!e) {
+				err = -ENOMEM;
 				goto out_free;
+			}
 
 			e->pnum = aeb->pnum;
 			e->ec = aeb->ec;
