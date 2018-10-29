Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6188BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7A5205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hY5nuW+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7A5205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeJ3H0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:26:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36590 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeJ3H0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:26:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id x2-v6so8791179eds.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IpTFPrLTGEHqK3c3WucGpgrnOZWsydy6XCoCU8e1Jcs=;
        b=hY5nuW+vPIGfFm3CtjOA4Mxa/YdmVdATvO89vG6uZN2FrbFx8+ii/ZUY692Gmp1inu
         9Fcep3Fb7FGeEUzczlZuntS45/4OanLxXbdoKVlFETyoC9WjQFXP1ZoLaI7leXaozeun
         cYrKObyUkewEBnDKYhLSou864qkF/b3h0GWho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpTFPrLTGEHqK3c3WucGpgrnOZWsydy6XCoCU8e1Jcs=;
        b=M6+QiJPNiOM2ELLMJgyF0D3SIUPSRpciK3V6TK+sQAa5buphZCwxafNncDinQnwmuf
         utflTbEZqo9lZJ1eiq6dKEqmgTwV+zi2D8rgptxZ8Cbe+ZMdtvEuwZDqq0B8w7NhLwm0
         m+6FFBB3X38V6E+TY5r/wxTcoxwSw27cWzijJ282fmDHslhptMU4WNSjRirt++43C8vQ
         mh8cJDdXJAb58jI7nPIyPzDsWIllBLKREPKkZ/TBueq4+N8z2lPgorl5RkbEIoeUAA2N
         C61FSPKR2vL8MjMxam+gLPD/OXEBOFP8FAjXEt1nqtDRZYv4WOAFOYwddZ7a5apDLx6H
         QnYQ==
X-Gm-Message-State: AGRZ1gKiA28yk5ZNTH8WCsKhuITlPob92u6i4Whx/JA4ulZ1vJHAX/FN
        GNNwNkGf5/dJtzyv/ZAtA/YMzs64tvc=
X-Google-Smtp-Source: AJdET5fOyCNpRxOsUZZoQ/PI0X/8HHs9OQMI3usGUNrDRDwG5EvJhPEwvnXgf7YivH2JucnhkdFnNw==
X-Received: by 2002:a50:f5ad:: with SMTP id u42-v6mr14490670edm.68.1540852547390;
        Mon, 29 Oct 2018 15:35:47 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id h3-v6sm7146380ede.42.2018.10.29.15.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Oct 2018 15:35:46 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] tracing: merge seq_print_sym_short() and seq_print_sym_offset()
Date:   Mon, 29 Oct 2018 23:35:40 +0100
Message-Id: <20181029223542.26175-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181029223542.26175-1-linux@rasmusvillemoes.dk>
References: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
 <20181029223542.26175-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions are nearly identical, so we can avoid some code
duplication by moving the conditional into a common implementation.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/trace/trace_output.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 6e6cc64faa38..85ecd061c7be 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -339,34 +339,17 @@ static inline const char *kretprobed(const char *name)
 #endif /* CONFIG_KRETPROBES */
 
 static void
-seq_print_sym_short(struct trace_seq *s, const char *fmt, unsigned long address)
+seq_print_sym(struct trace_seq *s, const char *fmt, unsigned long address,
+	      bool offset)
 {
 	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_KALLSYMS
 	const char *name;
 
-	kallsyms_lookup(address, NULL, NULL, NULL, str);
-
-	name = kretprobed(str);
-
-	if (name && strlen(name)) {
-		trace_seq_printf(s, fmt, name);
-		return;
-	}
-#endif
-	snprintf(str, KSYM_SYMBOL_LEN, "0x%08lx", address);
-	trace_seq_printf(s, fmt, str);
-}
-
-static void
-seq_print_sym_offset(struct trace_seq *s, const char *fmt,
-		     unsigned long address)
-{
-	char str[KSYM_SYMBOL_LEN];
-#ifdef CONFIG_KALLSYMS
-	const char *name;
-
-	sprint_symbol(str, address);
+	if (offset)
+		sprint_symbol(str, address);
+	else
+		kallsyms_lookup(address, NULL, NULL, NULL, str);
 	name = kretprobed(str);
 
 	if (name && strlen(name)) {
@@ -424,10 +407,7 @@ seq_print_ip_sym(struct trace_seq *s, unsigned long ip, unsigned long sym_flags)
 		goto out;
 	}
 
-	if (sym_flags & TRACE_ITER_SYM_OFFSET)
-		seq_print_sym_offset(s, "%s", ip);
-	else
-		seq_print_sym_short(s, "%s", ip);
+	seq_print_sym(s, "%s", ip, sym_flags & TRACE_ITER_SYM_OFFSET);
 
 	if (sym_flags & TRACE_ITER_SYM_ADDR)
 		trace_seq_printf(s, " <" IP_FMT ">", ip);
-- 
2.19.1.6.gbde171bbf5

