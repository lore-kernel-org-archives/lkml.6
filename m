Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6607C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754372054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570477;
	bh=45WexkbCaMA+QXszrKHbrZhhF+DccvXRga10KbJ6nL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvZOqrkuyTwQiFCrvfjLKk/G58BebVRYyWZlYv9ALTqQFd1ZACM+kDNXctEY/mPkw
	 aOzdWBq79lmo0mn/n09Os4GIZighfEfO1elnRltBHwqZ5o+ChkrBlHGYbtNtt36gvx
	 Z8QJn+pNRUh1E0CHUUuYwD7hYMkcMKimD4Uy9XDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbfAOQlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732724AbfAOQlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:41:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D9DA2054F;
        Tue, 15 Jan 2019 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570470;
        bh=45WexkbCaMA+QXszrKHbrZhhF+DccvXRga10KbJ6nL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2KtnmvcyHoSpUc7HQszDJrr4AJyy+qLF/fMdY9BR3ufQs8ZGnL/tE8XrX472z+lPq
         9KIUapbvthlUn6s5hu2OtNn7UzBhLHSRTn4wLtBBoyLR9dtnBxp2Aa5rqeJYXQ55CC
         x8DC38PovzHPwdxHd+zR16vWSeI4WbJRzjh1JOGw=
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
Subject: [PATCH 4.14 13/27] slab: alien caches must not be initialized if the allocation of the alien cache failed
Date:   Tue, 15 Jan 2019 17:36:02 +0100
Message-Id: <20190115154902.028510696@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
References: <20190115154901.189747728@linuxfoundation.org>
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
@@ -679,8 +679,10 @@ static struct alien_cache *__alloc_alien
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
 


