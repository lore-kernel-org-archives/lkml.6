Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F88EECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF6620896
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF6620896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeGNNXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:23:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeGNNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:23:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6ED3vOk487603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 14 Jul 2018 06:03:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6ED3uY0487600;
        Sat, 14 Jul 2018 06:03:56 -0700
Date:   Sat, 14 Jul 2018 06:03:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Simon Ser <tipbot@zytor.com>
Message-ID: <tip-6d77d3b43ad84a48b502f02dc618e7c36737bdfe@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, hpa@zytor.com, jpoimboe@redhat.com,
        contact@emersion.fr
Reply-To: hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          contact@emersion.fr, peterz@infradead.org, mingo@kernel.org
In-Reply-To: <d1c1c3fe55872be433da7bc5e1860538506229ba.1531153015.git.jpoimboe@redhat.com>
References: <d1c1c3fe55872be433da7bc5e1860538506229ba.1531153015.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Use '.strtab' if '.shstrtab' doesn't
 exist, to support ORC tables on Clang
Git-Commit-ID: 6d77d3b43ad84a48b502f02dc618e7c36737bdfe
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6d77d3b43ad84a48b502f02dc618e7c36737bdfe
Gitweb:     https://git.kernel.org/tip/6d77d3b43ad84a48b502f02dc618e7c36737bdfe
Author:     Simon Ser <contact@emersion.fr>
AuthorDate: Mon, 9 Jul 2018 11:17:22 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 14 Jul 2018 14:59:42 +0200

objtool: Use '.strtab' if '.shstrtab' doesn't exist, to support ORC tables on Clang

Clang puts its section header names in the '.strtab' section instead of
'.shstrtab', which causes objtool to fail with a "can't find
.shstrtab section" warning when attempting to write ORC metadata to an
object file.

If '.shstrtab' doesn't exist, use '.strtab' instead.

Signed-off-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/d1c1c3fe55872be433da7bc5e1860538506229ba.1531153015.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/elf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 0d1acb704f64..7ec85d567598 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -519,10 +519,12 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	sec->sh.sh_flags = SHF_ALLOC;
 
 
-	/* Add section name to .shstrtab */
+	/* Add section name to .shstrtab (or .strtab for Clang) */
 	shstrtab = find_section_by_name(elf, ".shstrtab");
+	if (!shstrtab)
+		shstrtab = find_section_by_name(elf, ".strtab");
 	if (!shstrtab) {
-		WARN("can't find .shstrtab section");
+		WARN("can't find .shstrtab or .strtab section");
 		return NULL;
 	}
 
