Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB56C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11936206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFBbUXFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11936206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbeKVFop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:44:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732079AbeKVFop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:44:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C080206BB;
        Wed, 21 Nov 2018 19:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827351;
        bh=i633TxlyqP9zN6D9illH9epcTUgKdRKKmNwNKbGYkjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFBbUXFsTs+TLf1V71BQiBRON0egJeiyFOykw5Cl64NksIcTIQF8cSM1DjY7jnHDF
         g1AXx+DeuTvhLRduaCGtDvGmQh/2aUNBd4h44+B/DKDECSnwzlHFAet2pO8hnAt30N
         gL1BItT4kjD/S0E21f4dsrQJIaUVu69Eq+OZon3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        =?UTF-8?q?=EB=B0=B0=EC=84=9D=EC=A7=84?= <soukjin.bae@samsung.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 18/21] inet: frags: better deal with smp races
Date:   Wed, 21 Nov 2018 20:07:02 +0100
Message-Id: <20181121183422.893081945@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
References: <20181121183422.103826775@linuxfoundation.org>
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

[ Upstream commit 0d5b9311baf27bb545f187f12ecfd558220c607d ]

Multiple cpus might attempt to insert a new fragment in rhashtable,
if for example RPS is buggy, as reported by 배석진 in
https://patchwork.ozlabs.org/patch/994601/

We use rhashtable_lookup_get_insert_key() instead of
rhashtable_insert_fast() to let cpus losing the race
free their own inet_frag_queue and use the one that
was inserted by another cpu.

Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: 배석진 <soukjin.bae@samsung.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_fragment.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -180,21 +180,22 @@ static struct inet_frag_queue *inet_frag
 }
 
 static struct inet_frag_queue *inet_frag_create(struct netns_frags *nf,
-						void *arg)
+						void *arg,
+						struct inet_frag_queue **prev)
 {
 	struct inet_frags *f = nf->f;
 	struct inet_frag_queue *q;
-	int err;
 
 	q = inet_frag_alloc(nf, f, arg);
-	if (!q)
+	if (!q) {
+		*prev = ERR_PTR(-ENOMEM);
 		return NULL;
-
+	}
 	mod_timer(&q->timer, jiffies + nf->timeout);
 
-	err = rhashtable_insert_fast(&nf->rhashtable, &q->node,
-				     f->rhash_params);
-	if (err < 0) {
+	*prev = rhashtable_lookup_get_insert_key(&nf->rhashtable, &q->key,
+						 &q->node, f->rhash_params);
+	if (*prev) {
 		q->flags |= INET_FRAG_COMPLETE;
 		inet_frag_kill(q);
 		inet_frag_destroy(q);
@@ -206,19 +207,20 @@ static struct inet_frag_queue *inet_frag
 /* TODO : call from rcu_read_lock() and no longer use refcount_inc_not_zero() */
 struct inet_frag_queue *inet_frag_find(struct netns_frags *nf, void *key)
 {
-	struct inet_frag_queue *fq;
+	struct inet_frag_queue *fq = NULL, *prev;
 
 	rcu_read_lock();
 
-	fq = rhashtable_lookup(&nf->rhashtable, key, nf->f->rhash_params);
-	if (fq) {
+	prev = rhashtable_lookup(&nf->rhashtable, key, nf->f->rhash_params);
+	if (!prev)
+		fq = inet_frag_create(nf, key, &prev);
+	if (prev && !IS_ERR(prev)) {
+		fq = prev;
 		if (!refcount_inc_not_zero(&fq->refcnt))
 			fq = NULL;
-		rcu_read_unlock();
-		return fq;
 	}
 	rcu_read_unlock();
 
-	return inet_frag_create(nf, key);
+	return fq;
 }
 EXPORT_SYMBOL(inet_frag_find);


