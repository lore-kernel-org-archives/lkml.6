Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E8C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AD82184F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="PAsIvIBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AD82184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbeHRQYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:24:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34076 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeHRQYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:24:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id h1-v6so5981205eds.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wv1XY51Lt2VJ9i95LO5VL5gr0Ba9AoWtqEVbo4MHCzo=;
        b=PAsIvIBNF1eghipQDa5XMNIzoDXoFWVMhVHzG7cnlURC1hEJ1RpOosAUNn9f9u5Xdv
         2pY+nVWrVp33U9zRvT0vDqF0LFZPccMcyAuc6yshATP7FpCCOmft+2frBVP/A1oJGqx0
         oMrscnrfA0du144r3FVf0gnHSj+9Jyyna9NEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wv1XY51Lt2VJ9i95LO5VL5gr0Ba9AoWtqEVbo4MHCzo=;
        b=JRvoEFjH5F1CU6A5e+3rlnowbO/gtP+rllQbvEycQDM2Q4H4nG5inyF6qxsNxOvZRL
         vSRbhjS2TM5fSqyMXYeDbdxvQhDwqag1UBlIRXVz4qNP0bVb39OUioYg1aG3IlsrDJqO
         n/WqvVggu3mrf4ZwqWVjIN6LCjNkhpNvw++otvO453bDRZEbmQCXRzywTcgnJH1Ts/BT
         AIHA2UZr8AjHY1p/V/HD8bS5fB0yUDfVkQJ8gpVgYpRBVenaYEhVjMFX8OK6S88dZS02
         l1SxEihgvpX4JKvgRp2nGxC6L+nwCvQz9K2e+x3yhxt3H4HfKsdCWUGCEbZpj92vxdNQ
         Q8Cg==
X-Gm-Message-State: AOUpUlEmH8CDhBQl2Q5LVyq7ZYTl2pdaRGMkJ5cht9n2z5C7lzPHWNQw
        jDjLO8eLc1bellGWxuVQBlB+eQ==
X-Google-Smtp-Source: AA+uWPw05aJY3E2WrJAx8U1LTRR14pod+maNDpi1PNIJHW/cL5yLEYXMNYb++wo+MzvRo7+ugFTWag==
X-Received: by 2002:a50:e0c9:: with SMTP id j9-v6mr46920228edl.198.1534598190183;
        Sat, 18 Aug 2018 06:16:30 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id r11-v6sm2821403edp.60.2018.08.18.06.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:16:29 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] linux/bitmap.h: handle constant zero-size bitmaps correctly
Date:   Sat, 18 Aug 2018 15:16:18 +0200
Message-Id: <20180818131623.8755-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static inlines in bitmap.h do not handle a compile-time constant
nbits==0 correctly (they dereference the passed src or dst pointers,
despite only 0 words being valid to access). I had the 0-day buildbot
chew on a patch [1] that would cause build failures for such cases
without complaining, suggesting that we don't have any such users
currently, at least for the 70 .config/arch combinations that was
built. Should any turn up, make sure they use the out-of-line versions,
which do handle nbits==0 correctly.

This is of course not the most efficient, but it's much less churn than
teaching all the static inlines an "if (zero_const_nbits())", and since
we don't have any current instances, this doesn't affect existing code
at all.

[1] lkml.kernel.org/r/20180815085539.27485-1-linux@rasmusvillemoes.dk

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/bitmap.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 1ee46f492267..b91a6b5d3e78 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -196,8 +196,13 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
+/*
+ * The static inlines below do not handle constant nbits==0 correctly,
+ * so make such users (should any ever turn up) call the out-of-line
+ * versions.
+ */
 #define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
+	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
 
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
-- 
2.16.4

