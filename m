Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD88C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFD020C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="suBfKTep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfBTMpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:45:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40016 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfBTMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:45:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so25797215wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gXqyUm+MzCzLQAxtw4op9wk2PcKOTUHWZhWJctI3Io=;
        b=suBfKTephxFP+rdqh9QzczLioDwgZsNZldG4s1nh7aGfk3wEFGpQ9PdSDS4yHWIosW
         CMz20JglknTgOIjfFaO6roeZJLwS6nLkve4A+CU0cKn5/n6inOXbO8dUd/xaDNCAek4F
         tDeqCMVMbJKNwhs6EecZjBmaYm/Yp05RlUwygtOpM1f2LSgsjrBjZZoGHSB1LSNAGCK2
         4uf9Fz5a1JhRTnz3HG1hCsgB9zV/ddcZyEYrtEcLI9hJKqzm/UlPsvhTyJm26nhpFmp8
         TqGNgiwm6KIeqMLVLNEIJW0jx+xZ8bnGjcVsAnKBF2yR5LJTxVtp1R2NZmooih+lSqjF
         OXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gXqyUm+MzCzLQAxtw4op9wk2PcKOTUHWZhWJctI3Io=;
        b=twlis2RvOROEtXBq2TpYObuMGRiNVsN+YhEbuworrc9dbYfs6eoSdUTyQzEIZdG+n8
         2GmdR4u/wYLwcjdC4DJbPCbfNZ/F1M7LzW2l4D3mvsAdBbhrKmECJ25rihiE7MS34hgW
         R8whhJ771eTfWVX+ocBUbhl6MtJNgSXNTSsLiSpc0Kw1oEk/rM7cQNW2yoqTbKI353sr
         tQFMV2Ahfj586xT9lkNtC/4l6kMcoHxShsP4YC00hWbZNWnbncV6hNsi6mW1jWTMsWui
         7HJMtD54GugIO+Pvzu67qxQC2jSYS5vAIDzFWg3/vmpcbAmsTUQbmeZthk1sZwPuSJr9
         0AIw==
X-Gm-Message-State: AHQUAua1B1g01dyLEel2HCUjDj1IW4CgrHdlIp13W4SbTn+OKn+AfAj3
        lwfKXwc+Q5uP0zQKg3e+SLOgPQ==
X-Google-Smtp-Source: AHgI3IaJRu9aCw0ZFP+B3NmgwPZu8apybwshVX27xoQP+MZRDazR203qivIq48ZC/KUV1m1/OgKHcg==
X-Received: by 2002:adf:de83:: with SMTP id w3mr23532379wrl.56.1550666738752;
        Wed, 20 Feb 2019 04:45:38 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id f196sm6378889wme.36.2019.02.20.04.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 04:45:37 -0800 (PST)
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
Subject: [PATCH 4/4] kasan, slab: remove redundant kasan_slab_alloc hooks
Date:   Wed, 20 Feb 2019 13:45:29 +0100
Message-Id: <4ca1655cdcfc4379c49c50f7bf80f81c4ad01485.1550602886.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <9c4c3ce5ccfb894c7fe66d91de7c1da2787b4da4.1550602886.git.andreyknvl@google.com>
References: <9c4c3ce5ccfb894c7fe66d91de7c1da2787b4da4.1550602886.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan_slab_alloc() calls in kmem_cache_alloc() and kmem_cache_alloc_node()
are redundant as they are already called via slab_alloc/slab_alloc_node()->
slab_post_alloc_hook()->kasan_slab_alloc(). Remove them.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 4ad95fcb1686..91c1863df93d 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3547,7 +3547,6 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	void *ret = slab_alloc(cachep, flags, _RET_IP_);
 
-	ret = kasan_slab_alloc(cachep, ret, flags);
 	trace_kmem_cache_alloc(_RET_IP_, ret,
 			       cachep->object_size, cachep->size, flags);
 
@@ -3637,7 +3636,6 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
 
-	ret = kasan_slab_alloc(cachep, ret, flags);
 	trace_kmem_cache_alloc_node(_RET_IP_, ret,
 				    cachep->object_size, cachep->size,
 				    flags, nodeid);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

