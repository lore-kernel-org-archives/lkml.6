Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D944BC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD21213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD21213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJJEJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:09:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38046 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeJJEJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:09:13 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hGhLKRwstRVX; Tue,  9 Oct 2018 22:50:26 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C733D1EC028B;
        Tue,  9 Oct 2018 22:50:25 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, x86@kernel.org
Subject: [RFC PATCH] kernel/panic: Filter out a potential trailing newline
Date:   Tue,  9 Oct 2018 22:50:19 +0200
Message-Id: <20181009205019.2786-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec057f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

If a call to panic() terminates the string with a \n, the result puts
the closing brace ']---' on a newline because panic() itself adds \n
too.

Now, if one goes and removes the newline chars from all panic()
invocations - and the stats right now look like this:

~300 calls with an \n
~500 calls without a \n

one is destined to a neverending game of whack-a-mole because the usual
thing to do is add a newline at the end of a string a function is
supposed to print.

Therefore, simply zap any \n at the end of the panic string to avoid
touching so many places in the kernel.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: x86@kernel.org
---
 kernel/panic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 8b2e002d52eb..5776d2879650 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -136,7 +136,7 @@ void panic(const char *fmt, ...)
 {
 	static char buf[1024];
 	va_list args;
-	long i, i_next = 0;
+	long i, i_next = 0, len;
 	int state = 0;
 	int old_cpu, this_cpu;
 	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
@@ -173,8 +173,12 @@ void panic(const char *fmt, ...)
 	console_verbose();
 	bust_spinlocks(1);
 	va_start(args, fmt);
-	vsnprintf(buf, sizeof(buf), fmt, args);
+	len = vscnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
+
+	if (len && buf[len - 1] == '\n')
+		buf[len - 1] = '\0';
+
 	pr_emerg("Kernel panic - not syncing: %s\n", buf);
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 	/*
-- 
2.19.0.271.gfe8321ec057f

