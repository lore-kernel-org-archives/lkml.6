Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50839C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A07D23FBA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A07D23FBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933230AbeGFNJd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:09:33 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42644 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932870AbeGFNJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:09:32 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MJ1cT-1fYwaC3RBB-002Vc6; Fri, 06 Jul 2018 15:09:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] zmalloc: hide unused lock_zspage
Date:   Fri,  6 Jul 2018 15:09:02 +0200
Message-Id: <20180706130924.3891230-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:4rEuEmSRwf5ryB+wBQ2gAsXvBAbhGKDH4WcZZHTZu5qqdCEXDsK
 UDI5CzboLBEMD904U1LHLlejQrJyCBSnZiM+XL19dMgKvP5Q9rza2P/WzeW9IgIAeRbkuUL
 0aLyJfo61YtBydtLx7Yn7FM26ksfSgi0AKo31FvjUuFr0SU1YHikCpqN+UXfMKX+qkFCOig
 oENc3AyLG5UCpmCKmdjjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7xXpi0wxGcU=:GTTFDHwA1JHsxfMzg3aNes
 btgkd+i6TGgmFlpgdXxbUNZvhWFt7v/yhjZPgWx6J5Qc7V0qbENeP4sgtKpUA6hAO7l+skNdL
 SLZa8tMn92besZhHynkx0P2Q/upkyT+VAP1MWAnFb//3Z984z77rGk7XDW1XOYIU/sQvY9Agu
 Y8CguazeyXAyS9W7YRbOThekbbvNi8RMMnb3/cYh9fzNsNkC6b4ATcHWsNScNHFoyo4X1Jrzd
 TDlVlrSz/4CxxQiLNiDaHIwlypRCkICgTHMsrMS6S+TxG1eNUKvNcMyj092hJSzcGZqELJqg/
 zdN4xPCrl6U9Hbke8lyvTMKGIOqSnqeTxKjkD9AdLsld26GNU1OOir4W2OSSP02Ca9BQyKXnq
 BilrXnBRARDFrPzYaaOyDm6TODlSza0t+IBP22Ft8Kf/j8MhdKDERKSuw3BwjTp5DsbqDvRhw
 NBRnHQarnYZiXUqNi4drb2rCzGcjopAVFxnTP/aUDxXIzaiFV/k2JgOz85IU8hRC2bR8XS76X
 v5SPzWAmkimvgKgi6bAjVSPxAJoEPV4fmvsojKx6r9HdtwFBmH0RweNpej1/uBxjk0tgGhfph
 hIQ03otqA7rf6+K2ybY/E1iXK5v4EtJol+sv7x2FQxbK2FfQu/nxjN/Area4vcMCKWDr5jdqH
 DJBEMxD+WQXeLi4AmGE17T0mECyI/kSCpv/Pw+fDMhO76lHFcJeo4VWKrNBK+x+hnCpo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making lock_zspage() static revealed that it is unused in some confiurations:

mm/zsmalloc.c:931:13: error: 'lock_zspage' defined but not used [-Werror=unused-function]

I considered moving it into the same #ifdef that hides its user, but
it seems better to keep it close to trylock_zspage() etc, so this
marks it __maybe_unused() to let the compiler drop it without warning
about it.

Fixes: 0de664ada6b6 ("mm/zsmalloc.c: make several functions and a struct static")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/zsmalloc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 900bea99452a..58886d40786b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -924,19 +924,6 @@ static void reset_page(struct page *page)
 	page->freelist = NULL;
 }
 
-/*
- * To prevent zspage destroy during migration, zspage freeing should
- * hold locks of all pages in the zspage.
- */
-static void lock_zspage(struct zspage *zspage)
-{
-	struct page *page = get_first_page(zspage);
-
-	do {
-		lock_page(page);
-	} while ((page = get_next_page(page)) != NULL);
-}
-
 static int trylock_zspage(struct zspage *zspage)
 {
 	struct page *cursor, *fail;
@@ -1814,6 +1801,19 @@ static enum fullness_group putback_zspage(struct size_class *class,
 }
 
 #ifdef CONFIG_COMPACTION
+/*
+ * To prevent zspage destroy during migration, zspage freeing should
+ * hold locks of all pages in the zspage.
+ */
+static void lock_zspage(struct zspage *zspage)
+{
+	struct page *page = get_first_page(zspage);
+
+	do {
+		lock_page(page);
+	} while ((page = get_next_page(page)) != NULL);
+}
+
 static struct dentry *zs_mount(struct file_system_type *fs_type,
 			       int flags, const char *dev_name,
 			       void *data, size_t data_size)
-- 
2.9.0

