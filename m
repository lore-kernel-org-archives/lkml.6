Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3017AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C66222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIY6S/bO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395413AbfBNGDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:03:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37518 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfBNGDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:03:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so2567572plr.4;
        Wed, 13 Feb 2019 22:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=obQgo3WVdga7QkxYHDWUZ23L/Zl/CdiYVduNTZIJDjQ=;
        b=QIY6S/bOj/YRcpvPpdxz6y2ECrrDzKWVfcFZxtzr7zCS1IigKnLpO/bPVGsngx2wTa
         0zb59mg76rUCiY6qtsibgvWtSEplAQrfrZq6xqWjVxYOYybd4sQPY3dUeu73vKQyR9fv
         TqK2BPrgpkus3Y6WWmhoflzMja0ElWWWpqCINQq60a5fHjBhTCavqU6ncOQBg1kigitV
         th1sBxqFf2NBybl8j43an3FhEyvjHGQ3V2yufcshyG6kyWPRrgL2B4lI9ZFjjN2RSiwY
         ab9XJKs6f5NWYrKVfOwPS+J/CaFlPIN3y8BQoYdBjiLOBQG8zV1o+oJqxmd2w/eoPLd9
         410A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=obQgo3WVdga7QkxYHDWUZ23L/Zl/CdiYVduNTZIJDjQ=;
        b=ZZPHgISVv1LznVlusDMd5nLuWAdhgVvfI8yHLYZO4kGYtUNmzy/jmJCFUf128A23vh
         i1EVYt3gqEbDBNbmj1pWWfa8BNmejvoky6xRWFa0/xKulJnIWq+fQJk0Z2WGTCXLXp+s
         32TZwQgKu8wz5sg6Z1yeZfNIcnYyPH+N3pqMW0HIJXqGa+eBbkmz2hbmB9FZy2NLMo4R
         dKiHVfvUk7mc9NpCn13lXCjbD0LxMW/76hmYlgoUIftJRh7q8BnZydZoU5MllvaXX1fT
         fiIiGx5MRR+JvWN0BiKUx/qWpIrr9Ax9Ztm+VKPxAb3AdLJYNQjCXyS63WsBnB/MXBe5
         he1Q==
X-Gm-Message-State: AHQUAub4vhu/63eQPQyywUlm8sMgooyYyAQWV+u8M/TDGimyEQuMgMqE
        HR/HTQosxXVA44YTmdB2+NQ=
X-Google-Smtp-Source: AHgI3IZTh/0h+ubFhW4CyDd4dzprRUcZhZ9by4+fTeY7uakZ1TA8CL0FxGZSen6AyOtSpeRLcmY62A==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr2431409plc.108.1550124183749;
        Wed, 13 Feb 2019 22:03:03 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id c23sm1269211pgh.73.2019.02.13.22.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 22:03:03 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     rdunlap@infradead.org, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, ohad@wizery.com,
        bjorn.andersson@linaro.org, wendy.liang@xilinx.com,
        arnaud.pouliquen@st.com, kumar.gala@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH V2 1/2] lib/string: add memrchr function
Date:   Thu, 14 Feb 2019 14:02:37 +0800
Message-Id: <1550124158-1111-1-git-send-email-xiaoxiang@xiaomi.com>
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
 include/linux/string.h |  3 +++
 lib/string.c           | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b87..915c617 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -167,6 +167,9 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 	memcpy(dst, src, cnt);
 }
 #endif
+#ifndef __HAVE_ARCH_MEMRCHR
+void *memrchr(const void *s, int c, size_t n);
+#endif
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *s, char old, char new);
 
diff --git a/lib/string.c b/lib/string.c
index 38e4ca0..595e0b3 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -964,6 +964,29 @@ void *memchr(const void *s, int c, size_t n)
 EXPORT_SYMBOL(memchr);
 #endif
 
+#ifndef __HAVE_ARCH_MEMRCHR
+/**
+ * memrchr - Find the last character in an area of memory.
+ * @s: The memory area
+ * @c: The byte to search for
+ * @n: The size of the area.
+ *
+ * Return: the address of the last occurrence of @c, or %NULL
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
+#endif
+
 static void *check_bytes8(const u8 *start, u8 value, unsigned int bytes)
 {
 	while (bytes) {
-- 
2.7.4

