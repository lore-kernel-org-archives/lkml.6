Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9353C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919492089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919492089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933377AbeGIPk3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:40:29 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37699 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932628AbeGIPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:40:28 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LqHEi-1gG1pM3ume-00dlZQ; Mon, 09 Jul 2018 17:40:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Shakeel Butt <shakeelb@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: only select SLUB_DEBUG with SYSFS=y
Date:   Mon,  9 Jul 2018 17:39:50 +0200
Message-Id: <20180709154019.1693026-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:gUxtO3pJnKJTl0ePfpnABE5YJ9fChZWvZUJoZGSwszV5z7M0sqL
 fMe9KP17XcCwxx3TJZNzJcq0ETEixXhYqI9WRiL20X2BTOELeJarnMeugfF/LWBYjoGA/HX
 H2w+I2OW/zAigHT4l11xfRYFwy6fEV7aGqeT3G6SIYNy8w3ljQFzV2SOaMbm7LwwoTF7PQs
 IhRku4B0RDuaUdN/fTOow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FDzyissbvbQ=:H9DrjPjHKV4gtSr4+kZKvE
 q3skx32uatpr/IvIs1NL6RA8GkiMr5tMSjM31tCRX5WBLJLpm4m8wRwFERNcNICAg46ljKVj+
 tqESRfta+0h6k/Eka+YGAbehIdHOAndTeUJ5WWtk3Lw1lPtrx9YdqaDHMv5qbaWE3b4U5NLQo
 8Jf2+ObUIsf7YpYetTkDyt5qprWBzrQZsnS95pSHV54OirrJXieKiCYxQapUcvzv6VKZe+7UE
 hO1gc+DgmESzAQlJbRhifUAjaZqFNjpTOW+auZXuZH3XYHHYC3Nr8QTxD1V+ejAFI1hMY9CjK
 1OyN+OgV5Y7Byu1TtS/x4h15Shy6qSCPmApnZAFcQfImz+FUYgvfIvj6BbEzsT4eFgYJ2aGZL
 MwuPsHE8y+4EEBfmYB0xWsbKNEFJFdMhJ2jx62gxeGTlCJ+du85gpTbx5KqzHYU8zgw2WwJKV
 nSQfeiJpvRwscfpoNjs4xl59NecxhC7ej4KWwRvpjLLSH4d0aNMR+ufhsyVFRI5sU6Z5fNJTI
 Ze6f66yO8Hsy4CxiVM+WCazl+Yf9+oOBypdNbuoIDxCAmbMW0xh07bjffLyRR+dr4HhqhR8E0
 nEGjUhIbuVURr0jJuDvspRJqexQ/It0bMsZ5iPICQO1i+Mk1Biq81MconqsQBHim9lMl6QNsD
 XsljTNSPzojc2alQZ1Vf7Vnj3U8DCySEPxkQn5BrpHR+wohTpCSJDaHsdRNFvVwsO9hE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with KASAN and SLUB but without sysfs now results in a build-time error:

WARNING: unmet direct dependencies detected for SLUB_DEBUG
  Depends on [n]: SLUB [=y] && SYSFS [=n]
  Selected by [y]:
  - KASAN [=y] && HAVE_ARCH_KASAN [=y] && (SLUB [=y] || SLAB [=n] && !DEBUG_SLAB [=n]) && SLUB [=y]
mm/slub.c:4565:12: error: 'list_locations' defined but not used [-Werror=unused-function]
 static int list_locations(struct kmem_cache *s, char *buf,
            ^~~~~~~~~~~~~~
mm/slub.c:4406:13: error: 'validate_slab_cache' defined but not used [-Werror=unused-function]
 static long validate_slab_cache(struct kmem_cache *s)

This disallows that broken configuration in Kconfig.

Fixes: dd275caf4a0d ("kasan: depend on CONFIG_SLUB_DEBUG")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.kasan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index c253c1b46c6b..befb127507c0 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -5,7 +5,7 @@ if HAVE_ARCH_KASAN
 
 config KASAN
 	bool "KASan: runtime memory debugger"
-	depends on SLUB || (SLAB && !DEBUG_SLAB)
+	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
 	select STACKDEPOT
-- 
2.9.0

