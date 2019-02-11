Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68589C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC4E20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896922;
	bh=zbk7SqNJ7efIYq2sgDwoiy0FrdC6MKgCTS3/1A05Qao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AJ0I9Xek63LVcrSYDqCFZvpkgbQCTAgQ/r9fB7Rn9LMJzVcyOhnm/iPT1E4c1F05O
	 KwlRNQDWQNKDDCbTsQm4z5babvYCnwKfdEgLb9NViTcVO+0oCZwk8jQ0KcY+H6eb8A
	 UA2rHroAA08RSA9vSAgllh7cuS4M6W/ch18boYMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfBKOzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbfBKOzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:55:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF96A2229E;
        Mon, 11 Feb 2019 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896914;
        bh=zbk7SqNJ7efIYq2sgDwoiy0FrdC6MKgCTS3/1A05Qao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mO2BD9qhbu5ZCMxVFSlbBctwAaRGgd2Ql5BCNM21dboi1aWtZCdqTtMFCSxBkNBxW
         aESBkUXW2Ulf2RSTirTWBrq/5A2tL56ir5q6Za+O+LHwX/48HzrnYa1NU3mPnB+A0t
         /pY5EPAXO2z3eBg5WGcxlG37q+jbWVb/LmxI4CZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 030/205] modpost: validate symbol names also in find_elf_symbol
Date:   Mon, 11 Feb 2019 15:17:08 +0100
Message-Id: <20190211141829.730972001@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



