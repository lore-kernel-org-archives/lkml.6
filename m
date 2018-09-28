Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1246C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904892172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904892172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeI1Nuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:50:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbeI1Nuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:50:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 39EA1AE2D;
        Fri, 28 Sep 2018 07:28:29 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, roger.pau@citrix.com,
        konrad.wilk@oracle.com, axboe@kernel.dk,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen/blkfront: correct purging of persistent grants
Date:   Fri, 28 Sep 2018 09:28:27 +0200
Message-Id: <20180928072827.14229-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a46b53672b2c2e3770b38a4abf90d16364d2584b ("xen/blkfront: cleanup
stale persistent grants") introduced a regression as purged persistent
grants were not pu into the list of free grants again. Correct that.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index a71d817e900d..429d20131c7e 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2670,8 +2670,8 @@ static void purge_persistent_grants(struct blkfront_info *info)
 			list_del(&gnt_list_entry->node);
 			gnttab_end_foreign_access(gnt_list_entry->gref, 0, 0UL);
 			rinfo->persistent_gnts_c--;
-			__free_page(gnt_list_entry->page);
-			kfree(gnt_list_entry);
+			gnt_list_entry->gref = GRANT_INVALID_REF;
+			list_add_tail(&gnt_list_entry->node, &rinfo->grants);
 		}
 
 		spin_unlock_irqrestore(&rinfo->ring_lock, flags);
-- 
2.16.4

