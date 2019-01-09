Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD12EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB3A2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAIW74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:59:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfAIW7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:59:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3FB680F6C;
        Wed,  9 Jan 2019 22:59:53 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B85A11019632;
        Wed,  9 Jan 2019 22:59:51 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 1/6] compiler.h: Make __ADDRESSABLE() symbol truly unique
Date:   Wed,  9 Jan 2019 16:59:36 -0600
Message-Id: <8bc857824f82462a296a8a3c4913a11a7f801e74.1547073843.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1547073843.git.jpoimboe@redhat.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 09 Jan 2019 22:59:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __ADDRESSABLE() macro uses the __LINE__ macro to create a temporary
symbol which has a unique name.  However, if the macro is used multiple
times from within another macro, the line number will always be the
same, resulting in duplicate symbols.

Make the temporary symbols truly unique by using __UNIQUE_ID instead of
__LINE__.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index fc5004a4b07d..5e45bc988b1e 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -291,7 +291,7 @@ unsigned long read_word_at_a_time(const void *addr)
  */
 #define __ADDRESSABLE(sym) \
 	static void * __section(".discard.addressable") __used \
-		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
+		__UNIQUE_ID(__addressable_##sym) = (void *)&sym;
 
 /**
  * offset_to_ptr - convert a relative memory offset to an absolute pointer
-- 
2.17.2

