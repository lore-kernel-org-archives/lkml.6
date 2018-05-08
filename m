Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933057AbeEHIVv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:21:51 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39017 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932732AbeEHIVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:21:48 -0400
X-Google-Smtp-Source: AB8JxZrIr4N2yrg6czF24gqQSZWDXYOnpmPmuyYu6wbbE7vsHVk0qbZt+a9AvUyGNrshAwNAIrEAcA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ata: libata-pmp: Fix a possible data race in sata_pmp_handle_link_fail
Date: Tue,  8 May 2018 16:21:40 +0800
Message-Id: <20180508082140.14038-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The write operation to "link->flags" is protected by
the lock on line 898, but the read operation to
this data on line 892 is not protected by the lock.
Thus, there may exist a data race for "link->flags".

To fix this data race, the read operation to "link->flags" 
should be also protected by the lock.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ata/libata-pmp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 85aa76116a30..42f61106ac70 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -889,15 +889,14 @@ static int sata_pmp_handle_link_fail(struct ata_link *link, int *link_tries)
 		return 1;
 
 	/* disable this link */
+	spin_lock_irqsave(ap->lock, flags);
 	if (!(link->flags & ATA_LFLAG_DISABLED)) {
 		ata_link_warn(link,
 			"failed to recover link after %d tries, disabling\n",
 			ATA_EH_PMP_LINK_TRIES);
-
-		spin_lock_irqsave(ap->lock, flags);
 		link->flags |= ATA_LFLAG_DISABLED;
-		spin_unlock_irqrestore(ap->lock, flags);
 	}
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	ata_dev_disable(link->device);
 	link->eh_context.i.action = 0;
-- 
2.17.0
