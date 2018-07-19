Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177EDECDFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F9A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pw4VVdBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F9A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeGSEqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 00:46:33 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36076 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeGSEqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 00:46:33 -0400
Received: by mail-qk0-f195.google.com with SMTP id a132-v6so3597618qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 21:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9L1c2SXSe9w4RAXutcBV4JB61x4zaXaUcgisK6i0cp4=;
        b=Pw4VVdBupRZ4fQdV7oOoQ5W+HbEZfyQ9oH8NVMUIdrQsU16kgRSjUGxjyDSmcLIbut
         N9wabmtH1uTe9aeKrsbwVSQYrlT/6rC+VwBM0uicacMsa+902aaESJp1miBVzIgUaWPs
         rWHkgHohlCYls1rwU1etNGieXb2SQrWSoyp/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9L1c2SXSe9w4RAXutcBV4JB61x4zaXaUcgisK6i0cp4=;
        b=nwLCSqG1XEHCq1RA13FyHR8E3qIwmILG8F1caB1l4tZu0RO4RsG70zBc0076UUMCsV
         0cz+PPJBwc5thvMpB6bv4zG+RvnhfslromMVILK9CtxipFnewJ4ajZHVBr9mPmkSCI8O
         GFhJKV1aJR6Kn8fnsUY8HgAPactNAQTlDenYIUlwvV7HAFzOZOLY+8CbV2NDeZa2H+Yo
         wZPhioIBXsbormIDQ5BO/rqyFgxpBKSaOn2dLpFDvYGrd2v3Z9b6XS9wZO9lpk27p8JG
         ws9lZr43X8Z0n/cWKfhBcEdm4nV8m/GZcVNxGk1pEMV5bZdrat/xUaaAnppuzcxchEyG
         xYog==
X-Gm-Message-State: AOUpUlFaBOHtFrXaZuehvwq+6F1ovDGZ2B1mq9jL1OAyhwjfsb0aSeHP
        PyccBIIoJiM5a0jb2W5qxvbnIg==
X-Google-Smtp-Source: AAOMgpeAIuvQ1UwFFmjYX6hBZUr+7ZC5su1riZxXg7NJFdwTXG9xINkn1EbNEE1lmJextcBf2YWDwQ==
X-Received: by 2002:ae9:ed8f:: with SMTP id c137-v6mr7492402qkg.276.1531973128555;
        Wed, 18 Jul 2018 21:05:28 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id w189-v6sm2741825qkc.36.2018.07.18.21.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 21:05:27 -0700 (PDT)
Date:   Thu, 19 Jul 2018 00:05:25 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Adam Borowski <kilobyte@angband.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Subject: Re: [PATCH 1/3] vt: avoid a VLA in the unicode screen scroll
 function
In-Reply-To: <nycvar.YSQ.7.76.1807172155070.11681@knanqh.ubzr>
Message-ID: <nycvar.YSQ.7.76.1807182353560.2327@knanqh.ubzr>
References: <20180718010242.5254-1-nicolas.pitre@linaro.org> <20180718010242.5254-2-nicolas.pitre@linaro.org> <20180718014813.ygcbgqxk4yo3ydbl@angband.pl> <nycvar.YSQ.7.76.1807172155070.11681@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, Nicolas Pitre wrote:

> But still, if nr > 2 that means you need a temporary storage because the 
> destination memory has to be preserved before the source memory can be 
> moved there, and that destination memory content cannot be stored in the 
> vacated source memory until the source content is moved.

OK I'm an idiot.

After looking in the literature, I found out that there is indeed a 
better way to do this. So here's an updated patch:

----- >8

Subject: [PATCH v2 1/3] vt: avoid a VLA in the unicode screen scroll function

The nr argument is typically small: most often nr == 1. However this
could be abused with a very large explicit scroll in a resized screen.
Make the code scroll lines by performing an array rotation operation to
avoid the need for a large temporary space.

Requested-by: Kees Cook <keescook@chromium.org>
Suggested-by: Adam Borowski <kilobyte@angband.pl>
Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 2d14bb195d..d527184579 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -104,6 +104,7 @@
 #include <linux/kdb.h>
 #include <linux/ctype.h>
 #include <linux/bsearch.h>
+#include <linux/gcd.h>
 
 #define MAX_NR_CON_DRIVER 16
 
@@ -432,20 +433,29 @@ static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 	struct uni_screen *uniscr = get_vc_uniscr(vc);
 
 	if (uniscr) {
-		unsigned int s, d, rescue, clear;
-		char32_t *save[nr];
-
-		s = clear = t;
-		d = t + nr;
-		rescue = b - nr;
-		if (dir == SM_UP) {
-			swap(s, d);
-			swap(clear, rescue);
+		unsigned int i, j, k, sz, d, clear;
+
+		sz = b - t;
+		clear = b - nr;
+		d = nr;
+		if (dir == SM_DOWN) {
+			clear = t;
+			d = sz - nr;
+		}
+		for (i = 0; i < gcd(d, sz); i++) {
+			char32_t *tmp = uniscr->lines[t + i];
+			j = i;
+			while (1) {
+				k = j + d;
+				if (k >= sz)
+					k -= sz;
+				if (k == i)
+					break;
+				uniscr->lines[t + j] = uniscr->lines[t + k];
+				j = k;
+			}
+			uniscr->lines[t + j] = tmp;
 		}
-		memcpy(save, uniscr->lines + rescue, nr * sizeof(*save));
-		memmove(uniscr->lines + d, uniscr->lines + s,
-			(b - t - nr) * sizeof(*uniscr->lines));
-		memcpy(uniscr->lines + clear, save, nr * sizeof(*save));
 		vc_uniscr_clear_lines(vc, clear, nr);
 	}
 }

