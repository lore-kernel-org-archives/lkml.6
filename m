Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED0C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8324208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8324208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbeHBC1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:27:34 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.101]:42560 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbeHBC1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:27:33 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id E58DB1DC5CD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 19:39:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id l1dyf2apCbXuJl1dyfSble; Wed, 01 Aug 2018 19:39:06 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=43304 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fl1dy-001tM9-EH; Wed, 01 Aug 2018 19:39:06 -0500
Date:   Wed, 1 Aug 2018 19:39:05 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] fs: dcache: Use true and false for boolean values
Message-ID: <20180802003905.GA21639@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.61.218
X-Source-L: No
X-Exim-ID: 1fl1dy-001tM9-EH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:43304
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/dcache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b928915..8c07ab1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -733,16 +733,16 @@ static inline bool fast_dput(struct dentry *dentry)
 		if (dentry->d_lockref.count > 1) {
 			dentry->d_lockref.count--;
 			spin_unlock(&dentry->d_lock);
-			return 1;
+			return true;
 		}
-		return 0;
+		return false;
 	}
 
 	/*
 	 * If we weren't the last ref, we're done.
 	 */
 	if (ret)
-		return 1;
+		return true;
 
 	/*
 	 * Careful, careful. The reference count went down
@@ -771,7 +771,7 @@ static inline bool fast_dput(struct dentry *dentry)
 
 	/* Nothing to do? Dropping the reference was all we needed? */
 	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
-		return 1;
+		return true;
 
 	/*
 	 * Not the fast normal case? Get the lock. We've already decremented
@@ -788,7 +788,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	if (dentry->d_lockref.count) {
 		spin_unlock(&dentry->d_lock);
-		return 1;
+		return true;
 	}
 
 	/*
@@ -797,7 +797,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * set it to 1.
 	 */
 	dentry->d_lockref.count = 1;
-	return 0;
+	return false;
 }
 
 
-- 
2.7.4

