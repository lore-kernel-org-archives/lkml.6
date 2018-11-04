Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF34AC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0E520685
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jppSSe1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0E520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbeKDWF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 17:05:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46365 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbeKDWF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 17:05:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so3083023pfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 04:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q0IjlPdLyA3cEWBQiuNF0SAFheYmblsEgu7HJ3hDm6g=;
        b=jppSSe1Y+L5SNtYSjjHsIgaS+IhW05qRNMmAtO0lhT2+klwMeu6IQoE27YGkwf2zwc
         Cnvfaafx2pEAe/5Dew6obhBeUZd9g/UJU4fhMK6X5NsygemxpRaCJKCIDzdecZQEXndb
         6mKIxWhicYmhaifoOTRwsE/4YeXHRtGMsAF9Li8aTOEdZ72tVSsuvBVORgTPbzTeghn3
         xFJZGDKITFl/MCu/bdd22uXUWTntbbK+wLROxs6kb+qTUvIufRRypbA0mC3yRCHkGcYj
         w6vBb9gat6plysHBtC8hp7EztGOqGStOpF9tqlrMFLf2TY18C676k3gGTvg1RxLgam/P
         x0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q0IjlPdLyA3cEWBQiuNF0SAFheYmblsEgu7HJ3hDm6g=;
        b=KN4Wc1/6PMuTaOVmVh3WVr+yNgxhZiOKPLTVTA+tueDmRVNwI/i6I7bgtG8jj4uJqI
         SZ9cODkS8ElFKXABWsdQRynm4ikgtiy0/CXzt+qy6H0JF/O+1ARX6JvE56jXixaonuEV
         //CtvLVib3oGbaKkjBOyC6HwOOooyZM4Vuz4PO4yiDaoJpzK+GSy/EJvz5aBiWJMnMlT
         5BIoAO/mBh0lFZwockL31h1ze/wKqtR5vJk9691ovSDy6ejC5WRmFQfT93mqAGWY4iYC
         nZ0E/iN10nW8ZdufJ/cGnb011brll7RypzZ7KOo/Z+57jZGTZfV+V3BG4anzIU37I7tj
         ejwQ==
X-Gm-Message-State: AGRZ1gJO+7pSg+mdvMy7py9oq+U2CZV8/yeUo0ebj0WOlEAiA1tUcMti
        giWK4CTlD+Vx6Xu4/peZKRM=
X-Google-Smtp-Source: AJdET5fCR0CW3qtZehYHZIu0SkoS3fw8GgBE1ArGjkrXoorgdzCMncdhiDze7kA68ou18YL9LTKL6w==
X-Received: by 2002:a63:dc0c:: with SMTP id s12mr17091932pgg.398.1541335832710;
        Sun, 04 Nov 2018 04:50:32 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id r26-v6sm38358173pga.69.2018.11.04.04.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 04:50:31 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] mm, slab: remove unnecessary unlikely()
Date:   Sun,  4 Nov 2018 07:50:28 -0500
Message-Id: <20181104125028.3572-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 mm/slab_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7eb8dc136c1c..4f54684f5435 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1029,10 +1029,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 
 		index = size_index[size_index_elem(size)];
 	} else {
-		if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
-			WARN_ON(1);
+		if (WARN_ON(size > KMALLOC_MAX_CACHE_SIZE))
 			return NULL;
-		}
 		index = fls(size - 1);
 	}
 
-- 
2.17.0

