Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6F1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BFE21914
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="c4Z37sro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BFE21914
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeHQNNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:13:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41343 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:13:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id v22-v6so5499895lfe.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 03:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oMSxPR2dafaNe+8+1D/CXhrOaVIzspAA8XH3G63SXZg=;
        b=c4Z37srokmUBThDJAzTJsBIL3iFvtNmDuEVhz3LMiKwc2EB9FxW5bzr41GEWrl222C
         a6u/7XLnnTAJnQUrnOdqc20dQKn0vbTvpE1fW4pnAlqsQifxZqEbAt31SJhTTjkTHXaO
         5FztcnFRruuO6uoWaBepoThE1XZxoVxAEB2GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oMSxPR2dafaNe+8+1D/CXhrOaVIzspAA8XH3G63SXZg=;
        b=mgusrnwukttTc5AKymy3t9EPrleuuGD9b+PDs55Mddta0q7zei344OmnXvWOKITLpq
         BDqA7qMjC5izuPQkxs0dFKzAdhfrDHTAWe+1OPojs4ZrRys0xYQ6c18EdL8ZdF0D4qIL
         6jR//e7qXqy3IdOB6LrZRHDdC0UVyCUlh68mEO0N5Gt6YnY38Ni7969zu2M+FP3zmfhM
         dpTPoylKS/35gJEsY3B/6Advb5t1nundz7kgutTIrlJhmgg9KAxYoKI56Y4h6qQbXBfG
         gmOZsjyRjDmrYP5/gJ434a2hNC4k7nYPvnTL7KuzB7VBAEPfw/sMceZh/7y1zJoQE4nx
         uyRA==
X-Gm-Message-State: AOUpUlHjhzQNXnhdxOGmrEkqIrf2dH4aUYuud/bMfF7s1vNomOlpfNV2
        zyRwOE+9GDlaUxUOimQRQMLtSw==
X-Google-Smtp-Source: AA+uWPy6Q6b/CMgc/GOtFYiqC4zNusaL6K6yXJiJ5p/rroneb31InIDZ2etOyevXocvTfF7we9keZw==
X-Received: by 2002:a19:4d0a:: with SMTP id a10-v6mr21049948lfb.5.1534500640916;
        Fri, 17 Aug 2018 03:10:40 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p9-v6sm248800ljh.0.2018.08.17.03.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 03:10:40 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Li <sparse@chrisli.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] linux/compiler.h: don't use bool
Date:   Fri, 17 Aug 2018 12:10:35 +0200
Message-Id: <20180817101036.20969-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Appararently, it's possible to have a non-trivial TU include a few headers,
including linux/build_bug.h, without ending up with linux/types.h. So
the 0day bot sent me

config: um-x86_64_defconfig (attached as .config)

>> include/linux/compiler.h:316:3: error: unknown type name 'bool'; did you mean '_Bool'?
      bool __cond = !(condition);    \

for something I'm working on.

Rather than contributing to the #include madness and including
linux/types.h from compiler.h, just use int.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 42506e4d1f53..c8eab637a2a7 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -313,7 +313,7 @@ unsigned long read_word_at_a_time(const void *addr)
 #ifdef __OPTIMIZE__
 # define __compiletime_assert(condition, msg, prefix, suffix)		\
 	do {								\
-		bool __cond = !(condition);				\
+		int __cond = !(condition);				\
 		extern void prefix ## suffix(void) __compiletime_error(msg); \
 		if (__cond)						\
 			prefix ## suffix();				\
-- 
2.16.4

