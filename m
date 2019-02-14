Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC011C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E7C21B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmjjxacK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395465AbfBNDsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:48:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38215 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387562AbfBNDsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:48:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so42519pgl.5;
        Wed, 13 Feb 2019 19:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i3gc5E2H5s0Z0cU1Rtar6FigVqhI90HZ+Cw+llye4LQ=;
        b=hmjjxacKBDS9YSm5KMm6z8uRO8UrEEmxpP/0bBUbPN2Z+JcbUTkn5nrFePQ/PIPLGO
         VmHLb+f9y3v4A7lQBcujsXn8Pd7fKmC9SpecuwiMLh7TIwCqd6wISNXHqYA82nt+3pUS
         OyYRY5zDvPvh6k6hpgxUOsg/it+ev6KL26RCydyAoxA7edeQhl+V3L8UZZ0RQ6Um0SWM
         8/TbN5StyisOXhNJTaJHL1BvgCkYjeJTtP3plDjS6itg2D3/5+p94p/Yljo77JHC6HiW
         lOkdAVd7AJIii2ORTCAOmcKVD7jb6ZWYAHTs4td/mAQ7mtx9Wn7btXxYfIpvCeHBJM6/
         9IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i3gc5E2H5s0Z0cU1Rtar6FigVqhI90HZ+Cw+llye4LQ=;
        b=DfEbZ1DWDrz0mxyAdwCBbbYV+Dn2arK2NN6Zvg5Y+H8Fkhz05wSNQ/KJe6YUnTE6PE
         QtJSXtqnulJsGR3k5wN58MOuJUGRnnZte7vVskmkr2vz+TjvIAuhvxac9WFDX/88TG0J
         w5XNPgug/YjsSe0nC7+tMQ9ypE7qQxkL8nwoAp1p0xBSGt78T/xSy+7H37fcTpRn86Xs
         KDReTWkP5vsvjTAHC5TySNjJyVNXkMzm7LoghWoLKBWxXTfmOSnZHMvBggzZG+VgiEWP
         QsN+pjBUb3Al+v7aj9f4+xut5BnNbi87fIztverrv0JOtviKbT2vtglRMEr2FLQcK/jd
         qMzw==
X-Gm-Message-State: AHQUAuaspDENX5240+g9uUwbqvf1GeGtygsJ2F7o/o+2ZPDuLKWsYuAc
        /HFLAhb+LAga3lqSZy4JQbg=
X-Google-Smtp-Source: AHgI3IY3GudN4kJXsQMH44OWMPdjekvfDuIPMiRDW0lFbe93LBhROkACL86nSS+VprfLsH4EIJdP3A==
X-Received: by 2002:a63:fc4d:: with SMTP id r13mr1740786pgk.242.1550116111584;
        Wed, 13 Feb 2019 19:48:31 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id g7sm969962pfi.187.2019.02.13.19.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 19:48:31 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, ohad@wizery.com,
        bjorn.andersson@linaro.org, wendy.liang@xilinx.com,
        arnaud.pouliquen@st.com, kumar.gala@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH 1/2] lib/string: add memrchr function
Date:   Thu, 14 Feb 2019 11:48:16 +0800
Message-Id: <1550116097-29710-1-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the detailed description for memrchr:

void *memrchr(const void *s, int c, size_t n);

The memrchr() function is like the memchr() function, except
that it searches backward from the end of the n bytes pointed
to by s instead of forward from the beginning.

The memrchr() functions return a pointer to the matching byte
or NULL if the character does not occur in the given memory
area.

Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
---
 include/linux/string.h |  1 +
 lib/string.c           | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b87..f380f4b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -167,6 +167,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 	memcpy(dst, src, cnt);
 }
 #endif
+void *memrchr(const void *s, int c, size_t n);
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *s, char old, char new);
 
diff --git a/lib/string.c b/lib/string.c
index 38e4ca0..92914f6 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -964,6 +964,27 @@ void *memchr(const void *s, int c, size_t n)
 EXPORT_SYMBOL(memchr);
 #endif
 
+/**
+ * memrchr - Find a character in an area of memory.
+ * @s: The memory area
+ * @c: The byte to search for
+ * @n: The size of the area.
+ *
+ * returns the address of the last occurrence of @c, or %NULL
+ * if @c is not found
+ */
+void *memrchr(const void *s, int c, size_t n)
+{
+	const unsigned char *p = s + n;
+
+	while (n-- != 0) {
+		if ((unsigned char)c == *--p)
+			return (void *)p;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(memrchr);
+
 static void *check_bytes8(const u8 *start, u8 value, unsigned int bytes)
 {
 	while (bytes) {
-- 
2.7.4

