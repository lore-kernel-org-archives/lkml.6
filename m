Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929B7C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5800520892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790580;
	bh=gmGAB9DFrtE9rUCRd96HLYIwHgcO5ij7LiYLnoYYSGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CHHO1DQ0CFdrEP3ILi/zhAvMs9ieV1put2hzMfoVO5HXre1A+5Ecubw6YD+A/y5de
	 xMZs+F9/Hfnkc1W4UpNf8KscYVigm4ggUoSMeK3/NfPU/9PynPFzeCbDVN944ZqGQJ
	 1x2inGC0D6Nja1n1e28HmWQAEw3bjvZoKi8sDRS0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5800520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbeLNMK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731373AbeLNMKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD24214D9;
        Fri, 14 Dec 2018 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789423;
        bh=gmGAB9DFrtE9rUCRd96HLYIwHgcO5ij7LiYLnoYYSGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYPEH6yacXG6xnCozeLDvEnUid87VJe7ieftnaLEvE5zncgoP2s+wSVbQ9dgH7HoS
         5GAnye1poREZ2AsRT7v08VuGr67DmzZemtgHyTYeElWfMvk29YWTPorPgIUQWz+z2D
         ra1U8u5tdQenbjizWtC0tAuqjG82yFx+/Via71qA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@gmx.us>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 77/89] debugobjects: avoid recursive calls with kmemleak
Date:   Fri, 14 Dec 2018 13:00:30 +0100
Message-Id: <20181214115733.502311885@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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
index 99308479b1c8..bacb00a9cd9f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -111,7 +111,6 @@ static void fill_pool(void)
 		if (!new)
 			return;
 
-		kmemleak_ignore(new);
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		hlist_add_head(&new->node, &obj_pool);
 		debug_objects_allocated++;
@@ -1085,7 +1084,6 @@ static int __init debug_objects_replace_static_objects(void)
 		obj = kmem_cache_zalloc(obj_cache, GFP_KERNEL);
 		if (!obj)
 			goto free;
-		kmemleak_ignore(obj);
 		hlist_add_head(&obj->node, &objects);
 	}
 
@@ -1141,7 +1139,8 @@ void __init debug_objects_mem_init(void)
 
 	obj_cache = kmem_cache_create("debug_objects_cache",
 				      sizeof (struct debug_obj), 0,
-				      SLAB_DEBUG_OBJECTS, NULL);
+				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
+				      NULL);
 
 	if (!obj_cache || debug_objects_replace_static_objects()) {
 		debug_objects_enabled = 0;
-- 
2.19.1



