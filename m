Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F6CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14C221841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217272;
	bh=9nhs/K8NgZHeGJT0prty4ndapnfsmUOg8Yg2y4nX7u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SDkHpwS0438PvAvT0wQHU7LkRRMdbD/bonlYmf0F6HqXp2LQbq0Ql4Fg5jz5Y4ffI
	 +MUF0B0Q19kySZNQr7LcEhbfNGIYFmTlCKsE5eWVFvYAB02BoSBhqlRSq0rJiQlArD
	 bcrLu8FYlfvCtvpIisLD2LgrnpIDx6WO7u5PuGoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389917AbfAKOea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:34:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389897AbfAKOe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:34:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C562063F;
        Fri, 11 Jan 2019 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217265;
        bh=9nhs/K8NgZHeGJT0prty4ndapnfsmUOg8Yg2y4nX7u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuahDgEX4/kMXbY3e32BC/fU7wKyRoDWpcD7Np1Q7LG/OFgwwHfBijTc9IRWWVheR
         KUwfZMm/3NA8/Ds6AjAjvE9horCTEVDR3LK8BJUzKqiizi2VSiGcYV8GrHC5t5vK/O
         +efL+7Jzf7lFgEnrlEBeALDQYkUHbnkt2IGQj7gI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Vasily Averin <vvs@virtuozzo.com>, NeilBrown <neilb@suse.com>,
        "J. Bruce Fields" <bfields@redhat.com>, stable@kernel.org
Subject: [PATCH 4.14 067/105] sunrpc: fix cache_head leak due to queued request
Date:   Fri, 11 Jan 2019 15:14:38 +0100
Message-Id: <20190111131108.632509732@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 struct cache_head *sunrpc_cache_lookup(struct cache_detail *detail,
 				       struct cache_head *key, int hash)
 {
@@ -95,6 +100,7 @@ struct cache_head *sunrpc_cache_lookup(s
 			if (cache_is_expired(detail, tmp)) {
 				hlist_del_init(&tmp->cache_list);
 				detail->entries --;
+				cache_fresh_locked(tmp, 0, detail);
 				freeme = tmp;
 				break;
 			}
@@ -110,8 +116,10 @@ struct cache_head *sunrpc_cache_lookup(s
 	cache_get(new);
 	write_unlock(&detail->hash_lock);
 
-	if (freeme)
+	if (freeme) {
+		cache_fresh_unlocked(freeme, detail);
 		cache_put(freeme, detail);
+	}
 	return new;
 }
 EXPORT_SYMBOL_GPL(sunrpc_cache_lookup);


