Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9A5C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88D520854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eidnu9Px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88D520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbeGVSf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:35:57 -0400
Received: from m12-18.163.com ([220.181.12.18]:51465 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbeGVSf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=8cOTVtmBlMUFmpnk+7
        QG1hlsJ1Hru+o5Vyjw5Eq4BXE=; b=eidnu9Px/AIoYuBHizpcAbGkghuGLA3kVO
        s/plchofzGTGvSP4EzghYWTkkBArxkIkpXZ51ktcXaU4NAb+xU1qGezcIi5qrcex
        PxWJxb5uZBsyqxWuy8Ap/W8SBsGdDCzFlNmUqYy6qAkL0GTEHkYwdxmkyCOebcmw
        M/90/wHpg=
Received: from fedora.localdomain (unknown [120.229.91.112])
        by smtp14 (Coremail) with SMTP id EsCowADn4RfhwFRb6UCbMA--.59693S4;
        Mon, 23 Jul 2018 01:38:05 +0800 (CST)
From:   Zhaoxiu Zeng <zengzhaoxiu@163.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: [PATCH 1/1] lib: use sunday algorithm to do strstr() and strnstr()
Date:   Mon, 23 Jul 2018 01:37:15 +0800
Message-Id: <20180722173715.25327-1-zengzhaoxiu@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowADn4RfhwFRb6UCbMA--.59693S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar43Gw1xCF17Gw43KF1DAwb_yoW8tw1fpF
        savrWfKa1ktr13JryfWF1kt343CFZagr4UJ3y2y3ZxA398JFZ8uwsrJF9Iv3ySq3yfWF1f
        Jrs5XFWFkayUZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdqXdUUUUU=
X-Originating-IP: [120.229.91.112]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/1tbiox+LgFUMGjySJwAAs9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

The Sunday algorithm is a variation of Boyer-Moore algorithm, it is easy and fast.
For the Sunday algorithm, to see
	http://www.inf.fh-flensburg.de/lang/algorithmen/pattern/sundayen.htm

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 lib/string.c | 92 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 11 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 2c0900a5d51a..ed4ab9ee3373 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -898,19 +898,51 @@ EXPORT_SYMBOL(memscan);
  */
 char *strstr(const char *s1, const char *s2)
 {
-	size_t l1, l2;
+	size_t l2;
+	const char *pchk = s1;
 
+#ifdef __HAVE_ARCH_STRLEN
 	l2 = strlen(s2);
+#else
+	for (l2 = 0; s2[l2] != 0; l2++)
+		/* nothing */;
+#endif
 	if (!l2)
 		return (char *)s1;
-	l1 = strlen(s1);
-	while (l1 >= l2) {
-		l1--;
-		if (!memcmp(s1, s2, l2))
+
+	/*
+	 * Sunday matching
+	 */
+	while (1) {
+		size_t i;
+		char k;
+
+		/* compare */
+		for (i = 0; i < l2; i++) {
+			if (s1[i] != s2[i])
+				break;
+		}
+		if (i >= l2)
 			return (char *)s1;
-		s1++;
+
+		/* if s1 terminate early? */
+		if (pchk < s1 + i)
+			pchk = s1 + i;
+		do {
+			k = *pchk;
+			if (k == 0)
+				return NULL;
+		} while (pchk++ != s1 + l2);
+
+		/* find the k's last presence in s2 (k = s1[l2]) */
+		for (i = l2; --i != (size_t)-1; ) {
+			if (k == s2[i])
+				break;
+		}
+
+		/* shift */
+		s1 += l2 - i;
 	}
-	return NULL;
 }
 EXPORT_SYMBOL(strstr);
 #endif
@@ -925,16 +957,54 @@ EXPORT_SYMBOL(strstr);
 char *strnstr(const char *s1, const char *s2, size_t len)
 {
 	size_t l2;
+	const char *pchk = s1;
 
+#ifdef __HAVE_ARCH_STRLEN
 	l2 = strlen(s2);
+#else
+	for (l2 = 0; s2[l2] != 0; l2++)
+		/* nothing */;
+#endif
 	if (!l2)
 		return (char *)s1;
+
+	/*
+	 * Sunday matching
+	 */
 	while (len >= l2) {
-		len--;
-		if (!memcmp(s1, s2, l2))
-			return (char *)s1;
-		s1++;
+		size_t i;
+		char k;
+
+		/* compare */
+		for (i = 0; i < l2; i++) {
+			if (s1[i] != s2[i])
+				break;
+		}
+		if (i >= l2)
+			return (char *)s1;
+		if (len == l2)
+			break;
+
+		/* if s1 terminate early? */
+		if (pchk < s1 + i)
+			pchk = s1 + i;
+		do {
+			k = *pchk;
+			if (k == 0)
+				return NULL;
+		} while (pchk++ != s1 + l2);
+
+		/* find the k's last presence in s2 (k = s1[l2]) */
+		for (i = l2; --i != (size_t)-1; ) {
+			if (k == s2[i])
+				break;
+		}
+
+		/* shift */
+		s1  += l2 - i;
+		len -= l2 - i;
 	}
+
 	return NULL;
 }
 EXPORT_SYMBOL(strnstr);
-- 
2.17.1


