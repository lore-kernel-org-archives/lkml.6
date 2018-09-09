Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BA5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 11:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A7620866
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 11:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A7620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeIIQc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 12:32:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37398 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbeIIQc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 12:32:26 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qpXx3Vzs8bRm; Sun,  9 Sep 2018 13:43:01 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDD0A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bdd:a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D250A1EC0368;
        Sun,  9 Sep 2018 13:43:00 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>
Subject: [PATCH] jump_label: Use static_key_linked() accessor
Date:   Sun,  9 Sep 2018 13:42:52 +0200
Message-Id: <20180909114252.17575-1-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... instead of open-coding it, in static_key_mod().

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Jason Baron <jbaron@akamai.com>
---
 kernel/jump_label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 2e62503bea0d..de97d8753b62 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -455,7 +455,7 @@ struct static_key_mod {
 
 static inline struct static_key_mod *static_key_mod(struct static_key *key)
 {
-	WARN_ON_ONCE(!(key->type & JUMP_TYPE_LINKED));
+	WARN_ON_ONCE(!static_key_linked(key));
 	return (struct static_key_mod *)(key->type & ~JUMP_TYPE_MASK);
 }
 
-- 
2.17.0.582.gccdcbd54c

