Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A211C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563122070B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999811;
	bh=qs8KlSQ+rjh8e+02sNflB8EQeYUwTVRq5iy9QGpg2iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l0UfwILLK/4etWsI7YArzolwu4GADfPBBQHxNNUGO0OPVCuQf0e4NehV/3RZVNagd
	 kTBIyzHvahZei1dXYj9fjhZv09CM/3jMMuQxXpLuiSJ/6veNF4P66yGjFDLAY8NZA/
	 sMdUF3I85+hmwP0V9w9pkWnMD1snbXm18nXppQb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbeL1MXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbeL1MOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39B102146F;
        Fri, 28 Dec 2018 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999281;
        bh=qs8KlSQ+rjh8e+02sNflB8EQeYUwTVRq5iy9QGpg2iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lp5uhpFwW5X4i6EHP2bcwazigWiaWIiENqTc0DstPVu7QRcgWr/Xn4nK77Det+B2a
         8uRHAcTbRX98LFI0QvoJcTFHpJFzRQbH57XFkC8GEQGJmL1SldAr7b7Kd2MJ0CUSMD
         xWe5l+oor++N4xKll7WxfcGbiE8YXP6pXDQBA07g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Mathias Krause <minipli@googlemail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.19 34/46] xfrm_user: fix freeing of xfrm states on acquire
Date:   Fri, 28 Dec 2018 12:52:28 +0100
Message-Id: <20181228113126.828460603@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Krause <minipli@googlemail.com>

commit 4a135e538962cb00a9667c82e7d2b9e4d7cd7177 upstream.

Commit 565f0fa902b6 ("xfrm: use a dedicated slab cache for struct
xfrm_state") moved xfrm state objects to use their own slab cache.
However, it missed to adapt xfrm_user to use this new cache when
freeing xfrm states.

Fix this by introducing and make use of a new helper for freeing
xfrm_state objects.

Fixes: 565f0fa902b6 ("xfrm: use a dedicated slab cache for struct xfrm_state")
Reported-by: Pan Bian <bianpan2016@163.com>
Cc: <stable@vger.kernel.org> # v4.18+
Signed-off-by: Mathias Krause <minipli@googlemail.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/xfrm.h    |    1 +
 net/xfrm/xfrm_state.c |    8 +++++++-
 net/xfrm/xfrm_user.c  |    4 ++--
 3 files changed, 10 insertions(+), 3 deletions(-)

--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1552,6 +1552,7 @@ int xfrm_state_walk(struct net *net, str
 		    int (*func)(struct xfrm_state *, int, void*), void *);
 void xfrm_state_walk_done(struct xfrm_state_walk *walk, struct net *net);
 struct xfrm_state *xfrm_state_alloc(struct net *net);
+void xfrm_state_free(struct xfrm_state *x);
 struct xfrm_state *xfrm_state_find(const xfrm_address_t *daddr,
 				   const xfrm_address_t *saddr,
 				   const struct flowi *fl,
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -426,6 +426,12 @@ static void xfrm_put_mode(struct xfrm_mo
 	module_put(mode->owner);
 }
 
+void xfrm_state_free(struct xfrm_state *x)
+{
+	kmem_cache_free(xfrm_state_cache, x);
+}
+EXPORT_SYMBOL(xfrm_state_free);
+
 static void xfrm_state_gc_destroy(struct xfrm_state *x)
 {
 	tasklet_hrtimer_cancel(&x->mtimer);
@@ -452,7 +458,7 @@ static void xfrm_state_gc_destroy(struct
 	}
 	xfrm_dev_state_free(x);
 	security_xfrm_state_free(x);
-	kmem_cache_free(xfrm_state_cache, x);
+	xfrm_state_free(x);
 }
 
 static void xfrm_state_gc_task(struct work_struct *work)
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2288,13 +2288,13 @@ static int xfrm_add_acquire(struct sk_bu
 
 	}
 
-	kfree(x);
+	xfrm_state_free(x);
 	kfree(xp);
 
 	return 0;
 
 free_state:
-	kfree(x);
+	xfrm_state_free(x);
 nomem:
 	return err;
 }


