Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeC0Bvf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:51:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38995 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752344AbeC0Bvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:51:33 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 27 Mar 2018 10:33:04 +1100
Subject: [PATCH 3/6] rhashtable: reset intr when rhashtable_walk_start sees
 new table
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152210718427.11435.17689950338335773862.stgit@noble>
In-Reply-To: <152210688405.11435.13010923693146415942.stgit@noble>
References: <152210688405.11435.13010923693146415942.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation claims that when rhashtable_walk_start_check()
detects a resize event, it will rewind back to the beginning
of the table.  This is not true.  We need to set ->slot and
->skip to be zero for it to be true.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rhashtable.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 24a57ca494cb..08018198f045 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -733,6 +733,8 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
 
 	if (!iter->walker.tbl && !iter->end_of_table) {
 		iter->walker.tbl = rht_dereference_rcu(ht->tbl, ht);
+		iter->slot = 0;
+		iter->skip = 0;
 		return -EAGAIN;
 	}
 
