Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3E0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E2E208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E2E208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754732AbeFRC47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:56:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47709 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754666AbeFRC44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:56:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9828CAEBB;
        Mon, 18 Jun 2018 02:56:55 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Mon, 18 Jun 2018 12:52:50 +1000
Subject: [PATCH 6/7] rhashtable: use cmpxchg() to protect ->future_tbl.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152929037051.23173.18373322147570571861.stgit@noble>
In-Reply-To: <152929034948.23173.8671757672560065344.stgit@noble>
References: <152929034948.23173.8671757672560065344.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than borrowing one of the bucket locks to
protect ->future_tbl updates, use cmpxchg().
This gives more freedom to change how bucket locking
is implemented.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rhashtable.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 2aa41c15df17..52ec83212856 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -297,21 +297,14 @@ static int rhashtable_rehash_attach(struct rhashtable *ht,
 				    struct bucket_table *old_tbl,
 				    struct bucket_table *new_tbl)
 {
-	/* Protect future_tbl using the first bucket lock. */
-	spin_lock_bh(old_tbl->locks);
-
-	/* Did somebody beat us to it? */
-	if (rcu_access_pointer(old_tbl->future_tbl)) {
-		spin_unlock_bh(old_tbl->locks);
-		return -EEXIST;
-	}
-
 	/* Make insertions go into the new, empty table right away. Deletions
 	 * and lookups will be attempted in both tables until we synchronize.
+	 * As cmpxchg() provides strong barriers, we do not need
+	 * rcu_assign_pointer().
 	 */
-	rcu_assign_pointer(old_tbl->future_tbl, new_tbl);
 
-	spin_unlock_bh(old_tbl->locks);
+	if (cmpxchg(&old_tbl->future_tbl, NULL, new_tbl) != NULL)
+		return -EEXIST;
 
 	return 0;
 }


