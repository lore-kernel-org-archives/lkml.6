Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711DCC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364FF20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVDOPqhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364FF20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbeLEJma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbeLEJm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:42:27 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43ECC2084C;
        Wed,  5 Dec 2018 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002946;
        bh=bO/rl1ox1Aj/DwHru83rzBxB3wJo/WMghjDbUhIXIbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVDOPqhOmof+Znt5FtMNsp90KTK079AwN+BX9pgmtjksL3jaP2uLQjWkb7twWe/P1
         b1vVHhSLXkcV7kUyQ/T9f0RdiXEjPhT7SVVGOeiUnInXktgWDMUJc5hnyuG6SED1Rb
         zUtsutK6RFiaSSqLMipEm8ukmS2g5SRpXb3q0ALc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@gmx.us>, Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 119/123] debugobjects: avoid recursive calls with kmemleak
Date:   Wed,  5 Dec 2018 04:35:51 -0500
Message-Id: <20181205093555.5386-119-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@gmx.us>

[ Upstream commit 8de456cf87ba863e028c4dd01bae44255ce3d835 ]

CONFIG_DEBUG_OBJECTS_RCU_HEAD does not play well with kmemleak due to
recursive calls.

fill_pool
  kmemleak_ignore
    make_black_object
      put_object
        __call_rcu (kernel/rcu/tree.c)
          debug_rcu_head_queue
            debug_object_activate
              debug_object_init
                fill_pool
                  kmemleak_ignore
                    make_black_object
                      ...

So add SLAB_NOLEAKTRACE to kmem_cache_create() to not register newly
allocated debug objects at all.

Link: http://lkml.kernel.org/r/20181126165343.2339-1-cai@gmx.us
Signed-off-by: Qian Cai <cai@gmx.us>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 70935ed91125..14afeeb7d6ef 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -135,7 +135,6 @@ static void fill_pool(void)
 		if (!new)
 			return;
 
-		kmemleak_ignore(new);
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		hlist_add_head(&new->node, &obj_pool);
 		debug_objects_allocated++;
@@ -1128,7 +1127,6 @@ static int __init debug_objects_replace_static_objects(void)
 		obj = kmem_cache_zalloc(obj_cache, GFP_KERNEL);
 		if (!obj)
 			goto free;
-		kmemleak_ignore(obj);
 		hlist_add_head(&obj->node, &objects);
 	}
 
@@ -1184,7 +1182,8 @@ void __init debug_objects_mem_init(void)
 
 	obj_cache = kmem_cache_create("debug_objects_cache",
 				      sizeof (struct debug_obj), 0,
-				      SLAB_DEBUG_OBJECTS, NULL);
+				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
+				      NULL);
 
 	if (!obj_cache || debug_objects_replace_static_objects()) {
 		debug_objects_enabled = 0;
-- 
2.17.1

