Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61514C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272E0213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5+W0k7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272E0213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeLEJv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:51:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbeLEJv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:51:27 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B35A22082B;
        Wed,  5 Dec 2018 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003487;
        bh=TuYDru3phCyU3K9B8a51AWeCuffIK8yuy1oAzXIlIio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5+W0k7RqIaYRPXxda+d9wSjxQhyppbKZPQLjeb9q08kbdWQ4joWrduc0F8sSNbq+
         iZ3en65dtDjVev8tLsrarYcDsChdedN116qAdFHnRC7qtWFY7913l6msdMrcubmYKz
         8G6QZSBJsjTo3ILrR5utzZiGHMftiIT/67VlgGTM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@gmx.us>, Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 44/45] debugobjects: avoid recursive calls with kmemleak
Date:   Wed,  5 Dec 2018 04:47:05 -0500
Message-Id: <20181205094706.7225-44-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094706.7225-1-sashal@kernel.org>
References: <20181205094706.7225-1-sashal@kernel.org>
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
 lib/debugobjects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 88580e8ee39e..1c43d4c5d2ab 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1110,7 +1110,8 @@ void __init debug_objects_mem_init(void)
 
 	obj_cache = kmem_cache_create("debug_objects_cache",
 				      sizeof (struct debug_obj), 0,
-				      SLAB_DEBUG_OBJECTS, NULL);
+				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
+				      NULL);
 
 	if (!obj_cache || debug_objects_replace_static_objects()) {
 		debug_objects_enabled = 0;
-- 
2.17.1

