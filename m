Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D9FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914A723D80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CA3fVeTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914A723D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932499AbeGCCQ7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:16:59 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46856 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932433AbeGCCQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:16:57 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so214063pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 19:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZRMCOOALmdPBNTvno/w/l5S4XOYv4a3poPPiFJRGf6U=;
        b=CA3fVeTyUUN1tfG608Y2v+JxiDnCDtKLqiH6+F4kX9DQ39gue5/wEN8s/cS4wtalLk
         tyyZ3zQK7n5h96klnbg/xuuKzrDLWY81DgJOrnRd2DXfOtt5b0XVLulLYw39EgyRYlLW
         9qoeL6L2W1nh3H88SJHTbS2uQQmt1dV433yvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZRMCOOALmdPBNTvno/w/l5S4XOYv4a3poPPiFJRGf6U=;
        b=AZU+EU+67CwN7+7GRzujJ+8Mao2zBebw9VflPSv6ZbOQiGsSFXDpK+EDAYp+DVmEMK
         i0V0pnNIm0kEGFMfQdUY5XCzvn1u4qPDJrK0Zx6MCYysrLFHn2iVm79YZABrP2GC4QCl
         74a3bWsb0a81H+Tndrb++98kuiIo6tHyOGDpCj+2qry0C4/w7bY5hmcAP5MLSaqMWsyY
         5gK+I5O+Jh8FfulfQh9hwSegMn0cpFMqTBHDp20FSfBOT8fOo6MGM9hhNlEU7YBJ2f6V
         BwHbAwGCmEtZmbGnFB4Pl17Qthtcz5uyFF8cpRn3M7XE8U619M9trfWb7ZlwSqcDjOt9
         9YCg==
X-Gm-Message-State: APt69E1L1t+4dwsluKjqhZZsyLW5KtXyo997SHRNXPNQHaKhgVDqpIGa
        4UGgimaV4ssRJVqE+Qb3SqNLLA==
X-Google-Smtp-Source: ADUXVKI+w1pXL43mODOiJABeBJGUAoHIl7r3s49TduCfU47LRfbeWaDA05zkuZNvteVn8jEYEKXucw==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr27837008plg.135.1530584217358;
        Mon, 02 Jul 2018 19:16:57 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n18-v6sm13045pge.37.2018.07.02.19.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 19:16:55 -0700 (PDT)
Date:   Mon, 2 Jul 2018 19:16:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] kernel.h: Documentation for roundup() vs round_up()
Message-ID: <20180703021654.GA42417@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things like commit 3619dec5103d ("dh key: fix rounding up KDF output
length") expose the lack of explicit documentation for roundup() vs
round_up(). At least we can try to document it better if anyone goes
looking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: fix whitespace (willy)
---
 include/linux/kernel.h | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 941dc0a5a877..dce6ab779a83 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -85,7 +85,23 @@
  * arguments just once each.
  */
 #define __round_mask(x, y) ((__typeof__(x))((y)-1))
+/**
+ * round_up - round up to next specified power of 2
+ * @x: the value to round
+ * @y: multiple to round up to (must be a power of 2)
+ *
+ * Rounds @x up to next multiple of @y (which must be a power of 2).
+ * To perform arbitrary rounding up, use roundup() below.
+ */
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+/**
+ * round_down - round down to next specified power of 2
+ * @x: the value to round
+ * @y: multiple to round down to (must be a power of 2)
+ *
+ * Rounds @x down to next multiple of @y (which must be a power of 2).
+ * To perform arbitrary rounding down, use rounddown() below.
+ */
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 
 /**
@@ -110,13 +126,30 @@
 # define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP(ll,d)
 #endif
 
-/* The `const' in roundup() prevents gcc-3.3 from calling __divdi3 */
+/**
+ * roundup - round up to the next specified multiple
+ * @x: the value to up
+ * @y: multiple to round up to (must be a power of 2)
+ *
+ * Rounds @x up to next multiple of @y. If @y will always be a power
+ * of 2, consider using the faster round_up().
+ *
+ * The `const' here prevents gcc-3.3 from calling __divdi3
+ */
 #define roundup(x, y) (					\
 {							\
 	const typeof(y) __y = y;			\
 	(((x) + (__y - 1)) / __y) * __y;		\
 }							\
 )
+/**
+ * rounddown - round down to next specified multiple
+ * @x: the value to round
+ * @y: multiple to round down to
+ *
+ * Rounds @x down to next multiple of @y. If @y will always be a power
+ * of 2, consider using the faster round_down().
+ */
 #define rounddown(x, y) (				\
 {							\
 	typeof(x) __x = (x);				\
-- 
2.17.1


-- 
Kees Cook
Pixel Security
