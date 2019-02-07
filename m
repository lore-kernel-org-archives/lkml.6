Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29CBC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6B32080A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539840;
	bh=hxNgexCr6k6tvbn5Wx9EM4jkdhVvq14u5rsoIFeMp0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s1uIvQAujsYrbTkvYCJKmYFh5RmoVyXYBWEIaWAuPZvqRj2/zrDkOjSNJRzAyfTIZ
	 flsSTxOoE9dGZRQrUSyZZnISIKi4eBMJNFBfXig7S4/aZlL/u35T6a4nXs1fTsrmWr
	 q0YoJbxqdpfSxcjEWsGDv/URTZT4GDHgjqd0UsEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfBGLn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:43:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbfBGLn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:43:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC04121917;
        Thu,  7 Feb 2019 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539835;
        bh=hxNgexCr6k6tvbn5Wx9EM4jkdhVvq14u5rsoIFeMp0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PnFRMmcIO3lEj463M3hkmeT3kJuADrAVVTx71kaOE16lJS6+P4KyUcEtya/OLUAfh
         Sgu5d/gcef7o+KVikx6RwZDfRmWJaZuxmKpovCIcc+mfK1YmQ3YEXjEBW90fdFQcNl
         +jJ2BEzHEK8nRDXBIZOCrJ+aCz5YVVz+gelDedR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        =?UTF-8?q?=EB=B0=B0=EC=84=9D=EC=A7=84?= <soukjin.bae@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 31/34] inet: frags: better deal with smp races
Date:   Thu,  7 Feb 2019 12:42:13 +0100
Message-Id: <20190207113026.757970660@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 0d5b9311baf27bb545f187f12ecfd558220c607d upstream.

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
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_fragment.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -188,21 +188,22 @@ static struct inet_frag_queue *inet_frag
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
@@ -215,17 +216,18 @@ EXPORT_SYMBOL(inet_frag_create);
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
 		if (!atomic_inc_not_zero(&fq->refcnt))
 			fq = NULL;
-		rcu_read_unlock();
-		return fq;
 	}
 	rcu_read_unlock();
-	return inet_frag_create(nf, key);
+	return fq;
 }
 EXPORT_SYMBOL(inet_frag_find);


