Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8332C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9912454A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ffNjqBT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9912454A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933944AbeFVPqd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:46:33 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:34461 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933670AbeFVPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:46:32 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b6585bef;
        Fri, 22 Jun 2018 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=mail; bh=KW60
        zVfrC8Hwr589uxTW8kpYXS0=; b=ffNjqBT1w6jjw84lejxF+5ntbUZqSN56rWHf
        HFe/wfV7l16uX3hZk+Xr7Aj1M2VW6nIDGwhGDslEId54vCDcXiTiQ6djPGYNSXbE
        EmiaraXNeTzD3DaoxZ6lhm10xdHqAkLQ+JLLmRl0ZvWEfk+DUQzD74hIZWeluvHK
        2Z1/qUCCYGRt9lXbnclZT4nTiNuJXuvUqptkvAh/WkM7R5crP1JACs31AwlByHsO
        2LUKBN8sy+n7m9nmqOSh30gxyIQNbUQgerrRNboDr8W3n4Mpac31Pb6SyJ6GBF1p
        uvAYP4RIuOBMF1QW2MUCoaPkkSe4GziWp7xOOjoIGrFFDhs7NQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 00b1b5ac (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 22 Jun 2018 15:40:15 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        stable@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: depend on CONFIG_SLUB_DEBUG
Date:   Fri, 22 Jun 2018 17:46:23 +0200
Message-Id: <20180622154623.25388-1-Jason@zx2c4.com>
In-Reply-To: <CALvZod7Rf0FZHqYBPd1OTkVuvA5QRrkYQku40QJtS2--g6PrQQ@mail.gmail.com>
References: <CALvZod7Rf0FZHqYBPd1OTkVuvA5QRrkYQku40QJtS2--g6PrQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN depends on having access to some of the accounting that SLUB_DEBUG
does; without it, there are immediate crashes [1]. So, the natural thing
to do is to make KASAN select SLUB_DEBUG.

[1] http://lkml.kernel.org/r/CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com

Fixes: f9e13c0a5a33 ("slab, slub: skip unnecessary kasan_cache_shutdown()")
Cc: Shakeel Butt <shakeelb@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org>
Cc: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 lib/Kconfig.kasan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 3d35d062970d..c253c1b46c6b 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -6,6 +6,7 @@ if HAVE_ARCH_KASAN
 config KASAN
 	bool "KASan: runtime memory debugger"
 	depends on SLUB || (SLAB && !DEBUG_SLAB)
+	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
 	select STACKDEPOT
 	help
-- 
2.17.1

