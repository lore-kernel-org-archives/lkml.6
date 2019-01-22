Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FC1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1707F217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170609;
	bh=i9+4GiLYRtmtv3ir+rbnVncJd83gUJJKoqTnAuitgYc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sB9BZJPFDjkrKK5k3sA2MTrSDQPvCVyFfZP7SVRwi2R22/8Mrhmhzmc8OQBoAhLBW
	 RKFADzicr2sQje1if0bwl9x2bNnpaDtAM2qcbhuuJMsU2/3guq26ZbDl/oieAxiICZ
	 dgS4rNDixJAVwDOZoLqbjxb6eiKUhAZw+JvO+uA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfAVPX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbfAVPXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 640F8217D4;
        Tue, 22 Jan 2019 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170604;
        bh=i9+4GiLYRtmtv3ir+rbnVncJd83gUJJKoqTnAuitgYc=;
        h=From:To:Cc:Subject:Date:From;
        b=2RVF+90PHUspuFyfrOJlpHopGsdIkh6jBP4DMuRChHm7DCuXC64LSiW9J8+8v6PRt
         oZmSkuGjVysIKnYVjs8XO03fgyCO9h41DpBhJE4DEuvwJQTtOMsKCL13NOiK7UQoNg
         AyNqLE1HKmb+hiseg7GdQwmWIS/IJpKPkRO4S8DE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org
Subject: [PATCH] zsmalloc: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:09 +0100
Message-Id: <20190122152151.16139-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-mm@kvack.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/zsmalloc.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 0787d33b80d8..1347d7922ea2 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -575,8 +575,6 @@ static void __init zs_stat_init(void)
 	}
 
 	zs_stat_root = debugfs_create_dir("zsmalloc", NULL);
-	if (!zs_stat_root)
-		pr_warn("debugfs 'zsmalloc' stat dir creation failed\n");
 }
 
 static void __exit zs_stat_exit(void)
@@ -654,22 +652,10 @@ static void zs_pool_stat_create(struct zs_pool *pool, const char *name)
 		return;
 	}
 
-	entry = debugfs_create_dir(name, zs_stat_root);
-	if (!entry) {
-		pr_warn("debugfs dir <%s> creation failed\n", name);
-		return;
-	}
-	pool->stat_dentry = entry;
-
-	entry = debugfs_create_file("classes", S_IFREG | 0444,
-				    pool->stat_dentry, pool,
-				    &zs_stats_size_fops);
-	if (!entry) {
-		pr_warn("%s: debugfs file entry <%s> creation failed\n",
-				name, "classes");
-		debugfs_remove_recursive(pool->stat_dentry);
-		pool->stat_dentry = NULL;
-	}
+	pool->stat_dentry = debugfs_create_dir(name, zs_stat_root);
+
+	debugfs_create_file("classes", S_IFREG | 0444, pool->stat_dentry, pool,
+			    &zs_stats_size_fops);
 }
 
 static void zs_pool_stat_destroy(struct zs_pool *pool)
-- 
2.20.1

