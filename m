Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F46C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4007E205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oe3mBe2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4007E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753892AbeGCET4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:19:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39237 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753841AbeGCETy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:19:54 -0400
Received: by mail-pf0-f193.google.com with SMTP id s21-v6so345865pfm.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 21:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=17s0LQyAKBlnFZaFLFQ0xMfW88C9MusfaAJS5cE7a0M=;
        b=oe3mBe2egiadk6WxQmC1ib8E+1L3le5XKl34hjEGGRh3lSr342Nqmn212Ohf5l0nIY
         /pnM89+2wQQbqMuoS4vC2ZsDU13PoZB4H2N+PeFE7QT8VSPljRYuvPlJtH9NxMyYzIKD
         ih7pyP8M0h+8rU60mMIA0CECkb8yX5hX6/eGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=17s0LQyAKBlnFZaFLFQ0xMfW88C9MusfaAJS5cE7a0M=;
        b=Gw3fUy0iBEqBTEb3jskfmtgcaafQpxLQxDoTLGhIMxIh+TrWGXDT8QkznHOawE7N2/
         3/SUzaRhf39mDTnJ1QnArFet5hXEuENiTmCIkZ7bRx9YEtOTAxqgsZ7sVQjF3721t5f8
         ofJztfJdhpAgWjwA4BIYEMozCr3H+il4kcHCuZxpe0Brm8VRODRwcUzrkKPku4Mmu5fP
         Z2AO/IGTqCNETERGTJFygklTOXmLgKoqSWdk7XTZNqPQFgqhxeioXEWWuQA5QKcmMjUg
         P26nf5FlUbYs3wmlfkG+95LVOZspDpSeS8RYbfErb+cIk7ibVy1WCWbTbb+XpyNzsB/4
         tzqw==
X-Gm-Message-State: APt69E2KmWqmXx7G0TtJGooMpo0lox4jP8VOM9HhUo0nYw91TSyn/sw5
        mTgMrIlYSUOPoVuW7PO8uLfgEg==
X-Google-Smtp-Source: ADUXVKIq6RUO0S8ymddfyA7KYmgXSYsUAH+8oQzoQpzQIse8iyqbTdJYEhf6VG5w2Nafclgd82pCqw==
X-Received: by 2002:a63:b91c:: with SMTP id z28-v6mr24151081pge.22.1530591594282;
        Mon, 02 Jul 2018 21:19:54 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a8-v6sm428287pfe.72.2018.07.02.21.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 21:19:52 -0700 (PDT)
Date:   Mon, 2 Jul 2018 21:19:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] kernel.h: Documentation for roundup() vs round_up()
Message-ID: <20180703041950.GA43464@beast>
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3: cut/paste-o fixes (kilobyte)
v2: whitespace fixes (willy)
---
 include/linux/kernel.h | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 941dc0a5a877..d6aac75b51ba 100644
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
+ * @y: multiple to round up to
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
