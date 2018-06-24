Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846A7C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5E425280
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5E425280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeFXVd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 17:33:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33881 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbeFXVd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 17:33:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fXCdP-00025r-09; Sun, 24 Jun 2018 21:33:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/zsmalloc: make several functions and a struct static
Date:   Sun, 24 Jun 2018 22:33:22 +0100
Message-Id: <20180624213322.13776-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The functions zs_page_isolate, zs_page_migrate, zs_page_putback,
lock_zspage, trylock_zspage and structure zsmalloc_aops are local to
source and do not need to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'zs_page_isolate' was not declared. Should it be static?
symbol 'zs_page_migrate' was not declared. Should it be static?
symbol 'zs_page_putback' was not declared. Should it be static?
symbol 'zsmalloc_aops' was not declared. Should it be static?
symbol 'lock_zspage' was not declared. Should it be static?
symbol 'trylock_zspage' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/zsmalloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a1a9debb6fc8..900bea99452a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -928,7 +928,7 @@ static void reset_page(struct page *page)
  * To prevent zspage destroy during migration, zspage freeing should
  * hold locks of all pages in the zspage.
  */
-void lock_zspage(struct zspage *zspage)
+static void lock_zspage(struct zspage *zspage)
 {
 	struct page *page = get_first_page(zspage);
 
@@ -937,7 +937,7 @@ void lock_zspage(struct zspage *zspage)
 	} while ((page = get_next_page(page)) != NULL);
 }
 
-int trylock_zspage(struct zspage *zspage)
+static int trylock_zspage(struct zspage *zspage)
 {
 	struct page *cursor, *fail;
 
@@ -1906,7 +1906,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	__SetPageMovable(newpage, page_mapping(oldpage));
 }
 
-bool zs_page_isolate(struct page *page, isolate_mode_t mode)
+static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
 	struct zs_pool *pool;
 	struct size_class *class;
@@ -1961,7 +1961,7 @@ bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	return true;
 }
 
-int zs_page_migrate(struct address_space *mapping, struct page *newpage,
+static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 		struct page *page, enum migrate_mode mode)
 {
 	struct zs_pool *pool;
@@ -2077,7 +2077,7 @@ int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	return ret;
 }
 
-void zs_page_putback(struct page *page)
+static void zs_page_putback(struct page *page)
 {
 	struct zs_pool *pool;
 	struct size_class *class;
@@ -2109,7 +2109,7 @@ void zs_page_putback(struct page *page)
 	spin_unlock(&class->lock);
 }
 
-const struct address_space_operations zsmalloc_aops = {
+static const struct address_space_operations zsmalloc_aops = {
 	.isolate_page = zs_page_isolate,
 	.migratepage = zs_page_migrate,
 	.putback_page = zs_page_putback,
-- 
2.17.0

