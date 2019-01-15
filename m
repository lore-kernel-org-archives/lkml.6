Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDBEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11FF20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570300;
	bh=rHdrXq04PbrnwIJz5EIIABROGpATaSJ0QZrIxxL1cmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u6nriSMKfeCxciHBh+ee/IV/HoVhrTVF+vhHy3brvH94JkQANyrieBXFKma22mDLd
	 vvmn3TefTf1pRsFwqXHvClG4TsYspHFmVnNAeq21Aqy8y/wQ92kFn3lALPWcJzDpOL
	 g+ErKyFI6pUjyiGHic5eV2mJbyMcjMhRR2EVx8eI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbfAOQiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732044AbfAOQiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1ED20675;
        Tue, 15 Jan 2019 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570294;
        bh=rHdrXq04PbrnwIJz5EIIABROGpATaSJ0QZrIxxL1cmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yI+Lnh7yowP0k6Ob05vV+VUGJ4oNwIhHPOWEosyLv1LfgssotiGzddgOHbc03ARSM
         u2XFyV0vKAA6jeMUuSaXTRi3Gk6SqDlOGbiKSz4UKnGz4ayOZVK4IK0jTd9ZTlKMdf
         zrpG0/xrTCkIIOdKoqx3kXOZzw3cyIKOmbzIkZXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        syzbot+d6ed4ec679652b4fd4e4@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 39/51] slab: alien caches must not be initialized if the allocation of the alien cache failed
Date:   Tue, 15 Jan 2019 17:35:35 +0100
Message-Id: <20190115154852.900991742@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
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

From: Christoph Lameter <cl@linux.com>

commit 09c2e76ed734a1d36470d257a778aaba28e86531 upstream.

Callers of __alloc_alien() check for NULL.  We must do the same check in
__alloc_alien_cache to avoid NULL pointer dereferences on allocation
failures.

Link: http://lkml.kernel.org/r/010001680f42f192-82b4e12e-1565-4ee0-ae1f-1e98974906aa-000000@email.amazonses.com
Fixes: 49dfc304ba241 ("slab: use the lock on alien_cache, instead of the lock on array_cache")
Fixes: c8522a3a5832b ("Slab: introduce alloc_alien")
Signed-off-by: Christoph Lameter <cl@linux.com>
Reported-by: syzbot+d6ed4ec679652b4fd4e4@syzkaller.appspotmail.com
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/slab.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/mm/slab.c
+++ b/mm/slab.c
@@ -875,8 +875,10 @@ static struct alien_cache *__alloc_alien
 	struct alien_cache *alc = NULL;
 
 	alc = kmalloc_node(memsize, gfp, node);
-	init_arraycache(&alc->ac, entries, batch);
-	spin_lock_init(&alc->lock);
+	if (alc) {
+		init_arraycache(&alc->ac, entries, batch);
+		spin_lock_init(&alc->lock);
+	}
 	return alc;
 }
 


