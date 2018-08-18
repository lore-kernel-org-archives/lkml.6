Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070E6C43615
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34F72184F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="i+viqHAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34F72184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeHRQYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:24:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37273 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:24:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so5972084eds.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o8YGwHnYHdWpPk8ZGnNNIQ7y1DHOGqK2LdTxIGTIzpo=;
        b=i+viqHAWNRlrSlMi2sd/NHW5vzF6Phj8c7pRnszOvzKu3KuZhMGyA6maZJQnslTTGG
         E3jweUAP3+hWWox3Qi97OuSQ8f4qd51gsa7vIQoy4fzR6P6a17hdrYXHFWDSsgIo+CQ7
         RUpa7607/y8SF5/sMx3j0s3fYppoApLPsBYgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o8YGwHnYHdWpPk8ZGnNNIQ7y1DHOGqK2LdTxIGTIzpo=;
        b=WZSbUk8EESI/e8iV4fi94lxTiXU9d5XqX4PuRORJMetFdRwLCduhbbc8kdbZ4Juxcn
         bsS+EyQ4FgVAmWLdBmPdJJ2mDsKIEkSKX49A15unEp3FDDI4/JodnKEeYJC7kr0eaSUB
         CVlAbD+D1QEzFFRil+9A4sbQLgrLKQpPdXA4Ulr41Y1cpLOd2mk/R98X2i08nDy8q0v7
         ORwK2l9kQYdXJgfA12biahdS/RGTW9a5LRxqWAH9h+AJkJlqfWKUjmxPBsHGuHvIUqBC
         XyoMlsAOd53OaRCycD/mIAMY3QRlctk//N1zVeyaUOxroEHzqKKApAg9wfruauaKljm0
         76hg==
X-Gm-Message-State: AOUpUlEevQ1oTANiEGYEnAMaE5ZOGO23YDnosz/CDJ7RauEdKoRugtPI
        g3uq/0hkO+qhoCzShSV7WXCOHw==
X-Google-Smtp-Source: AA+uWPxBdgKvyfNSPzHYJVC6NFmc8CT2JnTbExAzjgucsxhg6dGcA1ja/7+giL17Ls/fIVKWMDZlXg==
X-Received: by 2002:a50:fd93:: with SMTP id o19-v6mr45787049edt.73.1534598191265;
        Sat, 18 Aug 2018 06:16:31 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id r11-v6sm2821403edp.60.2018.08.18.06.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:16:30 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] linux/bitmap.h: remove redundant uses of small_const_nbits()
Date:   Sat, 18 Aug 2018 15:16:19 +0200
Message-Id: <20180818131623.8755-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the _zero, _fill and _copy functions, the small_const_nbits
branch is redundant. If nbits is small and const, gcc knows full well
that BITS_TO_LONGS(nbits) is 1, so len is also a compile-time
constant (sizeof(long)), and calling memset or memcpy with a length
argument of sizeof(long) makes gcc generate the expected code anyway:

#include <string.h>
void a(unsigned long *x) { memset(x, 0, 8); }
void b(unsigned long *x) { memset(x, 0xff, 8); }
void c(unsigned long *x, const unsigned long *y) { memcpy(x, y, 8); }

turns into

0000000000000000 <a>:
   0:   48 c7 07 00 00 00 00    movq   $0x0,(%rdi)
   7:   c3                      retq
   8:   0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
   f:   00

0000000000000010 <b>:
  10:   48 c7 07 ff ff ff ff    movq   $0xffffffffffffffff,(%rdi)
  17:   c3                      retq
  18:   0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
  1f:   00

0000000000000020 <c>:
  20:   48 8b 06                mov    (%rsi),%rax
  23:   48 89 07                mov    %rax,(%rdi)
  26:   c3                      retq

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/bitmap.h | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index b91a6b5d3e78..a7a8b5017d62 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -206,33 +206,21 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
 
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
-		*dst = 0UL;
-	else {
-		unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-		memset(dst, 0, len);
-	}
+	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	memset(dst, 0, len);
 }
 
 static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
-		*dst = ~0UL;
-	else {
-		unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-		memset(dst, 0xff, len);
-	}
+	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	memset(dst, 0xff, len);
 }
 
 static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
-		*dst = *src;
-	else {
-		unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-		memcpy(dst, src, len);
-	}
+	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	memcpy(dst, src, len);
 }
 
 /*
-- 
2.16.4

