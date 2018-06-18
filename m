Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0D5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73144208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73144208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbeFRC4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:56:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:47606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754516AbeFRC4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:56:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA3E1AED1;
        Mon, 18 Jun 2018 02:56:22 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Mon, 18 Jun 2018 12:52:50 +1000
Subject: [PATCH 1/7] rhashtable: silence RCU warning in rhashtable_test.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152929037032.23173.10158594383022895152.stgit@noble>
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

print_ht in rhashtable_test calls rht_dereference() with neither
RCU protection or the mutex.  This triggers an RCU warning.
So take the mutex to silence the warning.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/test_rhashtable.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index fb6968109113..6ca59ffcacbe 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -501,6 +501,8 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 	unsigned int i, cnt = 0;
 
 	ht = &rhlt->ht;
+	/* Take the mutex to avoid RCU warning */
+	mutex_lock(&ht->mutex);
 	tbl = rht_dereference(ht->tbl, ht);
 	for (i = 0; i < tbl->size; i++) {
 		struct rhash_head *pos, *next;
@@ -534,6 +536,7 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 		}
 	}
 	printk(KERN_ERR "\n---- ht: ----%s\n-------------\n", buff);
+	mutex_unlock(&ht->mutex);
 
 	return cnt;
 }


