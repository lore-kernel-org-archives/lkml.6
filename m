Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9863BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFBB20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFBB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933459AbeGIQRm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:17:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932806AbeGIQRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:17:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA7BF87A6C;
        Mon,  9 Jul 2018 16:17:40 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-114.rdu2.redhat.com [10.10.120.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB96551E4;
        Mon,  9 Jul 2018 16:17:39 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Simon Ser <contact@emersion.fr>
Subject: [PATCH] objtool: Use '.strtab' if '.shstrtab' doesn't exist
Date:   Mon,  9 Jul 2018 11:17:22 -0500
Message-Id: <d1c1c3fe55872be433da7bc5e1860538506229ba.1531153015.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 09 Jul 2018 16:17:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 09 Jul 2018 16:17:40 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Ser <contact@emersion.fr>

Clang puts its section header names in the '.strtab' section instead of
'.shstrtab', which causes objtool to fail with a "can't find
.shstrtab section" warning when attempting to write ORC metadata to an
object file.

If '.shstrtab' doesn't exist, use '.strtab' instead.

Signed-off-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
 
-- 
2.17.0

