Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A472ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46089214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46089214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbeIREe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730207AbeIREeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:25 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6B26C03;
        Mon, 17 Sep 2018 23:04:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 099/126] rhashtable: add schedule points
Date:   Tue, 18 Sep 2018 00:42:27 +0200
Message-Id: <20180917211710.401950636@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

Rehashing and destroying large hash table takes a lot of time,
and happens in process context. It is safe to add cond_resched()
in rhashtable_rehash_table() and rhashtable_free_and_destroy()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit ae6da1f503abb5a5081f9f6c4a6881de97830f3e)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/rhashtable.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -364,6 +364,7 @@ static int rhashtable_rehash_table(struc
 		err = rhashtable_rehash_chain(ht, old_hash);
 		if (err)
 			return err;
+		cond_resched();
 	}
 
 	/* Publish the new table pointer. */
@@ -1073,6 +1074,7 @@ void rhashtable_free_and_destroy(struct
 		for (i = 0; i < tbl->size; i++) {
 			struct rhash_head *pos, *next;
 
+			cond_resched();
 			for (pos = rht_dereference(*rht_bucket(tbl, i), ht),
 			     next = !rht_is_a_nulls(pos) ?
 					rht_dereference(pos->next, ht) : NULL;


