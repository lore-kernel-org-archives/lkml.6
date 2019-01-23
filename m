Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13284C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34232184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="hkVutrwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfAWVUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:20:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36409 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfAWVUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:20:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so1822684pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bx0GVwN+/IXTNkh6VmHwdIZW0CTo69XIFMKKCgUqC/w=;
        b=hkVutrwa5Huy/h8BU5djJ5x/ro6a1dL2C8b2CBsiJplrrwU1cvcLycu01aszyRqJD3
         WzDVGhcZzv5/JqL15hEys8jmlVdiRKTMcCqt+GyZNpqpNVI29An3/AxGJwaTVclO3a/w
         IArAO8tEt8KNs4q0W9Tw5RdhZStEXWqG5Yt3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bx0GVwN+/IXTNkh6VmHwdIZW0CTo69XIFMKKCgUqC/w=;
        b=AfiX284E6goI+h6MvPVF/wU48ks3hHDx+u5jeLNNo3YHFQCNuvAo5DYMqlqFoL+mWD
         wnYqk6kwTGtVep/PzdMURdwRyXxpuqX6canfpeTy69lpetbwNoz+MC+cwvVIZczQ7ZK+
         RbRFFCRQpEJV8SOXAkteivRCQPXgxJNHOBIsZ7DCOHcd3RY/l7icHHFETEkodwb8N9/J
         wqNAJQkhlMKZddfKqyiEXsa8yPrpO+fT4FX0RTjDQOzCnStCSBa+nzVslLBD8Wf6mCk6
         uik+KWIDfy3MKYSDXsYAsMz908z8+MeXXfRVOS5T3yS5GKGptEoyRqpFd3NS3YP0t8f9
         /YKg==
X-Gm-Message-State: AJcUukeA/6Zbs+3f6vTXIYtQT+mwvXKp/Yu5qz/YxGnkaaAEim0aMpO2
        Fqh04p4ylVuubREazxljB6cb
X-Google-Smtp-Source: ALg8bN6Z/fjIdfXgS3Eqthssoa/UV3KFJAqweTSE29ZMxdbY/ds4E3XiEMUGddiK4qIMSu/6YB8nKQ==
X-Received: by 2002:a63:a91a:: with SMTP id u26mr3436095pge.349.1548278452786;
        Wed, 23 Jan 2019 13:20:52 -0800 (PST)
Received: from debian9-jae.jaalam.net ([209.139.228.33])
        by smtp.gmail.com with ESMTPSA id u6sm22801696pgr.79.2019.01.23.13.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 13:20:52 -0800 (PST)
From:   Josh Elsasser <jelsasser@appneta.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     josh@elsasser.ca, Josh Elsasser <jelsasser@appneta.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] rhashtable: avoid reschedule loop after rapid growth and shrink
Date:   Wed, 23 Jan 2019 13:17:58 -0800
Message-Id: <20190123211758.104275-1-jelsasser@appneta.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running workloads with large bursts of fragmented packets, we've seen
a few machines stuck returning -EEXIST from rht_shrink() and endlessly
rescheduling their hash table's deferred work, pegging a CPU core.

Root cause is commit da20420f83ea ("rhashtable: Add nested tables"), which
stops ignoring the return code of rhashtable_shrink() and the reallocs
used to grow the hashtable. This uncovers a bug in the shrink logic where
"needs to shrink" check runs against the last table but the actual shrink
operation runs on the first bucket_table in the hashtable (see below):

 +-------+    +--------------+          +---------------+
 | ht    |    | "first" tbl  |          | "last" tbl    |
 | - tbl ---> | - future_tbl ---------> |  - future_tbl ---> NULL
 +-------+    +--------------+          +---------------+
               ^^^                          ^^^
	       used by rhashtable_shrink()  used by rht_shrink_below_30()

A rehash then stalls out when both the last table needs to shrink, the
first table has more elements than the target size, but rht_shrink() hits
a non-NULL future_tbl and returns -EEXIST. This skips the item rehashing
and kicks off a reschedule loop, as no forward progress can be made while
the rhashtable needs to shrink.

Extend rhashtable_shrink() with a "tbl" param to avoid endless exit-and-
reschedules after hitting the EEXIST, allowing it to check a future_tbl
pointer that can actually be non-NULL and make forward progress when the
hashtable needs to shrink.

Fixes: da20420f83ea ("rhashtable: Add nested tables")
Signed-off-by: Josh Elsasser <jelsasser@appneta.com>
---
 lib/rhashtable.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 852ffa5160f1..98e91f9544fa 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -377,9 +377,9 @@ static int rhashtable_rehash_alloc(struct rhashtable *ht,
  * It is valid to have concurrent insertions and deletions protected by per
  * bucket locks or concurrent RCU protected lookups and traversals.
  */
-static int rhashtable_shrink(struct rhashtable *ht)
+static int rhashtable_shrink(struct rhashtable *ht,
+			     struct bucket_table *old_tbl)
 {
-	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
 	unsigned int nelems = atomic_read(&ht->nelems);
 	unsigned int size = 0;
 
@@ -412,7 +412,7 @@ static void rht_deferred_worker(struct work_struct *work)
 	if (rht_grow_above_75(ht, tbl))
 		err = rhashtable_rehash_alloc(ht, tbl, tbl->size * 2);
 	else if (ht->p.automatic_shrinking && rht_shrink_below_30(ht, tbl))
-		err = rhashtable_shrink(ht);
+		err = rhashtable_shrink(ht, tbl);
 	else if (tbl->nest)
 		err = rhashtable_rehash_alloc(ht, tbl, tbl->size);
 
-- 
2.19.1

