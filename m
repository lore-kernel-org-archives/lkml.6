Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AD3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1DD20685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3lonrAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfBTIhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:37:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40823 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfBTIhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:37:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id t14so16926261lfk.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tBj//QOlOyjUJzu3wlOuk95ckvdPlbdm8RVV0pjJRDw=;
        b=a3lonrAS40uoTQfSOuKHsMVc5OKd5ZbWNpSazXSzDxqigEzJ4AOoe8kmhPgfVNLtxy
         Ifq7ZJ1Ie9sKFCdhn0h8lw5znN5TEzGd50gxlrtMbVO1adoAd2ypqsrwFjLzHX91Ukww
         HsklqLKaCWtBRa9mmzc2EdN60hV8Sf4fd5s4hr9x/4mGvkOPBEJoklXVvNrleSEhDkyC
         yH4KnO4BhkchQCBEh9ZLl/TI5neexA+u2xSTeJ8IB/M+Ur+GZdnQkhpTTy5E70Us2kvH
         9HRKn7kxhaKBlzfU+XVIHYMQv2k1TiCU8XMY3tpXCD86VmJpkk0uhUP8eQUk2+EEr/wY
         d8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tBj//QOlOyjUJzu3wlOuk95ckvdPlbdm8RVV0pjJRDw=;
        b=h1cgwtM6spKRmW7yuYoYypA48iMYewybXTZJgBAdM9lNFYf5mGSlGBAmOdKSKwzgDM
         PdG/3BBW0YpkKpFRla1vWSbxJT7IaDrAnvtLafoIW/oITnpnXky8Ep0IQrglxJCllgpN
         i/ooxLeaeqjAKqXz3ZNdk5gqJmsGC9ees7JV5yXf4JyoUotb6UWIW/x0oQPgTAwO6xO0
         GWGwY83jpNitU78pSsBMvqlIYX1wTsHzUoPFVRAq4s5ZHCEf9l/7OU7D6tuwoQPmxbvi
         HodgvE7B68oM/e+CJplkRRQ/Yf5/UufT1/F23YSAIG235wbojD8l8hTc9WBJJpvTSrhf
         7EGg==
X-Gm-Message-State: AHQUAua7GAcT6Ex+QcW+s95dJYJIvDJjEPJCXWUqtPmUjaU2n2AkdbDm
        099VrWXmfZFbXkxctKG/5KM=
X-Google-Smtp-Source: AHgI3IZtrOvjkaaWQpsLCMsnmjDD7fBtXfY5IV4YeJ93T3EUZujbBMJGGWBlKLZ4/nUK1s87YnPeyg==
X-Received: by 2002:a19:c116:: with SMTP id r22mr19504519lff.32.1550651833049;
        Wed, 20 Feb 2019 00:37:13 -0800 (PST)
Received: from localhost ([188.162.52.148])
        by smtp.gmail.com with ESMTPSA id k124sm1115781lfg.95.2019.02.20.00.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 00:37:12 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/6] bitmap_parselist: don't calculate length of the input string
Date:   Wed, 20 Feb 2019 11:37:00 +0300
Message-Id: <20190220083705.14050-2-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220083705.14050-1-ynorov@marvell.com>
References: <20190220083705.14050-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_parselist() calculates length of the input string before passing
it to the __bitmap_parselist(). But the end-of-line condition is checked
for every character in __bitmap_parselist() anyway. So doing it in wrapper
is a simple waste of time.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 98872e9025da..ad1fb7e6ad0e 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -614,10 +614,7 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
 
 int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
 {
-	char *nl  = strchrnul(bp, '\n');
-	int len = nl - bp;
-
-	return __bitmap_parselist(bp, len, 0, maskp, nmaskbits);
+	return __bitmap_parselist(bp, UINT_MAX, 0, maskp, nmaskbits);
 }
 EXPORT_SYMBOL(bitmap_parselist);
 
-- 
2.17.1

