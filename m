Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F6CECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C389E2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C389E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbeISTUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:20:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:52992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731391AbeISTUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AFF1ACDE;
        Wed, 19 Sep 2018 13:42:36 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v2] xen: issue warning message when out of grant maptrack entries
Date:   Wed, 19 Sep 2018 15:42:33 +0200
Message-Id: <20180919134233.3040-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a driver domain (e.g. dom0) is running out of maptrack entries it
can't map any more foreign domain pages. Instead of silently stalling
the affected domUs issue a rate limited warning in this case in order
to make it easier to detect that situation.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/grant-table.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 7bafa703a992..84575baceebc 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1040,18 +1040,33 @@ int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 		return ret;
 
 	for (i = 0; i < count; i++) {
-		/* Retry eagain maps */
-		if (map_ops[i].status == GNTST_eagain)
-			gnttab_retry_eagain_gop(GNTTABOP_map_grant_ref, map_ops + i,
-						&map_ops[i].status, __func__);
-
-		if (map_ops[i].status == GNTST_okay) {
+		switch (map_ops[i].status) {
+		case GNTST_okay:
+		{
 			struct xen_page_foreign *foreign;
 
 			SetPageForeign(pages[i]);
 			foreign = xen_page_foreign(pages[i]);
 			foreign->domid = map_ops[i].dom;
 			foreign->gref = map_ops[i].ref;
+			break;
+		}
+
+		case GNTST_no_device_space:
+			pr_warn_ratelimited("maptrack limit reached, can't map all guest pages\n");
+			break;
+
+		case GNTST_eagain:
+			/* Retry eagain maps */
+			gnttab_retry_eagain_gop(GNTTABOP_map_grant_ref,
+						map_ops + i,
+						&map_ops[i].status, __func__);
+			/* Test status in next loop iteration. */
+			i--;
+			break;
+
+		default:
+			break;
 		}
 	}
 
-- 
2.16.4

