Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F3DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB9E208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB9E208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936135AbeFRKJ1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:09:27 -0400
Received: from zulu.geekplace.eu ([5.45.100.158]:42958 "EHLO zulu.geekplace.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934795AbeFRKJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:09:23 -0400
Received: from flo-ubook.informatik.uni-erlangen.de (flowubook.informatik.uni-erlangen.de [131.188.34.88])
        by zulu.geekplace.eu (Postfix) with ESMTPA id 859304A17CD;
        Mon, 18 Jun 2018 12:09:17 +0200 (CEST)
From:   Florian Schmaus <flo@geekplace.eu>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org
Cc:     Florian Schmaus <flo@geekplace.eu>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] bcache: do not assign in if condition in bcache_init()
Date:   Mon, 18 Jun 2018 12:09:01 +0200
Message-Id: <20180618100902.4015-3-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180618100902.4015-1-flo@geekplace.eu>
References: <20180618100902.4015-1-flo@geekplace.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an error condition reported by checkpatch.pl which is caused by
assigning a variable in an if condition.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 drivers/md/bcache/super.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index db7177d422e5..f09f4f046315 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2328,9 +2328,15 @@ static int __init bcache_init(void)
 		return bcache_major;
 	}
 
-	if (!(bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0)) ||
-	    !(bcache_kobj = kobject_create_and_add("bcache", fs_kobj)) ||
-	    bch_request_init() ||
+	bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0);
+	if (!bcache_wq)
+		goto err;
+
+	bcache_kobj = kobject_create_and_add("bcache", fs_kobj);
+	if (!bcache_kobj)
+		goto err;
+
+	if (bch_request_init() ||
 	    bch_debug_init(bcache_kobj) || closure_debug_init() ||
 	    sysfs_create_files(bcache_kobj, files))
 		goto err;
-- 
2.16.4

