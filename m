Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9D7C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC6720838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC6720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeH3VhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:37:20 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:14372 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbeH3VhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:37:20 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 30 Aug 2018 10:33:41 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 90A96B05D7;
        Thu, 30 Aug 2018 13:34:06 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH 1/6] x86/alternatives: clarify text_mutex use in text_poke
Date:   Thu, 30 Aug 2018 10:32:13 -0700
Message-ID: <20180830173218.238900-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830173218.238900-1-namit@vmware.com>
References: <20180830173218.238900-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

text_mutex is expected to be held before text_poke() is called, but we
cannot add a lockdep assertion since kgdb does not take it, and instead
*supposedly* ensures the lock is not taken and will not be acquired by
any other core while text_poke() is running.

The reason for the "supposedly" comment is that it is not entirely clear
that this would be the case if gdb_do_roundup is zero.

Add a comment to clarify this behavior.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/alternative.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 014f214da581..d0c0d8b724e1 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -685,7 +685,10 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
  * in a way that permits an atomic write. It also makes sure we fit on a single
  * page.
  *
- * Note: Must be called under text_mutex.
+ * Context: Must be called under text_mutex. kgdb is an exception: it does not
+ *	    hold the mutex, as it *supposedly* ensures that no other core is
+ *	    holding the mutex and ensures that none of them will acquire the
+ *	    mutex while the code runs.
  */
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
-- 
2.17.1

