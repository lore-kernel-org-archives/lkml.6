Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3818C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A38205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HhlIJr4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfBNAZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:25:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47071 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfBNAZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:25:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so4516423wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xv22CgztNiptmL1IpEe32/U9BVLPdU1sqDTM5ZydeiE=;
        b=HhlIJr4FWxNaNivefuJ+bnt6Cq6HW7Q52ilE48ZsQqjbtnHgee4hlqRgSCcjUyQ3d5
         RBdZpO9q2BMCElpsu8MXwIzHOZe5OUT5V8X7obmacrhhCOGKhX8nOQwKazkEjSUND7xk
         66AtVE3HBZnXxcev29ErJipHiWd3dzL/rEqAxab/+R7IAKEDZJ8thijXd9ztOjoHl/6C
         XDXL+vWafOandWWLJMbEb6N1SIHoCLHF4ZsxnBgIJ6z7DVSB23yvsjKxRmeC5yYH+a91
         NrmImhn+jkl+ZXn5wJdNRaQrjaLJV9E0JojwqpVn7/1xHsCbw/mYOLRJqUsLR/pLYZu+
         /9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xv22CgztNiptmL1IpEe32/U9BVLPdU1sqDTM5ZydeiE=;
        b=qEqwxXmAvfgt/M1ngar/v+2Gs88rxO4fYO7ORtX5qOjIfu6cBgTstsSuntBKnEIzD0
         YUkkatA2S4U0pUO4VL7ctyyOuHQW6fMDxaFRKGIreJKuNYQcRxPxfkMFa1eH3Tnb7Ct1
         aH/iI7KHMCB3rVdfAg4cRPR0a4/Vc3fcFtSvXZLLi6zAOLivFb403ONi5cGP7mx3AsrW
         ZCilO11ID234/1c9MVdFJES9K3CR+0KFzqIk0zhhyzx8n7DsJDWu63oTT3dMOyO66S64
         5nkLiu/24xJg3F33GbH9oTIvRO2aiqpCjA5I8vzNQbBEAvR9iJtPMhNThQUDtasc/IkW
         pKZQ==
X-Gm-Message-State: AHQUAuYqNYRE0qs9cJBI1ojaxxsGsnjr0dtiiMHMZgJMffDJeHeKJL8g
        8z2opymDHJwZh8KnVqt3k5AtNA==
X-Google-Smtp-Source: AHgI3IYd9U0Z1ZibscRpnAuj8JVl1ut7OMIRHjvQVt/fMZsv+OV+uKxcoCfJmTEmRasdp0dHRvhurg==
X-Received: by 2002:adf:9f54:: with SMTP id f20mr542834wrg.88.1550103951643;
        Wed, 13 Feb 2019 16:25:51 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id b3sm1442324wme.27.2019.02.13.16.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 16:25:50 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] kasan, slub: fix more conflicts with CONFIG_SLAB_FREELIST_HARDENED
Date:   Thu, 14 Feb 2019 01:25:47 +0100
Message-Id: <bf858f26ef32eb7bd24c665755b3aee4bc58d0e4.1550103861.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_KASAN_SW_TAGS is enabled, ptr_addr might be tagged.
Normally, this doesn't cause any issues, as both set_freepointer()
and get_freepointer() are called with a pointer with the same tag.
However, there are some issues with CONFIG_SLUB_DEBUG code. For
example, when __free_slub() iterates over objects in a cache, it
passes untagged pointers to check_object(). check_object() in turns
calls get_freepointer() with an untagged pointer, which causes the
freepointer to be restored incorrectly.

Add kasan_reset_tag to freelist_ptr(). Also add a detailed comment.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slub.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 80da3a40b74d..c80e6699357c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -249,7 +249,18 @@ static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
 				 unsigned long ptr_addr)
 {
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
-	return (void *)((unsigned long)ptr ^ s->random ^ ptr_addr);
+	/*
+	 * When CONFIG_KASAN_SW_TAGS is enabled, ptr_addr might be tagged.
+	 * Normally, this doesn't cause any issues, as both set_freepointer()
+	 * and get_freepointer() are called with a pointer with the same tag.
+	 * However, there are some issues with CONFIG_SLUB_DEBUG code. For
+	 * example, when __free_slub() iterates over objects in a cache, it
+	 * passes untagged pointers to check_object(). check_object() in turns
+	 * calls get_freepointer() with an untagged pointer, which causes the
+	 * freepointer to be restored incorrectly.
+	 */
+	return (void *)((unsigned long)ptr ^ s->random ^
+			(unsigned long)kasan_reset_tag((void *)ptr_addr));
 #else
 	return ptr;
 #endif
-- 
2.20.1.791.gb4d0f1c61a-goog

