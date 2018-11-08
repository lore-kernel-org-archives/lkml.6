Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DCCECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD85208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLvzvpe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD85208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeKIHnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731692AbeKIHnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:04 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 993E8208A3;
        Thu,  8 Nov 2018 22:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714734;
        bh=oTIhF7gUkwxoaxZuNSIa2z1UOsjElZinfUYebwnOmUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLvzvpe+Xe1c5xXpQjU603GUDxBNSsq5872egL/Pz3cnSeXEdVsTwn7nRfdzX26aA
         hJ2Rja/5iLzXmkQe4yoXfCfR3IgkPp7q1OoeKzabraUoERb7x3X1sOTKtuab6PVq3u
         BzisuRojDtqPrdWcYvncC5HTjFyXGqgxDPeQn/BY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 095/171] IB/rxe: put the pool on allocation failure
Date:   Thu,  8 Nov 2018 13:51:05 -0800
Message-Id: <20181108215134.368468396@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6b9f8970cd30929cb6b372fa44fa66da9e59c650 ]

If the allocation of elem fails, it is not sufficient to simply check
for NULL and return.  We need to also put our reference on the pool or
else we will leave the pool with a permanent ref count and we will never
be able to free it.

Fixes: 4831ca9e4a8e ("IB/rxe: check for allocation failure on elem")
Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 1c4e5b2e6835..527ca662da69 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -402,23 +402,25 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 	kref_get(&pool->rxe->ref_cnt);
 
-	if (atomic_inc_return(&pool->num_elem) > pool->max_elem) {
-		atomic_dec(&pool->num_elem);
-		rxe_dev_put(pool->rxe);
-		rxe_pool_put(pool);
-		return NULL;
-	}
+	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
+		goto out_put_pool;
 
 	elem = kmem_cache_zalloc(pool_cache(pool),
 				 (pool->flags & RXE_POOL_ATOMIC) ?
 				 GFP_ATOMIC : GFP_KERNEL);
 	if (!elem)
-		return NULL;
+		goto out_put_pool;
 
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
 
 	return elem;
+
+out_put_pool:
+	atomic_dec(&pool->num_elem);
+	rxe_dev_put(pool->rxe);
+	rxe_pool_put(pool);
+	return NULL;
 }
 
 void rxe_elem_release(struct kref *kref)
-- 
2.17.1



