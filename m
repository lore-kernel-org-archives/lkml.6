Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C84C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B7D22432
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XVRIEm1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B7D22432
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934044AbeFUVcy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:32:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933968AbeFUV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=he4LchhH0ZhNYXo30SJP2NvkEmGGjaOKw+GZ4cMdmL8=; b=XVRIEm1B2Wkjk8vJ5JjSNvLyB
        LCcqYs7RQk5OigRzP6cdY40qaUpvXupabrU0SvwmCQ82Ad4A6C5yuiy3rjTW/QtclCovATwl0IaTT
        tyuU1PeuyHfulaxH9JHoPbWdXUryn6qtplBQlYLvJUkabfzWI/nLhrD8nO+sBzf8TUi2WCGcL6Ewe
        rT83JmW/g4BFURcBJNwirrSvo9mGQuweQBupmW1zfHSm/go7/Znqx7+iLc2z6+nPG2aHB9+T5uw1y
        FhS+XeyGtK49arxt3anwJIOcj/jMJwUHeMMbQpuQYklXTem08pW3vSFvp+f4G74aE/PW7DXibmosg
        5RQ70FqXA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78g-0001cb-HD; Thu, 21 Jun 2018 21:29:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 20/26] idr-test: Convert ida_check_nomem to new API
Date:   Thu, 21 Jun 2018 14:28:29 -0700
Message-Id: <20180621212835.5636-21-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't move this test to kernel space because there's no way to
force kmalloc to fail.  But we can use the new API and check this
works when the test is in userspace.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 tools/testing/radix-tree/idr-test.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 604b51dc9b38..0f557784327d 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -320,19 +320,20 @@ void ida_dump(struct ida *);
 
 /*
  * Check that we get the correct error when we run out of memory doing
- * allocations.  To ensure we run out of memory, just "forget" to preload.
+ * allocations.  In userspace, GFP_NOWAIT will always fail an allocation.
  * The first test is for not having a bitmap available, and the second test
  * is for not being able to allocate a level of the radix tree.
  */
 void ida_check_nomem(void)
 {
 	DEFINE_IDA(ida);
-	int id, err;
+	int id;
 
-	err = ida_get_new_above(&ida, 256, &id);
-	assert(err == -EAGAIN);
-	err = ida_get_new_above(&ida, 1UL << 30, &id);
-	assert(err == -EAGAIN);
+	id = ida_alloc_min(&ida, 256, GFP_NOWAIT);
+	IDA_BUG_ON(&ida, id != -ENOMEM);
+	id = ida_alloc_min(&ida, 1UL << 30, GFP_NOWAIT);
+	IDA_BUG_ON(&ida, id != -ENOMEM);
+	IDA_BUG_ON(&ida, !ida_is_empty(&ida));
 }
 
 /*
-- 
2.17.1

