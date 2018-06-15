Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AA8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA83A20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gt7/IhO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA83A20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756608AbeFOWUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:20:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10697 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbeFOWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1529101243; x=1560637243;
  h=from:to:cc:subject:date:message-id;
  bh=/wH011kFI1FzxMdbVhreZtZ/XI3+AcncW/91jksqT9k=;
  b=Gt7/IhO9abQAwkUdG8zGAfAZmzWF485YH6wnXHcy1ZPC4A5yC9PTKsbG
   SLwHKFHBDuaQCZWO37zsqon3GlKvzQDkF3Mt1HgNOPCess28kMBcMx+/1
   5AB0JyLzYFWXGNHlCkOnwuFaYJksKVs9QvYXaUq0uYj1m80989y+mLU0n
   hWbto0KHyDYWa9I41oIG6kcNzkT4XPWpKWEP4nvrAl9tIUoKtf/HKU99a
   9mtkqUVapjkku3it/8JDBSsiM7eVAV8ADzZMTAP8V+yefJqDrGsfKEXjU
   CttNtTPga/7o5UgJ6nLI8hfPl5fYnrp7C6sq0YyUPW67+TbbFZR7sn2Qa
   w==;
X-IronPort-AV: E=Sophos;i="5.51,228,1526313600"; 
   d="scan'208";a="82733610"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2018 06:20:43 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 15 Jun 2018 15:10:24 -0700
Received: from thinkpad-bart.sdcorp.global.sandisk.com ([10.111.67.248])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jun 2018 15:20:42 -0700
From:   Bart Van Assche <bart.vanassche@wdc.com>
To:     Joel Becker <jlbec@evilplan.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH] configfs: Use kvasprintf() instead of open-coding it
Date:   Fri, 15 Jun 2018 15:20:42 -0700
Message-Id: <20180615222042.30397-1-bart.vanassche@wdc.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 fs/configfs/item.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/fs/configfs/item.c b/fs/configfs/item.c
index 88f266efc09b..99d491cd01f9 100644
--- a/fs/configfs/item.c
+++ b/fs/configfs/item.c
@@ -64,7 +64,6 @@ static void config_item_init(struct config_item *item)
  */
 int config_item_set_name(struct config_item *item, const char *fmt, ...)
 {
-	int error = 0;
 	int limit = CONFIGFS_ITEM_NAME_LEN;
 	int need;
 	va_list args;
@@ -79,25 +78,11 @@ int config_item_set_name(struct config_item *item, const char *fmt, ...)
 	if (need < limit)
 		name = item->ci_namebuf;
 	else {
-		/*
-		 * Need more space? Allocate it and try again
-		 */
-		limit = need + 1;
-		name = kmalloc(limit, GFP_KERNEL);
-		if (!name) {
-			error = -ENOMEM;
-			goto Done;
-		}
 		va_start(args, fmt);
-		need = vsnprintf(name, limit, fmt, args);
+		name = kvasprintf(GFP_KERNEL, fmt, args);
 		va_end(args);
-
-		/* Still? Give up. */
-		if (need >= limit) {
-			kfree(name);
-			error = -EFAULT;
-			goto Done;
-		}
+		if (!name)
+			return -EFAULT;
 	}
 
 	/* Free the old name, if necessary. */
@@ -106,8 +91,7 @@ int config_item_set_name(struct config_item *item, const char *fmt, ...)
 
 	/* Now, set the new name */
 	item->ci_name = name;
- Done:
-	return error;
+	return 0;
 }
 EXPORT_SYMBOL(config_item_set_name);
 
-- 
2.17.0

