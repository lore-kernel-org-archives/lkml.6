Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30571C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F30920660
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F30920660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937243AbeFSDCi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:02:38 -0400
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:50332
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755376AbeFSDC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:02:26 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AWEwBicShb/6c80XZcHgEGDINJgU8SK?=
 =?us-ascii?q?IN5lFZGAQEBAQEGgQ00kDiEKIF4HhgBhEACgl8hNhYBAgEBAQEBAQJtKIUpBiN?=
 =?us-ascii?q?WEBgBDAIYDgICRxAGE4UYDKpTghwaAogtgWiBC4dJgQyBB4E/hxqDOIJVAodJh?=
 =?us-ascii?q?Vc/izcJjwmIGIUjK5JqByqBUk0uCoJ+kFwyMHoBAY4KgkgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AWEwBicShb/6c80XZcHgEGDINJgU8SKIN5lFZGAQEBAQE?=
 =?us-ascii?q?GgQ00kDiEKIF4HhgBhEACgl8hNhYBAgEBAQEBAQJtKIUpBiNWEBgBDAIYDgICR?=
 =?us-ascii?q?xAGE4UYDKpTghwaAogtgWiBC4dJgQyBB4E/hxqDOIJVAodJhVc/izcJjwmIGIU?=
 =?us-ascii?q?jK5JqByqBUk0uCoJ+kFwyMHoBAY4KgkgBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,241,1526313600"; 
   d="scan'208";a="90294647"
Received: from unknown (HELO pluto.themaw.net) ([118.209.60.167])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 19 Jun 2018 11:02:04 +0800
Subject: [PATCH 2/6] autofs - fix clearing AUTOFS_EXP_LEAVES in
 autofs_expire_indirect()
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Jun 2018 11:02:04 +0800
Message-ID: <152937732410.21213.7447294898147765076.stgit@pluto.themaw.net>
In-Reply-To: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
References: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expire flag AUTOFS_EXP_LEAVES is cleared before the second
call to should_expire() in autofs_expire_indirect() but the
parameter passed in the second call is incorrect.

Fortunately AUTOFS_EXP_LEAVES expire flag has not been used for
a long time but might be needed in the future so fix it rather
than remove the expire leaves functionality.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/expire.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 295feec10ea6..41855cdc5630 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -467,7 +467,7 @@ struct dentry *autofs_expire_indirect(struct super_block *sb,
 		 * things have changed.
 		 */
 		flags &= ~AUTOFS_EXP_LEAVES;
-		found = should_expire(expired, mnt, timeout, how);
+		found = should_expire(expired, mnt, timeout, flags);
 		if (!found || found != expired)
 			/* Something has changed, continue */
 			goto next;

