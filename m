Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A027C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04E221841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217706;
	bh=s8NNfvVisdaq1k5+MpCpnzUaBtA3p161ro/j6t51LOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zi8ayeZXmi44v6jhT9DJCucqSVV1owhnVaX1c6QLdOS+SV/9vmc8nat2JmhRJPfTy
	 TgJPrCjOkjoJtyiJ5C0V+/BU+40Ve1e/xbTstWHFTWgIJiObZE73VfRA86A3THODrm
	 xnPTMWpRdbMRPyMqL92maDAl/Xqq+oD4u8KRiWhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbfAKOlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391322AbfAKOlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:41:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C50232133F;
        Fri, 11 Jan 2019 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217701;
        bh=s8NNfvVisdaq1k5+MpCpnzUaBtA3p161ro/j6t51LOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPPfodnBxacT89mqjrDOufrdw10uva/vZixoE7klhcf7HKdY+l+IuCCatzYXNyM3j
         cDILNaH+dmZBolCSq7xG+9i9ZByKUCTQb8h+kyXTYu0sMffAcSuZ+hNgrPcGciIa+a
         gfs+fdp8N67h7LEeGvJERL45658Vpo2xPRLXs84M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Vasily Averin <vvs@virtuozzo.com>, NeilBrown <neilb@suse.com>,
        "J. Bruce Fields" <bfields@redhat.com>, stable@kernel.org
Subject: [PATCH 4.20 10/65] sunrpc: fix cache_head leak due to queued request
Date:   Fri, 11 Jan 2019 15:14:56 +0100
Message-Id: <20190111131057.748549749@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit 4ecd55ea074217473f94cfee21bb72864d39f8d7 upstream.

After commit d202cce8963d, an expired cache_head can be removed from the
cache_detail's hash.

However, the expired cache_head may be waiting for a reply from a
previously submitted request. Such a cache_head has an increased
refcounter and therefore it won't be freed after cache_put(freeme).

Because the cache_head was removed from the hash it cannot be found
during cache_clean() and can be leaked forever, together with stalled
cache_request and other taken resources.

In our case we noticed it because an entry in the export cache was
holding a reference on a filesystem.

Fixes d202cce8963d ("sunrpc: never return expired entries in sunrpc_cache_lookup")
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: stable@kernel.org # 2.6.35
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/cache.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -54,6 +54,11 @@ static void cache_init(struct cache_head
 	h->last_refresh = now;
 }
 
+static void cache_fresh_locked(struct cache_head *head, time_t expiry,
+				struct cache_detail *detail);
+static void cache_fresh_unlocked(struct cache_head *head,
+				struct cache_detail *detail);
+
 static struct cache_head *sunrpc_cache_find_rcu(struct cache_detail *detail,
 						struct cache_head *key,
 						int hash)
@@ -100,6 +105,7 @@ static struct cache_head *sunrpc_cache_a
 			if (cache_is_expired(detail, tmp)) {
 				hlist_del_init_rcu(&tmp->cache_list);
 				detail->entries --;
+				cache_fresh_locked(tmp, 0, detail);
 				freeme = tmp;
 				break;
 			}
@@ -115,8 +121,10 @@ static struct cache_head *sunrpc_cache_a
 	cache_get(new);
 	spin_unlock(&detail->hash_lock);
 
-	if (freeme)
+	if (freeme) {
+		cache_fresh_unlocked(freeme, detail);
 		cache_put(freeme, detail);
+	}
 	return new;
 }
 


