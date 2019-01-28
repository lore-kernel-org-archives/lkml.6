Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5986C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EFA2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692002;
	bh=nbPMvAwFh0xLHwV1LEOqxCp6y2HejG7/ucojB+mswcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hP0doFvznFgdyHmMx8DoW832803BEp2Iwqb+Cebnp4ZsZ327ULw3FmIgWOYFQhRwP
	 4T+Pvz8K+gyJq7Go0jo5SJSWowk/DBC0Wi0T8MTQiByQoymOlMzzj1Itl+1zap5i4B
	 F5d9LTqMFFcBdWnDvk8WwoOoaKjyhYmx3m0JLlJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbfA1QNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:13:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733301AbfA1QNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E103F2147A;
        Mon, 28 Jan 2019 16:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691997;
        bh=nbPMvAwFh0xLHwV1LEOqxCp6y2HejG7/ucojB+mswcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjwky3GYZV5gxt6U9IabG7KNpMc/35qkD9vKfso6P5FXP9Bxqu7rMXOv4KRlYdkja
         tE6yVZInz+J1mpfkb9Ppdl55zMSQMV/OC7kgVQrDxt5+uih7hsJRzoTwHrmYLCC0rQ
         zBmXcCS8kQNgr7he5QMs/41Fby66BXEmmCq7JG10=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 033/170] modpost: validate symbol names also in find_elf_symbol
Date:   Mon, 28 Jan 2019 11:09:43 -0500
Message-Id: <20190128161200.55107-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit 5818c683a619c534c113e1f66d24f636defc29bc ]

If an ARM mapping symbol shares an address with a valid symbol,
find_elf_symbol can currently return the mapping symbol instead, as the
symbol is not validated. This can result in confusing warnings:

  WARNING: vmlinux.o(.text+0x18f4028): Section mismatch in reference
  from the function set_reset_devices() to the variable .init.text:$x.0

This change adds a call to is_valid_name to find_elf_symbol, similarly
to how it's already used in find_elf_symbol2.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/modpost.c | 50 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 18bc8738e989..e36a673833ae 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1215,6 +1215,30 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 	return 1;
 }
 
+static inline int is_arm_mapping_symbol(const char *str)
+{
+	return str[0] == '$' && strchr("axtd", str[1])
+	       && (str[2] == '\0' || str[2] == '.');
+}
+
+/*
+ * If there's no name there, ignore it; likewise, ignore it if it's
+ * one of the magic symbols emitted used by current ARM tools.
+ *
+ * Otherwise if find_symbols_between() returns those symbols, they'll
+ * fail the whitelist tests and cause lots of false alarms ... fixable
+ * only by merging __exit and __init sections into __text, bloating
+ * the kernel (which is especially evil on embedded platforms).
+ */
+static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
+{
+	const char *name = elf->strtab + sym->st_name;
+
+	if (!name || !strlen(name))
+		return 0;
+	return !is_arm_mapping_symbol(name);
+}
+
 /**
  * Find symbol based on relocation record info.
  * In some cases the symbol supplied is a valid symbol so
@@ -1240,6 +1264,8 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
 			continue;
 		if (ELF_ST_TYPE(sym->st_info) == STT_SECTION)
 			continue;
+		if (!is_valid_name(elf, sym))
+			continue;
 		if (sym->st_value == addr)
 			return sym;
 		/* Find a symbol nearby - addr are maybe negative */
@@ -1258,30 +1284,6 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
 		return NULL;
 }
 
-static inline int is_arm_mapping_symbol(const char *str)
-{
-	return str[0] == '$' && strchr("axtd", str[1])
-	       && (str[2] == '\0' || str[2] == '.');
-}
-
-/*
- * If there's no name there, ignore it; likewise, ignore it if it's
- * one of the magic symbols emitted used by current ARM tools.
- *
- * Otherwise if find_symbols_between() returns those symbols, they'll
- * fail the whitelist tests and cause lots of false alarms ... fixable
- * only by merging __exit and __init sections into __text, bloating
- * the kernel (which is especially evil on embedded platforms).
- */
-static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
-{
-	const char *name = elf->strtab + sym->st_name;
-
-	if (!name || !strlen(name))
-		return 0;
-	return !is_arm_mapping_symbol(name);
-}
-
 /*
  * Find symbols before or equal addr and after addr - in the section sec.
  * If we find two symbols with equal offset prefer one with a valid name.
-- 
2.19.1

