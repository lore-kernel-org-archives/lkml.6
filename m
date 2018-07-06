Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4251C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FB7219DA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FB7219DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754164AbeGFHXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:23:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:48864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753476AbeGFHXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:23:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89E3FAFCC;
        Fri,  6 Jul 2018 07:23:11 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri, 06 Jul 2018 17:22:30 +1000
Subject: [PATCH 1/5] rhashtable: use cmpxchg() in nested_table_alloc()
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <153086175005.24852.16109495489833855391.stgit@noble>
In-Reply-To: <153086169828.24852.10332573315056854948.stgit@noble>
References: <153086169828.24852.10332573315056854948.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nested_table_alloc() relies on the fact that there is
at most one spinlock allocated for every slot in the top
level nested table, so it is not possible for two threads
to try to allocate the same table at the same time.

A future patch will change the locking and invalidate
this assumption.  So change the code to protect against
a race using cmpxchg() - if it loses, it frees the table
that it allocated.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rhashtable.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 9ddb7134285e..c6eaeaff16d1 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -132,9 +132,11 @@ static union nested_table *nested_table_alloc(struct rhashtable *ht,
 			INIT_RHT_NULLS_HEAD(ntbl[i].bucket);
 	}
 
-	rcu_assign_pointer(*prev, ntbl);
-
-	return ntbl;
+	if (cmpxchg(prev, NULL, ntbl) == NULL)
+		return ntbl;
+	/* Raced with another thread. */
+	kfree(ntbl);
+	return rcu_dereference(*prev);
 }
 
 static struct bucket_table *nested_bucket_table_alloc(struct rhashtable *ht,


