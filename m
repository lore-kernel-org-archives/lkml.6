Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07632ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A722085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FYDHFMdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A722085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeJ0Fw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:52:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35405 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeJ0Fw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:52:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id e2-v6so2470026edn.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kf8ZmI841IiUzvNJlQfjDPXm4MdEs8qIqqeVPkR+sKg=;
        b=FYDHFMdtcXt0O4j/6Su/pgmnyqP5sU8CKbQMANbxN/ZUDMu6pYEfPtvYwLXIkYIXcS
         iS87sob9+G1SACjDsvFfI+WVO2V6vROrpx0SKemTf68K5JG6FWeQc+owSKrql7Z9cQf2
         28DAyqg5PrIoenFCvsCWTU9b5lW+EbB/64A90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kf8ZmI841IiUzvNJlQfjDPXm4MdEs8qIqqeVPkR+sKg=;
        b=FUZUaVBo8sZJShNy8bkSDTuBiIqgXugmguXCugrLmr1qIuMcvNh1NnPS+SpTE1E3TU
         da9I5m4AAP1GpvS80irNhlJiZZs47Y/dwrc7pMa1DMCSO5qWJ1l5BQWCypv0OPybhpO9
         Jju+9CN1wSGWMsjBT7Q6wN+dZDsE86l1la9Fv4917bgQzuQVLKOH1wuZbvZKiLfLlfcW
         DdDM5zmNjO0944mY6UUMin8YZyLGXAfsQA+tK2LHG0v255/seQMsAG5pUyTRhaw5ZJKg
         kEjaNxOmTpULUCPP9MO//jf+KUtMQjaXueHVpuY6WRilWMweCjFSHraLEOhUk7ci5EsI
         DBGw==
X-Gm-Message-State: AGRZ1gIUoJooXOVNXUn+MYQ2xVa7kEhQ0EGLzWJtht/34XNESlw895WW
        Du3eul5zl48EWUf8f1/3O5Lazw==
X-Google-Smtp-Source: AJdET5f5vAuZEUzEyiSQ17lJGUNTvsGxgmXAHSfN9Z6QMH4io5a2caK+bRdjZ1eka9za5ghXBGS+dg==
X-Received: by 2002:a50:adca:: with SMTP id b10-v6mr4472049edd.184.1540588430843;
        Fri, 26 Oct 2018 14:13:50 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id a40-v6sm4786220edd.61.2018.10.26.14.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 14:13:50 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tracing: avoid -Wformat-nonliteral warning
Date:   Fri, 26 Oct 2018 23:13:45 +0200
Message-Id: <20181026211347.2442-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
References: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with -Wformat-nonliteral, gcc complains

kernel/trace/trace_output.c: In function ‘seq_print_sym’:
kernel/trace/trace_output.c:356:3: warning: format not a string literal, argument types not checked [-Wformat-nonliteral]
   trace_seq_printf(s, fmt, name);

But seq_print_sym only has a single caller which passes "%s" as fmt, so
we might as well just use that directly. That also paves the way for
further cleanups that will actually make that format string go away
entirely.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/trace/trace_output.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 501311dcfca6..7417ce5fe4bb 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -339,8 +339,7 @@ static inline const char *kretprobed(const char *name)
 #endif /* CONFIG_KRETPROBES */
 
 static void
-seq_print_sym(struct trace_seq *s, const char *fmt, unsigned long address,
-	      bool with_offset)
+seq_print_sym(struct trace_seq *s, unsigned long address, bool with_offset)
 {
 	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_KALLSYMS
@@ -353,12 +352,12 @@ seq_print_sym(struct trace_seq *s, const char *fmt, unsigned long address,
 	name = kretprobed(str);
 
 	if (name && strlen(name)) {
-		trace_seq_printf(s, fmt, name);
+		trace_seq_printf(s, "%s", name);
 		return;
 	}
 #endif
 	snprintf(str, KSYM_SYMBOL_LEN, "0x%08lx", address);
-	trace_seq_printf(s, fmt, str);
+	trace_seq_printf(s, "%s", str);
 }
 
 #ifndef CONFIG_64BIT
@@ -407,7 +406,7 @@ seq_print_ip_sym(struct trace_seq *s, unsigned long ip, unsigned long sym_flags)
 		goto out;
 	}
 
-	seq_print_sym(s, "%s", ip, sym_flags & TRACE_ITER_SYM_OFFSET);
+	seq_print_sym(s, ip, sym_flags & TRACE_ITER_SYM_OFFSET);
 
 	if (sym_flags & TRACE_ITER_SYM_ADDR)
 		trace_seq_printf(s, " <" IP_FMT ">", ip);
-- 
2.19.1.6.gbde171bbf5

